<?php

use Phalcon\Mvc\View;
use Phalcon\Validation;
use  Phalcon\Validation\Validator\PresenceOf;
use Phalcon\Mvc\Url;

class AkdjadwalujianController extends \Phalcon\Mvc\Controller
{

    public function initialize()
    {
        if (empty($this->session->get('uid'))) {
            $this->response->redirect('account/loginEnd');
        }
    	$this->view->setRenderLevel(View::LEVEL_ACTION_VIEW);
    }

    public function jadujiAction($value='')
    {
    	$get_session = $this->session->get('ps_id');
		$explode = explode('-', $get_session);
		$ps_id = $explode[1];

		$q = "SELECT thn_akd,session_id,nama FROM RefAkdSession 
					where ps_id = '$ps_id' 
					order by thn_akd desc, session_id desc limit 5";
		$tahun_sesi = $this->modelsManager->executeQuery($q);


		$this->view->tahun_sesi = $tahun_sesi;
		$this->view->pick('akd_pra_sesi/jadwal_ujian/select_sesi');
    }

    public function daftarUjianAction($value='')
    {
    	$get_session = $this->session->get('ps_id');
		$explode = explode('-', $get_session);
		$ps_id = $explode[1];

		$sesi = explode('-', $_POST['sesi']);
		$thn_akd = $sesi[0];
		$session_id = $sesi[1];

    	$cmd = "SELECT id,ujian_id,nama_long from RefAkdDefujian
            where ps_id = '$ps_id'
              and thn_akd = '$thn_akd'
              and session_id = '$session_id'";
        $defujian = $this->modelsManager->executeQuery($cmd);

        $this->view->sesi = $_POST['sesi'];
        $this->view->defujian = $defujian;
		$this->view->pick('akd_pra_sesi/jadwal_ujian/list_defujian');
    }

    public function listmkAction($value='')
    {
    	$get_session = $this->session->get('ps_id');
		$explode = explode('-', $get_session);
		$ps_id = $explode[1];

    	$sesi = explode('-', $_POST['sesi']);
		$thn_akd = $sesi[0];
		$session_id = $sesi[1];

        $id = $_POST['id'];
		$cmd = "SELECT id,ujian_id,nama_long from RefAkdDefujian where id = '$id'";
        $defujian = $this->modelsManager->executeQuery($cmd)->toArray();

        $sesi_nama = FungsiController::nama_sesi($thn_akd,$session_id);

    	$cmd = "SELECT a.thn_kur,
               a.kode_mk,
               c.nama,
               a.nama_kelas,
(SELECT t.nama FROM RefAkdMkkpklDosen s LEFT JOIN RefAkdSdm t on s.nip=t.nip WHERE s.jenis= '1' and a.id=s.id_mkkpkl) as namadosen1
          from RefAkdMkkpkl a
          left join RefAkdMku c
           on a.ps_id=c.ps_id and a.thn_kur=c.thn_kur and a.kode_mk=c.kode_mk
         where a.thn_akd='$thn_akd'
           and a.session_id='$session_id'
           and a.ps_id = '$ps_id'
         order by c.nama,c.semester,c.kode_mk,a.nama_kelas";
        $list_mk = $this->modelsManager->executeQuery($cmd);

        $this->view->defujian = $defujian[0];
        $this->view->sesi_nama = $sesi_nama;

        $this->view->sesi = $_POST['sesi'];
        $this->view->id = $_POST['id'];
        $this->view->ujian_id = $_POST['ujian_id'];
        $this->view->list_mk = $list_mk;
		$this->view->pick('akd_pra_sesi/jadwal_ujian/list_mk');
    }

