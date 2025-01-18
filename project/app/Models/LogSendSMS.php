<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class LogSendSMS extends Model
{
    use HasFactory;
    protected $guarded = [];
    public $table='log_send_sms';
    protected $fillable = [
        'user_id',
        'user_type',
        'phone_to',
        'phone_from',
        'message_id',
        'status',
        'enviroment',
        'message_info',
    ];
    public $timestamps=true;

}
