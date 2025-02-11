<?php

namespace App\Http\Controllers\Admin;

use App\Models\RPALogs;
use App\Models\User;
use App\Models\Admin;
use App\Models\Country;
use App\Models\Deposit;
use App\Models\Currency;
use App\Models\Merchant;
use App\Models\Transaction;
use App\Models\Withdrawals;
use App\Helpers\MediaHelper;
use Illuminate\Http\Request;
use App\Models\Generalsetting;
use Illuminate\Support\Facades\DB;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Hash;
use App\Http\Requests\Admin\AdminProfileRequest;
use App\Models\RPAServices;
use InvalidArgumentException;
class AdminController extends Controller
{
   public function __construct()
   {
     $this->middleware('auth:admin');
   }


    // DASHBOARD
    public function index()
    {
        $data['totalUser']     = User::where('email_verified',1)->count();
        $data['totalMerchant'] = Merchant::where('email_verified',1)->count();
        $data['totalCurrency'] = Currency::count();
        $data['totalCountry']  = Country::count();
        $data['totalRole']     = DB::table('roles')->count();
        $data['totalStaff']    = Admin::where('role','!=','super-admin')->count();
    
        $profit = collect([]);
        Transaction::where('charge','>',0)->with('currency')->get()->map(function($q) use($profit){
            $profit->push((float) amountConv($q->charge,$q->currency));
        });
        $data['totalProfit'] = $profit->sum();

        $data['recentUsers']     = User::latest()->take(7)->get();
        $data['recentMerchants'] = Merchant::latest()->take(7)->get();

        $deposit = collect([]);
        Deposit::with('currency')->get()->map(function($q) use($deposit){
            $deposit->push((float) amountConv($q->amount,$q->currency));
        });
        $data['totalDeposit'] = $deposit->sum();

        $withdraw = collect([]);
        Withdrawals::with('currency')->get()->map(function($q) use($withdraw){
            $withdraw->push((float) amountConv($q->amount,$q->currency));
        });

        $data['totalWithdraw'] = $withdraw->sum();
        return view('admin.dashboard',$data);
    }

    // PROFILE
    public function profile()
    {
        $data = admin();
        return view('admin.profile',compact('data'));
    }


    // PROFILE
    public function profileupdate(AdminProfileRequest $request)
    {
        $request->validate(['name'=>'required','email'=>'required|email','phone'=>'required']);
        $data = admin();
        $input = $request->only('name','photo','phone','email');
        
        if($request->hasFile('photo')){
            $status = MediaHelper::ExtensionValidation($request->file('photo'));
            if(!$status){
                return back()->with('error','Image format is invalid');
            }
            $input['photo'] = MediaHelper::handleUpdateImage($request->file('photo'),$data->photo,[200,200]);
        }

        $data->update($input);
        return back()->with('success','Profile Updated Successfully');
    }

    // CHANGE PASSWORD
    public function passwordreset()
    {
        return view('admin.change_password');
    }

    public function changepass(AdminProfileRequest $request)
    {
        $request->validate(['old_password'=>'required','password'=>'required|confirmed|min:6']);
        $user = admin();
        if ($request->old_password){
            if (Hash::check($request->old_password, $user->password)){
                $user->password = bcrypt($request->password);
                $user->update();
            }else{
                return back()->with('error','Old Password Mismatch');  
            }
        }
    
        return back()->with('success','Password Changed Successfully');

    }

    public function profitReports()
    {
        $remark = request('remark');
        $search = request('search');
        $range = request('range');
        $startDate = null;
        $endDate   = null;
      
        if(request('range') != null){
            $date     = explode('-',$range);
            $startDate = @trim($date[0]);
            $endDate   = @trim($date[1]);

            if ($startDate && !preg_match("/\d{2}\/\d{2}\/\d{4}/",$startDate))  return back()->with('error','Invalid date format');
        
            if ($endDate && !preg_match("/\d{2}\/\d{2}\/\d{4}/",$endDate))  return back()->with('error','Invalid date format');
        }
        
        $logs = Transaction::when($remark,function($q) use($remark){
            return $q->where('remark',$remark);
        })
        ->when($search,function($q) use($search){
            return $q->where('trnx',$search);
        })
        ->when(request('range'),function($q) use($startDate,$endDate){
            return $q->whereDate('created_at','>=',dateFormat($startDate,'Y-m-d'))->whereDate('created_at','<=',dateFormat($endDate,'Y-m-d'));
        })
        ->where('charge','>',0)->with('currency')->latest()->paginate(15);
        return view('admin.profit_report',compact('logs','range'));
    }

    public function transactions()
    {
        $remark = request('remark');
        $search = request('search');
        $fromDate = request('from_date');
        $toDate = request('to_date');
        $remarks = Transaction::distinct()->pluck('remark');
        $transactions = Transaction::when($remark,function($q) use($remark){
            return $q->where('remark',$remark);
        })
        ->when($fromDate, function($q) use($fromDate) {
            return $q->whereDate('created_at', '>=', $fromDate);
        })
        ->when($toDate, function($q) use($toDate) {
            return $q->whereDate('created_at', '<=', $toDate);
        })
        ->when($search,function($q) use($search){
            return $q->where('trnx',$search);
        })
        ->with('currency')->latest()->paginate(15);
        return view('admin.transactions',compact('transactions','search','remarks'));
    }

