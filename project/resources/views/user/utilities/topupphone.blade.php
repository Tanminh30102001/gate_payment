@extends('layouts.user')

@section('title')
    @lang('Nạp tiền điện thoại')
@endsection

@section('breadcrumb')
    @lang('Nạp tiền điện thoại')
@endsection

@section('content')
<div class="container-xl">
    <div class="row row-deck row-cards mb-5">
        <div class="col-12">
            <div class="card">
                <div class="card-body">
                    <!-- Tabs for Category Selection -->
                    <ul class="nav nav-tabs" id="categoryTab" role="tablist">
                        <li class="nav-item" role="presentation">
                            <a class="nav-link active" id="mobile-tab" data-bs-toggle="tab" href="#mobile" role="tab" aria-controls="mobile" aria-selected="true">
                                @lang('Nạp tiền điện thoại')
                            </a>
                        </li>
                        <li class="nav-item" role="presentation">
                            <a class="nav-link" id="data-tab" data-bs-toggle="tab" href="#data" role="tab" aria-controls="data" aria-selected="false">
                                @lang('Nạp data 3G/4G')
                            </a>
                        </li>
                    </ul>

                    <!-- Tab Content -->
                    <div class="tab-content" id="categoryTabContent">
                        <!-- Mobile Tab -->
                        <div class="tab-pane fade show active" id="mobile" role="tabpanel" aria-labelledby="mobile-tab">
                            <form action="" method="post" class="mt-3">
                                @csrf
                                <div class="mb-3">
                                    <label for="phone_number" class="form-label">@lang('Số điện thoại')</label>
                                    <input type="text" class="form-control" id="phone_number" placeholder="@lang('Nhập số điện thoại')" required>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">@lang('Loại thuê bao')</label>
                                    <div class="form-check form-check-inline">
                                        <input class="form-check-input" type="radio" name="subscription_type" id="prepaid" value="prepaid" checked>
                                        <label class="form-check-label" for="prepaid">@lang('Trả trước')</label>
                                    </div>
                                    <div class="form-check form-check-inline">
                                        <input class="form-check-input" type="radio" name="subscription_type" id="postpaid" value="postpaid">
                                        <label class="form-check-label" for="postpaid">@lang('Trả sau')</label>
                                    </div>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">@lang('Chọn mệnh giá')</label>
                                    <div class="row">
                                        <!-- Amount Cards -->
                                        @foreach([10000, 20000, 30000, 50000, 100000, 200000, 300000, 500000] as $amount)
                                            <div class="col-6 col-md-3 mb-3">
                                                <div class="card amount-card" data-amount="{{ $amount }}">
                                                    <div class="card-body text-center">
                                                        <h5 class="card-title">{{ number_format($amount, 0, ',', '.') }} đ</h5>
                                                        <p class="card-text">Nhận thêm: {{ number_format($amount * 0.05, 0, ',', '.') }} đ</p>
                                                        <!-- Example of additional info, e.g., discount, bonus points, etc. -->
                                                    </div>
                                                </div>
                                            </div>
                                        @endforeach
                                    </div>
                                </div>
                                <button type="submit" class="btn btn-primary w-100">@lang('Tiếp tục')</button>
                            </form>
                        </div>

                        <!-- Data Tab -->
                        <div class="tab-pane fade" id="data" role="tabpanel" aria-labelledby="data-tab">
                            <form action="" method="post" class="mt-3">
                                @csrf
                                <div class="mb-3">
                                    <label for="phone_number_data" class="form-label">@lang('Số điện thoại')</label>
                                    <input type="text" class="form-control" id="phone_number_data" placeholder="@lang('Nhập số điện thoại')" required>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">@lang('Chọn gói data')</label>
                                    <div class="row">
                                        <!-- Data Cards -->
                                        @foreach([10000, 20000, 30000, 50000, 100000, 200000, 300000, 500000] as $amount)
                                            <div class="col-6 col-md-3 mb-3">
                                                <div class="card amount-card" data-amount="{{ $amount }}">
                                                    <div class="card-body text-center">
                                                        <h5 class="card-title">{{ number_format($amount, 0, ',', '.') }} đ</h5>
                                                        <p class="card-text">Nhận thêm: {{ number_format($amount * 0.05, 0, ',', '.') }} đ</p>
                                                    </div>
                                                </div>
                                            </div>
                                        @endforeach
                                    </div>
                                </div>
                                <button type="submit" class="btn btn-primary w-100">@lang('Tiếp tục')</button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    // JavaScript to handle card selection
    document.querySelectorAll('.amount-card').forEach(card => {
        card.addEventListener('click', function () {
            // Remove active class from all cards
            document.querySelectorAll('.amount-card').forEach(c => c.classList.remove('active-card'));
            // Add active class to the selected card
            this.classList.add('active-card');
        });
    });
</script>

<style>
    .amount-card {
        cursor: pointer;
        transition: transform 0.2s;
    }
    .amount-card:hover {
        transform: scale(1.05);
    }
    .active-card {
        border: 2px solid #007bff;
        background-color: #e7f3ff;
    }
</style>
@endsection