    public function addJadwalFormAction($value='')
    {
    	$get_session = $this->session->get('ps_id');
		$explode = explode('-', $get_session);
		$ps_id = $explode[1];

		$sesi = explode('-', $_POST['sesi']);
		$thn_akd = $sesi[0];
		$session_id = $sesi[1];

		$ujian_id = $_POST['ujian_id'];
        $thn_kur = $_POST['thn_kur'];
		$kode_mk = $_POST['kode_mk'];
		$nama_kelas = $_POST['nama_kelas'];

		$cmd="SELECT a.ruang_id,b.nama_ruang
			from RefAkdRuangAktif a
			 left join RefAkdRuang b on a.ps_id=b.ps_id and a.ruang_id=b.ruang_id 
			where a.ps_id = '$ps_id'
			  and a.thn_akd = '$thn_akd'
			  and a.session_id = '$session_id'
			group by a.ruang_id
			order by b.nama_ruang";
		$ruang = $this->modelsManager->executeQuery($cmd);

		$cmd = "SELECT a.id,a.jadwal_id,a.awal,a.akhir,a.kapasitas,
                  a.ruang_id,b.nama_ruang,a.st_gabung,c.volume
           from RefAkdJadwalUjian a
           left join RefAkdRuang b on a.ruang_id=b.ruang_id
           left join RefAkdConfruang c on c.ruang_id = a.ruang_id
                                and c.conf_id = a.conf_id
           where a.ps_id = '$ps_id'
             and a.ujian_id = '$ujian_id'
             and a.thn_akd = '$thn_akd'
             and a.session_id = '$session_id'
             and a.kode_mk = '$kode_mk'
             and a.thn_kur = '$thn_kur'
             and a.nama_kelas = '$nama_kelas'
           order by a.awal,a.jadwal_id";
		$list_jad2 = $this->modelsManager->executeQuery($cmd)->toArray();

		$dt_list_jad2 = [];
		foreach ($list_jad2 as $key => $value) {
			$awal = $value['awal'];
			$akhir = $value['akhir'];
			$ruang_id = $value['ruang_id'];

			$q = "SELECT a.kode_mk,a.thn_kur,a.nama_kelas,a.kapasitas,a.jadwal_id,a.thn_akd,a.session_id,a.ujian_id
	                   from RefAkdJadwalUjian a
	                   where ruang_id = '$ruang_id'
	                     and not (awal >= '$akhir' or akhir <= '$awal')
	                     and concat(a.ps_id,'-',a.thn_kur,'-',a.kode_mk,'-',a.nama_kelas) != '$ps_id-$thn_kur-$kode_mk-$nama_kelas'";
	       	$gab_nya = $this->modelsManager->executeQuery($q)->toArray();

			$dt_list_jad2[] = array(
				'id' => $value['id'] , 
				'jadwal_id' => $value['jadwal_id'] , 
				'awal' => $value['awal'] , 
				'akhir' => $value['akhir'] , 
				'kapasitas' => $value['kapasitas'] , 
				'ruang_id' => $value['ruang_id'] , 
				'nama_ruang' => $value['nama_ruang'] , 
				'volume' => $value['volume'] , 
				'st_gabung' => $gab_nya , 
			);
		}

		// echo "<pre>".print_r($dt_list_jad2,1)."</pre>";die();
		$cmd = "SELECT count(nomhs) as jml_mhs from RefAkdKrs
                     where kode_mk = '$kode_mk'
                       and thn_kur = '$thn_kur'
                       and nama_kelas = '$nama_kelas'
                       and thn_akd = '$thn_akd'
                       and session_id = '$session_id'
                       and ps_id = '$ps_id'
                       and st_ambil != 'w'";
		$jml_mhs = $this->modelsManager->executeQuery($cmd)->toArray();


        $this->view->jml_mhs = $jml_mhs[0]['jml_mhs'];
        $this->view->ruang = $ruang;
        $this->view->dt_list_jad2 = $dt_list_jad2;

        $this->view->sesi = $_POST['sesi'];
        $this->view->id = $_POST['id'];
        $this->view->ujian_id = $_POST['ujian_id'];

        $this->view->thn_kur = $_POST['thn_kur'];
		$this->view->kode_mk = $_POST['kode_mk'];
		$this->view->nama_kelas = $_POST['nama_kelas'];

		$this->view->pick('akd_pra_sesi/jadwal_ujian/form_add_ujian');
    }

    public function konfigurasiOptionAction($value='')
    {
    	$get_session = $this->session->get('ps_id');
		$explode = explode('-', $get_session);
		$ps_id = $explode[1];

    	$ruang_id = $_POST['ruang_id'];

    	$cmd="SELECT * from RefAkdConfruang where ps_id = '$ps_id' and ruang_id = '$ruang_id' order by conf_id";
		$konf = $this->modelsManager->executeQuery($cmd)->toArray();

		if (count($konf) == 0) {
			echo "<option value=\"0\" > null </option>";
		}else{
			echo "<option value=\"0\" >  </option>";
			foreach ($konf as $key => $value) {
				echo "<option value=\"$value[conf_id]\" > $value[nama_conf] </option>";
			}
		}
    }

    public function konfigurasiKapasitasAction($value='')
    {
    	$get_session = $this->session->get('ps_id');
		$explode = explode('-', $get_session);
		$ps_id = $explode[1];

    	$conf_id = $_POST['conf_id'];


    	$cmd="SELECT volume from RefAkdConfruang where conf_id = '$conf_id'";
		$konf = $this->modelsManager->executeQuery($cmd)->toArray();

		if ($conf_id == 0) {
			echo "<input class=\"form-control\" type=\"text\" size=\"2\" name=\"kapasitas_id\" maxlength=\"2\" value=\"0\" readonly>";
		}else{
			echo "<input class=\"form-control\" type=\"text\" size=\"2\" name=\"kapasitas_id\" maxlength=\"2\" value=\"".$konf[0]['volume']."\" readonly>";
		}
    }

