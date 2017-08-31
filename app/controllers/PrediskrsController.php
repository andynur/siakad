<?php
use Phalcon\Mvc\View;
use Phalcon\Validation;
use Phalcon\Forms\Element\Text;
use Phalcon\Validation\Validator\Date;
use Phalcon\Validation\Validator\PresenceOf;
use Phalcon\Validation\Validator\Numericality;

use Phalcon\Cache\Backend\Redis;
use Phalcon\Cache\Frontend\Data as FrontData;

class PrediskrsController extends FungsiController
{

    public function initialize()
    {
      if (empty($this->session->get('uid'))) {
          $this->response->redirect('account/loginEnd');
      }
      $this->view->setRenderLevel(View::LEVEL_ACTION_VIEW);
      date_default_timezone_set('Asia/Jakarta');
    }


    public function psmhs_id($nomhs)
    {
    	$sql2 = "SELECT id_ps from RefAkdMhs where id_mhs = '$nomhs'";
		$dt_mhs = $this->modelsManager->executeQuery($sql2);
    }

    public function db_array($sql)
    {
    	return $this->modelsManager->executeQuery($sql)->toArray();
    }


    public function DataKrsReloadAction()
    {
    	/* connec to redis */
    	$redis = new PredisController;
		$predis = $redis->config();

		$get_session = $this->session->get('ps_id');
		$explode = explode('-', $get_session);
		$ps_id = $explode[1];

    	$nomhs = $_GET['nomhs'];
		$krs_ol = $_GET['krs_ol'];

		$key_redis = "krs_mhs_".$nomhs."_".$krs_ol;
		if (empty($predis->get($key_redis))) {
			$this->ListMkDitawarkanAction($nomhs,$krs_ol);
		}

    	$data_json = $predis->get($key_redis);
    	$data = json_decode($data_json,TRUE);

    	if ($data['halaman'] == "error/error") {

    		$this->view->nomhs = $data['nomhs'];
	    	$this->view->krs_ol = $data['krs_ol'];
	    	$this->view->ps_id = $data['ps_id'];
			$this->view->psmhs_id = $data['psmhs_id'];
			$this->view->thn_akd = $data['thn_akd'];
			$this->view->session_id = $data['session_id'];
			$this->view->ol_id = $data['ol_id'];

			$halaman = "error/error";
			$this->view->angka = $data['angka'];
			$this->view->pesan1 = $data['pesan1'];
			$this->view->pesan2 = $data['pesan2'];
    	}else{

	    	$this->view->nomhs = $data['nomhs'];
	    	$this->view->krs_ol = $data['krs_ol'];
	    	$this->view->ps_id = $data['ps_id'];
			$this->view->psmhs_id = $data['psmhs_id'];
			$this->view->thn_akd = $data['thn_akd'];
			$this->view->session_id = $data['session_id'];
			$this->view->ol_id = $data['ol_id'];

	    	$this->view->jatah_sks = $data['jatah_sks'];
			$this->view->session_thn_sks = $data['session_thn_sks'];
			$this->view->nama_ps = $data['nama_ps'];
			$this->view->dt_mhs = $data['dt_mhs'];
			$this->view->sys_pilihan_sks = $data['sys_pilihan_sks'];
			$this->view->nm_pilihan_sks = $data['nm_pilihan_sks'];

			$nomhs = $data['nomhs'];
	    	$krs_ol = $data['krs_ol'];
			$psmhs_id = $data['psmhs_id'];
			$thn_akd = $data['thn_akd'];
			$session_id = $data['session_id'];
			$map_nilai_mk = $data['map_nilai_mk'];
			$vcx = $data['vcx'];
			$thn_kur = $data['dt_mhs']['id_kur'];
			$angkatan = $data['dt_mhs']['angkatan'];

			/* CEK RELOAD ATO TIDAK : JIKA RELOAD MAKA REPLACE DATA REDIS */			
			$this->RedisDataMkKrs($nomhs,$psmhs_id,$thn_akd,$session_id,$krs_ol,$thn_kur,$angkatan);
			
			$key_redis2 = "krs_data_".$nomhs."_".$krs_ol;
			$data_json = $predis->get($key_redis2);
	    	$data_krs = json_decode($data_json,TRUE);

			$this->view->krs_mhs = $data_krs['krs_mhs']; // krs yang di pilih mhs
			$this->view->pilih_jadwal = $data_krs['pilih_jadwal']; // jadwal krs jam_awal - jam_akhir
			$this->view->jad_mk = $data_krs['jad_mk']; // jadwal krs jam_awal - jam_akhir

	    	/* CEK LIST MK YANG DIAJUKAN */
	    	$key_redis4 = "krs_data_count_".$nomhs."_".$krs_ol;
	    	$data_json = $predis->get($key_redis4);
	    	$data_krs_count = json_decode($data_json,TRUE);

			$cmd = "SELECT jadkul_id,thn_akd,session_id,nama_kelas,ps_id,kode_mk,nama,thn_kur,semester,sks from ViewListMkKrs d
			        where thn_akd = '$thn_akd' 
			          and session_id = '$session_id'
			          and nama_kelas is not null
			          and ps_id = '$ps_id'
			          and ps_allow = '$psmhs_id' group by kode_mk";
			$list_mk_krs_diajukan = $this->modelsManager->executeQuery($cmd)->toArray();
			$list_mk_count = count($list_mk_krs_diajukan);
			
			if ($data_krs_count['count'] != $list_mk_count) {
				$map_nilai_mk = $data['map_nilai_mk'];
				$vcx = $data['vcx'];
				$this->RedisKrsMk($nomhs,$psmhs_id,$thn_akd,$session_id,$krs_ol,$map_nilai_mk,$vcx,$thn_kur,$angkatan);
				
				$data_krs_count['count'] = $list_mk_count;
				$predis->set($key_redis4, json_encode($data_krs_count));
			}
			
			$key_redis3 = "krs_data_ajukan_".$nomhs."_".$krs_ol;
	    	$data_json = $predis->get($key_redis3);
	    	$data_krs_ajukan = json_decode($data_json,TRUE);

			$this->view->list_mk_krs_diajukan = $data_krs_ajukan['list_mk_krs_diajukan']; // list_mk_krs_diajukan
			$this->view->list_prasyarat_tidak_lolos = $data_krs_ajukan['list_prasyarat_tidak_lolos']; // list_prasyarat_tidak_lolos

			// echo "<pre>".print_r($key_redis3,1)."</pre>";die();


			/* MASUK DATA MHS */
	    	$this->view->krsx_ke = $data['krsx_ke']; // nilai tertinggi krs per MK
			$this->view->krs_nilai_tinggi = $data['krs_nilai_tinggi']; // nilai tertinggi krs per MK

			$halaman = 'akd_krs/list_mk_ditawarkan';
    	}

		$this->view->pick($halaman);

    }


