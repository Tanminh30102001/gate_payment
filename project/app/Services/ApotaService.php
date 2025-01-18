<?php

namespace App\Services;

use Firebase\JWT\JWT;
use Firebase\JWT\Key;
use Illuminate\Http\Client\Request;
use Illuminate\Support\Facades\Http;

class ApotaService
{
    protected $baseUrl;
    protected $partnerCode;
    protected $API_KEY;
    protected $SECRET_KEY;

    public function __construct()
    {
        $this->baseUrl = env('APOTA_URL');
        $this->partnerCode = env('PARTNER_CODE');
        $this->API_KEY = env('API_KEY');
        $this->SECRET_KEY = env('SECRET_KEY');
    }
    function createJWTToken()
    {
        $partnerCode = $this->partnerCode;
        $apiKey = $this->API_KEY;
        $secretKey = $this->SECRET_KEY;
        $currentTime = time();
        $payload = [
            'iss' => $partnerCode,
            'jti' => $apiKey . '-' . $currentTime,
            'api_key' => $apiKey,
            'exp' => $currentTime + 3600
        ];
        $header = [
            'typ' => 'JWT',  // Loại token là JWT
            'alg' => 'HS256',  // Thuật toán mã hóa
            'cty' => 'appotapay-api;v=1'  // Kiểu nội dung
        ];
        $jwt = JWT::encode($payload, $secretKey, 'HS256', null, $header);

        return $jwt;
    }
    function replaceNullsWithEmptyStrings($array)
    {
        foreach ($array as &$item) {
            foreach ($item as $key => $value) {
                if (is_null($value)) {
                    $item[$key] = ""; // Thay thế null bằng chuỗi rỗng
                }
            }
        }
        return $array;
    }
    function createSignature($data, $secretKey)
    {

        ksort($data);
        $rawData = http_build_query($data);

        $signature = hash_hmac('sha256', $rawData, $secretKey);

        return $signature;
    }
    public function getBill($billCode, $serviceCode)
    {
        $jwtToken = $this->createJWTToken();
        $refId = generatePartnerRefId(7);
        $data = [
            'partnerRefId' =>  $refId,
            'billCode' => $billCode,
            'serviceCode' => $serviceCode
        ];
        $dataToSign = "billCode={$billCode}&partnerRefId={$refId}&serviceCode={$serviceCode}";
        $signature = hash_hmac('sha256', $dataToSign, $this->SECRET_KEY);
        $data['signature'] = $signature;

        $url = $this->baseUrl . '/api/v1/service/bill/check';
        $response = Http::withHeaders([
            'X-APPOTAPAY-AUTH' => 'Bearer ' . $jwtToken,
        ])->post($url, $data);

        return ['res' => $response->json(),  'refId' =>  $refId];
    }
    public function payBill($billDetails, $billCode, $serviceCode, $refId)
    {
        $amount = $billDetails[0]['amount'];
        $billDetailString = json_encode($this->replaceNullsWithEmptyStrings($billDetails));
        $partnerCode = $refId; //generatePartnerRefId(); //$this->partnerCode
        $dataToSign = "amount={$amount}&billCode={$billCode}&billDetail={$billDetailString}&partnerRefId={$partnerCode}&serviceCode={$serviceCode}";
        $signature = hash_hmac('sha256', $dataToSign, $this->SECRET_KEY);
        $data = [
            'amount' => $amount,
            'billDetail' => $billDetailString,
            'partnerRefId' => $partnerCode,
            'billCode' => $billCode,
            'serviceCode' => $serviceCode,
            'signature' => $signature
        ];
        $url = $this->baseUrl . '/api/v1/service/bill/pay';
        $response = Http::withHeaders([
            'X-APPOTAPAY-AUTH' => 'Bearer ' . $this->createJWTToken(), // Thêm JWT Token nếu cần
        ])->post($url, $data);
        return $response->json();
    }
    public function getProductApota()
    {
        $url = $this->baseUrl . '/api/v2/service/topup/productCodes';
        $jwtToken = $this->createJWTToken();
        $response = Http::withHeaders([
            'X-APPOTAPAY-AUTH' => 'Bearer ' . $jwtToken,
            'Accept' => 'application/json',
        ])->get($url);
        return $response;
    }
    public function buyProductApota($telco, $telcoServiceType, $phoneNumber, $productCode)
    {
        $refId = generatePartnerRefId(7);
        $dataToSign = "partnerRefId={$refId}&phoneNumber={$phoneNumber}&productCode={$productCode}&telco={$telco}&telcoServiceType={$telcoServiceType}";
        $signature = hash_hmac('sha256', $dataToSign, $this->SECRET_KEY);
        $dataSend = [
            'partnerRefId' => $refId,
            'telco' => $telco,
            'telcoServiceType' => $telcoServiceType,
            'phoneNumber' => $phoneNumber,
            'productCode' => $productCode,
            'signature' => $signature,
        ];
        // $signature=$this->createSignature($dataSend, $this->SECRET_KEY);
        // $dataSend['signature'] = $signature;
        $url = $this->baseUrl . '/api/v2/service/topup/charging';

        $response = Http::withHeaders([
            'X-APPOTAPAY-AUTH' => 'Bearer ' . $this->createJWTToken(), // Thêm JWT Token nếu cần
        ])->post($url, $dataSend);
        return $response->json();
    }
}
