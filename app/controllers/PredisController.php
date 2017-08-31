<?php
use Phalcon\Cache\Backend\Redis;
use Phalcon\Cache\Frontend\Data as FrontData;

class PredisController extends \Phalcon\Mvc\Controller
{

    public function config($value='')
    {

    	$client = new Predis\Client([
		    'scheme' => 'tcp',
		    'host'   => 'localhost',
		    'port'   => 6379,
		    "lifetime" => 172800,
		]);

		return $client;
    }
    

}

//////////////////////////////////
//////// CONTOH PEMAKAIAN ////////
//////////////////////////////////

// /* CONEKSI KE REDIS */
// $redis = new PredisController;
// $predis = $redis->config();

// /* SET DATA KE REDIS */
// $data = array(
// 	'nama' => "Kanbara Akihito", 
// 	'no' => "JHYYF673472346", 
// 	'kelas' => "A2", 
// 	);
// $predis->set("my-data", json_encode($data)); // JSON DATA
// $predis->expire("my-data", 10); // SET EXPIRE 10 DETIK


// /* GET DATA Redis per key */
// $get = $predis->get("my-data");
// echo "$get";


?>