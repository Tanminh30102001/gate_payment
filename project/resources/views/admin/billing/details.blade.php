@extends('layouts.admin')

@section('title')
@lang('Manage Billing')
@endsection

@section('breadcrumb')
<section class="section">
    <div class="section-header">
        <h1>@lang('Details bill')</h1>
    </div>
</section>
@endsection

@section('content')
<div class="row justify-content-center">
    {{$listRPA}}
    @php
    if($listRPA->data_send){
    $payload=json_decode($listRPA->data_send,true);
    if(array_key_exists('bill_value', $payload)){
    $billValue = $payload['bill_value'];
    } else {
    $billValue = 'Không có bill_value';
    }

    }

    @endphp

    <div class="col-md-12">
        @if ($listRPA->status==='not-send-bot')
        <div class="alert alert-warning" role="alert">
            This invoice has not been processed yet!
        </div>
        @else
        <div class="alert alert-success" role="alert">
            This invoice has been processed successfully!
        </div>

        @endif
        {{$payload['category']}}
        <div class="row">
            <div class="form-group col-md-4">
                <label>@lang('Transaction ID')</label>
                <input class="form-control" type="text" name="name" value="{{$listRPA->transactionId}}" required>
            </div>
            <div class="form-group col-md-4">
                <label>@lang('Category')</label>
                <input class="form-control" type="text" name="name" value="{{$payload['category']}}" required>
            </div>
            <div class="form-group col-md-4">
                <label>@lang('Publisher')</label>
                <input class="form-control" type="text" name="name" value="{{$payload['type_category']}}" required>
            </div>
        </div>

        <div class="row">
            <div class="form-group col-md-2">
                <label> @if($listRPA->user_type==2) @lang('Merchant Call') @else @lang('User Call') @endif</label>
                @php
                $user=\App\Models\Merchant::where('id', $listRPA->user_id)->first();
                @endphp
                <input class="form-control" type="text" name="name" value="{{$user->name}}" required>
            </div>
            <div class="form-group col-md-2">
                <label>@lang('Type payment')</label>
                <input class="form-control" type="text" name="name" value="{{$payload['type_payment']}}" required>
            </div>
            <div class="form-group col-md-4">
                <label>@lang('Customer code')</label>
                <input class="form-control" type="text" name="name" value="{{$payload['customer_code']}}" required>
            </div>
            @if($payload['category']==='VETC')
            <div class="form-group col-md-2">
                <label>@lang('Color')</label>
                <input class="form-control" type="text" name="name" value="{{$payload['color']}}" required>
            </div>
            @endif
            <div class="form-group col-md-2">
                <label>@lang('Bill value')</label>
                <input class="form-control" type="text" name="name" value="{{$billValue}}" required>
            </div>
        </div>
        <hr>
    </div>
 
    <div class="card">
        <div  class="card-title text-center"> UPDATE BILL</div>
        <div class="card-body">
            <form action="{{route('admin.updateBill')}}" method="POST">
                @csrf
                <div class="row">
                    <div class="form-group col-md-6">
                        <input  class="form-control" hidden type="text" name="transactionId" value="{{$listRPA->transactionId}}" required>
                    </div>
                    <div class="form-group col-md-6">
                        <input class="form-control" hidden type="text" name="type_payment" value="{{$payload['type_payment']}}" required>
                    </div>
                    <div class="form-group col-md-6">
                        <input class="form-control" hidden type="text" name="customer_code" value="{{$payload['customer_code']}}" required>
                    </div>
                    <div class="form-group col-md-6">
                        <input class="form-control"hidden type="text" name="category" value="{{$payload['category']}}" required>
                    </div>
                    <div class="form-group col-md-6">
                        <input class="form-control"hidden type="text" name="type_category" value="{{$payload['type_category']}}" required>
                    </div>
                    <div class="form-group col-md-6">
                        <input class="form-control" hidden type="text" name="bill_value" value="{{$billValue}}" required>
                    </div>
                    <div class="form-group col-md-6">
                        <label>@lang('Ky')</label>
                        <input class="form-control"  type="text" name="ky" value="" required>
                    </div>
                    <div class="form-group col-md-6">
                        <label>@lang('Full Name')</label>
                        <input class="form-control" type="text" name="full_name" value="" required>
                    </div>
                    <div class="form-group col-md-12 text-left">
                        <button type="submit" class="btn btn-primary btn-lg">@lang('Submit')</button>
                    </div>
                </div>
            </form>
        </div>
    </div>
  
</div>


@endsection
@push('style')
<style>
    .form-control {
        line-height: 1.2 !important
    }
</style>
@endpush

@push('script')
<script>
    'use strict';
        $('.action').on('click',function(){
            var route = $(this).data('route')
            var status = $(this).data('status')
            var text = ''
            if(status == 1){
                text = "@lang('You are about to deactivate this addon. Please note that once you deactive the whole addon will no longer be workable in the system. So are you sure about this action?')"
            }else{
                text = "@lang('Are you sure about this action?')"
            }

            $('#statusModal').find('.status-text').text(text)
            $('#statusModal').find('form').attr('action', route)
            $('#statusModal').modal('show')

        })
</script>
@endpush