    public function tambahJadwalAction()
    {
    	// echo "<pre>".print_r($_POST,1)."</pre>";die();
    	$get_session = $this->session->get('ps_id');
		$explode = explode('-', $get_session);
		$ps_id = $explode[1];

		$sesi = explode('-', $_POST['sesi']);
		$thn_akd = $sesi[0];
		$session_id = $sesi[1];


		$dd1 = $_POST['dd1'];
		$mm1 = $_POST['mm1'];
		$yyyy1 = $_POST['yyyy1'];

		$dd2 = $_POST['dd2'];
		$mm2 = $_POST['mm2'];
		$yyyy2 = $_POST['yyyy2'];

		$jam_awal = $_POST['t1'];
		$jam_akhir = $_POST['t2'];

		$t1 = $_POST['t1'];
		$t2 = $_POST['t2'];
		
		$ruang_id = $_POST['ruang_id'];
		$ujian_id = $_POST['ujian_id'];

		$thn_kur = $_POST['thn_kur'];
		$kode_mk = $_POST['kode_mk'];
		$nama_kelas = $_POST['nama_kelas'];
		$kap = $_POST['jml_mhs'];// jml mhs yang masuk ruangan itu
		$conf_id = $_POST['conf_id'];

		$jam_awal = str_replace(".",":",$jam_awal);
		$jam_akhir = str_replace(".",":",$jam_akhir);

		$arr = explode(":",$jam_awal);
		if(count($arr) == 2) {
		 $jam_awal .= ":00";
		} elseif (count($arr) == 1) {
		 $jam_awal .= ":00:00";
		}

		$arr = explode(":",$jam_akhir);
		if(count($arr) == 2) {
		 $jam_akhir .= ":00";
		} elseif (count($arr) == 1) {
		 $jam_akhir .= ":00:00";
		}

		if($t1 == '') {
		 $jam_awal = "NULL";
		} else{ $jam_awal = "$yyyy1-$mm1-$dd1 $jam_awal"; $jam_awal2 = "'$jam_awal'";}
		if($t2 == '') {
		 $jam_akhir = "NULL";
		} else{ $jam_akhir = "$yyyy2-$mm2-$dd2 $jam_akhir";$jam_akhir2 = "'$jam_akhir'";}

		$cmd = "SELECT a.id,
					a.kode_mk,
					a.kapasitas,
                  a.thn_kur,
                  a.nama_kelas,
                  a.awal,
                  a.akhir,
                  a.ruang_id,
                  c.nama
             from RefAkdJadwalUjian a
             left join RefAkdMku c on c.ps_id = a.ps_id
                            and c.thn_kur = a.thn_kur
                            and c.kode_mk = a.kode_mk
            where a.ruang_id = '$ruang_id'
              and not (a.awal >= $jam_akhir2 or a.akhir <= $jam_awal2)
              and concat(a.ps_id,'-',a.thn_kur,'-',a.kode_mk,'-',a.nama_kelas) != '$ps_id-$thn_kur-$kode_mk-$nama_kelas'";
        $cek = $this->modelsManager->executeQuery($cmd)->toArray();

        if (count($cek) > 0) {
        	$id_yg_akan_digabungkan = $cek[0]['id'];
        	$mhs_nya = $cek[0]['kapasitas'];
        	$thn_kur = $cek[0]['thn_kur'];
        	$kode_mkx = $cek[0]['kode_mk'];
        	$nama_kelasx = $cek[0]['nama_kelas'];
        	$namax = $cek[0]['nama'];

        	$notif = array(
                'title' => 'warning',
                'text' => "JADWAL BENTROK DENGAN: <br/> $thn_kur $kode_mkx : $namax : KELAS $nama_kelasx <br> Apakan Akan DI GABUNG ?",
                'type' => 'warning',
                'data' => $cek[0],
                'id_yg_akan_digabungkan' => $id_yg_akan_digabungkan,
                'mhs_nya' => $mhs_nya,
            );
       		echo json_encode($notif);
        }else{
			$cmd = "SELECT max(jadwal_id) as jadwal_id from RefAkdJadwalUjian
				where ps_id = '$ps_id'
				and thn_akd = '$thn_akd'
				and session_id = '$session_id'
				and ujian_id = '$ujian_id'";
	        $jadwal_id_max = $this->modelsManager->executeQuery($cmd)->toArray();
			$jadwal_id = $jadwal_id_max[0]['jadwal_id']+1;       

	        $RefAkdJadwalUjian = new RefAkdJadwalUjian();
            $RefAkdJadwalUjian->assign(array(
                'ps_id' => $ps_id,
                'thn_akd' => $thn_akd,
                'session_id' => $session_id,
                'jadwal_id' => $jadwal_id,
                'kode_mk' => $kode_mk,
                'thn_kur' => $thn_kur,
                'awal' => $jam_awal,
                'akhir' => $jam_akhir,
                'ujian_id' => $ujian_id,
                'nama_kelas' => $nama_kelas,
                'ruang_id' => $ruang_id,
                'kapasitas' => $kap,
                'conf_id' => $conf_id
                )
            );
            $RefAkdJadwalUjian->save();

            $notif = array(
                'title' => 'success',
                'text' => "Jadwal Berhasil Di input",
                'type' => 'success'
            );
       		echo json_encode($notif);
        }
    }

