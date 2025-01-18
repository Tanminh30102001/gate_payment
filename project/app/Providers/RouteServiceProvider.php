<?php

namespace App\Providers;

use Illuminate\Cache\RateLimiting\Limit;
use Illuminate\Foundation\Support\Providers\RouteServiceProvider as ServiceProvider;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\RateLimiter;
use Illuminate\Support\Facades\Route;

class RouteServiceProvider extends ServiceProvider
{
    /**
     * The path to your application's "home" route.
     *
     * Typically, users are redirected here after authentication.
     *
     * @var string
     */
    public const HOME = '/home';

    /**
     * Define your route model bindings, pattern filters, and other route configuration.
     */
    public function boot()
    {
        $this->configureRateLimiting();

        $this->routes(function () {
            Route::prefix('api')
                ->middleware('api')
                ->namespace($this->namespace)
                ->group(base_path('routes/api.php'));
            Route::middleware('web')
                ->namespace($this->namespace)
                ->group(base_path('routes/web.php'));
            Route::middleware('web')
                ->namespace($this->namespace)
                ->group(base_path('routes/adminRoute.php'));
            Route::middleware('web')
                ->namespace($this->namespace)
                ->group(base_path('routes/userRoute.php'));
            Route::middleware('web')
                ->namespace($this->namespace)
                ->group(base_path('routes/merchantRoute.php'));
            Route::middleware('web')
                ->namespace($this->namespace)
                ->group(base_path('routes/agentRoute.php'));
        });
    }

    /**
     * Configure the rate limiters for the application.
     *
     * @return void
     */
    protected function configureRateLimiting()
    {
        RateLimiter::for('api', function (Request $request) {
            return Limit::perMinute(60)->by(optional($request->user())->id ?: $request->ip());
        });
        RateLimiter::for('sendSMS', function (Request $request) {
            $accessKey = $request->header('Authorization') ?: $request->query('access_key');

            // Kiểm tra access key trong cơ sở dữ liệu
            $user = DB::table('api_creds')->where('access_key', $accessKey)->first();

            if (!$user) {
                return Limit::perMinute(1,1)->by($request->ip());
            }
            return Limit::perMinutes(1, 1)->by($user->id);
            // Nếu tìm thấy user, giới hạn dựa trên ID người dùng
            // return Limit::perMinute(5)->by($user->id);
            
        });
    }
}
