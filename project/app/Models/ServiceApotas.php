<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ServiceApotas extends Model
{
    use HasFactory;
    public $table = 'service_apota';
    public $timestamps = false;
    protected $fillable = ['serviceCode', 'categories', 'serviceName'];
}