    public function digabungAction($value='')
    {
    	// echo "<pre>".print_r($_POST,1)."</pre>";die();
    	$get_session = $this->session->get('ps_id');
		$explode = explode('-', $get_session);
		$ps_id = $explode[1];

		$sesi = explode('-', $_POST['sesi']);
		$thn_akd = $sesi[0];
		$session_id = $sesi[1];


		$dd1 = $_POST['dd1'];
		$mm1 = $_POST['mm1'];
		$yyyy1 = $_POST['yyyy1'];

		$dd2 = $_POST['dd2'];
		$mm2 = $_POST['mm2'];
		$yyyy2 = $_POST['yyyy2'];

		$jam_awal = $_POST['t1'];
		$jam_akhir = $_POST['t2'];

		$t1 = $_POST['t1'];
		$t2 = $_POST['t2'];
		
		$ruang_id = $_POST['ruang_id'];
		$ujian_id = $_POST['ujian_id'];

		$thn_kur = $_POST['thn_kur'];
		$kode_mk = $_POST['kode_mk'];
		$nama_kelas = $_POST['nama_kelas'];
		$kap = $_POST['jml_mhs'];// jml mhs yang masuk ruangan itu
		$conf_id = $_POST['conf_id'];

		$jam_awal = str_replace(".",":",$jam_awal);
		$jam_akhir = str_replace(".",":",$jam_akhir);

		$arr = explode(":",$jam_awal);
		if(count($arr) == 2) {
		 $jam_awal .= ":00";
		} elseif (count($arr) == 1) {
		 $jam_awal .= ":00:00";
		}

		$arr = explode(":",$jam_akhir);
		if(count($arr) == 2) {
		 $jam_akhir .= ":00";
		} elseif (count($arr) == 1) {
		 $jam_akhir .= ":00:00";
		}

		if($t1 == '') {
		 $jam_awal = "NULL";
		} else{ $jam_awal = "$yyyy1-$mm1-$dd1 $jam_awal"; $jam_awal2 = "'$jam_awal'";}
		if($t2 == '') {
		 $jam_akhir = "NULL";
		} else{ $jam_akhir = "$yyyy2-$mm2-$dd2 $jam_akhir";$jam_akhir2 = "'$jam_akhir'";}


		$cmd = "SELECT volume from RefAkdConfruang
			where ps_id = '$ps_id'
			and conf_id = '$conf_id'
			and ruang_id = '$ruang_id'";
        $ruang_volume = $this->modelsManager->executeQuery($cmd)->toArray();

		$mhs_nya = $_POST['mhs_nya'];// jml mhs yang mai di gabung
        if ($ruang_volume[0]['volume'] < $kap+$mhs_nya) {
        	$ruang_kap = $ruang_volume[0]['volume'];
        	$mhs_ttl = $kap+$mhs_nya;
        	$notif = array(
	            'title' => 'Error',
	            'text' => "PERINGATAN : JUMLAH KURSI MASIH KURANG! <br> Kapasitas Ruang : $ruang_kap <br> Jml Mhs yang di gabung : $mhs_ttl",
	            'type' => 'error'
	        );
	        echo json_encode($notif);
        }else{
	        $cmd = "SELECT max(jadwal_id) as jadwal_id from RefAkdJadwalUjian
				where ps_id = '$ps_id'
				and thn_akd = '$thn_akd'
				and session_id = '$session_id'
				and ujian_id = '$ujian_id'";
	        $jadwal_id_max = $this->modelsManager->executeQuery($cmd)->toArray();
			$jadwal_id = $jadwal_id_max[0]['jadwal_id']+1;       

	        $RefAkdJadwalUjian = new RefAkdJadwalUjian();
	        $RefAkdJadwalUjian->assign(array(
	            'ps_id' => $ps_id,
	            'thn_akd' => $thn_akd,
	            'session_id' => $session_id,
	            'jadwal_id' => $jadwal_id,
	            'kode_mk' => $kode_mk,
	            'thn_kur' => $thn_kur,
	            'awal' => $jam_awal,
	            'akhir' => $jam_akhir,
	            'ujian_id' => $ujian_id,
	            'nama_kelas' => $nama_kelas,
	            'ruang_id' => $ruang_id,
	            'kapasitas' => $kap,
	            'conf_id' => $conf_id,
	            'st_gabung' => "Y"
	            )
	        );
	        $RefAkdJadwalUjian->save();

	        $id_yg_akan_digabungkan = $_POST['id_yg_akan_digabungkan'];
	        $cls = RefAkdJadwalUjian::findFirstById($id_yg_akan_digabungkan);
	        $cls->assign(array(
	            'st_gabung' => "Y",
	            )
	        );

	        $notif = array(
	            'title' => 'success',
	            'text' => "Jadwal Berhasil Di input",
	            'type' => 'success'
	        );
	   		echo json_encode($notif);
        }

    }

    public function delJadwalAction($id)
    {
    	$this->view->setRenderLevel(View::LEVEL_ACTION_VIEW);
        $del=RefAkdJadwalUjian::findById($id);
        $del->delete();
        echo json_encode(array("status" => true));
    }

///////////////////////////////////////////////////////////////////////////////////////
/////////////////////////// EDIT JADWAL UJIAN ////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////

    public function formEditAction($id)
    {
    	$get_session = $this->session->get('ps_id');
		$explode = explode('-', $get_session);
		$ps_id = $explode[1];

		$sesi = explode('-', $_POST['sesi']);
		$thn_akd = $sesi[0];
		$session_id = $sesi[1];

        $thn_kur = $_POST['thn_kur'];
		$kode_mk = $_POST['kode_mk'];
		$nama_kelas = $_POST['nama_kelas'];

        $cmd = "SELECT a.id,a.jadwal_id,a.awal,a.akhir,a.kapasitas,
                  a.ruang_id,b.nama_ruang,a.st_gabung,a.mhs_campur,c.volume
           from RefAkdJadwalUjian a
           left join RefAkdRuang b on a.ruang_id=b.ruang_id
           left join RefAkdConfruang c on c.ruang_id = a.ruang_id
                                and c.conf_id = a.conf_id
           where a.id = '$id' ";
		$list_jad2 = $this->modelsManager->executeQuery($cmd)->toArray();

		$dt_list_jad2 = [];
		foreach ($list_jad2 as $key => $value) {
			$awal = $value['awal'];
			$akhir = $value['akhir'];
			$ruang_id = $value['ruang_id'];

			$q = "SELECT a.kode_mk,a.thn_kur,a.nama_kelas,a.kapasitas,a.jadwal_id,a.thn_akd,a.session_id,a.ujian_id
	                   from RefAkdJadwalUjian a
	                   where ruang_id = '$ruang_id'
	                     and not (awal >= '$akhir' or akhir <= '$awal')
	                     and concat(a.ps_id,'-',a.thn_kur,'-',a.kode_mk,'-',a.nama_kelas) != '$ps_id-$thn_kur-$kode_mk-$nama_kelas'";
	       	$gab_nya = $this->modelsManager->executeQuery($q)->toArray();

			$dt_list_jad2[] = array(
				'id' => $value['id'] , 
				'jadwal_id' => $value['jadwal_id'] , 
				'awal' => $value['awal'] , 
				'akhir' => $value['akhir'] , 
				'kapasitas' => $value['kapasitas'] , 
				'ruang_id' => $value['ruang_id'] , 
				'nama_ruang' => $value['nama_ruang'] , 
				'volume' => $value['volume'] , 
				'st_gabung' => $gab_nya , 
				'mhs_campur' => $value['mhs_campur'] , 
				'gabung_st' => $value['st_gabung'] , 
			);
		}

		$cmd="SELECT a.ruang_id,b.nama_ruang
			from RefAkdRuangAktif a
			 left join RefAkdRuang b on a.ps_id=b.ps_id and a.ruang_id=b.ruang_id 
			where a.ps_id = '$ps_id'
			  and a.thn_akd = '$thn_akd'
			  and a.session_id = '$session_id'
			group by a.ruang_id
			order by b.nama_ruang";
		$ruang = $this->modelsManager->executeQuery($cmd)->toArray();

		$cmd = "SELECT count(nomhs) as jml_mhs from RefAkdKrs
                     where kode_mk = '$kode_mk'
                       and thn_kur = '$thn_kur'
                       and nama_kelas = '$nama_kelas'
                       and thn_akd = '$thn_akd'
                       and session_id = '$session_id'
                       and ps_id = '$ps_id'
                       and st_ambil != 'w'";
		$jml_mhs = $this->modelsManager->executeQuery($cmd)->toArray();

		$bulan = array(
			1	=> 'Januari',
			2	=> 'Februari',
			3	=> 'Maret',
			4	=> 'April',
			5	=> 'Mei',
			6	=> 'Juni',
			7	=> 'Juli',
			8	=> 'Agustus',
			9	=> 'September',
			10	=> 'Oktober',
			11	=> 'November',
			12	=> 'Desember'
		);

        $this->view->jml_mhs = $jml_mhs[0]['jml_mhs'];
        $this->view->bulan = $bulan;
        $this->view->ruang = $ruang;
        $this->view->dt_list_jad2 = $dt_list_jad2;

        $this->view->sesi = $_POST['sesi'];
        $this->view->id = $_POST['id'];
        $this->view->ujian_id = $_POST['ujian_id'];

        $this->view->thn_kur = $_POST['thn_kur'];
		$this->view->kode_mk = $_POST['kode_mk'];
		$this->view->nama_kelas = $_POST['nama_kelas'];

		$this->view->pick('akd_pra_sesi/jadwal_ujian/form_edit_ujian');
    }

