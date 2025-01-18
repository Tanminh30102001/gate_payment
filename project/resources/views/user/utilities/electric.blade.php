@extends('layouts.user')

@section('title')
@lang('Utilites bill')
@endsection

@section('breadcrumb')
@lang('Utilites bill')
@endsection

@section('content')


<div class="container-xl">
    <div class="row">
        @foreach($categories as $key => $category)
        <div class="col-md-4 mb-4">
            <div class="card">
                <div class="card-body">
                    <h5 class="card-title">{{ $category }}</h5>
                    <p class="card-text">Dịch vụ cho {{ strtolower($category) }}</p>
                    <a href="{{ route('user.detailServiceApota', ['category' => $key]) }}" class="btn btn-primary">Xem dịch vụ</a>
                </div>
            </div>
        </div>
        @endforeach
    </div>
    <hr>
    <div class="col-md-12">
        <h2> @lang('History')</h2>
    </div>
    <div class="row">
        <div class="table-responsive">
            <table class="table table-striped">
              <thead>
                <tr>
                  <th>@lang('Date')</th>
                  <th>@lang('Transaction ID')</th>
                  <th>@lang('Description')</th>
                  <th>@lang('Amount')</th>
                  <th>@lang('Charge')</th>
  
                </tr>
              </thead>
              <tbody>
                @forelse($transactions as $item)
                <tr>
                  <td data-label="@lang('Date')">{{dateFormat($item->created_at,'d-M-Y')}}</td>
                  <td data-label="@lang('Transaction ID')">
                    {{__($item->trnx)}}
                  </td>
                  <td data-label="@lang('Description')">
                    {{__($item->details)}}
                  </td>
                  <td data-label="@lang('Amount')">
                    <span class="{{$item->type == '+' ? 'text-success':'text-danger'}}">{{$item->type}}
                      {{amount($item->amount,$item->currency->type,2)}} {{$item->currency->code}}</span>
                  </td>
                  <td data-label="@lang('Charge')">
                    {{amount($item->charge,$item->currency->type,2)}} {{$item->currency->code}}
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
          @if ($transactions->hasPages())
          <div class="card-footer">
            {{$transactions->links('admin.partials.paginate')}}
          </div>
          @endif
    </div>
</div>

<script>
   
    document.querySelector('.confirm').addEventListener('click', function() {
        var modal = new bootstrap.Modal(document.getElementById('confirmationModal'));
        modal.show();
    });
    document.getElementById('modalConfirm').addEventListener('click', function() {
        document.getElementById('form-pay').submit();
    });

</script>
@endsection
