<?php

namespace App\Services;

use App\Models\Airline;
use App\Models\Airport;
use Illuminate\Http\Client\Request;
use Illuminate\Support\Facades\Http;

class DataComService
{
    protected $baseUrl;
    protected $headerUser;
    protected $headerPass;
    protected $agentAccount;
    protected $agentPassword;
    protected $productKey;
    public function __construct()
    {
        $this->baseUrl =env('URL_DATACOM');
        $this->headerUser=env('HEADER_USER');
        $this->headerPass=env('HEADER_PASS');
        $this->agentAccount=env('AGENT_ACCOUNT');
        $this->agentPassword=env('AGENT_PASSWORD');
        $this->productKey=env('PRODUCT_KEY_DATACOM');
    }
    public function searchFlight($adt=0,$chd=0,$inf=0,$listFlight=[]){
        $response = Http::post($this->baseUrl . 'searchFlight', [
            'Adt' => $adt,
            'Chd' => $chd,
            'Inf' => $inf,
            'ViewMode' => 'string',
            'ListFlight' => $listFlight,
            'HeaderUser' => $this->headerUser,
            'HeaderPass' => $this->headerPass,
            'AgentAccount' => $this->agentAccount,
            'AgentPassword' => $this->agentPassword,
            'ProductKey' => $this->productKey,
            'Currency' => 'VND',
            'Language' => 'vi',
            'IpRequest' => ''
        ]);
       $data=$response->json();
        return $data;
    }
    public function searchMinFareFlight($startPoint,$endPoint,$departDate,$airline){
        $dataSend=[
            'FlightRequest'=>[
                'StartPoint'=>$startPoint,
                'EndPoint'=>$endPoint,
                'DepartDate'=>$departDate,
                'Airline'=>$airline??'',
            ],
            'HeaderUser' => $this->headerUser,
            'HeaderPass' => $this->headerPass,
            'AgentAccount' => $this->agentAccount,
            'AgentPassword' => $this->agentPassword,
            'ProductKey' => $this->productKey,
            'Currency' => 'VND',
            'Language' => 'vi',
            'IpRequest' => ''
        ];
        $response = Http::post($this->baseUrl . 'searchminfare', $dataSend);
        $data=$response->json();
        return $data;
    }
    public function searchMinMonth($startPoint,$endPoint,$airline,$month,$year){
        $dataSend=[
            'StartPoint'=>$startPoint,
            'EndPoint'=>$endPoint,
            'Airline'=>$airline??'',
            'Month'=>$month,
            'Year'=>$year,
            'HeaderUser' => $this->headerUser,
            'HeaderPass' => $this->headerPass,
            'AgentAccount' => $this->agentAccount,
            'AgentPassword' => $this->agentPassword,
            'ProductKey' => $this->productKey,
            'Currency' => 'VND',
            'Language' => 'vi',
            'IpRequest' => ''
        ];
        $response = Http::post($this->baseUrl . 'searchmonth', $dataSend);
        $data=$response->json();
        return $data;
    }
    public function getInfoBagge($session,$fareDataId,$flightValue){
        $payload = [
            'ListFareData' => [
                [
                    'Session' => $session,
                    'FareDataId' => $fareDataId,
                    'ListFlight' => [
                        [
                            'FlightValue' => $flightValue
                        ]
                    ]
                ]
            ],
            'HeaderUser' => $this->headerUser,
            'HeaderPass' => $this->headerPass,
            'AgentAccount' => $this->agentAccount,
            'AgentPassword' => $this->agentPassword,
            'ProductKey' => $this->productKey,
            'Currency' => 'VND',
            'Language' => 'vi',
            'IpRequest' => ''
        ];
        $response = Http::post($this->baseUrl . 'getbaggage', $payload);
        return $response;
    }
    public function getFareRules($session,$fareDataId,$flightValue){
        $payload = [
            "GetFromGds"=> false,
            'ListFareData' => [
                [
                    'Session' => $session,
                    'FareDataId' => $fareDataId,
                    'ListFlight' => [
                        [
                            'FlightValue' => $flightValue
                        ]
                    ]
                ]
            ],
            'HeaderUser' => $this->headerUser,
            'HeaderPass' => $this->headerPass,
            'AgentAccount' => $this->agentAccount,
            'AgentPassword' => $this->agentPassword,
            'ProductKey' => $this->productKey,
            'Currency' => 'VND',
            'Language' => 'en',
            'IpRequest' => ''
        ]; 
        $response = Http::post($this->baseUrl . 'getfarerules', $payload);
        $data=$response->json();
        return $data;
    }
    public function verifyFlight($session,$fareDataId,$flightValue){
        $payload = [
            "GetFromGds"=> false,
            'ListFareData' => [
                [
                    'Session' => $session,
                    'FareDataId' => $fareDataId,
                    'ListFlight' => [
                        [
                            'FlightValue' => $flightValue
                        ]
                    ]
                ]
            ],
            'HeaderUser' => $this->headerUser,
            'HeaderPass' => $this->headerPass,
            'AgentAccount' => $this->agentAccount,
            'AgentPassword' => $this->agentPassword,
            'ProductKey' => $this->productKey,
            'Currency' => 'VND',
            'Language' => 'en',
            'IpRequest' => ''
        ]; 
        $response = Http::post($this->baseUrl . 'verifyflight', $payload);
        $data=$response->json();
        return $data;
    }
    public function getAirportName($code){
        $airportName=Airport::where('Code',$code)->first();
        return $airportName->Name;
    }
    public function getAirlineName($code){
        $airportName=Airline::where('Code',$code)->first();
        return $airportName->Name_En;
    }

}
