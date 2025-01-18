<?php

namespace App\Services;

use App\Models\VoucherGotit;
use Illuminate\Http\Client\Request;
use Illuminate\Support\Facades\Http;

class GOTITService
{
    protected $TOKEN_AUTHORIZE_GOTIT;
    protected $url_get;
    protected $url_create;
    protected $url_gotit;

    public function __construct()
    {

        $this->TOKEN_AUTHORIZE_GOTIT = env('TOKEN_AUTHORIZE_GOTIT');
        $this->url_get = env('URL_GOTIT_LIST_VOUCHER');
        $this->url_create = env('URL_GOTIT_CREATE_VOUCHER');
        $this->url_gotit=env('URL_GOTIT');
    }
    public function getProductFromGotit($page, $pageSize, $minPrice, $maxPrice)
    {

        $url = $this->url_get;

        $response = Http::withHeaders([
            'X-GI-Authorization' => $this->TOKEN_AUTHORIZE_GOTIT,
            'Content-Type' => 'application/json'
        ])->get($url, [
                    'categoryId' => 10,
                    'page' => $page,
                    'pageSize' => $pageSize,
                    'isExcludeStoreListInfo' => false,
                    'storeListPage' => 1,
                    'storeListPageSize' => 2,
                    'minPrice' => $minPrice,
                    'maxPrice' => $maxPrice,
                    'orderBy' => 'asc',
                    'pagination' => [
                        'pageSize' => 100,
                        'page' => 1,
                        'pageTotal' => 1
                    ],
                    'storeListPagination' => [
                        'page' => 1,
                        'pageSize' => 5
                    ]
                ]);
        $data = $response->json()['data'][0];
        $product1408 = collect($data['productList'])->firstWhere('productId', 1408);
        if ($product1408) {
            $productId = $product1408['productId'];
            foreach ($product1408['prices'] as $price) {
                $priceId = $price['priceId'];
                $priceValue = $price['priceValue'];
                $voucherData = [
                    'productId' => $productId,
                    'priceId' => $priceId,
                    'priceValue' => $priceValue,
                ];
                $existingVoucher = VoucherGotit::where('productId', $productId)
                    ->where('priceId', $price['priceId'])
                    ->first();
                if ($existingVoucher) {
                    // Update existing record
                    VoucherGotit::where('productId', $productId)
                        ->where('priceId', $price['priceId'])
                        ->update($voucherData);
                } else {
                    // Insert new record
                    VoucherGotit::insert($voucherData);
                }
            }

        }
        return VoucherGotit::all();

    }
    public function createVoucher($productId, $productPriceId, $expiryDate, $orderName, $phone = '', $transactionRefId)
    {
        $voucher = VoucherGotit::where('productId', $productId)->where('priceId', $productPriceId)->first();

        if (!$voucher) {
            return [
                'success' => false,
                'error' => 'Voucher not found'
            ];
        }
        $body = [
            "productId" => $productId,
            "productPriceId" => $productPriceId,
            "quantity" => 1,
            "expiryDate" => $expiryDate,
            "orderName" => $orderName,
            "transactionRefId" => $transactionRefId,
            "isConvertToCoverLink" => 0,
            "use_otp" => 0,
            "otp_type" => 1,
            "password" => "88888",
            "receiver_name" => "Client",
            "phone" => $phone ?? '0338386701'
        ];

        $response = Http::withHeaders([
            'X-GI-Authorization' => $this->TOKEN_AUTHORIZE_GOTIT,
            'Content-Type' => 'application/json',
        ])->post($this->url_create . '/v', $body);
        $data = $response->json();
        return $data;
    }
    public function getBrands(){
        $url = $this->url_gotit;

        $response = Http::withHeaders([
            'X-GI-Authorization' => $this->TOKEN_AUTHORIZE_GOTIT,
            'Content-Type' => 'application/json'
        ])->get($url.'/brands', []);
        $data = $response->json();
        return $data;
    }
    public function detailsVoucher($transactionId){
        $url = $this->url_gotit;
        $response = Http::withHeaders([
            'X-GI-Authorization' =>  $this->TOKEN_AUTHORIZE_GOTIT,
            'Content-Type' => 'application/json',
        ])->get($url . '/vouchers/multiple/status/'.$transactionId);
        $data=$response->json();
        return $data; 
    }   
    public function getCategory(){
        $url = $this->url_gotit;
        $response = Http::withHeaders([
            'X-GI-Authorization' =>  $this->TOKEN_AUTHORIZE_GOTIT,
            'Content-Type' => 'application/json',
        ])->get($url . '/categories');
        $data=$response->json();
        return $data; 
    }
    public function getBrandByCategory($cateId){
        $url = $this->url_gotit;
        $response = Http::withHeaders([
            'X-GI-Authorization' =>  $this->TOKEN_AUTHORIZE_GOTIT,
            'Content-Type' => 'application/json',
        ])->get($url . '/categories'.'/'.$cateId.'/brands');
        $data=$response->json();
        return $data; 
    }
}
