<?php

namespace App\Http\Controllers\User;

use App\Models\RPALogs;
use App\Models\VoucherGotit;
use App\Models\Wallet;
use App\Models\Voucher;
use App\Models\Transaction;
use Illuminate\Support\Str;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use App\Models\ProductApota;
use App\Models\RPAServices;
use Carbon\Carbon;
use App\Models\ServiceApotas;
use Illuminate\Support\Facades\Http;

class UtilitiesController extends Controller
{
    public function electricBill()
    {
        $wallets = Wallet::where('user_id', auth()->id())->where('user_type', 1)->where('balance', '>', 0)->get();
        $recentPays = Transaction::where('user_id', auth()->id())->where('remark', 'pay_electric')->latest()->paginate(5);
        return view('user.utilities.electric', compact('wallets', 'recentPays'));
    }
    public function listServiceApota(Request $request)
    {
        $categories = [
            'BILL_ELECTRIC' => 'Hoá đơn điện',
            'BILL_WATER' => 'Hoá đơn nước',
            'BILL_TELEVISION' => 'Hoá đơn truyền hình',
            'BILL_FINANCE' => 'Hoá đơn tài chính',
            'BILL_INTERNET' => 'Hoá đơn Internet',
            'BILL_TELEPHONE' => 'Hoá đơn điện thoại',
            'BILL_EDU' => 'Hoá đơn học phí',
        ];
        $services = [];
        if ($request->has('categories')) {
            $category = $request->input('category');
            $services = ServiceApotas::where('category', $category)->get();
        }
        $transactions = Transaction::where('remark', 'pay_bill_ultilies')->where('user_id', auth()->id())->paginate(10);
        return view('user.utilities.electric', compact('categories', 'services', 'transactions'));
    }
    public function getListService(Request $request)
    {
        $categories = [
            'BILL_ELECTRIC' => 'Hoá đơn điện',
            'BILL_WATER' => 'Hoá đơn nước',
            'BILL_TELEVISION' => 'Hoá đơn truyền hình',
            'BILL_FINANCE' => 'Hoá đơn tài chính',
            'BILL_INTERNET' => 'Hoá đơn Internet',
            'BILL_TELEPHONE' => 'Hoá đơn điện thoại',
            'BILL_EDU' => 'Hoá đơn học phí',
        ];
        $services = [];
        if ($request->has('categories')) {
            $category = $request->input('category');
            $services = ServiceApotas::where('categories', $category)->get();
        }
        return view('user.utilities.electric', compact('categories', 'services'));
    }
    public function detailService($category)
    {
        $services = ServiceApotas::where('categories', $category)->get();
        $wallets = Wallet::where('user_id', auth()->id())->where('user_type', 1)->get();

        return view('user.utilities.detailsService', compact('category', 'services', 'wallets'));
    }
    public function userGetBillApota(Request $request)
    {

        $dataSend = [
            'bill_code' => $request->customer_code,
            'service_code' => $request->serviceCode,
        ];
        $wallets = Wallet::where('user_id', auth()->id())->where('user_type', 1)->where('balance', '>', 0)->get();

        $response = Http::post(route('checkBillApota'), $dataSend);
        if ($response->successful()) {
            $dataResponse = $response['data'];
            session()->put('billDetail', $dataResponse['data']['billDetail']);
            session()->put('refId', $dataResponse['parnerRefId']);
            session()->put('service_code', $request->serviceCode);
            session()->put('bill_code', $request->customer_code);
            $cate = ServiceApotas::where('serviceCode', $request->serviceCode)->first();
            $category = $cate->categories;
            $services = ServiceApotas::where('categories', $category)->get();
        } else {
            return redirect()->back()->withErrors(['msg' => 'Không thể kiểm tra hóa đơn.']);
        }

        return view('user.utilities.detailsService', compact('dataResponse', 'category', 'services', 'wallets'));
    }
    public function userPayBillApota(Request $requets)
    {

        $dataSend = [
            'billDetail' => json_decode($requets->bill_detail),
            'bill_code' => session()->get('bill_code'),
            'service_code' => session()->get('service_code'),
            'refId' => $requets->refId
        ];
        $charge = charge('create-voucher');

        $wallets = Wallet::where('user_id', auth()->id())->where('user_type', 1)->get();
        $amount = json_decode($requets->bill_detail);
        $wallet_id = $requets->wallet_id;
        $wallet = Wallet::find($wallet_id);
        if ($amount[0]->amount > $wallet->balance) {
            return back()->with('error', __('Not enough balance'));
        }
        $response = Http::post(route('payBillApota'), $dataSend);
        if ($response->successful()) {
            $wallet->balance -=  $amount[0]->amount;
            $wallet->save();

            $trnx              = new Transaction();
            $trnx->trnx        = str_rand();
            $trnx->wallet_id   =  $wallet->id;
            $trnx->user_id     = auth()->id();
            $trnx->user_type   = 1;
            $trnx->currency_id = $wallet->currency->id;
            $trnx->amount      = $amount[0]->amount;
            $trnx->charge      = 0;
            $trnx->remark      = 'pay_bill_ultilies';
            $trnx->type        = '-';
            $trnx->details     = trans("User Pay $requets->category");
            $trnx->save();
            return redirect(route('user.listServiceAptota'))->with('success', __('Pay bill success'));
        } else {
            return back()->with('error', __('This bill is paid or Something went wrong'));
        }
    }
    public function topupPhone(Request $request)
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
        $wallets = Wallet::where('user_id', auth()->id())->where('user_type', 1)->where('balance', '>', 0)->get();
        $recentPays = Transaction::where('user_id', auth()->id())->where('remark', 'pay_top_up')->latest()->paginate(5);