    public function RedisDataMkKrs($nomhs,$psmhs_id,$thn_akd,$session_id,$krs_ol,$thn_kur,$angkatan)
    {
    	/* connec to redis */
    	$redis = new PredisController;
		$predis = $redis->config();

    	$fungsi = new FungsiController;
    	$helper = new Helpers();

    	$get_session = $this->session->get('ps_id');
		$explode = explode('-', $get_session);
		$ps_id = $explode[1];

    	$cmd = "SELECT b.jadkul_id,a.kode_mk,
	               a.thn_kur,
	               a.thn_akd,
	               a.session_id,
	               b.nama,
                   b.semester,
                   b.sks,
                   a.nama_kelas,
                   b.jam_awal,
                   b.jam_akhir
	          from RefAkdKrsol a join ViewListMkKrs b
		on a.thn_akd=b.thn_akd and a.session_id=b.session_id and a.nama_kelas=b.nama_kelas and a.ps_id=b.ps_id and a.kode_mk=b.kode_mk and a.thn_kur=b.thn_kur
	         where a.nomhs = '$nomhs'
	           and a.psmhs_id = '$psmhs_id'
	           and a.st_ambil != 'w'
	           and a.thn_akd = '$thn_akd'
	           and a.session_id = '$session_id'";

		$krs_mhs = $this->modelsManager->executeQuery($cmd)->toArray();
		foreach ($krs_mhs as $key => $value) {
			$pilih[$value['kode_mk']] = $value;
			$pilih_jadwal[$value['jadkul_id']] = $value;
		}


		/* JADWAL KULIAH PER MATAKULIAH */
		$cmd = "SELECT jadkul_id,nama_kelas,kode_mk,hari,jam_awal,jam_akhir,namadosen,namaruang,jml_mhs,kapasitas,prasyt_ang from ViewJadwalKrs
		        where thn_akd = '$thn_akd' 
		          and session_id = '$session_id'
		          and nama_kelas is not null
		          and ps_id = '$ps_id'
		          and ps_allow = '$psmhs_id'";
		$ViewJadwalKrs = $this->modelsManager->executeQuery($cmd)->toArray();

		foreach ($ViewJadwalKrs as $k => $v) {

			if (!empty($v['prasyt_ang'])) {
				$prasyt_ang = explode(',', $v['prasyt_ang']);
				if (in_array($angkatan, $prasyt_ang)) {
					
					$krs_jadwal[$v['kode_mk']][] = $v;

					if (array_key_exists($v['kode_mk'],$krs_jadwal)) {
						$s = $krs_jadwal[$v['kode_mk']];
						array_filter($s);
						array_push($s, $v);
					}
				}
			}else{
				$krs_jadwal[$v['kode_mk']][] = $v;

				if (array_key_exists($v['kode_mk'],$krs_jadwal)) {
					$s = $krs_jadwal[$v['kode_mk']];
					array_filter($s);
					array_push($s, $v);
				}
			}
		}

		$data_krs['krs_mhs'] = $pilih;
		$data_krs['pilih_jadwal'] = $pilih_jadwal;
		$data_krs['jad_mk'] = $krs_jadwal;

		$key_redis2 = "krs_data_".$nomhs."_".$krs_ol;
		$predis->set($key_redis2, json_encode($data_krs));
    }

