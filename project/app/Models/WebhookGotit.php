<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class WebhookGotit extends Model
{
    use HasFactory;
    public $table='webhook_gotit';
    protected $fillable = [
       'payload',
    ];
    public $timestamps=true;
}
