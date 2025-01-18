<?php

namespace App\Http\Middleware;

use Closure;
use App\Models\ApiCreds;
use Illuminate\Http\Request;

class MerchantAccess
{
    /**
     * Handle an incoming request.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \Closure  $next
     * @return mixed
     */
    public function handle(Request $request, Closure $next)
    {
        // Lấy access_key từ header Authorization
        $access_key = $request->header('Authorization') ?? '';

        // Kiểm tra access_key có tồn tại trong database hay không
        $accessKeyExists = ApiCreds::where('access_key', $access_key)->first();

        // Nếu không có Authorization hoặc access_key không hợp lệ
        if (empty($access_key) || !$accessKeyExists) {
            return response()->json([
                'status' => false,
                'message' => 'Unauthorized'
            ], 401);
        }

        // Nếu hợp lệ, tiếp tục xử lý request
        return $next($request);
    }
}
