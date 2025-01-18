<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class VoucherGotit extends Model
{
    use HasFactory;
    public $table='voucher_gotits';
    protected $fillable = [
        'productId',
        'priceId',
        'priceValue'
    ];
    public $timestamps=true;
}