    public function editJadwalAction($value='')
    {
    	// echo "<pre>".print_r($_POST,1)."</pre>";die();
    	$get_session = $this->session->get('ps_id');
		$explode = explode('-', $get_session);
		$ps_id = $explode[1];

		$sesi = explode('-', $_POST['sesi']);
		$thn_akd = $sesi[0];
		$session_id = $sesi[1];


		$dd1 = $_POST['dd1'];
		$mm1 = $_POST['mm1'];
		$yyyy1 = $_POST['yyyy1'];

		$dd2 = $_POST['dd2'];
		$mm2 = $_POST['mm2'];
		$yyyy2 = $_POST['yyyy2'];

		$jam_awal = $_POST['t1'];
		$jam_akhir = $_POST['t2'];

		$t1 = $_POST['t1'];
		$t2 = $_POST['t2'];
		
		$ruang_id = $_POST['ruang_id'];
		$ruang_id_sebelumnya = $_POST['ruang_id_sebelumnya'];
		$ujian_id = $_POST['ujian_id'];
		$id_jadwal = $_POST['id_jadwal'];
		
		$mhs_campur = (isset($_POST['mhs_campur']) ) ? "Y" : "N";
		$st_gabung = (isset($_POST['st_gabung']) ) ? "Y" : "N";


		$thn_kur = $_POST['thn_kur'];
		$kode_mk = $_POST['kode_mk'];
		$nama_kelas = $_POST['nama_kelas'];
		$kap = $_POST['jml_mhs'];// jml mhs yang masuk ruangan itu
		$conf_id = $_POST['conf_id'];

		$gabung_action = (isset($_POST['gabung_action']) ) ? "Y" : "N";

		$jam_awal = str_replace(".",":",$jam_awal);
		$jam_akhir = str_replace(".",":",$jam_akhir);

		$arr = explode(":",$jam_awal);
		if(count($arr) == 2) {
		 $jam_awal .= ":00";
		} elseif (count($arr) == 1) {
		 $jam_awal .= ":00:00";
		}

		$arr = explode(":",$jam_akhir);
		if(count($arr) == 2) {
		 $jam_akhir .= ":00";
		} elseif (count($arr) == 1) {
		 $jam_akhir .= ":00:00";
		}

		if($t1 == '') {
		 $jam_awal = "NULL";
		} else{ $jam_awal = "$yyyy1-$mm1-$dd1 $jam_awal"; $jam_awal2 = "'$jam_awal'";}
		if($t2 == '') {
		 $jam_akhir = "NULL";
		} else{ $jam_akhir = "$yyyy2-$mm2-$dd2 $jam_akhir";$jam_akhir2 = "'$jam_akhir'";}


		if ($gabung_action != 'Y') {
			$cmd = "SELECT a.id,
						a.kode_mk,
						a.kapasitas,
	                  a.thn_kur,
	                  a.nama_kelas,
	                  a.awal,
	                  a.akhir,
	                  a.ruang_id,
	                  c.nama
	             from RefAkdJadwalUjian a
	             left join RefAkdMku c on c.ps_id = a.ps_id
	                            and c.thn_kur = a.thn_kur
	                            and c.kode_mk = a.kode_mk
	            where a.ruang_id = '$ruang_id'
	              and not (a.awal >= $jam_akhir2 or a.akhir <= $jam_awal2)
	              and concat(a.ps_id,'-',a.thn_kur,'-',a.kode_mk,'-',a.nama_kelas) != '$ps_id-$thn_kur-$kode_mk-$nama_kelas'";
	        $cek = $this->modelsManager->executeQuery($cmd)->toArray();
    	}else{
    		$cek = array();
    	}
        if (count($cek) > 0) {
        	$id_yg_akan_digabungkan = $cek[0]['id'];
        	$mhs_nya = $cek[0]['kapasitas'];
        	$thn_kur = $cek[0]['thn_kur'];
        	$kode_mkx = $cek[0]['kode_mk'];
        	$nama_kelasx = $cek[0]['nama_kelas'];
        	$namax = $cek[0]['nama'];

        	$notif = array(
                'title' => 'warning',
                'text' => "JADWAL BENTROK DENGAN: <br/> $thn_kur $kode_mkx : $namax : KELAS $nama_kelasx <br> Apakan Akan DI GABUNG ?",
                'type' => 'warning',
                'data' => $cek[0],
                'id_yg_akan_digabungkan' => $id_yg_akan_digabungkan,
                'mhs_nya' => $mhs_nya
            );
       		echo json_encode($notif);
        }else{
        	if ($gabung_action == 'Y') {

        		$RefAkdJadwalUjian = RefAkdJadwalUjian::findFirstById($id_jadwal);
	            $RefAkdJadwalUjian->assign(array(
	                'awal' => $jam_awal,
	                'akhir' => $jam_akhir,
	                'kapasitas' => $kap,
	                'mhs_campur' => $mhs_campur,
	                'st_gabung' => "Y"
	                )
	            );
	            $RefAkdJadwalUjian->save();

		        $id_yg_akan_digabungkan = $_POST['id_yg_akan_digabungkan'];
		        $cls = RefAkdJadwalUjian::findFirstById($id_yg_akan_digabungkan);
		        $cls->assign(array(
		            'st_gabung' => "Y",
		            )
		        );
        	}else{
	        	if ($ruang_id_sebelumnya == $ruang_id) {    

			        $RefAkdJadwalUjian = RefAkdJadwalUjian::findFirstById($id_jadwal);
		            $RefAkdJadwalUjian->assign(array(
		                'awal' => $jam_awal,
		                'akhir' => $jam_akhir,
		                'kapasitas' => $kap,
		                'mhs_campur' => $mhs_campur,
		                'st_gabung' => $st_gabung
		                )
		            );
		            $RefAkdJadwalUjian->save();
	        	}else{     

			        $RefAkdJadwalUjian = RefAkdJadwalUjian::findFirstById($id_jadwal);
		            $RefAkdJadwalUjian->assign(array(
		                'awal' => $jam_awal,
		                'akhir' => $jam_akhir,
		                'kapasitas' => $kap,
		                'ruang_id' => $ruang_id,
		                'conf_id' => $conf_id,
		                'mhs_campur' => $mhs_campur,
		                'st_gabung' => $st_gabung
		                )
		            );
		            $RefAkdJadwalUjian->save();

	        	}
        	}
            $notif = array(
                'title' => 'success',
                'text' => "Jadwal Berhasil Di Edit",
                'type' => 'success'
            );
       		echo json_encode($notif);
        }
    }




///////////////////////////////////////////////////////////////////////////////////////
/////////////////////////// JADWAL UJIAN GABUNGAN ////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////

