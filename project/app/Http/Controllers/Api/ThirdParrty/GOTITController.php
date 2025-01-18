<?php

namespace App\Http\Controllers\Api\ThirdParrty;

use Illuminate\Http\Request;
use App\Http\Controllers\Api\ApiController;
use App\Models\WebhookGotit;
use App\Services\GOTITService;
use Illuminate\Support\Str;

class GOTITController extends ApiController
{
    protected $GOTITService;
    
    public function __construct(GOTITService $GOTITService)
    {
        $this->GOTITService = $GOTITService;
       
    }
    public function index(Request $request){
        
        $params = $request->all();
        $page = $params['page'] ?? '';
        $pageSize = $params['pageSize'] ?? '10000';
        $minPrice = $params['minPrice'] ?? 1;
        $maxPrice = $params['maxPrice'] ?? 10000000;
        $data = $this->GOTITService->getProductFromGotit($page,$pageSize,$minPrice,$maxPrice);
        return $data;
    }
    public function create(Request $request){
        $params = $request->all();
        $prefix=env('PREFIX');
        $productId = $params['productId'] ?? '';
        $productPriceId = $params['productPriceId'] ?? '';
        $expiryDate = $params['expiryDate'] ?? '';
        $orderName = $params['orderName'] ?? '';
        $phone = $params['phone'] ?? '0338386701';
        $transactionRefId =  $prefix . Str::uuid();
        
         $data = $this->GOTITService->createVoucher($productId,$productPriceId,$expiryDate,$orderName, $phone,$transactionRefId);
         return $data;
    }
    public function handleWebhook(Request $request){
        $data = $request->all();
        $jsonData = json_encode($data);
        $webhook =new WebhookGotit();
        $webhook->payload = $jsonData;
        $webhook->save();
        return response()->json(['status' => 'success']);
    }
    public function getBrands(){
        $datas = $this->GOTITService->getBrands();
        return $this->sendResponse($datas['data'],'success');
    }
    public function getBrandsByCate($cateId){
        $datas = $this->GOTITService->getBrandByCategory($cateId);
        return $this->sendResponse($datas['data'],'success');
    }
    public function getDetails($transactionId){
        $datas = $this->GOTITService->detailsVoucher($transactionId);
        return $this->sendResponse($datas['data'],'success');
    }
    public function getCategories(){
        $datas = $this->GOTITService->getCategory();
        return $this->sendResponse($datas['data'],'success'); 
    }

}