    public function cookie()
    {
        return view('admin.cookie');
    }

    public function updateCookie(Request $request)
    {
        $data = $request->validate([
            'status' => 'required',
            'button_text' => 'required',
            'cookie_text' => 'required'
        ]);

        $gs = Generalsetting::first();
        $gs->cookie = $data;
        $gs->update();
        return back()->with('success','Cookie concent updated');
    }



    public function generate_bkup()
    {
        $bkuplink = "";
        $chk = file_get_contents('backup.txt');
        if ($chk != ""){
            $bkuplink = url($chk);
        }
        return view('admin.movetoserver',compact('bkuplink','chk'));
    }


    public function clear_bkup()
    {
        $destination  = public_path().'/install';
        $bkuplink = "";
        $chk = file_get_contents('backup.txt');
        if ($chk != ""){
            unlink(public_path($chk));
        }

        if (is_dir($destination)) {
            $this->deleteDir($destination);
        }
        $handle = fopen('backup.txt','w+');
        fwrite($handle,"");
        fclose($handle);
        //return "No Backup File Generated.";
        return redirect()->back()->with('success','Backup file Deleted Successfully!');
    }


    public function activation()
    {
        $activation_data = "";
        if (file_exists(base_path('..').'/project/vendor/markury/license.txt')){
            $license = file_get_contents(base_path('..').'/project/vendor/markury/license.txt');
            if ($license != ""){
                $activation_data = "<i style='color:#08bd08; font-size:45px!important' class='fas fa-check-circle mb-3'></i><br><h3 style='color:#08bd08;'>Your system is activated!</h3>";
            }
        }
        return view('admin.activation',compact('activation_data'));
    }


    public function activation_submit(Request $request)
    {
        
        $purchase_code =  $request->pcode;
        $my_script =  'Genius Wallet';
        $my_domain = url('/');

        $varUrl = str_replace (' ', '%20', config('services.genius.ocean').'purchase112662activate.php?code='.$purchase_code.'&domain='.$my_domain.'&script='.$my_script);

        if( ini_get('allow_url_fopen') ) {
            $contents = file_get_contents($varUrl);
        }else{
            $ch = curl_init();
            curl_setopt ($ch, CURLOPT_URL, $varUrl);
            curl_setopt ($ch, CURLOPT_RETURNTRANSFER, 1);
            $contents = curl_exec($ch);
            curl_close($ch);
        }

        $chk = json_decode($contents,true);

        if($chk['status'] != "success")
        {
            
            $msg = $chk['message'];
            return back()->with('error',$msg);

        }else{
            $this->setUp($chk['p2'],$chk['lData']);

            if (file_exists(base_path('..').'/rooted.txt')){
                unlink(base_path('..').'/rooted.txt');
            }

            $fpbt = fopen(base_path('..').'/project/vendor/markury/license.txt', 'w');
            fwrite($fpbt, $purchase_code);
            fclose($fpbt);

            $msg = 'Congratulation!! Your System is successfully Activated.';
            return back()->with('success',$msg);
          
        }
       
    }

    function setUp($mtFile,$goFileData){
        $fpa = fopen(base_path('..').$mtFile, 'w');
        fwrite($fpa, $goFileData);
        fclose($fpa);
    }

    public function recurse_copy($src,$dst) {
        $dir = opendir($src);
        @mkdir($dst);
        while(false !== ( $file = readdir($dir)) ) {
            if (( $file != '.' ) && ( $file != '..' )) {
                if ( is_dir($src . '/' . $file) ) {
                    $this->recurse_copy($src . '/' . $file,$dst . '/' . $file);
                }
                else {
                    copy($src . '/' . $file,$dst . '/' . $file);
                }
            }
        }
        closedir($dir);
    }

    public function deleteDir($dirPath) {
        if (! is_dir($dirPath)) {
            throw new InvalidArgumentException("$dirPath must be a directory");
        }
        if (substr($dirPath, strlen($dirPath) - 1, 1) != '/') {
            $dirPath .= '/';
        }
        $files = glob($dirPath . '*', GLOB_MARK);
        foreach ($files as $file) {
            if (is_dir($file)) {
                self::deleteDir($file);
            } else {
                unlink($file);
            }
        }
        rmdir($dirPath);
    }
    public function getBilling(){
        $listRPA=RPAServices::orderByDesc('created_at')->paginate(10);
        return view('admin.billing.index',compact('listRPA'));
    }
    public function detailsBill($transactionId){
        $listRPA=RPALogs::where('transactionId',$transactionId)->first();
        return view('admin.billing.details',compact('listRPA'));
    }
    public function updateBill(Request $request){
        dd($request->all());
    }


}
