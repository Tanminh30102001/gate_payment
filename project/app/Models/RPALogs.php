<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class RPALogs extends Model
{
    use HasFactory;
    public $table='rpa_logs';
    protected $fillable = [
        'transactionId',
        'user_id',
        'user_type',
        'data_send',
        'data_receive',
        'type_payment',
        'status'
    ];
    public $timestamps=true;
    protected $hidden = [
        'id',

    ];
}