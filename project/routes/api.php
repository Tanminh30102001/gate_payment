<?php

use App\Http\Controllers\Api\ThirdParrty\GOTITController;
use App\Http\Controllers\Api\ThirdParrty\VIMOController;
use App\Http\Controllers\Api\ThirdParrty\ApotaController;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Api\User\AuthController;
use App\Http\Controllers\Api\User\UserController;
use App\Http\Controllers\Front\FrontendController;
use App\Http\Controllers\Api\User\EscrowController;
use App\Http\Controllers\Api\User\DepositController;
use App\Http\Controllers\Api\User\VoucherController;
use App\Http\Controllers\Api\SupportTicketController;
use App\Http\Controllers\Api\User\TransferController;
use App\Http\Controllers\Api\Merchant\LoginController;
use App\Http\Controllers\Api\User\MakePaymentController;
use App\Http\Controllers\Api\Merchant\MerchantController;
use App\Http\Controllers\Api\User\RequestMoneyController;
use App\Http\Controllers\Api\User\ExchangeMoneyController;
use App\Http\Controllers\Api\User\ManageInvoiceController;
use App\Http\Controllers\Api\Merchant\WithdrawalController;
use App\Http\Controllers\Api\ThirdParrty\DataComController;
use App\Http\Controllers\Api\User\WithdrawalController as UserWithdrawalController;
use Telegram\Bot\Api;

Route::get('qr-code-scan/{email}',   [FrontendController::class, 'scanQR']);
Route::get('module',   [FrontendController::class, 'moduleData']);


