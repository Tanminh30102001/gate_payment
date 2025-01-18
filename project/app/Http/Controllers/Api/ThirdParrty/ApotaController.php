<?php

namespace App\Http\Controllers\Api\ThirdParrty;

use Illuminate\Http\Request;
use App\Http\Controllers\Api\ApiController;
use App\Models\WebhookGotit;
use App\Services\ApotaService;
use Illuminate\Support\Str;
use App\Models\ServiceApotas;

class ApotaController extends ApiController
{
    protected $ApotaService;
    public function __construct(ApotaService $ApotaService)
    {
        $this->ApotaService = $ApotaService;
    }
    public function getCategories()
    {
        $data = [
            'BILL_ELECTRIC' => 'Hoá đơn điện',
            'BILL_WATER' => 'Hoá đơn nước',
            'BILL_TELEVISION' => 'Hoá đơn truyền hình',
            'BILL_FINANCE' => 'Hoá đơn tài chính',
            'BILL_INTERNET' => 'Hoá đơn Internet',
            'BILL_TELEPHONE' => 'Hoá đơn điện thoại',
            'BILL_EDU' => 'Hoá đơn học phí',
        ];
        return  $this->sendResponse($data, 'success');
    }
    public function getService(Request $request)
    {
        $query = ServiceApotas::query();
        if ($request->has('categories')) {
            $query->where('categories', $request->input('categories'));
        }
        $data = $query->get();
        return  $this->sendResponse($data, 'success');
    }
    public function getBill(Request $request)
    {
        $bill_code = $request->bill_code ?? '';
        $service_code = $request->service_code ?? '';

        if ($bill_code == '' || $service_code == '') {
            return $this->sendError('Required Field');
        }
        $data = $this->ApotaService->getBill($bill_code, $service_code);
        // if(!isset($data['billDetail'])){
        //     return $this->sendError('Error code: '.$data['errorCode'] .'. Try Again' );
        // }
        $dataResponse = [
            'data' => $data['res'],
            'parnerRefId' => $data['refId']
        ];

        return  $this->sendResponse($dataResponse, 'success');
    }
    public function payBill(Request $request)
    {
        $billDetail = $request->billDetail ?? '';
        $billCode = $request->bill_code ?? '';
        $serviceCode = $request->service_code ?? '';
        $refId = $request->refId ?? '';
        if ($billDetail == '' || $billCode == "" || $serviceCode == '' || $refId == '') {
            return $this->sendError('Required Field');
        }

        $data = $this->ApotaService->payBill($billDetail, $billCode, $serviceCode, $refId);

        if ($data['errorCode'] !== 0) {
            return $this->sendError('Something went wrong. Try Again!!', ['errorCode' => $data['errorCode'], 'message' => $data['message']]);
        }
        return $this->sendResponse($data['billDetail'], 'success');
    }
    public function getProductApota()
    {
        $data = $this->ApotaService->getProductApota();
        $dataResponse = $data['data'];

        if (isset($data['errorCode']) && $data['errorCode'] !== 0) {
            return $this->sendError('Something went wrong. Try Again', ['errorCode' => $data['errorCode'], 'message' => $data['message']]);
        }
        return $this->sendResponse($dataResponse, 'success');
    }
    public function topupMobile(Request $request)
    {
        $telco = $request->telco ?? '';
        $telcoServiceType = $request->telcoServiceType ?? '';
        $phoneNumber = $request->phoneNumber ?? '';
        $productCode =  $request->productCode ?? '';
        if ($telco == '' || $telcoServiceType == '' || $phoneNumber == '' || $productCode == '') {
            return $this->sendError('Required Field');
        }
        $data = $this->ApotaService->buyProductApota($telco, $telcoServiceType, $phoneNumber, $productCode);
        if (isset($data['errorCode']) && $data['errorCode'] != 0) {
            return $this->sendError('Something went wrong. Try Again', ['errorCode' => $data['errorCode'], 'message' => $data['message']]);
        }
        return $this->sendResponse($data['transaction'], 'success');
    }
}
