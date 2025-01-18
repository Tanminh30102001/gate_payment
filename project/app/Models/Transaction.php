<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Transaction extends Model
{
    use HasFactory;
    protected $fillable = [
        'trnx',
        'user_id', // Thêm 'user_id' vào đây để cho phép mass assignment
        'user_type',
        'currency_id',
        'wallet_id',
        'amount',
        'remark',
        'type',
        'details',
    ];

    public function currency()
    {
        return $this->belongsTo(Currency::class)->withDefault();
    }
    public function user()
    {
        return $this->belongsTo(User::class)->withDefault();
    }
    public function merchant()
    {
        return $this->belongsTo(Merchant::class,'user_id')->withDefault();
    }
    public function agent()
    {
        return $this->belongsTo(Agent::class,'user_id')->withDefault();
    }
}