Route::prefix('user')->middleware('maintenance')->group(function () {
    Route::post('login',                           [AuthController::class, 'login']);
    Route::post('register',                        [AuthController::class, 'register']);
    Route::post('forgot-password',                 [AuthController::class, 'forgotPasswordSubmit']);
    Route::post('forgot-password/verify-code',     [AuthController::class, 'verifyCodeSubmit']);
    Route::post('reset-password',                  [AuthController::class, 'resetPasswordSubmit']);

    Route::post('verify-email',                    [AuthController::class, 'verifyEmailSubmit'])->middleware('auth:sanctum');

    Route::get('resend/verify-email/code',         [AuthController::class, 'verifyEmailResendCode'])->name('verify.email.resend')->middleware('auth:sanctum');

    Route::post('two-step/verification',           [AuthController::class, 'twoStepVerify'])->middleware('auth:sanctum');
    Route::post('send/two-step/verify-code/',      [AuthController::class, 'twoStepsendCode'])->middleware('auth:sanctum');
    Route::post('/two-step/code/verify',            [AuthController::class, 'twoStepCodeVerify'])->middleware('auth:sanctum');
    Route::get('resend/two-step/verify-code',      [AuthController::class, 'twoStepResendCode'])->middleware('auth:sanctum');

    Route::middleware(['auth:sanctum', 'email_verify', 'twostep_api'])->group(function () {
        Route::get('settings',                [AuthController::class, 'settings']);
        Route::post('logout',                  [AuthController::class, 'logout']);
        Route::get('/dashboard',               [UserController::class, 'index']);
        Route::get('/generate-qrcode',         [UserController::class, 'generateQR']);
        Route::get('/user-info',               [UserController::class, 'userInfo']);

        Route::get('kyc-form-data',            [UserController::class, 'kycForm']);
        Route::post('kyc-form',                [UserController::class, 'kycFormSubmit']);

        Route::get('transactions',             [UserController::class, 'transactions']);
        Route::get('transaction/details/{id}', [UserController::class, 'trxDetails']);

        Route::post('profile-settings',        [UserController::class, 'profileSubmit']);
        Route::post('change-password',         [UserController::class, 'changePass']);

        Route::middleware(['module', 'kyc'])->group(function () {
            //transfer-money
            Route::get('transfer-money',    [TransferController::class, 'transferForm']);
            Route::post('transfer-money',   [TransferController::class, 'submitTransfer']);

            //Request Money
            Route::get('request-money',     [RequestMoneyController::class, 'requestForm']);
            Route::post('request-money',    [RequestMoneyController::class, 'requestSubmit']);

            //exchange money
            Route::get('exchange-money',    [ExchangeMoneyController::class, 'exchangeForm']);
            Route::post('exchange-money',   [ExchangeMoneyController::class, 'submitExchange']);

            // merchant payment
            Route::get('make-payment',      [MakePaymentController::class, 'paymentForm']);
            Route::post('make-payment',     [MakePaymentController::class, 'submitPayment']);

            //voucher
            Route::get('create-voucher',    [VoucherController::class, 'create']);
            Route::post('create-voucher',   [VoucherController::class, 'submit']);

            //withdraw
            Route::get('withdraw-money',    [UserWithdrawalController::class, 'withdrawForm']);
            Route::post('withdraw-money',   [UserWithdrawalController::class, 'withdrawSubmit']);
            Route::get('cash-out',          [UserWithdrawalController::class,'cashOutForm']);
            Route::post('cash-out',         [UserWithdrawalController::class,'cashOut']);
            Route::post('check-ajent',      [UserWithdrawalController::class, 'checkReceiver']);

            //invoice
            Route::get('create-invoice',    [ManageInvoiceController::class, 'create']);
            Route::post('create-invoice',   [ManageInvoiceController::class, 'store']);

            //escrow
            Route::get('make-escrow',       [EscrowController::class, 'create']);
            Route::post('make-escrow',      [EscrowController::class, 'store']);

            //deposit
            Route::get('deposit',           [DepositController::class, 'index'])->name('deposit.index');
        });

        //transfer-money
        Route::get('transfer-money/history',  [TransferController::class, 'transferHistory']);
        Route::post('check-receiver',         [TransferController::class, 'checkReceiver']);

        //Request Money
        Route::get('money-request',           [RequestMoneyController::class, 'moneyRequests']);
        Route::get('sent-money-requests',     [RequestMoneyController::class, 'sentRequests']);
        Route::get('received-money-requests', [RequestMoneyController::class, 'receivedRequests']);
        Route::post('accept-money-request',   [RequestMoneyController::class, 'acceptRequest']);
        Route::post('reject-money-request',   [RequestMoneyController::class, 'rejectRequest']);

        //exchange money
        Route::get('exchange-money/history',  [ExchangeMoneyController::class, 'exchangeHistory']);

        //payment history
        Route::get('payment/history',   [MakePaymentController::class, 'paymentHistory']);
        Route::post('check-merchant',   [MakePaymentController::class, 'checkMerchant']);

        //Reedem voucher
        Route::get('vouchers',          [VoucherController::class, 'vouchers']);
        Route::get('redeem-voucher',    [VoucherController::class, 'reedemForm']);
        Route::post('redeem-voucher',   [VoucherController::class, 'reedemSubmit']);
        Route::get('redeemed-history',  [VoucherController::class, 'reedemHistory']);

        //withdraw
        Route::get('withdraw-methods',  [UserWithdrawalController::class, 'methods']);
        Route::get('withdraw-history',  [UserWithdrawalController::class, 'history']);
        Route::post('check/agent',      [UserWithdrawalController::class, 'checkReceiver']);

        //support ticket
        Route::get('support/tickets',                        [SupportTicketController::class, 'index'])->name('user.tickets');
        Route::get('support/ticket/messages/{ticket_num}',   [SupportTicketController::class, 'messages'])->name('user.ticket.messages');
        Route::post('open/support/ticket',                   [SupportTicketController::class, 'openTicket'])->name('user.ticket.open');
        Route::post('reply/ticket/{ticket_num}',             [SupportTicketController::class, 'replyTicket'])->name('user.ticket.reply');

        //invoice
        Route::get('invoices',                  [ManageInvoiceController::class, 'index']);
        Route::post('invoice/pay-status',       [ManageInvoiceController::class, 'payStatus']);
        Route::post('invoice/publish-status',   [ManageInvoiceController::class, 'publishStatus']);
        Route::get('invoices-edit/{id}',        [ManageInvoiceController::class, 'edit']);
        Route::post('invoices-update/{id}',     [ManageInvoiceController::class, 'update']);
        Route::get('invoice-cancel/{id}',       [ManageInvoiceController::class, 'cancel']);
        Route::get('invoice/send-mail/{id}',    [ManageInvoiceController::class, 'sendToMail']);
        Route::get('invoice/view/{number}',     [ManageInvoiceController::class, 'view']);

        //escrow
        Route::get('my-escrow',              [EscrowController::class, 'index']);
        Route::get('escrow-pending',         [EscrowController::class, 'pending']);
        Route::get('escrow-dispute/{id}',    [EscrowController::class, 'disputeForm']);
        Route::post('escrow-dispute/{id}',   [EscrowController::class, 'disputeStore']);
        Route::get('release-escrow/{id}',    [EscrowController::class, 'release']);
        Route::get('file-download/{id}',     [EscrowController::class, 'fileDownload'])->name('user.api.escrow.file.download');

        //deposit
        Route::post('deposit/submit',        [DepositController::class, 'depositSubmit']);
        Route::post('payment-submit',        [DepositController::class, 'depositPayment'])->name('deposit.payment');
        Route::get('deposit/history',        [DepositController::class, 'dipositHistory'])->name('deposit.history');
        Route::get('gateway-methods',        [DepositController::class, 'methods'])->name('gateway.methods');
        Route::post('deposit-process',       [DepositController::class, 'depositProcess'])->name('deposit.process');

        //twostep
        Route::post('/two-step/send-code',        [UserController::class, 'twoStepSendCode']);
        Route::post('/two-step/verify',           [UserController::class, 'twoStepVerifySubmit']);
    });
});
//===================RPA======================================//

