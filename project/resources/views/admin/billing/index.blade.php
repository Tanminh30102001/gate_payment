@extends('layouts.admin')

@section('title')
   @lang('Manage Billing')
@endsection

@section('breadcrumb')
 <section class="section">
    <div class="section-header">
        <h1>@lang('Manage Billing')</h1>
    </div>
</section>
@endsection

@section('content')
    <div class="row justify-content-center">
        
        <div class="col-md-12">
            <div class="card border-left border-primary">
                <div class="card-body">
                    <span class="font-weight-bold">@lang('Warning') :  </span> <code class="text-warning">@lang('We strongly recommend that, please backup your whole system and database before you install the addon.')</code>
                </div>
            </div>
            <div class="table-responsive">
                <table class="table table-striped">
                  <thead>
                    <tr>
                      <th>@lang('Date')</th>
                      <th>@lang('Transaction ID')</th>
                      <th>@lang('Type Bill')</th>
                      <th>@lang('Customer_code')</th>
                      <th>@lang('Type Payment')</th>
                      <th>@lang('status')</th>
                      <th> @lang('Action')</th>
                      
                    </tr>
                  </thead>
                  <tbody>
                    @forelse($listRPA as $item)
                    @php
                        $payload = json_decode($item->payload, true);
                    @endphp
                    <tr>
                      <td data-label="@lang('Date')">{{dateFormat($item->created_at,'d-M-Y')}}</td>
                      <td data-label="@lang('Transaction ID')">
                        {{__($item->transactionId)}}
                      </td>
                      <td data-label="@lang('Category')">{{ __($payload['category']) }}</td>
        <td data-label="@lang('Customer Code')">{{ __($payload['customer_code']) }}</td>
        <td data-label="@lang('Type Payment')">{{ __($payload['type_payment']) }}</td>
        @if ($item->status==='not-send-bot')
        <td data-label="@lang('Type Payment')"> <span class="badge badge-warning">@lang('Pending')</span></td>
        @else 
        <td data-label="@lang('Type Payment')"> <span class="badge badge-success">@lang('Done')</span></td>
        @endif
        <td data-label="@lang('Type Payment')">
            <a class="btn btn-primary details"
            href="{{route('admin.detailsBill',$item->transactionId)}}"  data-toggle="tooltip" data-placement="top" title="Details">@lang('Details')</a>
            {{-- <button class="input-group-text btn btn-primary text-white"  data-toggle="tooltip" data-placement="top" title="Details" ><a href=""></a> <i class="fas fa-stream"></i></button>  --}}
        </td>

                    </tr>
                    @empty
                    <tr>
                      <td class="text-center" colspan="12">@lang('No data found!')</td>
                    </tr>
                    @endforelse
                  </tbody>
                </table>
              </div>
              @if ($listRPA->hasPages())
              <div class="card-footer">
                {{$listRPA->links('admin.partials.paginate')}}
              </div>
              @endif
            {{-- <div class="card">
                <div class="card-header d-flex justify-content-between">
                    <h5>@lang('Install Addon')</h5>
                    <h6 class="text-primary">@lang('System version : '.sysVersion())</h6>
                </div>
                <div class="card-body">
                    <form class="form-horizontal" action="{{route('admin.addon.install')}}" method="POST"   enctype="multipart/form-data">
                        @csrf   
                        <div class="form-group">
                            <label>@lang('Addon Purchase Key')</label>
                            <div class="custom-file">
                                <input type="text" name="purchase_key" class="form-control" required>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="addon_zip">@lang('Zip File')</label>
                            <div class="custom-file">
                                <input type="file" name="addon" class="form-control" required>
                            </div>
                        </div>
                        <div class="form-group mb-0 text-right">
                            <button type="submit" class="btn btn-primary">@lang('Install / Addon')</button>
                        </div>
                    </form>

                    <hr>

                    <h5 class="my-4">@lang('Installed Addon')</h5>
                    <div class="table-responsive">
                        <table class="table table-bordered">
                            <thead>
                                <tr>
                                    <th>@lang('Name')</th>
                                    <th>@lang('Version')</th>
                                    <th>@lang('Status')</th>
                                    <th class="text-right">@lang('Action')</th>
                                </tr>
                            </thead>
                            <tbody>
                                @forelse($addons as $addon)
                                <tr>
                                    <td>{{ucwords($addon->name)}}</td>
                                    <td>{{$addon->version}}</td>
                                    <td>
                                        @if($addon->status == 1)
                                            <span class="badge badge-success">@lang('Active')</span>
                                        @else
                                            <span class="badge badge-danger">@lang('Inactive')</span>
                                        @endif
                                    </td>
                                    <td class="text-right">
                                        @if ($addon->status == 1)
                                            <a href="javascript:;" data-route="{{route('admin.addon.status', $addon->id)}}" data-status="{{$addon->status}}" class="action btn btn-sm btn-danger">@lang('Deactivate')</a>
                                        @else
                                            <a href="javascript:;" data-route="{{route('admin.addon.status', $addon->id)}}" data-status="{{$addon->status}}" class="btn btn-primary btn-sm action">@lang('Activate')</a>
                                        @endif
                                    </td>
                                </tr>
                                @empty
                                    
                                <tr><td colspan="12" class="text-center">@lang('No installed addon found')</td></tr>
                                @endforelse
                            </tbody>
                        </table>
                </div>
            </div> --}}

            
        </div>
        
    </div>


    {{-- <div class="modal fade" id="statusModal" tabindex="-1" role="dialog" aria-labelledby="modelTitleId" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <form action="" method="POST">
                @csrf
                <div class="modal-content">
                    <div class="modal-body text-center mt-4">
                        <h6 class="status-text"></h6>
                    </div>
                    <div class="modal-footer justify-content-center">
                        <button type="button" class="btn btn-dark" data-dismiss="modal">@lang('Close')</button>
                        <button type="submit" class="btn btn-primary">@lang('Yes I\'m sure')</button>
                    </div>
                </div>
            </form>
        </div>
    </div> --}}


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