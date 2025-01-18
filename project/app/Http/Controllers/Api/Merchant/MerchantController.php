<?php

namespace App\Http\Controllers\Api\Merchant;

use App\Helpers\SendSMSHelper;
use App\Models\LogSendSMS;
use App\Models\VoucherGotit;
use App\Services\GOTITService;
use App\Models\ServiceApotas;
use App\Models\ProductApota;
use Image;
use App\Models\Module;
use App\Models\Wallet;
use App\Models\KycForm;
use App\Models\ApiCreds;
use App\Models\Transaction;
use App\Models\Withdrawals;
use Illuminate\Support\Str;
use App\Helpers\MediaHelper;
use Illuminate\Http\Request;
use App\Models\Generalsetting;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Validator;
use App\Http\Controllers\Api\ApiController;
use App\Models\Charge;
use App\Models\Merchant;
use App\Models\RPALogs;
use App\Models\Voucher;
use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\Log;

class MerchantController extends ApiController
{
    protected $GOTITService;

    public function __construct(GOTITService $GOTITService)
    {
        $this->GOTITService = $GOTITService;
    }
    public function dashboard()
    {
        $user = request()->user();
        $success['wallets'] = Wallet::where('user_type', 2)->where('user_id', $user->id)->get();
        $success['recent_withdraw'] = Withdrawals::where('merchant_id', $user->id)->take(7)->get();
        $success['recent_transactions'] = Transaction::where('user_id', $user->id)->where('user_type', 2)->take(7)->get();
        return $this->sendResponse($success, 'success');
    }

    public function generateQR()
    {
        return $this->sendResponse(['qrcode_image' => generateQR(request()->user()->email)], 'QR code has been generated');
    }


    public function apiKeyGenerate()
    {
        $user = request()->user();
        $cred = ApiCreds::whereMerchantId($user->id)->first();
        if (!$cred) {
            ApiCreds::create([
                'merchant_id' => merchant()->id,
                'access_key' => (string) Str::uuid(),
                'api_key' => (string) strtolower(Str::random(32)),
                'mode' => 0
            ]);
        }
        $cred->access_key = (string) Str::uuid();
        $cred->api_key = (string) strtolower(Str::random(32));
        $cred->update();
        return $this->sendResponse(['access_key' => $cred->access_key], 'New api key has been generated');
    }

    public function serviceMode()
    {
        $user = request()->user();
        $cred = ApiCreds::whereMerchantId($user->id)->first();
        if ($cred->mode == 0) {
            $cred->mode = 1;
            $msg = 'Service selected as Active Mode';
        } else {
            $cred->mode = 0;
            $msg = 'Service selected as Test Mode';
        }
        $cred->update();
        return $this->sendResponse(['success'], __($msg));
    }


