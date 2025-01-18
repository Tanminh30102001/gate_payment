<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ApiCreds extends Model
{
    use HasFactory;

    protected $guarded = [];
    public $fillable=[
        'api_key',
        'merchant_id',
        'access_key',
        'mode'
    ];

    public function merchant()
    {
        return $this->belongsTo(Merchant::class,'merchant_id');
    }
}
