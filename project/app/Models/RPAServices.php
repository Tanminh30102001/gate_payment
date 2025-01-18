<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class RPAServices extends Model
{
    use HasFactory;
    public $table='rpaservices';
    protected $fillable = [
        'transactionId',
        'payload',
        'status',
        'response_from_bot'
    ];
    public $timestamps=true;
    protected $hidden = [
        'id',

    ];
}