    public function profileUpdate(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'name' => 'required',
            'phone' => 'required',
            'photo' => 'image|mimes:jpg,jpeg,png',
            'city' => 'required',
            'zip' => 'required',
            'business_name' => 'required',
        ]);

        if ($validator->fails()) {
            return $this->sendError('Validation Error', $validator->errors());
        }

        $user = $request->user();
        $user->business_name = $request->business_name;
        $user->name = $request->name;
        $user->phone = $request->phone;
        $user->city = $request->city;
        $user->zip = $request->zip;
        $user->address = $request->address;

        if ($request->photo) {
            $user->photo = MediaHelper::handleMakeImage($request->photo, [300, 300]);
        }

        $user->update();
        return $this->sendResponse(['success'], 'Profile has been updated');
    }

    public function updatePassword(Request $request)
    {
        $validator = Validator::make($request->all(), ['old_pass' => 'required', 'password' => 'required|min:6|confirmed']);
        if ($validator->fails()) {
            return $this->sendError('Validation Error', $validator->errors());
        }
        $user = $request->user();
        if (Hash::check($request->old_pass, $user->password)) {
            $password = bcrypt($request->password);
            $user->password = $password;
            $user->save();
            return $this->sendResponse(['success'], 'Password has been changed');
        } else {
            return $this->sendError('Error', ['The old password doesn\'t match!']);
        }
    }



    public function transactions()
    {
        $remark = request('remark');
        $search = request('search');
        $user = request()->user();
        $success['transactions'] = Transaction::where('user_id', $user->id)->where('user_type', 2)
            ->when($remark, function ($q) use ($remark) {
                return $q->where('remark', $remark);
            })
            ->when($search, function ($q) use ($search) {
                return $q->where('trnx', $search);
            })
            ->latest()
            ->paginate(15);

        $success['remark_list'] = [
            'merchant_payment',
            'merchant_api_payment',
            'withdraw_money'
        ];
        $success['remark'] = $remark;
        $success['search'] = $search;

        return $this->sendResponse($success, 'Transaction history');
    }

    public function trxDetails($id)
    {
        $user = request()->user();
        $success['transaction'] = Transaction::where('id', $id)->where('user_type', 2)->where('user_id', $user->id)->first();
        if (!$success['transaction']) {
            return $this->sendError('Error', ['Transaction not found']);
        }
        return $this->sendResponse($success, 'Transaction details');
    }

    public function twoStepSendCode(Request $request)
    {
        $validator = Validator::make($request->all(), ['password' => 'required|confirmed']);
        if ($validator->fails()) {
            return $this->sendError('Validation Error', $validator->errors());
        }

        $user = $request->user();
        if (Hash::check($request->password, $user->password)) {
            $code = randNum();
            $user->two_fa_code = $code;
            $user->update();
            sendSMS($user->phone, trans('Your two step authentication OTP is : ') . $code, Generalsetting::value('contact_no'));
            return $this->sendResponse(['success'], 'OTP code is sent to your phone.');
        } else {
            return $this->sendError('Error', ['The password doesn\'t match!']);
        }
    }

    public function twoStepVerifySubmit(Request $request)
    {
        $validator = Validator::make($request->all(), ['code' => 'required']);
        if ($validator->fails()) {
            return $this->sendError('Validation Error', $validator->errors());
        }

        $user = $request->user();
        if ($request->code != $user->two_fa_code) {
            return $this->sendError('Error', ['Invalid OTP']);
        }
        if ($user->two_fa_status == 1) {
            $user->two_fa_status = 0;
            $user->two_fa = 0;
            $msg = 'Your two step authentication is de-activated';
        } else {
            $user->two_fa_status = 1;
            $msg = 'Your two step authentication is activated';
        }
        $user->two_fa_code = null;
        $user->save();
        return $this->sendResponse(['success'], $msg);
    }

    public function kycForm()
    {
        $user = request()->user();
        if ($user->kyc_status == 2)
            return $this->sendError('Error', ['You have already submitted the KYC data.']);
        if ($user->kyc_status == 1)
            return $this->sendError('Error', ['Your KYC data is already verified.']);
        $success['kyc_form_data'] = KycForm::where('user_type', 2)->get();
        return $this->sendResponse($success, 'success');
    }

    public function kycFormSubmit(Request $request)
    {
        $user = request()->user();
        if ($user->kyc_status == 2)
            return $this->sendError('Error', ['You have already submitted the KYC data.']);
        if ($user->kyc_status == 1)
            return $this->sendError('Error', ['Your KYC data is already verified.']);
        $data = $request->except('_token');
        $kycForm = KycForm::where('user_type', 2)->get();
        $rules = [];
        foreach ($kycForm as $value) {
            if ($value->required == 1) {
                if ($value->type == 2) {
                    $rules[$value->name] = 'required|image|mimes:png,jpg,jpeg|max:5120';
                }
                $rules[$value->name] = 'required';
            }
            if ($value->type == 2) {
                $rules[$value->name] = 'image|mimes:png,jpg,jpeg|max:5120';
                if (request("$value->name")) {
                    $filename = MediaHelper::handleMakeImage(request("$value->name"));
                }
                unset($data[$value->name]);
                $data['image'][$value->name] = $filename;
            }
            if ($value->type == 3) {
                unset($data[$value->name]);
                $data['details'][$value->name] = request("$value->name");
            }
        }
        $validator = Validator::make($request->all(), $rules);
        if ($validator->fails()) {
            return $this->sendError('Validation Error', $validator->errors());
        }

        $user->kyc_info = $data;
        $user->kyc_status = 2;
        $user->save();

        return $this->sendResponse(['success'], 'KYC data has been submitted for review.');
    }
    public function getPubliser(Request $request)
    {
        $service_code = $request->input('service_code', '');
        if (!$service_code) {
            return $this->sendError('require_valid', $service_code);
        }
        $listCategory = (object) [
            "Điện" => "ELECTRIC",
            "Hóa đơn INTERNET" => "INTERNET",
            "Nạp tiền điện thoại" => "PHONE",
            "Thu phí không dừng VETC" => "VETC"
        ];
        $dataElectric = (object) [
            "EVN" => "Điện lực Hà Nội",
            "EVNHCM" => "Điện lực Hồ Chí Minh",
            "EVNNPC" => "Điện lực Miền Bắc",
            "EVNCPC" => "Điện lực Miền Trung",
            "EVNSPC" => "Điện lực Miền Nam"
        ];

        $dataWatter = (object) [
            "HCMTA" => "Cty nước Trung An – TP.HCM",
            "HCMCLO" => "Cty nước Chợ Lớn – TP.HCM",
            "HCMNT" => "Cty nước Nông thôn – TP.HCM",
            "NBE" => "Cty nước Nhà Bè – TP.HCM",
            "DNI" => "Cty nước Đồng Nai",
            "HCMBT" => "Cty nước Bến Thành – TP.HCM",
            "HCMGD" => "Cty nước Gia Định – TP.HCM",
            "HUE" => "Cty nước Huế",
            "HCMUT" => "Cty nước Phú Hòa Tân – TP.HCM",
            "HCMTH" => "Cty nước Tân Hòa – TP.HCM",
            "HCMTD" => "Cty nước Thủ Đức – TP.HCM"
        ];
        if ($service_code === 'BILL_ELECTRIC') {
            return response()->json([
                'status' => '200',
                'message' => 'Success',
                'data' => $dataElectric,
            ], 200);
        }
        return response()->json([
            'status' => '200',
            'message' => 'Success',
            'data' => $dataWatter,
        ], 200);
    }
    public function getListService(Request $request)
    {
        $access_key = $request->header('Authorization') ?? '';
        $access_keyExist = ApiCreds::where('access_key', $access_key)->first();
        if (empty($access_key) || !$access_keyExist) {
            return $this->sendError('unauthorized');
        }
        $listCategory = (object) [
            "ELECTRIC" => "Điện",
            "INTERNET" => "Hóa đơn INTERNET",
            "PHONE" => "Nạp tiền điện thoại",
            "VETC" => "Thu phí không dừng VETC"
        ];
        return $this->sendResponse($listCategory);
    }
    public function getDetailsService(Request $request)
    {
        $service_code = $request->input('category', '');
        if (!$service_code) {
            return $this->sendError('require_valid', $service_code);
        }
        $dataElectric = (object) [
            "EVN" => "evn",
            "DNAG" => "Điện nước An Giang"
        ];

        $dataInternet = (object) [
            "VIETTEL" => "Tổng Công ty Viễn thông Viettel",
            "FPT" => "Công ty cổ phần viễn thông FPT",
            "SPT" => "Công ty Cổ phần Dịch vụ Bưu chính Viễn Thông Sài Gòn",
            "VNPT" => "Tập đoàn Bưu chính Viễn thông Việt Nam"
        ];

        $dataPhone = (object) [
            "PAY_BEFORE" => "Dịch vụ trả trước",
            "PAY_AFTER" => "Dịch vụ trả sau"
        ];

        $dataVETC = (object) [
            "VETC" => "VETC"
        ];
        if ($service_code === 'ELECTRIC') {
            return   $this->sendResponse($dataElectric);
        } elseif ($service_code === 'INTERNET') {
            return  $this->sendResponse($dataInternet);
        } elseif ($service_code === 'PHONE') {
            return  $this->sendResponse($dataPhone);
        } elseif ($service_code === 'VETC') {
            return  $this->sendResponse($dataVETC);
        } else {
            return $this->sendError('Service code not found', $service_code);
        }
    }
    public function getBill(Request $request)
    {
        $customer_code = $request->customer_code ?? '';
        $service_code = $request->service_code ?? '';
        $publisher = $request->publisher ?? '';
        $access_key = $request->header('Authorization') ?? '';
        if (empty($access_key)) {
            return $this->sendError('Error', ['unauthorized']);
        }
        if (empty($customer_code) || empty($service_code) || empty($publisher)) {
            return $this->sendError('Error', ['Missing required parameters.']);
        }

        $url = route('getBillApiVimo');
        $response = Http::timeout(2.0)->get($url, [
            'customer_code' => $customer_code,
            'service_code' => $service_code,
            'publisher' => $publisher
        ]);

        if ($response->successful()) {
            return $response->json();
        } else {
            return response()->json([
                'status' => 'error',
                'message' => 'Unexpected HTTP status: ' . $response->status() . ' ' . $response->reason()
            ]);
        }
    }
    public function payBill(Request $request)
    {
        $bill_number = $request->bill_number ?? '';
        $amount = $request->amount ?? '';
        $period = $request->period ?? '';
        $customer_code = $request->customer_code ?? '';
        $publisher = $request->publisher ?? '';
        $service_code = $request->service_code ?? '';
        $access_key = $request->header('Authorization') ?? '';
        $accessKeyExists = ApiCreds::where('access_key', $access_key)->first();

        if (empty($access_key) || !$accessKeyExists) {
            return $this->sendError('Error', ['unauthorized']);
        }

        if (
            empty($bill_number) || empty($amount) || empty($period) || empty($customer_code) ||
            empty($publisher) || empty($service_code) || empty($access_key)
        ) {
            return $this->sendError('error', 'Missing required parameters', 200);
        }
        $walletMerchant = Wallet::where('user_id', $accessKeyExists->merchant_id)->where('user_type', 2)->first();
        if ($amount > $walletMerchant->balance) {
            return $this->sendError('error', 'Insufficient balance', 200);
        }
        $merchant = Merchant::where('id', $accessKeyExists->merchant_id)->first();
        $transData = [
            'trnx' => str_rand(),
            'user_id' => $merchant->id,
            'user_type' => 2,
            'currency_id' => 15,
            'wallet_id' => $walletMerchant->id,
            'amount' => $amount,
            'remark' => 'pay_bill',
            'type' => '-',
            'details' => 'Merchat' . $merchant->name . ' Paid bill' . $bill_number
        ];


        $url = route('payBillApiVimo');
        try {
            $response = Http::timeout(2.0)->asForm()->post($url, [
                'bill_number' => $bill_number,
                'amount' => $amount,
                'period' => $period,
                'customer_code' => $customer_code,
                'publisher' => $publisher,
                'service_code' => $service_code,
            ]);

            if ($response->successful()) {
                $transaction = Transaction::create($transData);
                $walletMerchant->balance -= $amount;
                $walletMerchant->save();
                return $response->json();
            } else {
                return response()->json([
                    'status' => 'error',
                    'message' => 'Unexpected HTTP status: ' . $response->status() . ' ' . $response->reason()
                ]);
            }
        } catch (\Exception $e) {
            return response()->json([
                'status' => 'error',
                'message' => 'Error: ' . $e->getMessage()
            ]);
        }
    }
    public function createVoucher(Request $request)
    {
        $params = $request->all();

        $url = route('createVoucherApiGotit');
        $params = $request->all();
        $prefix = env('PREFIX');
        $productId = $params['productId'] ?? '';
        $productPriceId = $params['productPriceId'] ?? '';
        $expiryDate = $params['expiryDate'] ?? '';
        $orderName = $params['orderName'] ?? '';
        $phone = $params['phone'] ?? '';
        $transactionRefId = $prefix . Str::uuid();
        $access_key = $request->header('Authorization') ?? '';
        $access_keyExist = ApiCreds::where('access_key', $access_key)->first();
        $voucher = VoucherGotit::where('productId', $productId)->where('priceId', $productPriceId)->first();
        if (!$voucher) {
            return $this->sendError('Error', ['voucher not found']);
        }
        if (!preg_match("/^\d{4}-\d{2}-\d{2}$/", $expiryDate) || $expiryDate == '') {
            return $this->sendError('The expiry date is not valid. The format must be \"yyyy-mm-dd\" and not exceed the specified expiry period of this account.');
        }
        if ($orderName == '' || $productId == '' || $productPriceId == '') {
            return $this->sendError('Order name is required');
        }

        if (empty($access_key) || !$access_keyExist) {
            return $this->sendError('Error', ['unauthorized']);
        }
        $walletMerchant = Wallet::where('user_id', $access_keyExist->merchant_id)->where('user_type', 2)->where('currency_id', 15)->first();
        if ($voucher->priceValue > $walletMerchant->balance) {
            return $this->sendError('error', 'Insufficient balance', 200);
        }
        $merchant = Merchant::where('id', $access_keyExist->merchant_id)->first();
        $transData = [
            'trnx' => str_rand(),
            'user_id' => $merchant->id,
            'user_type' => 2,
            'currency_id' => 15,
            'wallet_id' => $walletMerchant->id,
            'amount' => $voucher->priceValue,
            'remark' => 'Create Voucher Gotit',
            'type' => '-',
            'details' => 'Merchat' . $merchant->name . ' Created voucher has ' . $transactionRefId
        ];
        try {
            $response = Http::asForm()->post($url, [
                'productId' => $productId,
                'productPriceId' => $productPriceId,
                'expiryDate' => $expiryDate,
                'orderName' => $orderName,
                'phone' => $phone,
            ]);
            if (isset($response['error']) && $response['error'] != '') {
                Log::error('API Error', [
                    'error' => $response['error'],
                    'response' => $response
                ]);
                return $this->sendError('Something went wrong. Try Again');
            }
            if ($response->successful()) {
                $transaction = Transaction::create($transData);
                $walletMerchant->balance -= $voucher->priceValue;
                $walletMerchant->save();
                $voucher = new Voucher();
                $voucher->user_id = $access_keyExist->merchant_id;
                $voucher->currency_id = $transaction->currency_id;
                $voucher->user_type = $transaction->user_type;
                $voucher->amount = (float) $voucher->priceValue;
                $voucher->code = $response['data'][0]['vouchers'][0]['voucherCode'];
                $voucher->transactionRefId = $response['data'][0]['vouchers'][0]['transactionRefId'];
                $voucher->voucher_link = $response['data'][0]['vouchers'][0]['voucherLink'];
                $voucher->voucher_serial = $response['data'][0]['vouchers'][0]['voucherSerial'];
                $voucher->expiryDate = $response['data'][0]['vouchers'][0]['expiryDate'];
                $voucher->save();
                return $response->json();
            } else {
                return $this->sendError('Unexpected HTTP status: ' . $response->status() . ' ' . $response->reason());
                // return response()->json([
                //     'status' => 'error',
                //     'message' => 'Unexpected HTTP status: ' . $response->status() . ' ' . $response->reason()
                // ]);
            }
        } catch (\Exception $e) {
            return $this->sendError('Error: ' . $e->getMessage());
            // return response()->json([
            //     'status' => 'error',
            //     'message' => 'Error: ' . $e->getMessage()
            // ]);
        }
    }
    public function merchantGetVoucher(Request $request)
    {
        $access_key = $request->header('Authorization') ?? '';
        $params = $request->all();
        $page = $params['page'] ?? '';
        $access_keyExist = ApiCreds::where('access_key', $access_key)->first();
        if (empty($access_key) || !$access_keyExist) {
            return $this->sendError('unauthorized');
        }
        $voucher = VoucherGotit::all();
        // $pageSize = $params['pageSize'] ?? '10000';
        // $minPrice = $params['minPrice'] ?? 1;
        // $maxPrice = $params['maxPrice'] ?? 10000000;
        // $data = $this->GOTITService->getProductFromGotit($page,$pageSize,$minPrice,$maxPrice);
        return $this->sendResponse($voucher);
    }
    public function getDetailsVoucher(Request $request, $transactionId)
    {
        $access_key = $request->header('Authorization') ?? '';
        $access_keyExist = ApiCreds::where('access_key', $access_key)->first();
        if (empty($access_key) || !$access_keyExist) {
            return $this->sendError('unauthorized');
        }
        $datas = $this->GOTITService->detailsVoucher($transactionId);
        return $this->sendResponse($datas['data'], 'success');
    }
    public function getBrands(Request $request)
    {
        $access_key = $request->header('Authorization') ?? '';
        $access_keyExist = ApiCreds::where('access_key', $access_key)->first();
        if (empty($access_key) || !$access_keyExist) {
            return $this->sendError('unauthorized');
        }
        $datas = $this->GOTITService->getBrands();
        return $this->sendResponse($datas['data'], 'success');
    }
    public function getCategories(Request $request)
    {
        $access_key = $request->header('Authorization') ?? '';
        $access_keyExist = ApiCreds::where('access_key', $access_key)->first();
        if (empty($access_key) || !$access_keyExist) {
            return $this->sendError('unauthorized');
        }
        $datas = $this->GOTITService->getCategory();
        return $this->sendResponse($datas['data'], 'success');
    }
    public function getBrandByCate(Request $request, $cateId)
    {
        $access_key = $request->header('Authorization') ?? '';
        $access_keyExist = ApiCreds::where('access_key', $access_key)->first();
        if (empty($access_key) || !$access_keyExist) {
            return $this->sendError('unauthorized');
        }
        $datas = $this->GOTITService->getBrandByCategory($cateId);
        return $this->sendResponse($datas['data'], 'success');
    }
    public function merchantSendInfo(Request $request)
    {
        $category = $request->category ?? '';
        $type_category = $request->type_category ?? '';
        $customer_code = $request->customer_code ?? '';
        $color = $request->color ?? '';
        $type_payment = $request->type_payment ?? '';
        $bill_value = $request->bill_value ?? '';
        $access_key = $request->header('Authorization') ?? '';
        $accessKeyExists = ApiCreds::where('access_key', $access_key)->first();
        if ($category == 'PHONE')
            $type_payment = 'payment';

        if (empty($access_key) || !$accessKeyExists) {
            return $this->sendError('Error', ['unauthorized']);
        }
        if ($category == '' || $type_category == '' || $customer_code == '' || $type_payment == '') {
            return $this->sendError('Missing required field ', 400);
        }
        if ($category === 'VETC' && $color == '') {
            return $this->sendError('Color is required ', $bill_value, 400);
        }

        if ($type_payment === 'payment' && empty($bill_value)) {
            return $this->sendError('Bill value is required ', $bill_value, 400);
        }
        if ($category === 'PHONE' && empty($bill_value)) {
            return $this->sendError('Bill value is required ', $bill_value, 400);
        }
        if ($category == 'VETC' && $type_payment === 'payment') {
            $charge = Charge::where('slug', 'pay-vetc')->first();
            $bill_value += $bill_value * ($charge->data->percent_charge / 100);
        }
        if ($category == 'VETC') {
            $type_category == 'VETC';
        }
        $data = [
            'category' => $category,
            'type_category' => $type_category,
            'customer_code' => $customer_code,
            'color' => $color,
            'type_payment' => $type_payment,
            'bill_value' => $bill_value,
        ];
        $walletMerchant = Wallet::where('user_id', $accessKeyExists->merchant_id)->where('user_type', 2)->first();
        $merchant = Merchant::where('id', $accessKeyExists->merchant_id)->first();
        if ($type_payment === 'payment' && $bill_value > $walletMerchant->balance) {
            return $this->sendError('Insufficient balance', 400);
        }

        try {
            $response = Http::post(route('rpaUserSendInfo'), $data);
            if ($response->successful()) {
                $logRpa = new RPALogs();
                $logRpa->user_id = $accessKeyExists->merchant_id;
                $logRpa->user_type = $walletMerchant->user_type;
                $logRpa->transactionId = $response->json()['data']['transactionId'];
                $logRpa->type_service = $category;
                $logRpa->data_send = json_encode($data);
                $logRpa->type_payment = $type_payment;
                $logRpa->status = $response->json()['data']['status'];
                $logRpa->save();
                $transData = [
                    'trnx' => $response['data']['transactionId'],
                    'user_id' => $accessKeyExists->merchant_id,
                    'user_type' => 2,
                    'currency_id' => 15,
                    'wallet_id' => $walletMerchant->id,
                    'amount' => $bill_value,
                    'remark' => 'Pay bill ' . $category,
                    'type' => '-',
                    'details' => 'Merchant' . $merchant->name . ' Paid bill for ' . $response['data']['transactionId']
                ];
                if ($type_payment === 'payment') {
                    $walletMerchant->balance -= $bill_value;
                    $walletMerchant->save();
                    $transaction = Transaction::create($transData);
                }
                return $response->json();
            } else {
                return $this->sendError('Failed to send data', $response->body(), $response->status());
            }
        } catch (\Exception $e) {
            return $this->sendError('Exception occurred', $e->getMessage(), 500);
        }
    }
    public function merchantGetInfo($transactionId, Request $request)
    {
        $access_key = $request->header('Authorization') ?? '';
        $accessKeyExists = ApiCreds::where('access_key', $access_key)->first();
        if (empty($access_key) || !$accessKeyExists) {
            return $this->sendError('Error', ['unauthorized']);
        }
        try {
            $response = Http::get(route('detailsTransaction', ['transactionId' => $transactionId]));
            if ($response->successful()) {
                if ($response->json()['data']['response_from_bot'] != null) {

                    $data_respone = json_decode($response->json()['data']['response_from_bot']);
                    $logRpa = RPALogs::where('transactionId', $transactionId)->first();
                    if ($logRpa == null) {
                        return $this->sendError('Transction is processing, back again', 400);
                    }
                    $logRpa->data_receive = $response->json()['data']['response_from_bot'];
                    $logRpa->status = $response->json()['data']['status'];
                    $logRpa->status_respone = $data_respone->status ?? null;
                    $logRpa->save();
                    return  $this->sendResponse($data_respone, 'success');
                }
                return $this->sendError('Transction is processing, back again');
            } else {
                return $this->sendError('Failed to send data', $response->body(), $response->status());
            }
        } catch (\Exception $e) {
            return $this->sendError('Exception occurred', $e->getMessage(), 500);
        }
    }
    public function sendSMS(Request $request, $mode)
    {

        $message = $request->message ?? '';
        $phoneTo = $request->phone_number ?? '';
        $access_key = $request->header('Authorization') ?? '';
        $accessKeyExists = ApiCreds::where('access_key', $access_key)->first();

        if (empty($access_key) || !$accessKeyExists) {
            return $this->sendError('Error', ['unauthorized']);
        }
        if (!$message || !$phoneTo) {
            return $this->sendError('Required Field');
        }
        if (strlen($phoneTo) > 10 || !preg_match('/^\d+$/', $phoneTo)) {
            return $this->sendError('Invalid phone number. Must be at least 10 digits and contain only numbers.');
        }
        if (!in_array($mode, ['sandbox', 'production'])) {
            return $this->sendError('Invalid mode specified.');
        }
        $merchant = MerChant::where('id', $accessKeyExists->merchant_id)->first();
        $sendMess = SendSMSHelper::send($phoneTo, $message, $mode);

        if (isset($sendMess['error'])) {
            return $this->sendError('Something wrong. Try again');
        }

        $logSendSMS = new LogSendSMS();
        $logSendSMS->phone_from = $merchant->phone;
        $logSendSMS->phone_to = $phoneTo;
        $logSendSMS->status = ($sendMess->status() === 200) ? 1 : 0;
        $logSendSMS->user_id = $merchant->id;
        $logSendSMS->user_type = 2;
        $logSendSMS->enviroment = $mode;
        $logSendSMS->message_id = $sendMess['MessageId'];
        $logSendSMS->message_info = $message;
        $logSendSMS->TransID = isset($sendMess['TransID']) ? $sendMess['TransID'] : null;
        $logSendSMS->save();
        $dataRes = $sendMess->body();
        $json = json_decode($dataRes, true);

        return $this->sendResponse($json, 'success');
    }
    public function getBillApota(Request $request)
    {
        $bill_code = $request->bill_code ?? '';
        $service_code = $request->service_code ?? '';
        if (empty($bill_code) || empty($service_code)) {
            return $this->sendError('Required Field');
        }
        $data = [
            'bill_code' => $bill_code,
            'service_code' => $service_code,
        ];
        $response =  Http::post(route('checkBillApota'), $data);

        $res = $response['data']['data'];
        if ($res['errorCode'] !== 0) {
            return $this->sendError('Something went wrong. Try again', ['errorCode' => $res['errorCode'], 'message' => $res['message']]);
        }
        $billDetail = $res['billDetail'];
        $parnerRefId = $response['data']['parnerRefId'];
        $dataResponse = [
            'billDetail' => $billDetail,
            'customer' => $res['customerInfo'],
            'parnerRefId' => $parnerRefId
        ];
        return $this->sendResponse($dataResponse, 'success');
    }
    public function payBillApota(Request $request)
    {
        $billDetail = $request->billDetail ?? '';
        $bill_code = $request->bill_code ?? '';
        $service_code = $request->service_code ?? '';
        $refId = $request->refId ?? '';
        if ($billDetail == '' || $bill_code == '' || $service_code == '' || $refId == '') {
            return $this->sendError('Required Field');
        }
        $access_key = $request->header('Authorization') ?? '';
        $accessKeyExists = ApiCreds::where('access_key', $access_key)->first();

        $walletMerchant = Wallet::where('user_id', $accessKeyExists->merchant_id)->where('user_type', 2)->where('currency_id', 15)->first();
        $amount = $amount = $billDetail[0]['amount'];
        if ($amount > $walletMerchant->balance) {
            return $this->sendError('Insufficient balance');
        }
        $category = ServiceApotas::where('serviceCode', $service_code)->first();
        $data = [
            'billDetail' => $billDetail,
            'bill_code' => $bill_code,
            'service_code' => $service_code,
            'refId' => $refId
        ];
        $response = Http::post(route('payBillApota'), $data);
        if ($response['success'] == false) {
            return $this->sendError($response['message']);
        }
        $merchant = Merchant::where('id', $accessKeyExists->merchant_id)->first();
        $transData = [
            'trnx' => str_rand(),
            'user_id' => $merchant->id,
            'user_type' => 2,
            'currency_id' => 15,
            'wallet_id' => $walletMerchant->id,
            'amount' => $amount,
            'remark' => $category->categories,
            'type' => '-',
            'details' => 'Merchant ' . $merchant->name . ". Paid $category->categories. bill_code:$bill_code "  . "with $refId"
        ];
        $transaction = Transaction::create($transData);
        $walletMerchant->balance -= $amount;
        $walletMerchant->save();
        return $this->sendResponse($response['data'], 'Paid bill successfully');
    }
    public function topupMobileApota(Request $request)
    {
        $telco = $request->telco ?? '';
        $telcoServiceType = $request->telcoServiceType ?? '';
        $phoneNumber = $request->phoneNumber ?? '';
        $productCode =  $request->productCode ?? '';
        if ($telco == '' || $telcoServiceType == '' || $phoneNumber == '' || $productCode == '') {
            return $this->sendError('Required Field');
        }
        $access_key = $request->header('Authorization') ?? '';
        $accessKeyExists = ApiCreds::where('access_key', $access_key)->first();

        $walletMerchant = Wallet::where('user_id', $accessKeyExists->merchant_id)->where('user_type', 2)->where('currency_id', 15)->first();
        $data = [
            'telco' => $telco,
            'telcoServiceType' => $telcoServiceType,
            'phoneNumber' => $phoneNumber,
            'productCode' => $productCode
        ];
        $product = ProductApota::where('productCode', $productCode)->first();
        $amount = $product->amount;
        if ($amount > $walletMerchant->balance) {
            return $this->sendError('Insufficient balance');
        }
        try {
            $response = Http::post(route('topupApota'), $data);

            // Kiểm tra response
            if ($response['success'] == false) {
                return $this->sendError($response['message'], $response->json()['response']);
            }
            $responseData = $response['data'];
            unset($responseData['appotapayTransId']);
            $merchant = Merchant::where('id', $accessKeyExists->merchant_id)->first();
            $transData = [
                'trnx' => str_rand(),
                'user_id' => $merchant->id,
                'user_type' => 2,
                'currency_id' => 15,
                'wallet_id' => $walletMerchant->id,
                'amount' => $responseData['amount'],
                'remark' => 'TOP_UP',
                'type' => '-',
                'details' => 'Merchant ' . $merchant->name . "Used topup mobile for " . $responseData['phoneNumber'] . "With amount:" . $responseData['amount']
            ];
            $transaction = Transaction::create($transData);
            $walletMerchant->balance -= $amount;
            $walletMerchant->save();
            return $this->sendResponse($responseData, 'Successfull');
        } catch (\Exception $e) {
            // Bắt bất kỳ exception nào và trả về lỗi
            return $this->sendError('Something went wrong: ' . $e->getMessage());
        }
    }
    public function getProductApota(Request $request)
    {
        $cate = $request->type ?? '';
        $telco = $request->telco ?? '';
        $query = ProductApota::query();
        if (!empty($cate)) {
            if ($cate == 'data') {
                $query->where('telco', 'like', '%_data');
            } elseif ($cate == 'mobile') {
                $query->where('telco', 'not like', '%_data');
            }
        }
        if (!empty($telco)) {
            if ($cate == 'data') {
                $query->where('telco', '=', $telco . '_data');
            } elseif ($cate == 'mobile') {
                $query->where('telco', 'like', $telco);
            }
            $query->where('telco', 'like', "%$telco%");
        }
        $products = $query->get();
        if ($products->isEmpty()) {
            return $this->sendError('No products found with the given filters.', [], 404);
        }
        return $this->sendResponse($products, 'Products retrieved successfully.');
    }
}
