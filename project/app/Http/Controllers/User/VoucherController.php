<?php

namespace App\Http\Controllers\User;

use App\Models\VoucherGotit;
use App\Models\Wallet;
use App\Models\Voucher;
use App\Models\Transaction;
use Illuminate\Support\Str;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Carbon\Carbon;
use Illuminate\Support\Facades\Http;

class VoucherController extends Controller
{
    
    public function vouchers()
    {
        $vouchers = Voucher::where('user_id',auth()->id())->orderBy('status','asc')->paginate(20);
        return view('user.voucher.vouchers',compact('vouchers'));
    }

    public function create()
    {
        $wallets = Wallet::where('user_id',auth()->id())->where('user_type',1)->where('balance', '>', 0)->get();
        $voucherGotiits=VoucherGotit::all();
        $charge = charge('create-voucher');
        $recentVouchers = Voucher::where('user_id',auth()->id())->latest()->take(7)->get();
        return view('user.voucher.voucher_create',compact('wallets','charge','recentVouchers','voucherGotiits'));
    }

    public function submit(Request $request)
    {
        $request->validate([
            'wallet_id' => 'required|integer',
            'product' => 'required',
        ]);
        $product = explode('|', $request->input('product'));
        $productId = $product[0];
        $priceId = $product[1];
        
        $voucherGotit=VoucherGotit::where('productId', $productId)->where('priceId', $priceId)->first();
        $amount=$voucherGotit->priceValue;
        $wallet = Wallet::where('id',$request->wallet_id)->where('user_type',1)->where('user_id',auth()->id())->first();
        if(!$wallet) return back()->with('error','Wallet not found');
        
        $charge = charge('create-voucher');
        $rate = $wallet->currency->rate;
        
        $finalCharge = chargeCalc($charge,$amount,$rate);
        $finalAmount =$amount;
        $response = Http::post(route('createVoucherApiGotit'), [
            'productId' => $productId,
            'productPriceId' => $priceId,
            'expiryDate' => Carbon::now()->addMonths(12)->toDateString(),
            'orderName'=>'Voucher created by user Alaba Pay'
        ]);

      
        $voucher = new Voucher();
        $voucher->user_id = auth()->id();
        $voucher->currency_id = $wallet->currency_id;
        $voucher->amount = $amount;
        $voucher->code = $response['data'][0]['vouchers'][0]['voucherCode'];
        $voucher->transactionRefId = $response['data'][0]['vouchers'][0]['transactionRefId'];
        $voucher->voucher_link=$response['data'][0]['vouchers'][0]['voucherLink'];
        $voucher->voucher_serial=$response['data'][0]['vouchers'][0]['voucherSerial'];
        $voucher->expiryDate=$response['data'][0]['vouchers'][0]['expiryDate'];
        $voucher->save();
        
        // if($finalAmount > $wallet->balance) return back()->with('error','Wallet has insufficient balance');
        
        $wallet->balance -=  $finalAmount;
        $wallet->save();

        $trnx              = new Transaction();
        $trnx->trnx        = str_rand();
        $trnx->user_id     = auth()->id();
        $trnx->user_type   = 1;
        $trnx->currency_id = $wallet->currency->id;
        $trnx->amount      = $finalAmount;
        $trnx->charge      = $finalCharge;
        $trnx->remark      = 'create_voucher';
        $trnx->type        = '-';
        $trnx->details     = trans('Voucher created');
        $trnx->save();

        // $commissionTrnx              = new Transaction();
        // $commissionTrnx->trnx        = $trnx->trnx;
        // $commissionTrnx->user_id     = auth()->id();
        // $commissionTrnx->user_type   = 1;
        // $commissionTrnx->currency_id = $wallet->currency->id;
        // // $commissionTrnx->amount      = $commission;
        // $commissionTrnx->charge      = 0;
        // $commissionTrnx->remark      = 'voucher_commission';
        // $commissionTrnx->type        = '+';
        // $commissionTrnx->details     = trans('Voucher commission');
        // $commissionTrnx->save();

        return back()->with('success','Voucher has been created successfully');

    }

    public function reedemForm()
    {
        $recentReedemed = Voucher::where('status',1)->where('reedemed_by',auth()->id())->take(7)->get();
        return view('user.voucher.reedem',compact('recentReedemed'));
    }

    public function reedemSubmit(Request $request)
    {
       $request->validate(['code' => 'required']);

       $voucher = Voucher::where('code',$request->code)->where('status',0)->first();
      
       if(!$voucher){
           return back()->with('error','Invalid voucher code');
       }

       if( $voucher->user_id == auth()->id()){
          return back()->with('error','Can\'t reedem your own voucher');
       }
       
       $wallet = Wallet::where('currency_id',$voucher->currency_id)->where('user_id',auth()->id())->first();
       if(!$wallet){
          $wallet = Wallet::create([
              'user_id' => auth()->id(),
              'user_type' => 1,
              'currency_id' => $voucher->currency_id,
              'balance'   => 0
          ]);
       }

       $wallet->balance += $voucher->amount;
       $wallet->update();

       $trnx              = new Transaction();
       $trnx->trnx        = str_rand();
       $trnx->user_id     = auth()->id();
       $trnx->user_type   = 1;
       $trnx->currency_id = $wallet->currency->id;
       $trnx->amount      = $voucher->amount;
       $trnx->charge      = 0;
       $trnx->remark      = 'reedem_voucher';
       $trnx->details     = trans('Voucher reedemed');
       $trnx->save();

       $voucher->status = 1;
       $voucher->reedemed_by = auth()->id();
       $voucher->update();

       return back()->with('success','Voucher reedemed successfully');

    }

    public function reedemHistory()
    { 
        $history = Voucher::where('status',1)->where('reedemed_by',auth()->id())->paginate(20);
        return view('user.voucher.history',compact('history'));
    }
}
