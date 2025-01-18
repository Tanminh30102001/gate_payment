<?php
namespace App\Helpers;

use App\Models\ResultLogs;
use GuzzleHttp\Client;
use GuzzleHttp\Exception\RequestException;
use Illuminate\Support\Facades\App;

class ApiHelper
{
    public static function Encrypt($text, $passphrase)
    {
       
        $salt = openssl_random_pseudo_bytes(8);
        $salted = $dx = '';
        while (strlen($salted) < 48) {
            $dx = md5($dx . $passphrase . $salt, true);
            $salted .= $dx;
        }
        $key = substr($salted, 0, 32);
        $iv = substr($salted, 32, 16);
        return base64_encode('Salted__' . $salt . openssl_encrypt($text . '', 'aes-256-cbc', $key, OPENSSL_RAW_DATA, $iv));
    }

}