        return view('user.utilities.topupphone', compact('wallets', 'recentPays','products'));
    }

    public function payTopupPhone(Request $request)
    {
        $customer_code = $request->phone_number ?? '';
        $bill_value = $request->bill_value ?? '';
        $wallet_id = $request->wallet_id ?? '';
        $type_category = $request->type_category ?? '';
        if ($customer_code == '' || $bill_value == '' || $wallet_id == '' || $type_category == '') {
            return back()->with('error', 'Required filed');
        }
        $wallets = Wallet::where('user_id', auth()->id())->where('user_type', 1)->get();
        $wallet = Wallet::find($wallet_id);
        if ($bill_value > $wallet->balance) {
            return back()->with('error', __('Not enough balance'));
        }

        $dataSend = [
            'customer_code' => $customer_code,
            'bill_value' => $bill_value,
            'type_category' => $type_category,
            'category' => 'PHONE',
            'type_payment' => 'payment'
        ];

        $response = Http::post(route('rpaUserSendInfo'), $dataSend);
        if ($response->successful()) {
            $dataRes = $response->json()['data'];
            $transactionId = $dataRes['transactionId'];
            $getDetails = Http::get(route('detailsTransaction', ['transactionId' => $transactionId]));
            sleep(25);
            $responeFromBot = RPAServices::where('transactionId', $transactionId)->first();
            $dataOfBot = json_decode($responeFromBot->response_from_bot);
            if ($dataOfBot->status == 1) {
                $rpaLogs = new RPALogs();
                $rpaLogs->transactionId = $transactionId;
                $rpaLogs->user_id = auth()->id();
                $rpaLogs->user_type = 1;
                $rpaLogs->type_service = 'PHONE';
                $rpaLogs->data_send =  json_encode($dataSend);
                $rpaLogs->data_receive =  $responeFromBot->response_from_bot;
                $rpaLogs->type_payment = 'payment';
                $rpaLogs->status = $responeFromBot->status;
                $rpaLogs->status_respone = $dataOfBot->status;
                $rpaLogs->save();
                return redirect()->route('user.topup')->with('error', __('Somethings went wrong. Please try again'));
            }
            $charge = charge('create-voucher');
            $rpaLogs = new RPALogs();
            $rpaLogs->transactionId = $transactionId;
            $rpaLogs->user_id = auth()->id();
            $rpaLogs->user_type = 1;
            $rpaLogs->type_service = 'PHONE';
            $rpaLogs->data_send = json_encode($dataSend);
            $rpaLogs->data_receive = $responeFromBot->response_from_bot;
            $rpaLogs->type_payment = 'payment';
            $rpaLogs->status = $responeFromBot->status;
            $rpaLogs->status_respone = $dataOfBot->status;
            $rpaLogs->save();
            $wallet->balance -=  $bill_value;
            $wallet->save();
            $trnx              = new Transaction();
            $trnx->trnx        = str_rand();
            $trnx->user_id     = auth()->id();
            $trnx->user_type   = 1;
            $trnx->currency_id = $wallet->currency->id;
            $trnx->amount      = $bill_value + ($bill_value * $charge->percent_charge / 100);
            $trnx->charge      =  $charge->percent_charge;
            $trnx->remark      = 'pay_top_up';
            $trnx->type        = '-';
            $trnx->details     = 'User paid top up for phone number:' . $customer_code;
            $trnx->save();
            return redirect()->route('user.topup')->with('success', __($dataOfBot->message));

            // return view('user.utilities.topupphone',compact('dataOfBot','wallets'));
        } else {
            return response()->json(['success' => false, 'message' => 'Failed to retrieve information']);
        }
    }
}