Route::post('/user-send-info',[\App\Http\Controllers\Api\ThirdParrty\VIMOController::class, 'getInfo'])->name('rpaUserSendInfo'); //->Dùng để bên App gửi thông tin sever-> Lưu lại 
Route::get('/bot-get-info',[\App\Http\Controllers\Api\ThirdParrty\VIMOController::class, 'botGetInfo']);//->Dùng để bot lấy thông tin từ sever
Route::post('/bot-send-info',[\App\Http\Controllers\Api\ThirdParrty\VIMOController::class, 'botSendInfo']);
Route::post('/bot-update-status',[\App\Http\Controllers\Api\ThirdParrty\VIMOController::class, 'botUpdateStatus']);//->Dùng để bot update status
Route::get('/get-transaction/{transactionId}',[\App\Http\Controllers\Api\ThirdParrty\VIMOController::class, 'getDetailsTrans'])->name('detailsTransaction');
//==========================================================//
//VIMO service
Route::get('get-bill-vimo',   [\App\Http\Controllers\Api\ThirdParrty\VIMOController::class, 'getBill'])->name('getBillApiVimo');
Route::get('get-balance',   [\App\Http\Controllers\Api\ThirdParrty\VIMOController::class, 'getBalancec']);
Route::post('pay-bill',   [\App\Http\Controllers\Api\ThirdParrty\VIMOController::class, 'payBill'])->name('payBillApiVimo');
Route::get('/webhook-rpa',[\App\Http\Controllers\Api\ThirdParrty\VIMOController::class,'webhookRPA']);
//end vimo service
//Got it service 
Route::get('get-voucher-gotit',   [GOTITController::class, 'index'])->name('getVoucherApiGotit');
Route::post('create-voucher-gotit',[GOTITController::class, 'create'])->name('createVoucherApiGotit');
Route::get('get-brands', [GOTITController::class, 'getBrands']);
Route::get('get-details/{transactionId}',[GOTITController::class, 'getDetails']);
Route::get('get-categories',[GOTITController::class, 'getCategories']);
Route::get('get-brands-categories/{cateId}',[GOTITController::class, 'getBrandsByCate']);
Route::post('gotit/webhook',[GOTITController::class, 'handleWebhook']);
//======================DataCom flight=====================//
Route::post('searchFlight',[DataComController::class,'searchFlight'])->name('searchFlight');
Route::post('searchMinFare',[DataComController::class,'searchMinFare'])->name('searchMinFare');// Giá thấp nhất trong ngày
Route::post('searchMinMonth',[DataComController::class,'searchMinMonth'])->name('searchMinMonth');//giá thấp nhất trong THáng
Route::post('getInfoBagge',[DataComController::class,'getInfoBagge'])->name('getInfoBagge');//Lấy thông tin của hành lý ký gửi 
Route::post('getFarerules',[DataComController::class,'getFareRules'])->name('getFarerules');// Láy thông tin điều kiện vé
Route::post('checkFlight',[DataComController::class,'checkInfoFlight'])->name('checkInfoFlight');
//=====================End DataCom=========================//
// ============================Apota==============================///
Route::get('get-categories-billing',[ApotaController::class, 'getCategories']);
Route::get('get-service-billing',[ApotaController::class, 'getService'])->name('getServiceApota');
Route::post('check-bill',[ApotaController::class,'getBill'])->name('checkBillApota');
Route::post('pay-bill',[ApotaController::class,'payBill'])->name('payBillApota');
Route::get('get-info-card',[ApotaController::class, 'getProductApota']);
Route::post('topup-mobile',[ApotaController::class, 'topupMobile'])->name('topupApota');


////========================= end apota==========================//

