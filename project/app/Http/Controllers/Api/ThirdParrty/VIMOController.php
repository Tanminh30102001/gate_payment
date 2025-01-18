<?php

namespace App\Http\Controllers\Api\ThirdParrty;
use Carbon\Carbon;
use App\Models\RPALogs;
use App\Models\RPAServices;
use Illuminate\Http\Request;
use App\Http\Controllers\Api\ApiController;
use App\Models\Merchant;
use App\Services\VIMOService;
use Illuminate\Support\Facades\Http;
use Telegram\Bot\Api;
use Telegram\Bot\Laravel\Facades\Telegram;
use Illuminate\Support\Str;

class VIMOController extends ApiController
{
    protected $VIMOSerVice;

    public function __construct(VIMOService $VIMOSerVice)
    {
        $this->VIMOSerVice = $VIMOSerVice;
    }

    public function getBill(Request $request)
    {
        $customer_code = $request->input('customer_code');
        $service_code = $request->input('service_code');
        $publisher = $request->input('publisher');

        if (empty($customer_code) || empty($service_code) || empty($publisher)) {
            return response()->json([
                'status' => 'error',
                'message' => 'Missing required parameters.'
            ], 400);
        }

        $response = $this->VIMOSerVice->getBill($customer_code, $service_code, $publisher);
        return $response;
        if ($response['status'] === 'success') {
            return response()->json($response);
        } else {
            return response()->json([
                'status' => 'error',
                'message' => $response['message']
            ]);
        }
    }
    public function getBalancec()
    {
        $response = $this->VIMOSerVice->getBalancePiPay();
        $telegram = new Api('7294847645:AAGNiybJg8r_MBAtSwW966SULQzApvdqq0M');
        $data = json_decode($response, true);

        $telegram->sendMessage([
            'chat_id' => '-4231128159',
            'text' => 'Balance hiện tại:' . $data['data']['balance'],
        ]);

    }
    public function handle(Request $request)
    {
        $telegram = new Api('7294847645:AAGNiybJg8r_MBAtSwW966SULQzApvdqq0M');
        $update = $telegram->commandsHandler(true);

        $message = $update->getMessage();
        $text = $message->getText();
        $chatId = $message->getChat()->getId();

        if ($text == '/check') {
            $this->getBalancec();
        }

        return 'ok';
    }
    public function payBill(Request $request)
    {
        $billNumber = $request->input('bill_number', '');
        $amount = (float) $request->input('amount');
        $period = $request->input('period', '');
        $customer_code = $request->input('customer_code', '');
        $publisher = $request->input('publisher', '');
        $service_code = $request->input('service_code', '');
        if (empty($billNumber) || empty($amount) || empty($period) || empty($customer_code) || empty($publisher) || empty($service_code)) {
            return $this->sendError('Validation Error', 'Missing required parameters', 400);
        }
        $response = $this->VIMOSerVice->payBill($billNumber, $amount, $period, $customer_code, $publisher, $service_code);
        return $this->sendResponse($response, 'success');
    }
    public function getInfo(Request $request)
    {
        $transactionId = Str::uuid();
        $category = $request->category ?? '';
        $type_category = $request->type_category ?? '';
        $customer_code = $request->customer_code ?? '';
        $color = $request->color ?? '';
        $type_payment = $request->type_payment ?? '';
        $bill_value = $request->bill_value ?? '';
        $status = $request->status ?? '';
        $data = [
            'transactionId' => $transactionId,
            'category' => $category,
            'type_category' => $type_category,
            'customer_code' => $customer_code,
            'color' => $color,
            'type_payment' => $type_payment,
            'bill_value' => $bill_value,
        ];

        if( $category==''||$type_category==''||$customer_code==''|| $type_payment==''){
            return $this->sendError('Missing required field ',$data,400);
        }
        if( $category==='VETC' && $color==''){
            return $this->sendError('Color is required ',$bill_value,400);
        }
        
        if( $type_payment==='payment' && empty($bill_value)){
            return $this->sendError('Bill value is required ',$bill_value,400);
     
        }
        if ($category === 'PHONE' && empty($bill_value)) {
            return $this->sendError('Bill value is required ',$bill_value,400);
        }
        $dataJson = json_encode($data);
        $rpa = new RPAServices();
        $rpa->transactionId = $transactionId;
        $rpa->payload = $dataJson;
        $rpa->status ='not-send-bot';

        $rpa->save();
        return $this->sendResponse( $rpa,'success');
    }
    public function botGetInfo()
    {
        $rpa = RPAServices::where('status', 'not-send-bot')->get();
        return $rpa;
    }
    public function botSendInfo(Request $request)
{
    $transactionId = $request->transactionId ?? '';

    if ($transactionId == '') {
        return $this->sendError('Required TransactionId ', $transactionId, 400);
    }
    $existTransaction = RPAServices::where('transactionId', $transactionId)->first();
    if (!$existTransaction) {
        return $this->sendError('Transaction not found', $existTransaction, 400);
    }

    // Dịch message từ request
    $response = Http::withHeaders([
        'lang' => 'vn',
        'gmt' => '1',
        'os-name' => '.',
        'os-version' => '.',
        'app-version' => '.',
        'Content-Type' => 'application/json',
        'uuid' => '.',
    ])->post('https://api.hifriend.site/translate-audio/translate-list', [
        'to-lang' => 'en-US',
        'messages' => [
            '1' => $request->message,
        ],
    ]);

    $translatedMessage = $response->json()['data']['1'] ?? $request->message;

    if ($request->status == 1) {
        $existTransaction->status = 'error';
        $existTransaction->message = $translatedMessage;
    }

    // Cập nhật message đã dịch vào response từ bot
    $requestData = $request->all();
    $requestData['message'] = $translatedMessage;

    $existTransaction->response_from_bot = json_encode($requestData);
    $existTransaction->status = 'recieved-from-bot';
    $existTransaction->save();

    return $existTransaction;
}
    public function botUpdateStatus(Request $request){
        $transactionId = $request->transactionId ?? '';
        $status=$request->status??'';
        $message=$request->message??'';
        if ($transactionId == '') {
            return $this->sendError('Required TransactionId ',$transactionId,400);
        }
        
        $existTransaction = RPAServices::where('transactionId', $transactionId)->first();
        if(!$existTransaction){
            return $this->sendError('Transaction not found',$transactionId,400);
        }
        $response = Http::withHeaders([
            'lang' => 'vn',
            'gmt' => '1',
            'os-name' => '.',
            'os-version' => '.',
            'app-version' => '.',
            'Content-Type' => 'application/json',
            'uuid' => '.',
        ])->post('https://api.hifriend.site/translate-audio/translate-list', [
            'to-lang' => 'en-US',
            'messages' => [
                '1' => $request->message,
            ],
        ]);

        $translatedMessage = $response->json()['data']['1'] ?? $request->message;
        $existTransaction->message=$translatedMessage;

        $existTransaction->status=$status==2?'bot-recived':'bot-pending';
        //$existTransaction->message=$message;
        $existTransaction->save();
        return $existTransaction;
    }
    public function getDetailsTrans($transactionId){
        $rpa = RPAServices::where('transactionId', $transactionId)->first();
       
        if(!$rpa){
            return $this->sendError('Transaction not found',$transactionId,400);
        }
        return $this->sendResponse($rpa,'success');
    }
    public function getCategory(){
        
    }
    public function webhookRPA(Request $request){
        //Lấy danh sách log rpa 
        $getListNewest=RPALogs::whereDate('created_at', Carbon::today())->orderByDesc('id')->get();

        // sau đó lấy transactionId để kiểm tra trong bảng RPAservice 
        foreach($getListNewest as $items){
            $transactionId=$items->transactionId;
            $rpaService=RPAServices::where('transactionId',$transactionId)->first();
        //nếu mà có dữ liệu trả về thì cập nhập vào bảng rpa logs 

            if($rpaService->response_from_bot !==null && $rpaService->status=='recieved-from-bot'){
                $rpaLogs=RPALogs::where('transactionId',$transactionId)->first();
                if($rpaLogs->data_recieve!==null){continue;}
                $rpaLogs->data_receive=$rpaService->response_from_bot;
                $rpaLogs->status=$rpaService->status;
                $rpaLogs->save();
                //và gửi dữ liệu về url merchant cung cấp 
                $merchant=Merchant::where('id',$rpaLogs->user_id)->first();
                if (!$merchant || !$merchant->url_webhook) {
                    continue;
                }
                $arraySend=json_decode($rpaService->response_from_bot,true);
                try {
                    $response = Http::withHeaders([
                        'Authorization' =>$merchant->secret_key, // Authorize key mà merchant cung cấp
                    ])->post($merchant->url_webhook, $arraySend);
                    if ($response->successful()) {
                        echo "Xử lý transactionId: $transactionId thành công";
                    } else {
                        echo  "Gửi dữ liệu thất bại cho transactionId: $transactionId. Phản hồi: " . $response->body();
                    }
                } catch (\Exception $e) {

                    echo "Lỗi khi gửi dữ liệu cho transactionId: $transactionId. Chi tiết lỗi: " . $e->getMessage();
                }
            }
        }
        echo" Đã xử lý xong hết "; 
    }
}