    public function listMkGabunganAction($value='')
    {
    	// echo "<pre>".print_r($_POST,1)."</pre>";
    	$get_session = $this->session->get('ps_id');
		$explode = explode('-', $get_session);
		$ps_id = $explode[1];

    	$sesi = explode('-', $_POST['sesi']);
		$thn_akd = $sesi[0];
		$session_id = $sesi[1];

        $id = $_POST['id'];
		$cmd = "SELECT id,ujian_id,nama_long from RefAkdDefujian where id = '$id'";
        $defujian = $this->modelsManager->executeQuery($cmd)->toArray();

        $sesi_nama = FungsiController::nama_sesi($thn_akd,$session_id);

    	$cmd = "SELECT a.thn_kur,
               a.kode_mk,
               c.nama,
               a.nama_kelas,
(SELECT count(z.nomhs) FROM RefAkdKrs z WHERE z.kode_mk= a.kode_mk and z.thn_kur=a.thn_kur and z.nama_kelas=a.nama_kelas 
			and z.thn_akd='$thn_akd'
			and z.session_id='$session_id'
			and z.ps_id = '$ps_id' and z.st_ambil != 'w' ) as jml_mhs,
(SELECT t.nama FROM RefAkdMkkpklDosen s LEFT JOIN RefAkdSdm t on s.nip=t.nip WHERE s.jenis= '1' and a.id=s.id_mkkpkl) as namadosen1
          from RefAkdMkkpkl a
          left join RefAkdMku c
           on a.ps_id=c.ps_id and a.thn_kur=c.thn_kur and a.kode_mk=c.kode_mk
         where a.thn_akd='$thn_akd'
           and a.session_id='$session_id'
           and a.ps_id = '$ps_id'
         order by c.nama,c.semester,c.kode_mk,a.nama_kelas";
         // echo "<pre>".print_r($cmd,1)."</pre>";die();
        $list_mk = $this->modelsManager->executeQuery($cmd);


        $this->view->defujian = $defujian[0];
        $this->view->sesi_nama = $sesi_nama;

        $this->view->sesi = $_POST['sesi'];
        $this->view->id = $_POST['id'];
        $this->view->ujian_id = $_POST['ujian_id'];
        $this->view->list_mk = $list_mk;
		$this->view->pick('akd_pra_sesi/jadwal_ujian/list_mk_gabungan');
    }

