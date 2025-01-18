@extends('layouts.user')

@section('title')
@lang('Pay Internet')
@endsection

@section('breadcrumb')
@lang('Pay Internet')
@endsection
@section('content')
<style>
    .btn-secondary {
        background-color: #6c757d;
        color: white;
        border: none;
        cursor: pointer;
        padding: 10px 20px;
        margin: 5px;
        display: inline-block;
    }

    .btn-secondary input[type="radio"] {
        display: none;
    }

    .btn-secondary.active {
        background-color: #007bff;
        color: white;
    }
</style>

<div class="container-xl">
    <div class="row row-deck row-cards mb-5">
        <div class="col-12">
            <div class="card">
                <div class="card-body">
                    <form action="" id="form" method="post">
                        @csrf
                        <div class="row">
                            <div class="col-md-6 mb-2">
                                <div class="form-label">@lang('Customer Code : ')</div>
                                <input type="text" name="customer_code" id="customer_code"
                                    class="form-control shadow-none mb-2" required>
                            </div>
                            <div class="col-md-6 mb-2">
                                <div class="form-label">@lang('Publisher')</div>
                                <select class="form-select wallet shadow-none" name="type_category">
                                    <option value="" selected>@lang('Select')</option>
                                    <option value="VIETTEL">@lang('Viettel')</option>
                                    <option value="FPT ">@lang('FPT Telecom')</option>
                                    <option value="SPT">@lang('SPT')</option>
                                    <option value="SCTV">@lang('SCTV')</option>
                                    <option value="ACT">@lang('ACT Telecom')</option>
                                    <option value="VNPT">@lang('Vinaphone/VNPT')</option>
                                    <option value="VNTT">@lang('VNTT')</option>
                                </select>
                            </div>
                            <div class="col-md-12 mb-3">
                                <div class="form-label">&nbsp;</div>
                                <button type="submit" class="btn btn-primary w-100">@lang('Check')</button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
    @if(session('dataOfBot'))
    <div class="card">
        <div class="card-body">
            <h4 class="card-title text-center">
                <i class="fas fa-info-circle fa-3x text-primary mb-2"></i>
                <p class="card-text">@lang('Transaction Details')</p>
            </h4>
            <div>
                <div class="row mb-2">
                    <div class="col-4"><strong>@lang('Customer Coded'):</strong></div>
                    <div class="col-8">{{ (session('dataOfBot'))->response->customer_code }}</div>
                </div>
                <div class="row mb-2">
                    <div class="col-4"><strong>@lang('Amount'):</strong></div>
                    <div class="col-8">{{ (session('dataOfBot'))->response->bill_value }}</div>
                </div>
                <div class="row mb-2">
                    <div class="col-4"><strong>@lang('Period'):</strong></div>
                    <div class="col-8">{{ (session('dataOfBot'))->response->ky }}</div>
                </div>
                <div class="row mb-2">
                    <div class="col-4"><strong>@lang('Full Name'):</strong></div>
                    <div class="col-8">{{ (session('dataOfBot'))->response->full_name }}</div>
                </div>
            </div>
            <form action="{{route('user.payInternet')}}" id="form-pay" method="post" class="row mb-2">
                @csrf
                <input name="customer_code" value="{{ (session('dataOfBot'))->response->customer_code }}" hidden />
                <input name="bill_value" value="{{ (session('dataOfBot'))->response->bill_value }}" hidden />
                <input name="type_category" value="{{ (session('dataOfBot'))->response->type_category }}" hidden />
                <input name="bill_value" value="{{ (session('dataOfBot'))->response->bill_value }}" hidden />
                <div class="row">
                    <div class="col-md-12">
                        <div class="form-label">@lang('Select Wallet')</div>
                        <select class="form-select wallet shadow-none" name="wallet_id">
                            <option value="" selected>@lang('Select')</option>
                            @foreach ($wallets as $wallet)
                            <option value="{{ $wallet->id }}" data-currency="{{ $wallet->currency->id }}"
                                data-code="{{ $wallet->currency->code }}">
                                {{ $wallet->currency->code }} -- ({{ amount($wallet->balance, $wallet->currency->type,
                                3)
                                }})
                            </option>
                            @endforeach
                        </select>
                    </div>
                </div>
                <div class="col-md-12 mb-3">
                    <div class="form-label">&nbsp;</div>
                    <button type="button" class="btn btn-primary w-100 confirm">@lang('Confirm Pay')</button>
                </div>
                <div class="modal modal-blur fade" id="confirmationModal" tabindex="-1" role="dialog"
                    aria-hidden="true">
                    <div class="modal-dialog modal-sm modal-dialog-centered" role="document">
                        <div class="modal-content">
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                            <div class="modal-status bg-primary"></div>
                            <div class="modal-body text-center py-4">
                                <i class="fas fa-info-circle fa-3x text-primary mb-2"></i>
                                <h3>@lang('Confirm payment')</h3>

                            </div>
                            <div class="modal-footer">
                                <div class="w-100">
                                    <div class="row">
                                        <div class="col"><a href="#" class="btn w-100" data-bs-dismiss="modal">
                                                @lang('Cancel')
                                            </a></div>
                                        <div class="col">
                                            <button type="button" id="modalConfirm"
                                                class="btn btn-primary w-100 confirm">
                                                @lang('Confirm')
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </form>
        </div>

    </div>
</div>
@endif


<div class="row row-deck row-cards mb-5">
    <div class="col-md-12">
        <h2> @lang('Recent Paid')</h2>
    </div>
    <div class="col-12">
        <div class="card">
            <div class="table-responsive">
                <table class="table table-vcenter card-table table-striped">
                    <thead>
                        <tr>
                            <th>@lang('Transaction')</th>
                            <th>@lang('Create')</th>
                            <th>@lang('Phone Number')</th>
                            <th>@lang('Amount')</th>
                        </tr>
                    </thead>
                    <tbody>
                        @foreach($recentPays as $item)
                        <tr>
                            <td>{{$item->trnx}}</td>
                            {{-- <td>{{numFormat($item->amount)}} {{$item->currency->code}}</td> --}}
                            <td>{{dateFormat($item->created_at)}}</td>
                            <td>
                                {{ $item->details}}
                            </td>
                            <td>{{numFormat($item->amount)}}</td>
                        </tr>
                        @endforeach

                        {{-- @empty
                        <tr>
                            <td class="text-center" colspan="12">@lang('No data found!')</td>
                        </tr>
                        @endforelse --}}
                    </tbody>
                </table>
            </div>
            @if ($recentPays->hasPages())
            <div class="card-footer">
                {{$recentPays->links()}}
            </div>
            @endif
        </div>
    </div>
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