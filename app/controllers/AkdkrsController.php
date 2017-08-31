<?php
use Phalcon\Mvc\View;
use Phalcon\Validation;
use Phalcon\Forms\Element\Text;
use Phalcon\Validation\Validator\Date;
use Phalcon\Validation\Validator\PresenceOf;
use Phalcon\Validation\Validator\Numericality;

use Phalcon\Cache\Backend\Redis;
use Phalcon\Cache\Frontend\Data as FrontData;

class AkdkrsController extends FungsiController
{

    public function initialize()
    {
      if (empty($this->session->get('uid'))) {
          $this->response->redirect('account/loginEnd');
      }
      $this->view->setRenderLevel(View::LEVEL_ACTION_VIEW);
      date_default_timezone_set('Asia/Jakarta');
    }

    public function listMkAction($value='')
    {
    	$jenis_user = $this->session->get('id_jenis');
		if ($jenis_user == '1') {
			$this->select_form();
    	}else{
			$this->ListMkDitawarkanAction();
    	}
    }

    public function select_form($value='')
    {
    	$get_session = $this->session->get('ps_id');
		$explode = explode('-', $get_session);
		$ps_id = $explode[1];
    	$user_ps = $this->session->get('id_ps');

		$sql = "SELECT a.thn_akd,
               a.session_id,
               a.nama,
               c.nama_ol,
               b.ol_id
          from RefAkdSession a
          left join RefAkdCrossKrs b 
          	on a.ps_id=b.ps_id and a.thn_akd=b.thn_akd and a.session_id=b.session_id
          left join RefAkdSessionOl c 
          	on a.ps_id=c.ps_id and a.thn_akd=c.thn_akd and a.session_id=c.session_id
         where b.ps_id = '$ps_id'
         and b.ps_allow = '$user_ps'
         order by b.thn_akd desc, b.session_id desc
         limit 10";
		$query = $this->modelsManager->executeQuery($sql);
		$this->view->krs_ol = $query;
		$this->view->pick('akd_krs/select_form');
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

    public function delKrsAction($value='')
    {
    	$kelas =$_POST['kelas'];
		$thn_kur =$_POST['thn_kur'];
		$ps_id =$_POST['ps_id'];
		$psmhs_id =$_POST['psmhs_id'];
		$thn_akd =$_POST['thn_akd'];
		$session_id =$_POST['session_id'];
		$nomhs =$_POST['nomhs'];
		$kode_mk =$_POST['kode_mk'];

		$del = "DELETE from RefAkdKrs 
				where nomhs = '$nomhs'
					and ps_id = '$ps_id'
					and psmhs_id = '$psmhs_id'
					and thn_akd = '$thn_akd'
					and session_id = '$session_id'
					and kode_mk = '$kode_mk'
					and thn_kur = '$thn_kur'
					and nama_kelas = '$kelas' ";
		$this->modelsManager->executeQuery($del);

		$del_krsol = "DELETE from RefAkdKrsol
				where nomhs = '$nomhs'
					and ps_id = '$ps_id'
					and psmhs_id = '$psmhs_id'
					and thn_akd = '$thn_akd'
					and session_id = '$session_id'
					and kode_mk = '$kode_mk'
					and thn_kur = '$thn_kur'
					and nama_kelas = '$kelas' ";
		$this->modelsManager->executeQuery($del_krsol);

		$del_p_mhs = "DELETE from RefAkdPresensiMhs
				where nomhs = '$nomhs'
					and ps_id = '$ps_id'
					and psmhs_id = '$psmhs_id'
					and thn_akd = '$thn_akd'
					and session_id = '$session_id'
					and kode_mk = '$kode_mk'
					and thn_kur = '$thn_kur'
					and nama_kelas = '$kelas' ";
		$this->modelsManager->executeQuery($del_p_mhs);
		$notif = array(
            'title' => 'success',
            'text' => 'MK berhasil batal di pilih..!',
            'type' => 'success'
        );
		echo json_encode($notif);
    }

    public function addKrsAction($value='')
    {
		$kelas =$_POST['kelas'];
		$thn_kur =$_POST['thn_kur'];
		$ps_id =$_POST['ps_id'];
		$psmhs_id =$_POST['psmhs_id'];
		$thn_akd =$_POST['thn_akd'];
		$session_id =$_POST['session_id'];
		$nomhs =$_POST['nomhs'];
		$hari =$_POST['hari'];
		$kode_mk =$_POST['kode_mk'];
		$krs_ol =$_POST['krs_ol'];

		$jam_awal =$_POST['jam_awal'];
		$jam_akhir =$_POST['jam_akhir'];

		// echo "<pre>".print_r($_POST,1)."</pre>";

		/* Cek TABRAKAN ATO TIDAK CUY */
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
		           and a.session_id = '$session_id'
		           and b.hari = '$hari'
		           and not (b.jam_awal >= '$jam_akhir' or b.jam_akhir <= '$jam_awal') ";
		$cek_jam = $this->modelsManager->executeQuery($cmd)->toArray();

		$cmd = "SELECT * from RefAkdKrsol
				 where nomhs = '$nomhs'
		           and ps_id = '$ps_id'
		           and psmhs_id = '$psmhs_id'
		           and thn_akd = '$thn_akd'
		           and session_id = '$session_id'
		           and thn_kur = '$thn_kur'
		           and kode_mk = '$kode_mk' ";
	    $cek_krs = $this->modelsManager->executeQuery($cmd);

	    $q = "SELECT * from RefAkdKrs
				 where nomhs = '$nomhs'
		           and ps_id = '$ps_id'
		           and psmhs_id = '$psmhs_id'
		           and thn_kur = '$thn_kur'
		           and kode_mk = '$kode_mk' ";
	    $cek_krs_ke = $this->modelsManager->executeQuery($q);
	    $krs_ke = count($cek_krs_ke)+1;

	    if (count($cek_krs) == 0) {
	    	if (count($cek_jam) == 0) {
				$simpan = new RefAkdKrs();
				$simpan->assign(array(
					'nomhs'		=> $_POST['nomhs'],
					'psmhs_id'	=> $_POST['psmhs_id'],
					'ps_id'		=> $_POST['ps_id'],
					'thn_akd'   => $_POST['thn_akd'],
					'session_id'=> $_POST['session_id'],
					'kode_mk'	=> $_POST['kode_mk'],
					'thn_kur'	=> $_POST['thn_kur'],
					'nama_kelas'		=> $_POST['kelas'],
					'krs_ke'		=> $krs_ke,
				));
				$simpan->save();

				$simpan_krsol = new RefAkdKrsol();
				$simpan_krsol->assign(array(
					'nomhs'		=> $_POST['nomhs'],
					'psmhs_id'	=> $_POST['psmhs_id'],
					'ps_id'		=> $_POST['ps_id'],
					'thn_akd'   => $_POST['thn_akd'],
					'session_id'=> $_POST['session_id'],
					'kode_mk'	=> $_POST['kode_mk'],
					'thn_kur'	=> $_POST['thn_kur'],
					'nama_kelas'		=> $_POST['kelas'],
					'sks'		=> $_POST['sks'],
				));
				$simpan_krsol->save();

				$simpan_p_mhs = new RefAkdPresensiMhs();
				$simpan_p_mhs->assign(array(
					'nomhs'		=> $_POST['nomhs'],
					'psmhs_id'	=> $_POST['psmhs_id'],
					'ps_id'		=> $_POST['ps_id'],
					'thn_akd'   => $_POST['thn_akd'],
					'session_id'=> $_POST['session_id'],
					'kode_mk'	=> $_POST['kode_mk'],
					'thn_kur'	=> $_POST['thn_kur'],
					'nama_kelas'		=> $_POST['kelas'],
				));
				$simpan_p_mhs->save();
				$notif = array(
	                'title' => 'success',
	                'text' => 'Data berhasil di Input',
	                'type' => 'success'
	            );
			}else{
				$nama_ps = $cek_jam[0]['nama'];
				$mk = $cek_jam[0]['kode_mk'];
				$kls = $cek_jam[0]['nama_kelas'];
				$notif = array(
	                'title' => 'warning',
	                'text' => "Jam Tabrakan Dengan :<br> $mk $nama_ps <br> Kelas : $kls",
	                'type' => 'warning'
	            );
			}

	    }else{
	    	$update = "UPDATE RefAkdKrs SET nama_kelas = '$kelas' 
			 where nomhs = '$nomhs'
	           and ps_id = '$ps_id'
	           and psmhs_id = '$psmhs_id'
	           and thn_akd = '$thn_akd'
	           and session_id = '$session_id'
	           and thn_kur = '$thn_kur'
	           and kode_mk = '$kode_mk' ";
        	$this->modelsManager->executeQuery($update);

        	$update = "UPDATE RefAkdKrsol SET nama_kelas = '$kelas' 
			 where nomhs = '$nomhs'
	           and ps_id = '$ps_id'
	           and psmhs_id = '$psmhs_id'
	           and thn_akd = '$thn_akd'
	           and session_id = '$session_id'
	           and thn_kur = '$thn_kur'
	           and kode_mk = '$kode_mk' ";
        	$this->modelsManager->executeQuery($update);

        	$update = "UPDATE RefAkdPresensiMhs SET nama_kelas = '$kelas' 
			 where nomhs = '$nomhs'
	           and ps_id = '$ps_id'
	           and psmhs_id = '$psmhs_id'
	           and thn_akd = '$thn_akd'
	           and session_id = '$session_id'
	           and thn_kur = '$thn_kur'
	           and kode_mk = '$kode_mk' ";
        	$this->modelsManager->executeQuery($update);

        	$notif = array(
                'title' => 'success',
                'text' => "Krs Berhasil di UPDATE..!",
                'type' => 'success'
            );
	    }
	    echo json_encode($notif);
    }

    public function ListMkDitawarkanAction($nomhs,$krs_ol)
    {
    	/* connec to redis */
    	$redis = new PredisController;
		$predis = $redis->config();

    	$fungsi = new FungsiController;
    	$helper = new Helpers();

    	$get_session = $this->session->get('ps_id');
		$explode = explode('-', $get_session);
		$ps_id = $explode[1];
		$psmhs_id = $explode[1];

		// $ps_id = 1;
		// $psmhs_id = 1;

		$krs_ol2 = explode('-', $krs_ol);
		$thn_akd = $krs_ol2[0];
		$session_id = $krs_ol2[1];
		$ol_id = $krs_ol2[2];

		/* send to view */
		// $this->view->nomhs = $nomhs;
		// $this->view->krs_ol = $_GET['krs_ol'];
		// $this->view->ps_id = $ps_id;
		// $this->view->psmhs_id = $psmhs_id;
		// $this->view->thn_akd = $thn_akd;
		// $this->view->session_id = $session_id;
		// $this->view->ol_id = $ol_id;

		$data['nomhs'] = $nomhs;
		$data['krs_ol'] = $krs_ol;
		$data['ps_id'] = $ps_id;
		$data['psmhs_id'] = $psmhs_id;
		$data['thn_akd'] = $thn_akd;
		$data['session_id'] = $session_id;
		$data['ol_id'] = $ol_id;


		$thn_sesi = $fungsi->nama_sesi($thn_akd,$session_id);

		$session = $this->db_array("SELECT * from RefAkdSession where ps_id = '$ps_id' and thn_akd = '$thn_akd' and session_id = '$session_id'");

		$daftar_cekal = $fungsi->daftar_cekal($ps_id,$thn_akd,$session_id);

		$thn_evaldosen = $session[0]['evaldosen_thn_akd'];
		$session_evaldosen = $session[0]['evaldosen_session_id'];
		$mhs_evaldosen = $this->db_array("SELECT a.kode_mk,a.nama_kelas,b.nip_dosen, c.nip as eval_dosen from RefAkdKrs a join RefAkdJadkulmg b on a.thn_akd=b.thn_akd and a.session_id=b.session_id and a.kode_mk=b.kode_mk and a.nama_kelas=b.nama_kelas left join RefAkdDevalTrans c on a.thn_akd=c.thn_akd and a.session_id=c.session_id and a.kode_mk=c.kode_mk and a.nama_kelas=c.nama_kelas and a.nomhs=c.nomhs
			where a.nomhs = '$nomhs' 
			and a.ps_id = '$ps_id' 
			and a.psmhs_id = '$psmhs_id' 
			and a.thn_akd = '$thn_evaldosen' 
			and a.session_id = '$session_evaldosen' ");
		foreach ($mhs_evaldosen as $key => $value) {
			if (!empty($value['eval_dosen'])) {
				$dt_eval_mhs[$value['kode_mk']] = $value['eval_dosen'];
			}else{
				$dt_eval_mhs[$value['kode_mk']] = "belum";
			}
		}

		/* DATA MAHASISWA */
		$sql2 = "SELECT id_mhs,angkatan,id_agama,nama,id_kur,ps_kur,id_status from RefAkdMhs where id_mhs = '$nomhs' and id_ps='$ps_id'";
		$dt_mhs = $this->modelsManager->executeQuery($sql2)->toArray();

		if (count($dt_mhs) == 0) {  /* CEK NOMHS ADA ATO TIDAK */
			$this->view->angka = "404";
			$this->view->pesan1 = "Oops! Data not found.";
			$this->view->pesan2 = "Nomhs Tidak Ditemukan, silahkan masukkan nomhs dengan benar!";
			$halaman = 'error/error';

			$data['halaman'] = $halaman;
			$data['angka'] = "404";
			$data['pesan1'] = "Oops! Data not found.";
			$data['pesan2'] = "Nomhs Tidak Ditemukan, silahkan masukkan nomhs dengan benar!";

		}elseif($dt_mhs[0]['id_status'] != "A"){  /* CEK MHS JIKA STATUS TIDAK AKTIF TIDAK BISA KRS,AN */
			$this->view->angka = "404";
			$this->view->pesan1 = "Oops! KRS Di Nonaktifkan!.";
			$this->view->pesan2 = "Mahasiswa ".$dt_mhs[0]['nama']." berstatus tidak aktif, Informasi lebih lanjut Hubungi Admin!";
			$halaman = 'error/error';

			$data['halaman'] = $halaman;
			$data['angka'] = "404";
			$data['pesan1'] = "Oops! KRS Di Nonaktifkan!.";
			$data['pesan2'] = "Mahasiswa ".$dt_mhs[0]['nama']." berstatus tidak aktif, Informasi lebih lanjut Hubungi Admin!";


		}elseif($session[0]['blockkrs'] == "Y"){  /* CEK KRS SESI YG DI PILIH DI BLOKIR ATO TIDAK */
			$this->view->angka = "404";
			$this->view->pesan1 = "Oops! KRS Di Nonaktifkan!.";
			$this->view->pesan2 = "KRS $thn_sesi sementara di nonaktifkan, Informasi lebih lanjut Hubungi Admin!";
			$halaman = 'error/error';

			$data['halaman'] = $halaman;
			$data['angka'] = "404";
			$data['pesan1'] = "Oops! KRS Di Nonaktifkan!.";
			$data['pesan2'] = "KRS $thn_sesi sementara di nonaktifkan, Informasi lebih lanjut Hubungi Admin!";

		}elseif(in_array($nomhs, $daftar_cekal)){  /* CEK MHS DI CEKAL ATO TIDAK */
			$this->view->angka = "404";
			$this->view->pesan1 = "Oops! KRS DI CEKAL!.";
			$this->view->pesan2 = "Nomhs $nomhs Dicekal untuk melakukan krs'an, Informasi lebih lanjut Hubungi Admin!";
			$halaman = 'error/error';

			$data['halaman'] = $halaman;
			$data['angka'] = "404";
			$data['pesan1'] = "Oops! KRS DI CEKAL!.";
			$data['pesan2'] = "Nomhs $nomhs Dicekal untuk melakukan krs'an, Informasi lebih lanjut Hubungi Admin!";
		}
		// elseif(in_array('belum', $dt_eval_mhs)){  /* CEK MHS SUDAH MENGISI EVAL DOSEN ATO BLM */
		// 	$this->view->angka = "404";
		// 	$this->view->pesan1 = "Oops! TIDAK BISA MELAKUKAN KRS!.";
		// 	$this->view->pesan2 = "Alasan : Evaluasi Dosen Belum Terisi semua. , Informasi lebih lanjut Hubungi Admin!";
		// 	$halaman = 'error/error';
		// }
		else{

			if ($session[0]['ips_check'] == 'Y') {
				$pthn_akd = $session[0]['pthn_akd'];
				$psession_id = $session[0]['psession_id'];
			}
			
			$rekap_smstr = $this->db_array("SELECT * from RefAkdRekapsemester where nomhs = '$nomhs' and ps_id = '$ps_id' and psmhs_id = '$psmhs_id' and thn_akd = '$pthn_akd' and session_id = '$psession_id'");

			$ipk = 0.00;
			$ips = 0.00;
			$sks_kum = 0;
			$sks_sem = 0;
			if (count($rekap_smstr) > 0) {
				$ipk = $rekap_smstr[0]['ipk'];
				$ips = $rekap_smstr[0]['ips'];
				$sks_kum = $rekap_smstr[0]['skskum'];
				$sks_sem = $rekap_smstr[0]['skssem'];
			}

			if ($session[0]['ips_check'] == 'Y' and $session[0]['ipk_check'] == 'Y') {
				if ($ipk > $ips) {
					$sys_pilihan_sks = $ipk;
					$nm_pilihan_sks = 'IPK';
				}else{
					$sys_pilihan_sks = $ips;
					$nm_pilihan_sks = 'IPS';
				}
			}elseif ($session[0]['ips_check'] == 'Y' ) {
				$sys_pilihan_sks = $ips;
				$nm_pilihan_sks = 'IPS';
			}elseif ($session[0]['ipk_check'] == 'Y') {
				$sys_pilihan_sks = $ipk;
				$nm_pilihan_sks = 'IPK';
			}

			$sks = $this->db_array("SELECT jatahsks from RefAkdDefRangeIp where ps_id = '$ps_id' and thn_akd = '$thn_akd' and session_id = '$session_id' and vstart <= $sys_pilihan_sks and vstop >= $sys_pilihan_sks ");

			//**************** SELECTING SKS jatah mahasiswa tergantung nilai = filter ke rangeIP *********************
			// $this->view->jatah_sks = $sks[0]['jatahsks'];
			// $this->view->session_thn_sks = $fungsi->nama_sesi($thn_akd, $session_id);
			// $this->view->nama_ps = $fungsi->nama_ps($ps_id);
			// $this->view->dt_mhs = $dt_mhs[0];
			// $this->view->sys_pilihan_sks = $sys_pilihan_sks;
			// $this->view->nm_pilihan_sks = $nm_pilihan_sks;

			$data['jatah_sks'] = $sks[0]['jatahsks'];
			$data['session_thn_sks'] = $fungsi->nama_sesi($thn_akd, $session_id);
			$data['nama_ps'] = $fungsi->nama_ps($ps_id);
			$data['dt_mhs'] = $dt_mhs[0];
			$data['sys_pilihan_sks'] = $sys_pilihan_sks;
			$data['nm_pilihan_sks'] = $nm_pilihan_sks;

			// echo "<pre>".print_r($dt_mhs[0],1)."</pre>";die();
			$thn_kur = $dt_mhs[0]['id_kur'];
			$angkatan = $dt_mhs[0]['angkatan'];


			//************ SELECT SEKALIGUS SEMUA YANG DIPERLUKAN *******************
			
			$cmd = "SELECT a.id,a.thn_akd,
						a.session_id,
						a.nama_kelas,
						a.ps_id,
						a.kode_mk,
						a.thn_kur,
						a.nilai,
						b.nilai_angka
					from RefAkdKrs a join RefSysNilai b on a.nilai=b.nilai where nomhs = '$nomhs' order by b.nilai_angka desc";
			$krs_data = $this->modelsManager->executeQuery($cmd)->toArray();

			/* $krsx KRS per matakuliah */			
			foreach ($krs_data as $k => $v) {
				$mk_id = $v['ps_id'].'#'.$v['thn_kur'].'#'.$v['kode_mk'];
				$array = array(
					'id' =>  $v['id'],
					'kode_mk' =>  $v['kode_mk'],
					'nilai' =>  $v['nilai'],
					'nilai_angka' =>  $v['nilai_angka']
				);

				$krsx[$mk_id][] = $array;

				if (array_key_exists($mk_id,$krsx)) {
					$r = $krsx[$mk_id];
					array_filter($r);
					array_push($r, $array);
				}
			}
			// echo "<pre>".print_r($krsx,1)."</pre>";

			/* GET nilai tertinggi KRS per Matakuliah */
			$krs_nilai_tinggi = $krsx;
			foreach ($krs_nilai_tinggi as $mk_krs => $wer) {
				$mm = count($wer)-1;
				for ($i=1; $i <= $mm; $i++) { 
					unset($krs_nilai_tinggi[$mk_krs][$i]);
				}
			}

			$mapmku = $this->db_array("SELECT * from RefAkdMapmku");
			foreach ($mapmku as $k => $v) {
				$bbb = $v['ps_idA'].'#'.$v['ps_idB'].'#'.$v['kurA'].'#'.$v['kurB'];
				$array = array(
					'mkA0' =>  $v['mkA0'],
					'mkA1' =>  $v['mkA1'],
					'mkA2' =>  $v['mkA2'],
					'mkB0' =>  $v['mkB0'],
					'mkB1' =>  $v['mkB1'],
					'mkB2' =>  $v['mkB2'],
				);

				$vcx[$bbb][] = $array;

				if (array_key_exists($bbb,$vcx)) {
					$m = $vcx[$bbb];
					array_filter($m);
					array_push($m, $array);
				}
			}
			// echo "<pre>".print_r($vcx,1)."</pre>";
			


			/* $krs_nilai_tinggi */
			// echo "<pre>".print_r($krs_nilai_tinggi,1)."</pre>";die();

			/* GET nilai tertinggi KRS per Matakuliah */
			/* MAPPING NILAI KRS MAHASISWA */
			foreach ($krs_nilai_tinggi as $key => $value) {
				$thn_kur_mk = explode('#', $key);
				if ($thn_kur_mk[0].'#'.$thn_kur_mk[1] != $ps_id.'#'.$thn_kur) {					
					$kodemk = $thn_kur_mk[2];
					$kur_nilainya = $thn_kur_mk[1];
					$ps_nilainya = $thn_kur_mk[0];
					//$zxc = $this->db_array("SELECT mkB0,mkB1,mkB2 from RefAkdMapmku where ps_idB = '$ps_id' and kurB = '$thn_kur' and ps_idA = '$ps_nilainya' and kurA = '$kur_nilainya' and (mkA0='$kodemk' OR mkA1='$kodemk' OR mkA2='$kodemk') ");

					$kk = $ps_nilainya.'#'.$ps_id.'#'.$kur_nilainya.'#'.$thn_kur;
					// echo "<pre>".print_r($vcx[$kk],1)."</pre>";
					foreach ($vcx[$kk] as $a => $b) {
						if ($b['mkA0'] == $kodemk || $b['mkA1'] == $kodemk || $b['mkA2'] == $kodemk ) {
							$n_mk[] = $b['mkB0'];
							$n_mk[] = $b['mkB1'];
							$n_mk[] = $b['mkB2'];
						}
					}
					// $n_mk[] = $zxc[0]['mkB0'];
					// $n_mk[] = $zxc[0]['mkB1'];
					// $n_mk[] = $zxc[0]['mkB2'];
					$edr = array_filter($n_mk);
					$count_mkmap = count($edr);

					$value[0]['kode_mk'] = $edr[0];
					$map = $value;
					$key_mk = $edr[0];

					$val2 = $value;
					$val3 = $value;
					if ($count_mkmap == 2) {
						$val2[0]['kode_mk'] = $edr[1];
						$map2 = $val2;
						$key_mk2 = $edr[1];
					}elseif($count_mkmap == 3){
						$val2 = $value;
						$val3 = $value;
						$val2[0]['kode_mk'] = $edr[1];
						$val3[0]['kode_mk'] = $edr[2];

						$map2 = $val2;
						$map3 = $val3;

						$key_mk2 = $edr[1];
						$key_mk3 = $edr[2];				
					}
				}else{
					$map = $value;
					$map2 = $value;
					$map3 = $value;
					$key_mk = $thn_kur_mk[2];
					$key_mk2 = $thn_kur_mk[2];
					$key_mk3 = $thn_kur_mk[2];
				}
				$conv_nilai[$key_mk] = $map;
				$conv_nilai[$key_mk2] = $map2;
				$conv_nilai[$key_mk3] = $map3;
			}

			foreach ($conv_nilai as $mk => $v) {
				foreach ($v as $key => $value) {
					$map_nilai_mk[$mk] = $value;
				}
			}
			$data['map_nilai_mk'] = $map_nilai_mk;
			/* $map_nilai_mk */
			// echo "<pre>".print_r($map_nilai_mk,1)."</pre>";
			// echo "<pre>".print_r($map_nilai_mk,1)."</pre>";die();



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
			// echo "<pre>".print_r($krs_jadwal,1)."</pre>";die();


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
			// echo "<pre>".print_r($cmd,1)."</pre>";die();


			// $this->view->krsx_ke = $krsx; // nilai tertinggi krs per MK
			// $this->view->krs_nilai_tinggi = $krs_nilai_tinggi; // nilai tertinggi krs per MK
			// $this->view->krs_mhs = $pilih; // krs yang di pilih mhs
			// $this->view->pilih_jadwal = $pilih_jadwal; // jadwal krs jam_awal - jam_akhir
			// $this->view->jad_mk = $krs_jadwal; // jadwal krs jam_awal - jam_akhir
			// $this->view->list_mk_krs_diajukan = $krs_yang_diajukan; // list_mk_krs_diajukan
			// $this->view->list_prasyarat_tidak_lolos = $text_pras; // list_prasyarat_tidak_lolos
			$halaman = 'akd_krs/list_mk_ditawarkan';

			$data['halaman'] = $halaman;
			$data['krsx_ke'] = $krsx;
			$data['krs_nilai_tinggi'] = $krs_nilai_tinggi;
			$data['krs_mhs'] = $pilih;
			$data['pilih_jadwal'] = $pilih_jadwal;
			$data['jad_mk'] = $krs_jadwal;
			$data['list_mk_krs_diajukan'] = $krs_yang_diajukan;
			$data['list_prasyarat_tidak_lolos'] = $text_pras;

			
		}

		/* MASUKKAN DATA KE REDIS */
		$key_redis = "krs_".$nomhs."_".$krs_ol;
		// if (empty($predis->get($key_redis))) {

			$predis->set($key_redis, json_encode($data));
			$predis->expire($key_redis, 10);
		// }
		
		// $this->view->pick($halaman);
    }

    public function DataKrsAction($aksi="")
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

			/* CEK RELOAD ATO TIDAK : JIKA RELOAD MAKA REPLACE DATA REDIS */
			
				$this->RedisDataMkKrs($nomhs,$psmhs_id,$thn_akd,$session_id,$krs_ol);
			
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
				$this->RedisKrsMk($nomhs,$psmhs_id,$thn_akd,$session_id,$krs_ol,$map_nilai_mk,$vcx);
				
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



public function ListMkDitawarkan2Action()
    {
    	/* connec to redis */
    	$redis = new PredisController;
		$predis = $redis->config();

    	$fungsi = new FungsiController;
    	$helper = new Helpers();

    	$get_session = $this->session->get('ps_id');
		$explode = explode('-', $get_session);
		$ps_id = $explode[1];
		$psmhs_id = $explode[1];

		// $ps_id = 1;
		// $psmhs_id = 1;

		$nomhs = $_GET['nomhs'];
		$krs_ol = $_GET['krs_ol'];
		$krs_ol2 = explode('-', $krs_ol);
		$thn_akd = $krs_ol2[0];
		$session_id = $krs_ol2[1];
		$ol_id = $krs_ol2[2];

		/* send to view */
		$this->view->nomhs = $nomhs;
		$this->view->krs_ol = $_GET['krs_ol'];
		$this->view->ps_id = $ps_id;
		$this->view->psmhs_id = $psmhs_id;
		$this->view->thn_akd = $thn_akd;
		$this->view->session_id = $session_id;
		$this->view->ol_id = $ol_id;

		$data['nomhs'] = $nomhs;
		$data['krs_ol'] = $krs_ol;
		$data['ps_id'] = $ps_id;
		$data['psmhs_id'] = $psmhs_id;
		$data['thn_akd'] = $thn_akd;
		$data['session_id'] = $session_id;
		$data['ol_id'] = $ol_id;


		$thn_sesi = $fungsi->nama_sesi($thn_akd,$session_id);

		$session = $this->db_array("SELECT * from RefAkdSession where ps_id = '$ps_id' and thn_akd = '$thn_akd' and session_id = '$session_id'");

		$daftar_cekal = $fungsi->daftar_cekal($ps_id,$thn_akd,$session_id);

		$thn_evaldosen = $session[0]['evaldosen_thn_akd'];
		$session_evaldosen = $session[0]['evaldosen_session_id'];
		$mhs_evaldosen = $this->db_array("SELECT a.kode_mk,a.nama_kelas,b.nip_dosen, c.nip as eval_dosen from RefAkdKrs a join RefAkdJadkulmg b on a.thn_akd=b.thn_akd and a.session_id=b.session_id and a.kode_mk=b.kode_mk and a.nama_kelas=b.nama_kelas left join RefAkdDevalTrans c on a.thn_akd=c.thn_akd and a.session_id=c.session_id and a.kode_mk=c.kode_mk and a.nama_kelas=c.nama_kelas and a.nomhs=c.nomhs
			where a.nomhs = '$nomhs' 
			and a.ps_id = '$ps_id' 
			and a.psmhs_id = '$psmhs_id' 
			and a.thn_akd = '$thn_evaldosen' 
			and a.session_id = '$session_evaldosen' ");
		foreach ($mhs_evaldosen as $key => $value) {
			if (!empty($value['eval_dosen'])) {
				$dt_eval_mhs[$value['kode_mk']] = $value['eval_dosen'];
			}else{
				$dt_eval_mhs[$value['kode_mk']] = "belum";
			}
		}

		/* DATA MAHASISWA */
		$sql2 = "SELECT id_mhs,angkatan,id_agama,nama,id_kur,ps_kur,id_status from RefAkdMhs where id_mhs = '$nomhs' and id_ps='$ps_id'";
		$dt_mhs = $this->modelsManager->executeQuery($sql2)->toArray();

		if (count($dt_mhs) == 0) {  /* CEK NOMHS ADA ATO TIDAK */
			$this->view->angka = "404";
			$this->view->pesan1 = "Oops! Data not found.";
			$this->view->pesan2 = "Nomhs Tidak Ditemukan, silahkan masukkan nomhs dengan benar!";
			$halaman = 'error/error';

			$data['halaman'] = $halaman;
			$data['angka'] = "404";
			$data['pesan1'] = "Oops! Data not found.";
			$data['pesan2'] = "Nomhs Tidak Ditemukan, silahkan masukkan nomhs dengan benar!";

		}elseif($dt_mhs[0]['id_status'] != "A"){  /* CEK MHS JIKA STATUS TIDAK AKTIF TIDAK BISA KRS,AN */
			$this->view->angka = "404";
			$this->view->pesan1 = "Oops! KRS Di Nonaktifkan!.";
			$this->view->pesan2 = "Mahasiswa ".$dt_mhs[0]['nama']." berstatus tidak aktif, Informasi lebih lanjut Hubungi Admin!";
			$halaman = 'error/error';

			$data['halaman'] = $halaman;
			$data['angka'] = "404";
			$data['pesan1'] = "Oops! KRS Di Nonaktifkan!.";
			$data['pesan2'] = "Mahasiswa ".$dt_mhs[0]['nama']." berstatus tidak aktif, Informasi lebih lanjut Hubungi Admin!";


		}elseif($session[0]['blockkrs'] == "Y"){  /* CEK KRS SESI YG DI PILIH DI BLOKIR ATO TIDAK */
			$this->view->angka = "404";
			$this->view->pesan1 = "Oops! KRS Di Nonaktifkan!.";
			$this->view->pesan2 = "KRS $thn_sesi sementara di nonaktifkan, Informasi lebih lanjut Hubungi Admin!";
			$halaman = 'error/error';

			$data['halaman'] = $halaman;
			$data['angka'] = "404";
			$data['pesan1'] = "Oops! KRS Di Nonaktifkan!.";
			$data['pesan2'] = "KRS $thn_sesi sementara di nonaktifkan, Informasi lebih lanjut Hubungi Admin!";

		}elseif(in_array($nomhs, $daftar_cekal)){  /* CEK MHS DI CEKAL ATO TIDAK */
			$this->view->angka = "404";
			$this->view->pesan1 = "Oops! KRS DI CEKAL!.";
			$this->view->pesan2 = "Nomhs $nomhs Dicekal untuk melakukan krs'an, Informasi lebih lanjut Hubungi Admin!";
			$halaman = 'error/error';

			$data['halaman'] = $halaman;
			$data['angka'] = "404";
			$data['pesan1'] = "Oops! KRS DI CEKAL!.";
			$data['pesan2'] = "Nomhs $nomhs Dicekal untuk melakukan krs'an, Informasi lebih lanjut Hubungi Admin!";
		}
		// elseif(in_array('belum', $dt_eval_mhs)){  /* CEK MHS SUDAH MENGISI EVAL DOSEN ATO BLM */
		// 	$this->view->angka = "404";
		// 	$this->view->pesan1 = "Oops! TIDAK BISA MELAKUKAN KRS!.";
		// 	$this->view->pesan2 = "Alasan : Evaluasi Dosen Belum Terisi semua. , Informasi lebih lanjut Hubungi Admin!";
		// 	$halaman = 'error/error';
		// }
		else{

			if ($session[0]['ips_check'] == 'Y') {
				$pthn_akd = $session[0]['pthn_akd'];
				$psession_id = $session[0]['psession_id'];
			}
			
			$rekap_smstr = $this->db_array("SELECT * from RefAkdRekapsemester where nomhs = '$nomhs' and ps_id = '$ps_id' and psmhs_id = '$psmhs_id' and thn_akd = '$pthn_akd' and session_id = '$psession_id'");

			$ipk = 0.00;
			$ips = 0.00;
			$sks_kum = 0;
			$sks_sem = 0;
			if (count($rekap_smstr) > 0) {
				$ipk = $rekap_smstr[0]['ipk'];
				$ips = $rekap_smstr[0]['ips'];
				$sks_kum = $rekap_smstr[0]['skskum'];
				$sks_sem = $rekap_smstr[0]['skssem'];
			}

			if ($session[0]['ips_check'] == 'Y' and $session[0]['ipk_check'] == 'Y') {
				if ($ipk > $ips) {
					$sys_pilihan_sks = $ipk;
					$nm_pilihan_sks = 'IPK';
				}else{
					$sys_pilihan_sks = $ips;
					$nm_pilihan_sks = 'IPS';
				}
			}elseif ($session[0]['ips_check'] == 'Y' ) {
				$sys_pilihan_sks = $ips;
				$nm_pilihan_sks = 'IPS';
			}elseif ($session[0]['ipk_check'] == 'Y') {
				$sys_pilihan_sks = $ipk;
				$nm_pilihan_sks = 'IPK';
			}

			$sks = $this->db_array("SELECT jatahsks from RefAkdDefRangeIp where ps_id = '$ps_id' and thn_akd = '$thn_akd' and session_id = '$session_id' and vstart <= $sys_pilihan_sks and vstop >= $sys_pilihan_sks ");

			//**************** SELECTING SKS jatah mahasiswa tergantung nilai = filter ke rangeIP *********************
			$this->view->jatah_sks = $sks[0]['jatahsks'];
			$this->view->session_thn_sks = $fungsi->nama_sesi($thn_akd, $session_id);
			$this->view->nama_ps = $fungsi->nama_ps($ps_id);
			$this->view->dt_mhs = $dt_mhs[0];
			$this->view->sys_pilihan_sks = $sys_pilihan_sks;
			$this->view->nm_pilihan_sks = $nm_pilihan_sks;

			$data['jatah_sks'] = $sks[0]['jatahsks'];
			$data['session_thn_sks'] = $fungsi->nama_sesi($thn_akd, $session_id);
			$data['nama_ps'] = $fungsi->nama_ps($ps_id);
			$data['dt_mhs'] = $dt_mhs[0];
			$data['sys_pilihan_sks'] = $sys_pilihan_sks;
			$data['nm_pilihan_sks'] = $nm_pilihan_sks;

			// echo "<pre>".print_r($dt_mhs[0],1)."</pre>";die();
			$thn_kur = $dt_mhs[0]['id_kur'];
			$angkatan = $dt_mhs[0]['angkatan'];


			//************ SELECT SEKALIGUS SEMUA YANG DIPERLUKAN *******************
			
			$cmd = "SELECT a.id,a.thn_akd,
						a.session_id,
						a.nama_kelas,
						a.ps_id,
						a.kode_mk,
						a.thn_kur,
						a.nilai,
						b.nilai_angka
					from RefAkdKrs a join RefSysNilai b on a.nilai=b.nilai where nomhs = '$nomhs' order by b.nilai_angka desc";
			$krs_data = $this->modelsManager->executeQuery($cmd)->toArray();

			/* $krsx KRS per matakuliah */			
			foreach ($krs_data as $k => $v) {
				$mk_id = $v['ps_id'].'#'.$v['thn_kur'].'#'.$v['kode_mk'];
				$array = array(
					'id' =>  $v['id'],
					'kode_mk' =>  $v['kode_mk'],
					'nilai' =>  $v['nilai'],
					'nilai_angka' =>  $v['nilai_angka']
				);

				$krsx[$mk_id][] = $array;

				if (array_key_exists($mk_id,$krsx)) {
					$r = $krsx[$mk_id];
					array_filter($r);
					array_push($r, $array);
				}
			}
			// echo "<pre>".print_r($krsx,1)."</pre>";

			/* GET nilai tertinggi KRS per Matakuliah */
			$krs_nilai_tinggi = $krsx;
			foreach ($krs_nilai_tinggi as $mk_krs => $wer) {
				$mm = count($wer)-1;
				for ($i=1; $i <= $mm; $i++) { 
					unset($krs_nilai_tinggi[$mk_krs][$i]);
				}
			}

			$mapmku = $this->db_array("SELECT * from RefAkdMapmku");
			foreach ($mapmku as $k => $v) {
				$bbb = $v['ps_idA'].'#'.$v['ps_idB'].'#'.$v['kurA'].'#'.$v['kurB'];
				$array = array(
					'mkA0' =>  $v['mkA0'],
					'mkA1' =>  $v['mkA1'],
					'mkA2' =>  $v['mkA2'],
					'mkB0' =>  $v['mkB0'],
					'mkB1' =>  $v['mkB1'],
					'mkB2' =>  $v['mkB2'],
				);

				$vcx[$bbb][] = $array;

				if (array_key_exists($bbb,$vcx)) {
					$m = $vcx[$bbb];
					array_filter($m);
					array_push($m, $array);
				}
			}
			$data['vcx'] = $vcx;
			// echo "<pre>".print_r($vcx,1)."</pre>";
			


			/* $krs_nilai_tinggi */
			// echo "<pre>".print_r($krs_nilai_tinggi,1)."</pre>";die();

			/* GET nilai tertinggi KRS per Matakuliah */
			/* MAPPING NILAI KRS MAHASISWA */
			foreach ($krs_nilai_tinggi as $key => $value) {
				$thn_kur_mk = explode('#', $key);
				if ($thn_kur_mk[0].'#'.$thn_kur_mk[1] != $ps_id.'#'.$thn_kur) {					
					$kodemk = $thn_kur_mk[2];
					$kur_nilainya = $thn_kur_mk[1];
					$ps_nilainya = $thn_kur_mk[0];
					//$zxc = $this->db_array("SELECT mkB0,mkB1,mkB2 from RefAkdMapmku where ps_idB = '$ps_id' and kurB = '$thn_kur' and ps_idA = '$ps_nilainya' and kurA = '$kur_nilainya' and (mkA0='$kodemk' OR mkA1='$kodemk' OR mkA2='$kodemk') ");

					$kk = $ps_nilainya.'#'.$ps_id.'#'.$kur_nilainya.'#'.$thn_kur;
					// echo "<pre>".print_r($vcx[$kk],1)."</pre>";
					foreach ($vcx[$kk] as $a => $b) {
						if ($b['mkA0'] == $kodemk || $b['mkA1'] == $kodemk || $b['mkA2'] == $kodemk ) {
							$n_mk[] = $b['mkB0'];
							$n_mk[] = $b['mkB1'];
							$n_mk[] = $b['mkB2'];
						}
					}
					// $n_mk[] = $zxc[0]['mkB0'];
					// $n_mk[] = $zxc[0]['mkB1'];
					// $n_mk[] = $zxc[0]['mkB2'];
					$edr = array_filter($n_mk);
					$count_mkmap = count($edr);

					$value[0]['kode_mk'] = $edr[0];
					$map = $value;
					$key_mk = $edr[0];

					$val2 = $value;
					$val3 = $value;
					if ($count_mkmap == 2) {
						$val2[0]['kode_mk'] = $edr[1];
						$map2 = $val2;
						$key_mk2 = $edr[1];
					}elseif($count_mkmap == 3){
						$val2 = $value;
						$val3 = $value;
						$val2[0]['kode_mk'] = $edr[1];
						$val3[0]['kode_mk'] = $edr[2];

						$map2 = $val2;
						$map3 = $val3;

						$key_mk2 = $edr[1];
						$key_mk3 = $edr[2];				
					}
				}else{
					$map = $value;
					$map2 = $value;
					$map3 = $value;
					$key_mk = $thn_kur_mk[2];
					$key_mk2 = $thn_kur_mk[2];
					$key_mk3 = $thn_kur_mk[2];
				}
				$conv_nilai[$key_mk] = $map;
				$conv_nilai[$key_mk2] = $map2;
				$conv_nilai[$key_mk3] = $map3;
			}

			foreach ($conv_nilai as $mk => $v) {
				foreach ($v as $key => $value) {
					$map_nilai_mk[$mk] = $value;
				}
			}
			$data['map_nilai_mk'] = $map_nilai_mk;
			/* $map_nilai_mk */
			// echo "<pre>".print_r($map_nilai_mk,1)."</pre>";
			// echo "<pre>".print_r($map_nilai_mk,1)."</pre>";die();



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
			// echo "<pre>".print_r($krs_jadwal,1)."</pre>";die();


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
			// echo "<pre>".print_r($cmd,1)."</pre>";die();


			$this->view->krsx_ke = $krsx; // nilai tertinggi krs per MK
			$this->view->krs_nilai_tinggi = $krs_nilai_tinggi; // nilai tertinggi krs per MK
			$this->view->krs_mhs = $pilih; // krs yang di pilih mhs
			$this->view->pilih_jadwal = $pilih_jadwal; // jadwal krs jam_awal - jam_akhir
			$this->view->jad_mk = $krs_jadwal; // jadwal krs jam_awal - jam_akhir
			$this->view->list_mk_krs_diajukan = $krs_yang_diajukan; // list_mk_krs_diajukan
			$this->view->list_prasyarat_tidak_lolos = $text_pras; // list_prasyarat_tidak_lolos
			$halaman = 'akd_krs/list_mk_ditawarkan';

			$data_krs['krs_mhs'] = $pilih;
			$data_krs['pilih_jadwal'] = $pilih_jadwal;
			$data_krs['jad_mk'] = $krs_jadwal;

			$data_krs_ajukan['list_mk_krs_diajukan'] = $krs_yang_diajukan;
			$data_krs_ajukan['list_prasyarat_tidak_lolos'] = $text_pras;

			$data_krs_count['count'] = count($list_mk_krs_diajukan);
			
			$data['krsx_ke'] = $krsx;
			$data['krs_nilai_tinggi'] = $krs_nilai_tinggi;

			$data['halaman'] = $halaman;
			
		}

		/* MASUKKAN DATA KE REDIS */
		$key_redis = "krs_mhs_".$nomhs."_".$krs_ol;
		$key_redis2 = "krs_data_".$nomhs."_".$krs_ol;
		$key_redis3 = "krs_data_ajukan_".$nomhs."_".$krs_ol;
		$key_redis4 = "krs_data_count_".$nomhs."_".$krs_ol;

		$predis->set($key_redis, json_encode($data));
		$predis->expire($key_redis, 172800); // 2 hari

		$predis->set($key_redis2, json_encode($data_krs)); // selalu uptudate

		$predis->set($key_redis3, json_encode($data_krs_ajukan));

		$predis->set($key_redis4, json_encode($data_krs_count));
		
		$this->view->pick($halaman);
    }

    public function RedisDataMkKrs($nomhs,$psmhs_id,$thn_akd,$session_id,$krs_ol)
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

    public function RedisKrsMk($nomhs,$psmhs_id,$thn_akd,$session_id,$krs_ol,$map_nilai_mk,$vcx)
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
}