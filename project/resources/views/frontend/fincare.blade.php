@extends('layouts.frontend')

@section('title')
    @lang('Fincare')
@endsection


@section('content')
    <!-- Documentation -->
    <section class="documentation-section pt-100 pb-100">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-lg-10">
                    <div class="documentation-wrapper">
                        <div class="documentation-item" id="intro">
                            <div class="documentation-header">
                                <h3 class="title">@lang('Fincare')</h3>

                            </div>
                            <p>
                                @lang('Proud to be the first and most reputable financial solutions platform in the region,
                                                                                                                                 helping the community experience safe, reliable, and transparent group credit. 
                                                                                                                                 We thoroughly address challenges faced by traditional capital contribution communities through an intelligent mechanism—Vote Credit scores, guaranteed by banks nationwide.')
                                @lang('Fincare - the first exclusive group credit platform in Vietnam.')
                            </p>
                        </div>
                        <div><button type="button" class="btn btn-dark mt-3"> <a href="https://fincare.vn/"
                                    target="blank" style="color:white">@lang('Join now') </a> </button> </div>
                        <div class="row my-5">
                            <div class="col-lg-4">
                                <p>@lang('By utilizing advanced technology with rapid and efficient processing capabilities, Fincare delivers exceptional benefits and optimizes cash flow management.')</p>
                            </div>
                            <div class="col-lg-4">
                                <p>@lang('Comprehensive KYC identification and three-party contracts (Bank - User - Fincare) ensure the thorough minimization of risks for members participating in Fincare\'s group credit').</p>
                            </div>
                            <div class="col-lg-4">
                                <p>@lang('Creating a flexible community capital source, building mechanisms for superior and sustainable profit.
                                                                                                                                ')</p>
                            </div>
                        </div>

                        <div class="documentation-item" id="api">
                            <div class="documentation-header">
                                <h3 class="title">@lang('Suitable for all demographics')</h3>
                            </div>
                            <div class="row">
                                <div class="col-6">
                                    <div class="row my-3">
                                        <p> @lang('Fincare is an exclusive project suitable for all demographics, developed from the traditional community funding platforms that have long existed in Vietnam and Southeast Asia. What makes Fincare unique
                                                                                                                                                                is its creation of a space where participants support and help each other based on voluntary agreements within a group.')</p>
                                    </div>
                                    <div class="row my-3">
                                        <p> @lang('Fincare offers flexibility to its participants, who can decide on the number of members, duration, and fund size through the group credit model. Each member contributes funds to a pool according to pre-agreed terms, with rights and responsibilities clearly defined')</p>
                                    </div>
                                    <div class="row my-3">
                                        <p> @lang('With this model, Fincare is not just an online group credit platform but also a community where participants contribute and make decisions together. Consensus and support help build a sustainable and prosperous financial future.')@lang(' It\'s a space where everyone has the opportunity to participate and benefit from the unity and mutual support within the Fincare community.')</p>
                                    </div>
                                </div>
                                <div class="col-6">
                                    <img src="https://fincare.vn/assets/solution-e550724d.gif"
                                        style="height: 70vh;width:70vh" />
                                </div>
                            </div>
                        </div>
                        <div class="documentation-item" id="payment">
                            <div class="documentation-header">
                                <h3 class="title">@lang('Save and Invest Safely with Fincare')</h3>
                            </div>

                            <div class="row">
                                <div class="col-6" style="position: relative">
                                    <img src="https://fincare.vn/assets/investment-409bcd75.svg" />
                                    <img src="https://fincare.vn/assets/Pi-ng-i-trong-game-unscreen-e298d86b.gif"
                                        style="position: absolute;top:0;right:0;transform:translate(30%,40%)" />
                                </div>
                                <div class="col-6">
                                    <p>
                                        @lang('With a primary focus on information security, Fincare integrates a triple-layered security system. The login process is modernly designed, incorporating Google Authenticator to rigorously protect player information. We are committed to safeguarding the personal and financial information of every member in the community. Our experienced team is dedicated to supporting players throughout their journey with Fincare\'s group credit services.')
                                    </p>
                                    <div class="mx-auto" style="width: 200px;">
                                        <button type="button" class="btn btn-dark" style="width: 200px;"><a
                                                href="https://fincare.vn/" target="blank" style="color:white">@lang('Join now') </a></button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="documentation-item" id="payment">
                            <div class="documentation-header">
                                <h3 class="title">@lang('Buy USD to play Fincare with Alaba pay')</h3>
                            </div>
                            <div class="row">
                                <div class="col-6 mt-3">
                                    <p>
                                        @lang('Are you ready to dive into the exciting world of Fincare? With Alaba Pay, purchasing USD to enhance your Fincare experience has never been easier!')
                                    </p>
                                    <div class="row mt-2">
                                        <p>
                                            @lang('Enjoy secure, fast, and easy transactions that let you dive straight into the game. With Alaba Pay, you get competitive exchange rates, multiple payment options, and 24/7 customer support. Simply log in, select the amount of USD, choose your payment method, and confirm your transaction. Your USD will be available instantly')
                                        </p>
                                    </div>
                                    <div class="row mt-3">
                                        <div class="mx-auto" style="width: 200px;">
                                            <button type="button" disabled class="btn btn-dark"
                                                style="width: 200px;">@lang('Comming soon')!</button>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-6">
                                    <img src="{{ getPhoto('buy_usdt-removebg-preview.png') }}" width="100%" height="300"
                                        alt="Tabler" class="navbar-brand-image">
                                </div>
                            </div>


                        </div>


                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Documentation -->
@endsection

@push('script')
    <script src="{{ asset('assets/frontend') }}/js/highlight.min.js"></script>
    <script>
        hljs.highlightAll();
    </script>

    <script src="{{ asset('assets/frontend') }}/js/clipboard.min.js"></script>
    <script>
        new ClipboardJS('.copy-btn');
        new ClipboardJS('.ver-btn');
    </script>
@endpush
