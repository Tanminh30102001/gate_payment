@extends('layouts.frontend')

@section('title')
    @lang('Thanh toán hóa đơn')
@endsection

@section('content')
    {{-- @if (session('payment_status'))
    <div class="alert alert-{{ session('payment_status')['success'] ? 'success' : 'danger' }}" role="alert">
        {{ session('payment_status')['message'] }}
        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
            <span aria-hidden="true">&times;</span>
          </button>
    </div>
    @endif --}}
    <div class="container mt-5">
        <h2 class="text-center"> Thanh Toán Điện Nước</h2>
        <form id="billForm" method="GET" action="{{ route('front.thanhtoandiennuoc') }}">
            <div class="form-group">
                <label for="serviceType">Loại dịch vụ</label>
                <select class="form-control" id="serviceType" name="serviceType">
                    <option value="">Chọn loại dịch vụ</option>
                    <option value="electricity" @if (isset($serviceType) && $serviceType == 'electricity') selected @endif>Tiền điện</option>
                    <option value="water" @if (isset($serviceType) && $serviceType == 'water') selected @endif>Tiền nước</option>
                </select>
            </div>
        </form>

        @if (isset($serviceType))
            <form id="paymentForm" method="GET" action="{{ route('getBillDetails') }}">
                <div class="form-group">
                    <label for="provider">Nhà cung cấp</label>
                    <select class="form-control" id="provider" name="provider">
                        <option value="">Chọn nhà cung cấp</option>
                        @foreach ($providers as $key => $value)
                            <option value="{{ $key }}">{{ $value }}</option>
                        @endforeach
                    </select>
                </div>

                <div class="form-group">
                    <label for="customerCode">Mã khách hàng</label>
                    <input type="text" class="form-control" id="customerCode" name="customerCode"
                        placeholder="Nhập mã khách hàng">
                </div>
                <div class="form-group">
                    <input type="hidden" name="serviceType" value="{{ $serviceType }}">
                </div>
                <div class="form-group">
                    <button type="submit" class="btn btn-primary mt-3">Xem hóa đơn</button>
                </div>
            </form>
        @endif
        {{-- {{dd($billDetails);}} --}}
        @if (isset($billDetails) && $billDetails !== null)
            <!-- Modal -->
            <div class="modal show" id="billDetailsModal" tabindex="-1" role="dialog" style="display:block;">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title">Chi tiết hóa đơn</h5>

                        </div>
                        <div class="modal-body">
                            <form method="POST" action="{{ route('front.handleThanhToanDienNuoc') }}">
                                @csrf
                                <p>Mã hóa đơn: {{ $billDetails['billNumber'] }}</p>
                                <p>Kỳ hạn: {{ $billDetails['period'] }}</p>
                                <p>Số tiền: {{ $billDetails['amount'] }} VND</p>
                        </div>
                        {{-- <div class="form-group mx-2">
                            <label for="signature">Nhập chữ ký</label>
                            <input type="text" class="form-control " id="signature" name="signature"
                                placeholder="Nhập chữ ký">
                        </div> --}}
                        <div class="modal-footer">
                            <input type="hidden" name="customerCode" value="{{ $customerCode }}">
                            <input type="hidden" name="billNumber" value="{{ $billDetails['billNumber'] }}">
                            <input type="hidden" name="period" value="{{ $billDetails['period'] }}">
                            <input type="hidden" name="amount" value="{{ $billDetails['amount'] }}">
                            <input type="hidden" name="billType" value="{{ $billDetails['billType'] }}">
                            <input type="hidden" name="serviceType" value="{{ $serviceType }}">
                            <input type="hidden" name="provider" value="{{ $provider }}">
                            <button type="button" class="btn btn-secondary"  onclick="closeModal()">Đóng</button>
                            <button type="submit" class="btn btn-primary" onclick="closeModal()">Thanh toán</button>
                        </div>
                        </form>
                    </div>
                </div>
            </div>
        @elseif(isset($billDetails) && $billDetails == null)
            <div class="modal show" id="billDetailsModal" tabindex="-1" role="dialog" style="display:block;">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title">Chi tiết hóa đơn</h5>
                        </div>
                        <div class="modal-body">
                            <h4> Hóa đơn này không có nợ cước</h4>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" onclick="closeModal()">Đóng</button>
                        </div>
                    </div>
                </div>
            </div>
        @endif

    </div>
@endsection

@push('script')
    <script>
        $(document).ready(function() {
            $('#serviceType').change(function() {
                var selectedValue = $(this).val();
                if (selectedValue !== "") {
                    window.location.href = "{{ route('front.thanhtoandiennuoc') }}?serviceType=" +
                        selectedValue;
                }
            });
        });
        function closeModal() {

        $('#billDetailsModal').modal('hide');
    }

    $(document).ready(function() {
        $('#billDetailsModal').modal('show');
    });
    
    </script>
@endpush
