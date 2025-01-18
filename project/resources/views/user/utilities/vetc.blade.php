@extends('layouts.user')

@section('title')
@lang('Pay VETC')
@endsection

@section('breadcrumb')
@lang('Pay VETC')
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
                                <div class="form-label">@lang('Number Plate : ')</div>
                                <input type="text" name="customer_code" id="customer_code" class="form-control shadow-none mb-2" required>
                            </div>
                            <div class="col-md-6 mb-2">
                                <div class="form-label">@lang('Color of plate')</div>
                                <select class="form-select wallet shadow-none" name="color">
                                    <option value="" selected>@lang('Select')</option>
                                    <option value="T">@lang('White')</option>
                                    <option value="V">@lang('Yellow')</option>
                                    <option value="X">@lang('Blue')</option>
                                </select>
                            </div>
                            <div class="col-md-6">
                                <div class="form-label">@lang('Select Wallet')</div>
                                <select class="form-select wallet shadow-none" name="wallet_id">
                                    <option value="" selected>@lang('Select')</option>
                                    @foreach ($wallets as $wallet)
                                    <option value="{{ $wallet->id }}" data-currency="{{ $wallet->currency->id }}" data-code="{{ $wallet->currency->code }}">
                                        {{ $wallet->currency->code }} -- ({{ amount($wallet->balance, $wallet->currency->type, 3) }})
                                    </option>
                                    @endforeach
                                </select>
                            </div>

                            <div class="col-md-12 ">
                                <div class="form-label">@lang(' Amount') <code class="limit">@lang('Min'):{{numFormat(charge('pay-vetc')->minimum)}} {{getCurrencyCode()}} - @lang('Max'):{{numFormat(charge('pay-vetc')->maximum)}} {{getCurrencyCode()}} </code> </div>
                                <input type="number" name="bill_value" id="bill_value" class="form-control shadow-none mb-2" required>
                                <small class="text-danger charge">@lang('Charge'): {{charge('pay-vetc')->percent_charge}} %</small>
                            </div>

                            {{-- <div class="col-md-12 my-3 info ">
                                <ul class="list-group mt-2">
                                    <li class="list-group-item d-flex justify-content-between font-weight-bold">@lang('Withdraw Amount : ')<span class="exAmount"></span></li>
                                    <li class="list-group-item d-flex justify-content-between font-weight-bold">@lang('Total Charge : ')<span class="exCharge"></span></li>
                                    <li class="list-group-item d-flex justify-content-between font-weight-bold">@lang('Total Amount : ')<span class="total_amount"></span></li>
                                </ul>

                                <div class="mt-4 text-center">
                                    <h5 class="text-danger">@lang('Withdraw instruction')</h5>
                                    <p class="instruction mt-2"></p>
                                </div>

                                <div class="mt-3 text-center">
                                    <h5 class="text-danger">@lang('Provide your withdraw account details.')</h5>
                                    <textarea name="user_data" class="form-control shadow-none" cols="30" rows="10" required></textarea>
                                </div>
                            </div> --}}

                            <div class="col-md-12 mb-3">
                                <div class="form-label">&nbsp;</div>
                                <button type="button" class="btn btn-primary w-100 confirm">@lang('Confirm')</button>
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
                    <div class="col-4"><strong>@lang('Transaction'):</strong></div>
                    <div class="col-8">{{ (session('dataOfBot'))->transactionId }}</div>
                </div>
                <div class="row mb-2">
                    <div class="col-4"><strong>@lang('Number Plate'):</strong></div>
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
        </div>
        </div>
    </div>
    @endif

    <div class="modal modal-blur fade" id="confirmationModal" tabindex="-1" role="dialog" aria-hidden="true">
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
                                <button type="button" id="modalConfirm" class="btn btn-primary w-100 confirm">
                                    @lang('Confirm')
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
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
    document.querySelectorAll('input[name="bill_value"]').forEach(input => {
        input.addEventListener('change', function() {
            document.querySelectorAll('.btn-secondary').forEach(label => {
                label.classList.remove('active');
            });
            this.closest('label').classList.add('active');
        });
    });
    document.querySelector('.confirm').addEventListener('click', function() {
        var modal = new bootstrap.Modal(document.getElementById('confirmationModal'));
        modal.show();
    });
    document.getElementById('modalConfirm').addEventListener('click', function() {
        document.getElementById('form').submit();
    });

</script>
@endsection