    public function gabPilihRuangAction($value='')
    {
    	$get_session = $this->session->get('ps_id');
		$explode = explode('-', $get_session);
		$ps_id = $explode[1];

    	foreach ($_POST as $key => $value) {
			$mk = explode('_', $key);
			if ($mk[0] == 'pilihmk') {
				$data_array = explode('#', $value);
				$dt[] = array(
					'sesi' => $data_array[0] , 
					'ujian_id' => $data_array[1] , 
					'thn_kur' => $data_array[2] , 
					'kode_mk' => $data_array[3] , 
					'nama_kelas' => $data_array[4] , 
					'nama' => $data_array[5] , 
					'jml_mhs' => $data_array[6] , 
				);
			}
		}

		$sesi = explode('-', $_POST['sesi']);
		$thn_akd = $sesi[0];
		$session_id = $sesi[1];

        $id = $_POST['id'];
		$cmd = "SELECT id,ujian_id,nama_long from RefAkdDefujian where id = '$id'";
        $defujian = $this->modelsManager->executeQuery($cmd)->toArray();
        $sesi_nama = FungsiController::nama_sesi($thn_akd,$session_id);

        $cmd = "SELECT a.ruang_id,b.nama_ruang,c.conf_id,c.nama_conf,count(d.no_kursi) as kapasitas
				from RefAkdRuangAktif a
				 left join RefAkdRuang b on b.ps_id=a.ps_id and b.ruang_id=a.ruang_id
				 left join RefAkdConfruang c on c.ps_id=a.ps_id and c.ruang_id=a.ruang_id
				 left join RefAkdMtrxruang d on d.ps_id=a.ps_id and d.ruang_id=a.ruang_id and d.conf_id=c.conf_id
				where a.ps_id = '$ps_id'
				  and a.thn_akd = '$thn_akd'
				  and a.session_id = '$session_id'
				group by a.ruang_id,c.conf_id
				order by b.nama_ruang,c.conf_id";
        $ruang = $this->modelsManager->executeQuery($cmd)->toArray();
		$this->view->ruang = $ruang;


		// sesi # ujian_id # thn_kur # kode_mk # nama_kelas # nama # jml_mhs
		$this->view->defujian = $defujian[0];
        $this->view->sesi_nama = $sesi_nama;

		$this->view->sesi = $_POST['sesi'];
        $this->view->id = $_POST['id'];
        $this->view->ujian_id = $_POST['ujian_id'];
		$this->view->data_mk = $dt;
		$this->view->pick('akd_pra_sesi/jadwal_ujian/form_mk_gabungan');
    }

    public function urutkanAction($value='')
    {
    	$get_session = $this->session->get('ps_id');
		$explode = explode('-', $get_session);
		$ps_id = $explode[1];

    	// echo "<pre>".print_r($_POST,1)."</pre>";die();
    	foreach ($_POST as $key => $value) {
			$mk = explode('_', $key);
			if ($mk[0] == 'pilihmk') {
				$data_array = explode('#', $value);
				$dt[] = array(
					'sesi' => $data_array[0] , 
					'ujian_id' => $data_array[1] , 
					'thn_kur' => $data_array[2] , 
					'kode_mk' => $data_array[3] , 
					'nama_kelas' => $data_array[4] , 
					'nama' => $data_array[5] , 
					'jml_mhs' => $data_array[6] , 
				);
			}elseif ($mk[0] == 'pilihruang') {
				$data_array2 = explode('#', $value);
				$dt2[] = array(
					'ruang_id' => $data_array2[0] , 
					'conf_id' => $data_array2[1] , 
					'nama_ruang' => $data_array2[2] , 
					'kapasitas' => $data_array2[3],
					'nama_conf' => $data_array2[4] 
				);
			}
		}

		$sesi = explode('-', $_POST['sesi']);
		$thn_akd = $sesi[0];
		$session_id = $sesi[1];

		$id = $_POST['id'];
		$cmd = "SELECT id,ujian_id,nama_long from RefAkdDefujian where id = '$id'";
        $defujian = $this->modelsManager->executeQuery($cmd)->toArray();
        $sesi_nama = FungsiController::nama_sesi($thn_akd,$session_id);

        $this->view->defujian = $defujian[0];
        $this->view->sesi_nama = $sesi_nama;



		$this->view->sesi = $_POST['sesi'];
        $this->view->id = $_POST['id'];
        $this->view->ujian_id = $_POST['ujian_id'];
		$this->view->data_mk = $dt;
		$this->view->data_ruang = $dt2;
		$this->view->pick('akd_pra_sesi/jadwal_ujian/urut_mk_gabungan');

    }

