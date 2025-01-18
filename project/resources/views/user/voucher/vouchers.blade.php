@extends('layouts.user')

@section('title')
   @lang('My vouchers')
@endsection

@section('breadcrumb')
   @lang('My vouchers')  
@endsection

@section('content')
    <div class="container-xl">
        <div class="row row-deck row-cards">
            <div class="col-12">
                <div class="card">
                    <div class="table-responsive">
                      <table class="table table-vcenter card-table table-striped">
                        <thead>
                          <tr>
                            <th>@lang('Voucher Code')</th>
                            <th>@lang('Voucher Serial')</th>
                            <th>@lang('Amount')</th>
                            <th>@lang('Voucher Link')</th>
                            <th>@lang('Create Date')</th>
                            <th>@lang('Expiry Date')</th>
                          </tr>
                        </thead>
                        <tbody>
                          @forelse ($vouchers as $item)
                          <tr>
                            <td data-label="@lang('Voucher Code')">{{$item->code}}</td>
                            <td data-label="@lang('Voucher Serial')">{{$item->voucher_serial}}</td>
                            <td data-label="@lang('Amount')">{{numFormat($item->amount)}} {{$item->currency->code}}</td>
                            <td data-label="@lang('Voucher Link')"> <a href="{{$item->voucher_link}}"> {{$item->voucher_link}}</a></td>
                            <td data-label="@lang('Date')">{{dateFormat($item->created_at)}}</td>
                            <td data-label="@lang('Expiry Date')">{{$item->expiryDate}}</td>
                          </tr>
                          @empty
                          <tr>
                              <td class="text-center" colspan="12">@lang('No data found!')</td>
                          </tr>
                          @endforelse
                        </tbody>
                      </table>
                    </div>
                    <div class="mt-2 text-right">
                        {{$vouchers->links()}}
                    </div>
                </div>
            </div>
        </div>
    </div>
@endsection