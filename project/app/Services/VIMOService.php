<?php

namespace App\Services;

use Illuminate\Http\Client\Request;
use Illuminate\Support\Facades\Http;

class VIMOSerVice
{
    protected $baseUrl;
    protected $MC_ENCRYPT_KEY;
    protected $MC_CODE;
    protected $MC_CHECKSUM_KEY;

    public function __construct()
    {
        $this->baseUrl =env('VIMO_URL');
        $this->MC_ENCRYPT_KEY = env('MC_ENCRYPT_KEY');
        $this->MC_CODE = env('MC_CODE');
        $this->MC_CHECKSUM_KEY = env('MC_CHECKSUM_KEY');
    }

    public function getBill($customer_code, $service_code, $publisher)
    {
        
        $url = env('VIMO_URL') . '/querybill';
        // ở đây sẽ truyền thêm vào authorize của vimo 
        $MC_ENCRYPT_KEY = env('MC_ENCRYPT_KEY');
        $MC_CODE = env('MC_CODE');
        $MC_CHECKSUM_KEY = env('MC_CHECKSUM_KEY');
        $data = [
            'mc_request_id' => 'BILL-1563261' . generateNumber(),
            'customer_code' => $customer_code,
            'publisher' => $publisher,
            'service_code' => $service_code,
        ];

        $jsonString = json_encode($data, JSON_UNESCAPED_SLASHES);
        $encryptedData = encryptData($jsonString, $MC_ENCRYPT_KEY);
        $md5str = $MC_CODE . $encryptedData . $MC_CHECKSUM_KEY;
        $checksum = md5($md5str);
        $params = [
            'fnc' => 'getbalance',
            'merchantcode' => $MC_CODE,
            'data' => $encryptedData,
            'checksum' => $checksum,
        ];
        $response = Http::withHeaders([
            'Authorization' => 'Basic ' . env('AUTHORIZE'),
            'Content-Type' => 'application/x-www-form-urlencoded',
        ])->asForm()->post($url, $params);
        if ($response->successful()) {
            $responseData = $response->json();
            if (isset($responseData['data'])) {
                return [
                    'status' => 'success',
                    'data' => $responseData['data']
                ];
            } else {
                return [
                    'status' => 'error',
                    'message' => 'No data found in response.'
                ];
            }
        } else {
            return [
                'status' => 'error',
                'message' => 'Unexpected HTTP status: ' . $response->status() . ' ' . $response->reason()
            ];
        }
    }


    public function getBalance(){
        $data = [
            'mc_request_id' => 'BILL-1563261' . generateNumber(),
        ];
        $jsonString = json_encode($data, JSON_UNESCAPED_SLASHES);
        $encryptedData = encryptData($jsonString, $this->MC_ENCRYPT_KEY);
        $md5str = $this->MC_CODE . $encryptedData . $this->MC_CHECKSUM_KEY;
        $checksum = md5($md5str);
        $params = [
            'fnc' => 'getbalance',
            'merchantcode' => $this->MC_CODE,
            'data' => $encryptedData,
            'checksum' => $checksum,
        ];
        $response = Http::withHeaders([
            'Authorization' => 'Basic ' . env('AUTHORIZE_TEST'),
            'Content-Type' => 'application/x-www-form-urlencoded',
        ])->asForm()->post($this->baseUrl.'/getbalance', $params);
        if ($response->successful()) {
            $responseData = $response->json();
            if (isset($responseData['data'])) {
                return [
                    'status' => 'success',
                    'data' => $responseData['data']
                ];
            } else {
                return [
                    'status' => 'error',
                    'message' => 'No data found in response.'
                ];
            }
        } else {
            return [
                'status' => 'error',
                'message' => 'Unexpected HTTP status: ' . $response->status() . ' ' . $response->reason()
            ];
        }
    }
    public function getBalancePiPay(){
          // URL của API
    $url = 'https://api-pipay.pigaming.co/api/v1/orders/payment/get-balance';
    $ch = curl_init($url);
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true); // Cho phép lấy kết quả trả về từ server

    $response = curl_exec($ch);
    if(curl_errno($ch)) {
        $error_msg = curl_error($ch);
    }
    curl_close($ch);

    return $response;
    }
    public function payBill($billNumber,$amount,$period,$customer_code,$publisher, $service_code)
{
    $fnc = 'paybill';
    $request_id = 'BILL-1563261' . rand(1000, 9999);
    $bill_payment = [
        "billNumber" => $billNumber,
        "period" => $period,
        "amount" => $amount,
        "otherInfo" => "",
    ];
    if ($service_code === "BILL_ELECTRIC") {
        $bill_payment["billType"] = "TD";
    }

    $data = [
        'mc_request_id' => $request_id,
        'service_code' => $service_code,
        'publisher' => $publisher,
        'customer_code' => $customer_code,
        "bill_payment" => [$bill_payment],
    ];

    $jsonString = json_encode($data, JSON_UNESCAPED_SLASHES);
    $MC_ENCRYPT_KEY = env('MC_ENCRYPT_KEY');
    $MC_CHECKSUM_KEY = env('MC_CHECKSUM_KEY');
    $MC_CODE = env('MC_CODE');
    $encrypt = encryptData($jsonString, $MC_ENCRYPT_KEY);
    $md5str = $MC_CODE . $encrypt . $MC_CHECKSUM_KEY;
    $checksum = md5($md5str);
    $params = [
        'fnc' => $fnc,
        'merchantcode' => $MC_CODE,
        'data' => $encrypt,
        'checksum' => $checksum,
    ];
    $url = env('VIMO_URL') .'/'. $fnc;
    $response = Http::withHeaders([
        'Authorization' => 'Basic ' . env('AUTHORIZE'),
        'Content-Type' => 'application/x-www-form-urlencoded',
    ])->asForm()->post($url, $params);
    $resData=json_decode($response, JSON_UNESCAPED_SLASHES);
    return  $resData['data'];
}
}