//merchant
Route::prefix('merchant')->middleware(['maintenance', 'check.merchant.auth'])->group(function () {
    //merchant use 
    // Route::get('getpublisher', [MerchantController::class, 'getPubliser']);
    // Route::get('getbill', [MerchantController::class, 'getBill']);
    // Route::post('paybill',[MerchantController::class, 'payBill']);
    ///
    //merchant use got it
    Route::post('create-voucher',[MerchantController::class,'createVoucher']);
    Route::get('getvoucher', [MerchantController::class, 'merchantGetVoucher']);
    Route::get('get-details-voucher/{transactionId}',[MerchantController::class, 'getDetailsVoucher']);
    Route::get('get-brands', [MerchantController::class, 'getBrands']);
    Route::get('get-categories', [MerchantController::class, 'getCategories']);
    Route::get('get-brands/{cateId}/category', [MerchantController::class, 'getBrandByCate']);
    // 
    //merchant use sendSMS  
    Route::post('sendMessage/{mode}', [MerchantController::class, 'sendSMS']);
    // Merchant use billing  Apota
    Route::post('get-bill',[MerchantController::class,'getBillApota']);
    Route::post('pay-bill',[MerchantController::class,'payBillApota']);
    Route::get('get-categories-billing',[ApotaController::class, 'getCategories']);
    Route::get('get-service-billing',[ApotaController::class, 'getService'])->name('getServiceApota');
    Route::post('top-up',[MerchantController::class,'topupMobileApota']);
    Route::get('get-info-topup',[MerchantController::class, 'getProductApota']);
    //
    //merchant check bill and pay bill by RPA
    Route::get('get-service', [MerchantController::class, 'getListService']);
    Route::get('get-details-service', [MerchantController::class, 'getDetailsService']);
    Route::post('send-info',[MerchantController::class,'merchantSendInfo']);
    Route::get('/get-info/{transactionId}',[MerchantController::class,'merchantGetInfo']);
  
    ////
    Route::post('login',                           [LoginController::class, 'login']);
    Route::post('register',                        [LoginController::class, 'register']);
    Route::post('forgot-password',                 [LoginController::class, 'forgotPasswordSubmit']);
    Route::post('forgot-password/verify-code',     [LoginController::class, 'verifyCodeSubmit']);
    Route::post('reset-password',                  [LoginController::class, 'resetPasswordSubmit']);

    Route::post('verify-email',                    [LoginController::class, 'verifyEmailSubmit'])->middleware('auth:sanctum');

    Route::get('resend/verify-email/code',         [LoginController::class, 'verifyEmailResendCode'])->name('verify.email.resend')->middleware('auth:sanctum');

    Route::post('two-step/verification',           [LoginController::class, 'twoStepVerify'])->middleware('auth:sanctum');
    Route::get('resend/two-step/verify-code',      [LoginController::class, 'twoStepResendCode'])->middleware('auth:sanctum');

    Route::get('/logout',                          [LoginController::class, 'logout'])->name('logout')->middleware('auth:sanctum');

    Route::middleware(['auth:sanctum', 'merchant_email_verify', 'twostep_api'])->group(function () {
        Route::get('/dashboard',                  [MerchantController::class, 'dashboard'])->name('dashboard');
        Route::get('/generate-qrcode',            [MerchantController::class, 'generateQR'])->name('qr');

        Route::get('transactions',                [MerchantController::class, 'transactions']);
        Route::get('transaction/details/{id}',    [MerchantController::class, 'trxDetails']);

        Route::post('/profile-setting',           [MerchantController::class, 'profileUpdate']);
        Route::post('/change-password',           [MerchantController::class, 'updatePassword']);

        //kyc form
        Route::get('kyc-form-data',               [MerchantController::class, 'kycForm']);
        Route::post('kyc-form',                   [MerchantController::class, 'kycFormSubmit']);

        //twostep
        Route::post('/two-step/send-code',        [MerchantController::class, 'twoStepSendCode']);
        Route::post('/two-step/verify',           [MerchantController::class, 'twoStepVerifySubmit']);


        Route::get('withdraw-methods',            [WithdrawalController::class, 'methods']);
        Route::get('withdraw-history',            [WithdrawalController::class, 'history']);

        Route::post('generate-api-key',           [MerchantController::class, 'apiKeyGenerate']);
        Route::get('service-mode',                [MerchantController::class, 'serviceMode']);

        //support ticket
        Route::get('support/tickets',                        [SupportTicketController::class, 'index'])->name('merchant.tickets');
        Route::get('support/ticket/messages/{ticket_num}',   [SupportTicketController::class, 'messages'])->name('merchant.ticket.messages');
        Route::post('open/support/ticket',                   [SupportTicketController::class, 'openTicket'])->name('merchant.ticket.open');
        Route::post('reply/ticket/{ticket_num}',             [SupportTicketController::class, 'replyTicket'])->name('merchant.ticket.reply');
    });
});