    public function RedisKrsMk($nomhs,$psmhs_id,$thn_akd,$session_id,$krs_ol,$map_nilai_mk,$vcx,$thn_kur,$angkatan)
    {
    	/* connec to redis */
    	$redis = new PredisController;
		$predis = $redis->config();

    	$fungsi = new FungsiController;
    	$helper = new Helpers();

    	$get_session = $this->session->get('ps_id');
		$explode = explode('-', $get_session);
		$ps_id = $explode[1];

    	/* GET PRASYARAT matakuliah */
			$q = "SELECT b.thn_kur,
               b.kode_mk,
               a.nama,
               b.nama_kelas,
               a.prasyarat,
               a.ps_id
				from RefAkdMkkpkl b left join RefAkdMku a
				on b.kode_mk = a.kode_mk and b.thn_kur = a.thn_kur and b.ps_id = a.ps_id 
				where b.thn_akd = '$thn_akd'
				      and b.session_id = '$session_id'
				      and b.thn_akd is not null 
				      and b.session_id is not null
				      and b.ps_id = '$ps_id'
				      and a.prasyarat!=''
				order by a.nama,a.thn_kur,a.urut,a.kode_mk,b.nama_kelas";
		    $mkkpkl = $this->modelsManager->executeQuery($q)->toArray();
		    foreach ($mkkpkl as $key => $value) {
				$mkkpkl_psrt[$value['ps_id'].'#'.$value['thn_kur'].'#'.$value['kode_mk']] = $value['prasyarat'];
			}
			// echo "<pre>".print_r($mkkpkl_psrt,1)."</pre>";die();


			/* MAPPING PRASYARAT MAHASISWA PER MATAKULIAH */
			$conv_psrt = array();
			foreach ($mkkpkl_psrt as $key => $value) {
				$thn_kur_mk = explode('#', $key);
				$val = explode(' ', $value);
				if ($thn_kur_mk[0].'#'.$thn_kur_mk[1] != $ps_id.'#'.$thn_kur) {
					$kode_mk_pras = $val[0];

					$kodemk = $thn_kur_mk[2];
					$kur_nilainya = $thn_kur_mk[1];
					$ps_nilainya = $thn_kur_mk[0];
					//$zxc = $this->db_array("SELECT mkB0,mkB1,mkB2 from RefAkdMapmku where ps_idB = '$ps_id' and kurB = '$thn_kur' and ps_idA = '$psB' and kurA = '$kurB' and (mkA0='$kode_mk_pras' OR mkA1='$kode_mk_pras' OR mkA2='$kode_mk_pras') ");

					$kk = $ps_nilainya.'#'.$ps_id.'#'.$kur_nilainya.'#'.$thn_kur;
					foreach ($vcx[$kk] as $a => $b) {
						if ($b['mkA0'] == $kode_mk_pras || $b['mkA1'] == $kode_mk_pras || $b['mkA2'] == $kode_mk_pras ) {
							$dt_mk[] = $b['mkB0'];
							$dt_mk[] = $b['mkB1'];
							$dt_mk[] = $b['mkB2'];
						}
					}

					// $dt_mk[] = $zxc[0]['mkB0'];
					// $dt_mk[] = $zxc[0]['mkB1'];
					// $dt_mk[] = $zxc[0]['mkB2'];
					$edr = array_filter($dt_mk);
					$cnt = count($edr);
					if ($cnt == 1) {
						$mkk = $edr[0].' '.$val[1].' '.$val[2];
					}elseif ($cnt == 2) {
						$mkk = $edr[0].' '.$val[1].' '.$val[2].' OR '.$edr[1].' '.$val[1].' '.$val[2];
					}elseif ($cnt == 3) {
						$mkk = $edr[0].' '.$val[1].' '.$val[2].' OR '.$edr[1].' '.$val[1].' '.$val[2].' OR '.$edr[2].' '.$val[1].' '.$val[2];
					}

				}else{
					$mkk = $value;
				}
				$conv_psrt[$thn_kur_mk[2]] = $mkk;
			}
			// echo "<pre>".print_r($conv_psrt,1)."</pre>";die();

			/* CEK PRASYARAT */
			foreach ($conv_psrt as $key => $value) {
				
				$pisah_srt = explode('AND', $value);
				// echo "<pre>".print_r($pisah_srt,1)."</pre>";

				foreach ($pisah_srt as $k => $v) {
					
					$str = rtrim($v);
					$str2 = ltrim($str);
					// echo "<pre>".print_r($str2,1)."</pre>";
					if (count(explode(' ', $str2)) > 3 ) {
						$or = explode(' OR ', $str2);
							foreach ($or as $a => $b) {
								$zz = rtrim($b);
								$zz2 = ltrim($zz);
								$cc[] = explode(' ', $zz2);
							}
						$vv[] = $cc;
					}else{
						$vv = explode(' ', $str2);
					}
					$rr[$key][] = $vv;
				}
			}
			// echo "<pre>".print_r($rr,1)."</pre>";die();



			/* CEK PRASYARAT LOLOS ATO TIDAK */
			$cont_nilai = $fungsi->conf_nilai(); // CONVERT NILAI HURUF KE ANGKA
			/* 0  = dimunculkan atao prasyarat terpenuhi*/
			/* 1  = tidak dimunculkan atao prasyarat tidak terpenuhi*/
			$cek_mk = 0;
			$cek_cek = array();
			foreach ($rr as $mk => $v) {
				foreach ($v as $value) {
					$pal = count($value);
					if ($pal == 1) {
						foreach ($value as $a => $b) {
							foreach ($b as $c => $d) {
								if (array_key_exists($d[0],$map_nilai_mk)) {
									$n = $map_nilai_mk[$d[0]]['nilai_angka'];
									$equal = $d[1];
									$asd = $cont_nilai[$d[2]];
									eval("if (".$n.$equal.$asd.") {\$zxzx=0;} else { \$zxzx=1; }");

									$text = $n.' '.$equal.' '.$asd;
									
								}else{
									
									$equal = $d[1];
									if ($d[0] == "#IPK") {$n = $ipk; $asd = $d[2];}
									elseif ($d[0] == "#IPS") {$n = $ips; $asd = $d[2];}
									elseif ($d[0] == "#SKS") {$n = $sks_kum; $asd = $d[2];}
									else{$n = 0; $asd = $cont_nilai[$d[2]];}

									$zxzx = 1;
									$text = $n.' '.$equal.' '.$asd;
								}
								$zzz[] = $zxzx;
								$text_filter[] = $text;
							}

						}
						/*karena OR jika salah satu prasyarat terpenuhi maha lolos*/
						if (in_array("0", $zzz)) {
							$cek_mk = 0;		
						}else{
							$cek_mk = 1;		
						}
						$text_text = implode(' OR ', $text_filter);
					}else{
						if ($value[0] == "#IPK") {
							$ipk_set = $ipk;
							$equal_set = $value[1];
							$ingin_set = $value[2];
							eval("if (".$ipk_set.$equal_set.$ingin_set.") {\$cek_mk=0;} else { \$cek_mk=1; }");
							$text_text = $ipk_set.' '.$equal_set.' '.$ingin_set;

						}elseif($value[0] == "#IPS"){
							$ips_set = $ips;
							$equal_set = $value[1];
							$ingin_set = $value[2];
							eval("if (".$ips_set.$equal_set.$ingin_set.") {\$cek_mk=0;} else { \$cek_mk=1; }");
							$text_text = $ips_set.' '.$equal_set.' '.$ingin_set;

						}elseif($value[0] == "#SKS"){
							$sks_kum = $sks_kum;
							$equal_set = $value[1];
							$ingin_set = $value[2];
							eval("if (".$sks_kum.$equal_set.$ingin_set.") {\$cek_mk=0;} else { \$cek_mk=1; }");
							$text_text = $sks_kum.' '.$equal_set.' '.$ingin_set;

						}elseif (array_key_exists($value[0],$map_nilai_mk)) {
							$n = $map_nilai_mk[$value[0]]['nilai_angka'];
							$equal = $value[1];
							$asd = $cont_nilai[$value[2]];

							eval("if (".$n.$equal.$asd.") {\$cek_mk=0;} else { \$cek_mk=1; }");
							$text_text = $n.' '.$equal.' '.$asd;
							
						}else{
							$n = 0;
							$equal = $value[1];
							$asd = $cont_nilai[$value[2]];

							/* kirim ke cek_cek*/
							$cek_mk = 1;
							$text_text = $n.' '.$equal.' '.$asd;
						}
					}
					$cek_cek[$mk][] = $cek_mk;
					$text_cek[$mk][] = $text_text;
				}
			}
			/* END CEK PRASYARAT LOLOS ATO TIDAK */
			// echo "<pre>".print_r($text_cek,1)."</pre>";die();
			// echo "<pre>".print_r($cek_cek,1)."</pre>";
			// die();

			$cmd = "SELECT jadkul_id,thn_akd,session_id,nama_kelas,ps_id,kode_mk,nama,thn_kur,semester,sks from ViewListMkKrs d
			        where thn_akd = '$thn_akd' 
			          and session_id = '$session_id'
			          and nama_kelas is not null
			          and ps_id = '$ps_id'
			          and ps_allow = '$psmhs_id' group by kode_mk";
			$list_mk_krs_diajukan = $this->modelsManager->executeQuery($cmd)->toArray();

			/*$cek-text_pras adalah prasyarat yang TIDAK lolos dan Ditampilkan */
			$text_pras=array();
			foreach ($list_mk_krs_diajukan as $key => $value) {
				if (array_key_exists($value['kode_mk'], $cek_cek)) {
						// JIKA ADA 1 DI $cek_cek MAKA TIDAK LOLOS
					if (in_array("1", $cek_cek[$value['kode_mk']])) {
						if (array_key_exists($value['kode_mk'], $text_cek)) {
							$text_pras[] = array(
								'kode_mk' => $value['kode_mk'], 
								'thn_kur' => $value['thn_kur'], 
								'nama' => $value['nama'], 
								'syarat' => $conv_psrt[$value['kode_mk']], 
								'alasan' => implode(' AND ', $text_cek[$value['kode_mk']]) 

							);
						}
					}
				}

			}
			// echo "<pre>".print_r($text_pras,1)."</pre>";



			/*$cek-cek adalah prasyarat yang lolos dan tidak nya*/
			/*jika dudalam array $cek-cek tidak ada angka 0 maka tidak lolos MK tersebut*/
			$mk_blox=array();
			foreach ($list_mk_krs_diajukan as $key => $value) {
				if (array_key_exists($value['kode_mk'], $cek_cek)) {
					if (in_array("1", $cek_cek[$value['kode_mk']])) {
						/* MK yang tidak lolos dimasukkan ke $mk_box*/
						$mk_blox[] = $value['kode_mk'];		
					}
				}
			}
			// echo "<pre>".print_r($mk_blox,1)."</pre>";die();

			/* cek jika $list_mk_krs_diajukan ada di $mk_bok jangan dimunculkan */
			foreach ($list_mk_krs_diajukan as $key => $value) {
				if (!in_array($value['kode_mk'], $mk_blox)) {
					$krs_yang_diajukan[] = $value;
				}
			}
			// echo "<pre>".print_r($krs_yang_diajukan,1)."</pre>";die();
			
			$data_krs_ajukan['list_mk_krs_diajukan'] = $krs_yang_diajukan;
			$data_krs_ajukan['list_prasyarat_tidak_lolos'] = $text_pras;
			$key_redis3 = "krs_data_ajukan".$nomhs."_".$krs_ol;
			$predis->set($key_redis3, json_encode($data_krs_ajukan));
    }