    public function simpanGabAction($value='')
    {
    	// echo "<pre>".print_r($_POST,1)."</pre>";
    	$get_session = $this->session->get('ps_id');
		$explode = explode('-', $get_session);
		$ps_id = $explode[1];

		$sesi = explode('-', $_POST['sesi']);
		$thn_akd = $sesi[0];
		$session_id = $sesi[1];


		$dd1 = $_POST['dd1'];
		$mm1 = $_POST['mm1'];
		$yyyy1 = $_POST['yyyy1'];

		$dd2 = $_POST['dd2'];
		$mm2 = $_POST['mm2'];
		$yyyy2 = $_POST['yyyy2'];

		$jam_awal = $_POST['t1'];
		$jam_akhir = $_POST['t2'];

		$t1 = $_POST['t1'];
		$t2 = $_POST['t2'];

		$jam_awal = str_replace(".",":",$jam_awal);
		$jam_akhir = str_replace(".",":",$jam_akhir);

		$arr = explode(":",$jam_awal);
		if(count($arr) == 2) {
		 $jam_awal .= ":00";
		} elseif (count($arr) == 1) {
		 $jam_awal .= ":00:00";
		}

		$arr = explode(":",$jam_akhir);
		if(count($arr) == 2) {
		 $jam_akhir .= ":00";
		} elseif (count($arr) == 1) {
		 $jam_akhir .= ":00:00";
		}

		if($t1 == '') {
		 $jam_awal = "NULL";
		} else{ $jam_awal = "$yyyy1-$mm1-$dd1 $jam_awal"; $jam_awal2 = "'$jam_awal'";}
		if($t2 == '') {
		 $jam_akhir = "NULL";
		} else{ $jam_akhir = "$yyyy2-$mm2-$dd2 $jam_akhir";$jam_akhir2 = "'$jam_akhir'";}

		foreach ($_POST as $key => $value) {
			$mk = explode('_', $key);
			if ($mk[0] == 'pilihmk') {
				
				$post = "urutan_mk".$mk[1];
				$data_post = $_POST[$post];
				$data_mk[$data_post] = $value;

			}elseif ($mk[0] == 'pilihruang') {

				$post = "urutan_ruang".$mk[1];
				$data_post = $_POST[$post];
				$data_ruang[$data_post] = $value;
			}
		}
		ksort($data_mk);
		ksort($data_ruang);
		// echo "<pre>".print_r($data_mk,1)."</pre>";
		// echo "<pre>".print_r($data_ruang,1)."</pre>";

		$notif = array();
		foreach($data_ruang as $ruang) {
            list($ruang_id,$conf_id,$nama_ruang,$kapasitas,$nama_conf)=explode("#",$ruang);
            $cmd = "SELECT a.kode_mk,
	                  a.thn_kur,
	                  a.nama_kelas,
	                  a.awal,
	                  a.akhir,
	                  a.ruang_id,
	                  c.nama
	             from RefAkdJadwalUjian a
	             left join RefAkdMku c on c.ps_id = a.ps_id
	                            and c.thn_kur = a.thn_kur
	                            and c.kode_mk = a.kode_mk
	            where a.ruang_id = '$ruang_id'
	              and not (a.awal >= $jam_akhir2 or a.akhir <= $jam_awal2) ";
	        $cek = $this->modelsManager->executeQuery($cmd)->toArray();

		    if (count($cek) > 0) {
	        	$thn_kur = $cek[0]['thn_kur'];
	        	$kode_mkx = $cek[0]['kode_mk'];
	        	$nama_kelasx = $cek[0]['nama_kelas'];
	        	$namax = $cek[0]['nama'];

	        	$notif = array(
	                'title' => 'warning',
	                'text' => "JADWAL BENTROK DENGAN: <br/> $thn_kur $kode_mkx : $namax : KELAS $nama_kelasx",
	                'type' => 'warning',
	                'data' => $cek[0],
	            );
	        }
        }

        if (!empty($notif)) {
			echo json_encode($notif);
		}else{
			// echo "<pre>".print_r('asd',1)."</pre>";
			$current_kap_sisa = 0;
			foreach($data_mk as $k => $kls) {
                  list($sesi,
                       $ujian_id,
                       $thn_kur,
                       $kode_mk,
                       $nama_kelas,
                       $nama,
                       $jml_mhs)=explode("#",$kls);

				$sesi2 = explode('-', $sesi);
				$thn_akd = $sesi2[0];
				$session_id = $sesi2[1];

				$sisamhs = $jml_mhs;


				while($sisamhs > 0) {
					if($current_kap_sisa > 0) {
					} else {
						$ruang = array_shift($data_ruang);
						list($ruang_id,$conf_id,$nama_ruang,$kapasitas,$nama_conf)=explode("#",$ruang);
						$current_kap_sisa = $kapasitas;
					}
					if($current_kap_sisa > $sisamhs) {
						$kapasitasx = $sisamhs;
						$current_kap_sisa -= $sisamhs;
						$sisamhs = 0;
					} elseif ($current_kap_sisa < $sisamhs) {
						$kapasitasx = $current_kap_sisa;
						$sisamhs -= $current_kap_sisa;
						$current_kap_sisa = 0;
					} elseif ($current_kap_sisa == $sisamhs) {
						$kapasitasx = $sisamhs;
						$current_kap_sisa = 0;
						$sisamhs = 0;
					}

					$cmd = "SELECT max(jadwal_id) as jadwal_id from RefAkdJadwalUjian
						where ps_id = '$ps_id'
						and thn_akd = '$thn_akd'
						and session_id = '$session_id'
						and ujian_id = '$ujian_id'";
					$jadwal_id_max = $this->modelsManager->executeQuery($cmd)->toArray();
					$jadwal_id = $jadwal_id_max[0]['jadwal_id']+1;       

					$RefAkdJadwalUjian = new RefAkdJadwalUjian();
					$RefAkdJadwalUjian->assign(array(
					    'ps_id' => $ps_id,
					    'thn_akd' => $thn_akd,
					    'session_id' => $session_id,
					    'jadwal_id' => $jadwal_id,
					    'kode_mk' => $kode_mk,
					    'thn_kur' => $thn_kur,
					    'awal' => $jam_awal,
					    'akhir' => $jam_akhir,
					    'ujian_id' => $ujian_id,
					    'nama_kelas' => $nama_kelas,
					    'ruang_id' => $ruang_id,
					    'kapasitas' => $kapasitasx,
					    'conf_id' => $conf_id,
					    'st_gabung' => "Y"
					    )
					);
					$RefAkdJadwalUjian->save();
					
					echo "<pre>".print_r($cmd,1)."</pre>";
            	}

            }

        	$notif = array(
			    'title' => 'success',
			    'text' => "Jadwal Berhasil Di input",
			    'type' => 'success'
			);
			echo json_encode($notif);
		}

    }

}

