<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ProductApota extends Model
{
    use HasFactory;
    public $table='product_apota';
    protected $fillable = [
        'telco',
        'productCode',
        'amount'
    ];
    public $timestamps=true;
}