    public function DataKrsAction($nomhs,$krs_ol)
    {
    	/* connec to redis */
    	$redis = new PredisController;
		$predis = $redis->config();

		$get_session = $this->session->get('ps_id');
		$explode = explode('-', $get_session);
		$ps_id = $explode[1];

		$key_redis = "krs_mhs_".$nomhs."_".$krs_ol;
		if (empty($predis->get($key_redis))) {
			$this->ListMkDitawarkanAction($nomhs,$krs_ol);
		}

    	$data_json = $predis->get($key_redis);
    	$data = json_decode($data_json,TRUE);

    	if ($data['halaman'] == "error/error") {

    		$this->view->nomhs = $data['nomhs'];
	    	$this->view->krs_ol = $data['krs_ol'];
	    	$this->view->ps_id = $data['ps_id'];
			$this->view->psmhs_id = $data['psmhs_id'];
			$this->view->thn_akd = $data['thn_akd'];
			$this->view->session_id = $data['session_id'];
			$this->view->ol_id = $data['ol_id'];

			$halaman = "error/error";
			$this->view->angka = $data['angka'];
			$this->view->pesan1 = $data['pesan1'];
			$this->view->pesan2 = $data['pesan2'];
    	}else{

	    	$this->view->nomhs = $data['nomhs'];
	    	$this->view->krs_ol = $data['krs_ol'];
	    	$this->view->ps_id = $data['ps_id'];
			$this->view->psmhs_id = $data['psmhs_id'];
			$this->view->thn_akd = $data['thn_akd'];
			$this->view->session_id = $data['session_id'];
			$this->view->ol_id = $data['ol_id'];

	    	$this->view->jatah_sks = $data['jatah_sks'];
			$this->view->session_thn_sks = $data['session_thn_sks'];
			$this->view->nama_ps = $data['nama_ps'];
			$this->view->dt_mhs = $data['dt_mhs'];
			$this->view->sys_pilihan_sks = $data['sys_pilihan_sks'];
			$this->view->nm_pilihan_sks = $data['nm_pilihan_sks'];

			$nomhs = $data['nomhs'];
	    	$krs_ol = $data['krs_ol'];
			$psmhs_id = $data['psmhs_id'];
			$thn_akd = $data['thn_akd'];
			$session_id = $data['session_id'];
			$map_nilai_mk = $data['map_nilai_mk'];
			$vcx = $data['vcx'];
			$thn_kur = $data['dt_mhs']['id_kur'];
			$angkatan = $data['dt_mhs']['angkatan'];

			/* CEK RELOAD ATO TIDAK : JIKA RELOAD MAKA REPLACE DATA REDIS */			
			$this->RedisDataMkKrs($nomhs,$psmhs_id,$thn_akd,$session_id,$krs_ol,$thn_kur,$angkatan);
			
			$key_redis2 = "krs_data_".$nomhs."_".$krs_ol;
			$data_json = $predis->get($key_redis2);
	    	$data_krs = json_decode($data_json,TRUE);

			$this->view->krs_mhs = $data_krs['krs_mhs']; // krs yang di pilih mhs
			$this->view->pilih_jadwal = $data_krs['pilih_jadwal']; // jadwal krs jam_awal - jam_akhir
			$this->view->jad_mk = $data_krs['jad_mk']; // jadwal krs jam_awal - jam_akhir

	    	/* CEK LIST MK YANG DIAJUKAN */
	    	$key_redis4 = "krs_data_count_".$nomhs."_".$krs_ol;
	    	$data_json = $predis->get($key_redis4);
	    	$data_krs_count = json_decode($data_json,TRUE);

			$cmd = "SELECT jadkul_id,thn_akd,session_id,nama_kelas,ps_id,kode_mk,nama,thn_kur,semester,sks from ViewListMkKrs d
			        where thn_akd = '$thn_akd' 
			          and session_id = '$session_id'
			          and nama_kelas is not null
			          and ps_id = '$ps_id'
			          and ps_allow = '$psmhs_id' group by kode_mk";
			$list_mk_krs_diajukan = $this->modelsManager->executeQuery($cmd)->toArray();
			$list_mk_count = count($list_mk_krs_diajukan);
			
			if ($data_krs_count['count'] != $list_mk_count) {
				$map_nilai_mk = $data['map_nilai_mk'];
				$vcx = $data['vcx'];
				$this->RedisKrsMk($nomhs,$psmhs_id,$thn_akd,$session_id,$krs_ol,$map_nilai_mk,$vcx,$thn_kur,$angkatan);
				
				$data_krs_count['count'] = $list_mk_count;
				$predis->set($key_redis4, json_encode($data_krs_count));
			}
			
			$key_redis3 = "krs_data_ajukan_".$nomhs."_".$krs_ol;
	    	$data_json = $predis->get($key_redis3);
	    	$data_krs_ajukan = json_decode($data_json,TRUE);

			$this->view->list_mk_krs_diajukan = $data_krs_ajukan['list_mk_krs_diajukan']; // list_mk_krs_diajukan
			$this->view->list_prasyarat_tidak_lolos = $data_krs_ajukan['list_prasyarat_tidak_lolos']; // list_prasyarat_tidak_lolos

			// echo "<pre>".print_r($key_redis3,1)."</pre>";die();


			/* MASUK DATA MHS */
	    	$this->view->krsx_ke = $data['krsx_ke']; // nilai tertinggi krs per MK
			$this->view->krs_nilai_tinggi = $data['krs_nilai_tinggi']; // nilai tertinggi krs per MK

			$halaman = 'akd_krs/list_mk_ditawarkan';
    	}

		$this->view->pick($halaman);

    }
}