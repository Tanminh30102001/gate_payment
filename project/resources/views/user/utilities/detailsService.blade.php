@extends('layouts.user')

@section('title')
@lang('Pay bill electric')
@endsection

@section('breadcrumb')
@lang('Pay bill electric')
@endsection

@section('content')

<div class="container-xl">
    
    <div class="card">
        <div class="card-body">
            <form action="{{ route('user.getBillApota') }}" method="GET">
                @csrf
                <div class="form-label">@lang('Customer Code')</div>
                <input type="text" name="customer_code" id="customer_code" class="form-control shadow-none mb-2"
                    placeholder="Nhập mã khách hàng" required value="{{ old('customer_code') }}">
                <div class="form-label">@lang('Select Publisher')</div>
                <select name="serviceCode" class="form-control shadow-none mb-2" required>
                    <option value="">Chọn nhà cung cấp</option>
                    @foreach($services as $service)
                    <option value="{{ $service->serviceCode }}">{{ $service->serviceName }}</option>
                    @endforeach
                </select>
                <div class="col-12 text-center"><button class="btn btn-primary" type="submit"> Submit </button> </div>
            </form>
        </div>
    </div>
    <div class="card">
        <div class="card-body">
            @if(isset($dataResponse))
            <div class="card">
                <div class="card-body">
                    @if(isset($dataResponse))
                    <h5 class="card-title">Chi tiết hóa đơn</h5>
                    <p><strong>Tên khách hàng:</strong> {{ $dataResponse['data']['customerInfo']['customerName'] }}</p>
                    <p><strong>Mã khách hàng:</strong> {{ $dataResponse['data']['customerInfo']['customerCode'] }}</p>
                    <p><strong>Địa chỉ khách hàng:</strong> {{ $dataResponse['data']['customerInfo']['customerAddress']
                        }}</p>

                    @if(isset($dataResponse['data']['billDetail'][0]))
                    {{-- <p><strong>Số hóa đơn:</strong> {{ $dataResponse['data']['billDetail'][0]['billNumber'] }}</p> --}}
                    <p><strong>Kỳ hóa đơn:</strong> {{ $dataResponse['data']['billDetail'][0]['period'] }}</p>
                    <p><strong>Số tiền:</strong> {{ number_format($dataResponse['data']['billDetail'][0]['amount'], 0,
                        ',', '.') }} VNĐ</p>
                    @else
                    <p>Không có thông tin hóa đơn.</p>
                    @endif
                    @else
                    <p>Không có dữ liệu hóa đơn nào.</p>
                    @endif
                </div>
             

                <form action="{{ route('user.userPayBillApota') }}" method="POST">
                    @csrf
                    <input type="text" name="bill_detail" id="bill_detail" class="form-control shadow-none mb-2"
                    placeholder="Nhập mã khách hàng"  value="{{ json_encode($dataResponse['data']['billDetail'])}} " hidden>
                    <input type="text" name="category" id="" value="{{ $category }}" hidden>
                    <input type="text" name="refId" id="refId" class="form-control shadow-none mb-2"
                    placeholder="Nhập mã khách hàng"  value="{{$dataResponse['parnerRefId']}} " hidden>
                    <select name="wallet_id" class="form-control shadow-none mb-2" required>
                        <option value="">Chọn ví</option>
                        @foreach($wallets as $wallet)
                        <option value="{{ $wallet->id }}">{{ $wallet->currency->code }} -- ({{amount($wallet->balance,$wallet->currency->type,2)}})</option>
                        @endforeach
                    </select>
                    <div class="col-12 text-center"><button class="btn btn-primary" type="submit">Thanh toán </button> </div>

                </form>
            </div>
            @else
            <p>Không có dữ liệu hóa đơn nào.</p>
            @endif
        </div>
       
    </div>



</div>

@endsection