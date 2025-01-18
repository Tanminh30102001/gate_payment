<?php

namespace App\Http\Controllers\Api\ThirdParrty;

use Illuminate\Http\Request;
use App\Http\Controllers\Api\ApiController;
use App\Services\DataComService;
use Illuminate\Support\Str;

class DataComController extends ApiController
{
    protected $DataComService;

    public function __construct(DataComService $DataComService)
    {
        $this->DataComService = $DataComService;
    }
    public function searchFlight(Request $request)
    {
        $adt = $request->adt ?? '';
        $chd = $request->chd ?? '';
        $inf = $request->inf ?? '';
        $listFlight = $request->listFlight;
        $flightSegments = [];
        foreach ($listFlight as $flight) {
            if (!isset($flight['startPoint'], $flight['endPoint'], $flight['departDate'])) {
                return $this->sendError('Incomplete flight segment data');
            }

            $flightSegments[] = [
                'StartPoint' => $flight['startPoint'],
                'EndPoint' => $flight['endPoint'],
                'DepartDate' => $flight['departDate'],
                'Airline' => $flight['airline']
            ];
        }

        // Gọi dịch vụ để tìm chuyến bay
        $data = $this->DataComService->searchFlight($adt, $chd, $inf, $flightSegments);
        if (isset($data['Status']) && $data['Status'] === false) {
            return $this->sendError($data['Message'], $data);
        }

        if (empty($data['ListFareData'])) {
            return $this->sendError('No flight data found');
        }
        $filteredData = [];
        $session = $data['Session'] ?? null;
        foreach ($data['ListFareData'] as $fareData) {
            $filteredFareData = [
                'Session' => $session,
                'FareDataId' => $fareData['FareDataId'],
                'Airline' => $fareData['Airline'],
                'System' => $fareData['System'],
                'Itinerary' => $fareData['Itinerary'],
                'FullFare' => $fareData['FullFare'],
                'Availability' => $fareData['Availability'],
                'Adt' => $fareData['Adt'],
                'Chd' => $fareData['Chd'],
                'Inf' => $fareData['Inf'],
                'TaxAdt' => $fareData['TaxAdt'],
                'TaxChd' => $fareData['TaxChd'],
                'TaxInf' => $fareData['TaxInf'],
                'VatAdt' => $fareData['VatAdt'],
                'VatChd' => $fareData['VatChd'],
                'VatInf' => $fareData['VatInf'],

                'TotalNetPrice' => $fareData['TotalNetPrice'],
                'TotalPrice' => $fareData['TotalPrice'],
            ];
            if (isset($fareData['ListFlight'])) {
                $filteredFareData['ListFlight'] = [];
                foreach ($fareData['ListFlight'] as $flight) {
                    $filteredFlight = [
                        'Airline' => $this->DataComService->getAirlineName($flight['Airline']),
                        'StartPoint' => $this->DataComService->getAirportName($flight['StartPoint']) . ' - ' . $flight['StartPoint'],
                        'EndPoint' => $this->DataComService->getAirportName($flight['EndPoint']) . ' - ' . $flight['EndPoint'],
                        'FlightNumber' => $flight['FlightNumber'],
                        'Duration' => $flight['Duration'],
                        'FlightValue' => $flight['FlightValue'],
                        'NoRefund' => $flight['NoRefund'],
                    ];

                    if (isset($flight['ListSegment'])) {
                        $filteredFlight['ListSegment'] = [];
                        foreach ($flight['ListSegment'] as $segment) {
                            $filteredSegment = [
                                'Airline' => $this->DataComService->getAirlineName($segment['Airline']),
                                'StartPoint' => $this->DataComService->getAirportName($segment['StartPoint']) . ' - ' . $segment['StartPoint'],
                                'EndPoint' => $this->DataComService->getAirportName($segment['EndPoint']) . ' - ' . $segment['EndPoint'],
                                'StartTime' => $segment['StartTime'],
                                'StartTimeZoneOffset' => $segment['StartTimeZoneOffset'],
                                'EndTime' => $segment['EndTime'],
                                'EndTimeZoneOffset' => $segment['EndTimeZoneOffset'],
                                'StartTm' => $segment['StartTm'],
                                'EndTm' => $segment['EndTm'],
                                'Cabin' => $segment['Cabin'],
                                'Class' => $segment['Class'],
                                'HandBaggage' => $segment['HandBaggage'],
                                'AllowanceBaggage' => $segment['AllowanceBaggage'],
                            ];

                            $filteredFlight['ListSegment'][] = $filteredSegment;
                        }
                    }

                    $filteredFareData['ListFlight'][] = $filteredFlight;
                }
            }

            $filteredData[] = $filteredFareData;
        }

        return $this->sendResponse($filteredData, 'success');
    }
    public function searchMinFare(Request $request)
    {
        $startPoint = $request->startPoint;
        $endPoint = $request->endPoint;
        $departDate = $request->departDate;
        $airline = $request->airline;
        $data = $this->DataComService->searchMinFareFlight($startPoint, $endPoint, $departDate, $airline);
        if (isset($data['Status']) && $data['Status'] === false) {
            return $this->sendError($data['Message'], $data);
        }
        if (empty($data['MinFlight'])) {
            return $this->sendError('No flight data found');
        }
        $session = $data['Session'] ?? null;
        $fareData = $data['MinFlight'];

        $filteredFareData = [
            'Session' => $session,
            'FareDataId' => $fareData['FareDataId'],
            'Airline' => $fareData['Airline'],
            'System' => $fareData['System'],
            'Itinerary' => $fareData['Itinerary'],
            'FullFare' => $fareData['FullFare'],
            'Availability' => $fareData['Availability'],
            'Adt' => $fareData['Adt'],
            'Chd' => $fareData['Chd'],
            'Inf' => $fareData['Inf'],
            'TaxAdt' => $fareData['TaxAdt'],
            'TaxChd' => $fareData['TaxChd'],
            'TaxInf' => $fareData['TaxInf'],
            'VatAdt' => $fareData['VatAdt'],
            'VatChd' => $fareData['VatChd'],
            'VatInf' => $fareData['VatInf'],
            'TotalNetPrice' => $fareData['TotalNetPrice'],
            'TotalPrice' => $fareData['TotalPrice'],
        ];

        // Lấy thông tin từ ListFlight
        if (isset($fareData['ListFlight'])) {
            $filteredFareData['ListFlight'] = [];
            foreach ($fareData['ListFlight'] as $flight) {
                $filteredFlight = [
                    'Airline' => $this->DataComService->getAirlineName($flight['Airline']),
                    'StartPoint' => $this->DataComService->getAirportName($flight['StartPoint']) . ' - ' . $flight['StartPoint'],
                    'EndPoint' => $this->DataComService->getAirportName($flight['EndPoint']) . ' - ' . $flight['EndPoint'],
                    'FlightNumber' => $flight['FlightNumber'],
                    'Duration' => $flight['Duration'],
                    'FlightValue' => $flight['FlightValue'],
                    'NoRefund' => $flight['NoRefund'],
                ];

                if (isset($flight['ListSegment'])) {
                    $filteredFlight['ListSegment'] = [];
                    foreach ($flight['ListSegment'] as $segment) {
                        $filteredSegment = [
                            'Airline' => $this->DataComService->getAirlineName($segment['Airline']),
                            'StartPoint' => $this->DataComService->getAirportName($segment['StartPoint']) . ' - ' . $segment['StartPoint'],
                            'EndPoint' => $this->DataComService->getAirportName($segment['EndPoint']) . ' - ' . $segment['EndPoint'],
                            'StartTime' => $segment['StartTime'],
                            'StartTimeZoneOffset' => $segment['StartTimeZoneOffset'],
                            'EndTime' => $segment['EndTime'],
                            'EndTimeZoneOffset' => $segment['EndTimeZoneOffset'],
                            'StartTm' => $segment['StartTm'],
                            'EndTm' => $segment['EndTm'],
                            'Cabin' => $segment['Cabin'],
                            'Class' => $segment['Class'],
                            'HandBaggage' => $segment['HandBaggage'],
                            'AllowanceBaggage' => $segment['AllowanceBaggage'],
                        ];

                        $filteredFlight['ListSegment'][] = $filteredSegment;
                    }
                }

                $filteredFareData['ListFlight'][] = $filteredFlight;
            }
        }

        return $this->sendResponse($filteredFareData, 'success');
    }
    public function searchMinMonth(Request $request)
    {
        $startPoint = $request->startPoint ?? '';
        $endPoint = $request->endPoint ?? '';
        $month = $request->month ?? 0;
        $airline = $request->airline ?? '';
        $year = $request->year ?? 0;
        $data = $this->DataComService->searchMinMonth($startPoint, $endPoint, $airline, $month, $year);
        if (isset($data['Status']) && $data['Status'] === false) {
            return $this->sendError($data['Message'], $data);
        }
        if (empty($data['ListMinPrice'])) {
            return $this->sendError('No flight data found');
        }

        $minPriceData = $data['ListMinPrice'];
        $result = [];
        $session = $data['Session'] ?? null;
        foreach ($minPriceData as $item) {
            $departDate = $item['DepartDate'];
            foreach ($item['ListFareData'] as $fareData) {
                $filteredFareData = [
                    'Session' => $session,
                    'FareDataId' => $fareData['FareDataId'],
                    'Airline' => $fareData['Airline'],
                    'System' => $fareData['System'],
                    'Itinerary' => $fareData['Itinerary'],
                    'FullFare' => $fareData['FullFare'],
                    'Availability' => $fareData['Availability'],
                    'Adt' => $fareData['Adt'],
                    'Chd' => $fareData['Chd'],
                    'Inf' => $fareData['Inf'],
                    'TaxAdt' => $fareData['TaxAdt'],
                    'TaxChd' => $fareData['TaxChd'],
                    'TaxInf' => $fareData['TaxInf'],
                    'VatAdt' => $fareData['VatAdt'],
                    'VatChd' => $fareData['VatChd'],
                    'VatInf' => $fareData['VatInf'],
                    'TotalNetPrice' => $fareData['TotalNetPrice'],
                    'TotalPrice' => $fareData['TotalPrice'],
                ];

                // Lấy thông tin từ ListFlight
                if (isset($fareData['ListFlight'])) {
                    $filteredFareData['ListFlight'] = [];
                    foreach ($fareData['ListFlight'] as $flight) {
                        $filteredFlight = [
                            'Airline' => $this->DataComService->getAirlineName($flight['Airline']),
                            'StartPoint' => $this->DataComService->getAirportName($flight['StartPoint']) . ' - ' . $flight['StartPoint'],
                            'EndPoint' => $this->DataComService->getAirportName($flight['EndPoint']) . ' - ' . $flight['EndPoint'],
                            'FlightNumber' => $flight['FlightNumber'],
                            'Duration' => $flight['Duration'],
                            'FlightValue' => $flight['FlightValue'],
                            'NoRefund' => $flight['NoRefund'],
                        ];

                        if (isset($flight['ListSegment'])) {
                            $filteredFlight['ListSegment'] = [];
                            foreach ($flight['ListSegment'] as $segment) {
                                $filteredSegment = [
                                    'Airline' => $this->DataComService->getAirlineName($segment['Airline']),
                                    'StartPoint' => $this->DataComService->getAirportName($segment['StartPoint']) . ' - ' . $segment['StartPoint'],
                                    'EndPoint' => $this->DataComService->getAirportName($segment['EndPoint']) . ' - ' . $segment['EndPoint'],
                                    'StartTime' => $segment['StartTime'],
                                    'StartTimeZoneOffset' => $segment['StartTimeZoneOffset'],
                                    'EndTime' => $segment['EndTime'],
                                    'EndTimeZoneOffset' => $segment['EndTimeZoneOffset'],
                                    'StartTm' => $segment['StartTm'],
                                    'EndTm' => $segment['EndTm'],
                                    'Cabin' => $segment['Cabin'],
                                    'Class' => $segment['Class'],
                                    'HandBaggage' => $segment['HandBaggage'],
                                    'AllowanceBaggage' => $segment['AllowanceBaggage'],
                                ];

                                $filteredFlight['ListSegment'][] = $filteredSegment;
                            }
                        }

                        $filteredFareData['ListFlight'][] = $filteredFlight;
                    }
                }

                $result[] = [
                    'departDate' => $departDate,
                    'fareData' => $filteredFareData
                ];
            }
        }

        return $this->sendResponse($result, 'success');
    }
    public function getInfoBagge(Request $request)
    {
        $session=$request->session??'';
        $fareDataId=$request->fareDataId??'';
        $flightValue=$request->flightValue??'';
        $data = $this->DataComService->getInfoBagge($session,$fareDataId, $flightValue);
        $responeData=$data['ListBaggage'];
        $result=[];
        foreach ($responeData as $info) {
            $filterData = [
                'Airline' => $this->DataComService->getAirlineName($info['Airline']),
                'StartPoint' => $this->DataComService->getAirportName($info['StartPoint']) . ' - ' . $info['StartPoint'],
                'EndPoint' => $this->DataComService->getAirportName($info['EndPoint']) . ' - ' . $info['EndPoint'],
                'Name'=>$info['Name'],
                'Price'=>$info['Price'],
                'Currency'=>$info['Currency'],
                'Confirmed'=>$info['Confirmed'],
                'Route'=>$info['Route']
            ];
            $result[] = $filterData;
        }
        return $this->sendResponse($result,'success');
    }
    public function getFareRules(Request $request){
        $session=$request->session??'';
        $fareDataId=$request->fareDataId??'';
        $flightValue=$request->flightValue??'';
        $data = $this->DataComService->getFareRules($session,$fareDataId, $flightValue);
        return  $this->sendResponse($data,'success');
    }
    public function checkInfoFlight(Request $request){
        $session=$request->session??'';
        $fareDataId=$request->fareDataId??'';
        $flightValue=$request->flightValue??'';
        $data = $this->DataComService->verifyFlight($session,$fareDataId, $flightValue);
        return  $this->sendResponse($data,'success');
    }
}
