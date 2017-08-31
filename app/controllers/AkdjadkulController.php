<?php

use Phalcon\Mvc\View;
use Phalcon\Validation;
use Phalcon\Forms\Element\Text;
use Phalcon\Validation\Validator\Date;
use Phalcon\Validation\Validator\PresenceOf;
use Phalcon\Validation\Validator\Numericality;
class AkdjadkulController extends \Phalcon\Mvc\Controller
{

    public function initialize()
    {
      if (empty($this->session->get('uid'))) {
          $this->response->redirect('account/loginEnd');
      }
      $this->view->setRenderLevel(View::LEVEL_ACTION_VIEW);
      date_default_timezone_set('Asia/Jakarta');
    }

    public function jadkulmgAction()
    {
		$get_session = $this->session->get('ps_id');
		$explode = explode('-', $get_session);
		$ps_id = $explode[1];

		$q = "SELECT thn_akd,session_id,nama FROM RefAkdSession 
					where ps_id = '$ps_id' 
					order by thn_akd desc, session_id desc limit 5";
		$tahun_sesi = $this->modelsManager->executeQuery($q);


		$this->view->tahun_sesi = $tahun_sesi;
		$this->view->pick('akd_pra_sesi/jadkul/jadwal_kuliah');
    }

    public function listMkJadwalAction($value='')
    {
    	$get_session = $this->session->get('ps_id');
		$explode = explode('-', $get_session);
		$ps_id = $explode[1];

		$exp = explode('-', $_POST['sesi']);
		$thn_akd = $exp[0];
		$session_id = $exp[1];

		$q = "SELECT 
				  a.id,
				  b.thn_kur,
                  b.kode_mk,
                  b.nama,
				  a.thn_akd,
				  a.session_id,
                  b.semester,
                  a.nama_kelas,
                  a.kapasitas,
                  c.jam_awal,
                  b.sks,
(SELECT t.nama FROM RefAkdMkkpklDosen s LEFT JOIN RefAkdSdm t on s.nip=t.nip WHERE s.jenis= '1' and a.id=s.id_mkkpkl) as dosen
             from RefAkdMkkpkl a
             
             left join RefAkdMku b
             on a.kode_mk=b.kode_mk and a.thn_kur=b.thn_kur and a.ps_id=b.ps_id
             
             left join RefAkdJadkulmg c 
				on c.kode_mk=a.kode_mk and c.thn_kur=a.thn_kur and c.ps_id=a.ps_id and c.nama_kelas=a.nama_kelas and c.thn_akd=a.thn_akd and c.session_id=a.session_id
				
           		left join RefAkdRuang d
             on c.kode_mk=c.ruang_id and a.ps_id=d.ps_id
             
           where a.thn_akd = '$thn_akd'
             and a.session_id = '$session_id'
             and b.ps_id = '$ps_id'
             and b.thn_kur = b.thn_kur
           group by a.thn_kur,a.kode_mk,a.nama_kelas
           order by b.nama,b.thn_kur,b.kode_mk,a.nama_kelas,b.semester,b.urut";
		$mk = $this->modelsManager->executeQuery($q);

		$this->view->thn_akd = $thn_akd;
        $this->view->session_id = $session_id;
		$this->view->mk = $mk;
		$this->view->pick('akd_pra_sesi/jadkul/list_mk_jadwal');
    }

    public function lihatJadwalAction()
    {
    	// echo "<pre>".print_r($_POST['id_mkkpkl'],1)."</pre>";die();
      $get_session = $this->session->get('ps_id');
      $explode = explode('-', $get_session);
      $ps_id = $explode[1];
      $thn_akd = $_POST['thn_akd'];
      $session_id = $_POST['session_id'];
      $thn_kur = $_POST['thn_kur'];
      $nama_kelas = $_POST['nama_kelas'];
      $kode_mk = $_POST['kode_mk'];

        $this->view->thn_akd = $_POST['thn_akd'];
        $this->view->session_id = $_POST['session_id'];
        $this->view->thn_kur = $_POST['thn_kur'];
        $this->view->nama = $_POST['nama'];
        $this->view->kapasitas = $_POST['kapasitas'];
        $this->view->nama_kelas = $_POST['nama_kelas'];
        $this->view->kode_mk = $_POST['kode_mk'];
        $this->view->sks = $_POST['sks'];
        $this->view->id_mkkpkl = $_POST['id_mkkpkl'];
        $this->view->sem = $_POST['semester'];

        $id = $_POST['id_mkkpkl'];
        $q = "SELECT s.nip, concat(t.gelar_dpn,' ',t.nama,', ',t.gelar_blk) as nama FROM RefAkdMkkpklDosen s LEFT JOIN RefAkdSdm t on s.nip=t.nip WHERE s.id_mkkpkl='$id' order by jenis";
		    $dosen = $this->modelsManager->executeQuery($q);

		$cmd = "SELECT a.jadkul_id,
                  a.hari,
                  DATE_FORMAT(a.jam_awal, '%H:%i') as jam_awal,
                  DATE_FORMAT(a.jam_akhir, '%H:%i') as jam_akhir,
                  a.ruang_id,
                  a.id,
                  c.nama_ruang,
                  concat(y.gelar_dpn,' ',y.nama,', ',y.gelar_blk) as dosen
         from RefAkdJadkulmg a
        left join RefAkdRuang c
        on a.ruang_id=c.ruang_id and a.ps_id=c.ps_id
        left join RefAkdSdm y on y.nip = a.nip_dosen
             where a.thn_kur = '$thn_kur'
               and a.kode_mk = '$kode_mk'
               and a.thn_akd = '$thn_akd'
               and a.session_id = '$session_id'
               and a.ps_id = '$ps_id'
               and a.nama_kelas = '$nama_kelas'
          order by a.hari,a.jam_awal";
		$jadwal = $this->modelsManager->executeQuery($cmd);


		$qry = "SELECT max(id) as id_jadkul
         from RefAkdJadkulmg
             where thn_kur = '$thn_kur'
               and kode_mk = '$kode_mk'
               and thn_akd = '$thn_akd'
               and session_id = '$session_id'
               and ps_id = '$ps_id'
               and nama_kelas = '$nama_kelas'";
		$id_jadkul = $this->modelsManager->executeQuery($qry)->toArray();

		$q_ruang = "SELECT ruang_id, nama_ruang from RefAkdRuang where ps_id = '$ps_id' order by nama_ruang";
		$ruang = $this->modelsManager->executeQuery($q_ruang);

        $this->view->id_jadkul = $id_jadkul[0]['id_jadkul']+1;
        $this->view->ruang = $ruang;
        $this->view->dosen = $dosen;
        
        $this->view->jadwal = $jadwal;

        $query = "select a.thn_kur,
          a.kode_mk,
          c.ps_id,
          b.nama,
          a.thn_akd,
          a.session_id,
          a.nama_kelas,
          a.id,
          b.semester,
          b.sks,
          a.hari,
          DATE_FORMAT(a.jam_awal,'%H:%i') as jam_awal,
          DATE_FORMAT(a.jam_akhir,'%H:%i') as jam_akhir,
          a.ruang_id,
          (SELECT s.nip FROM RefAkdMkkpklDosen s WHERE s.jenis= '1' and c.id=s.id_mkkpkl) as nip1,
          (SELECT s.nip FROM RefAkdMkkpklDosen s WHERE s.jenis= '2' and c.id=s.id_mkkpkl) as nip2,
          (SELECT s.nip FROM RefAkdMkkpklDosen s WHERE s.jenis= '3' and c.id=s.id_mkkpkl) as nip3,
          (SELECT s.nip FROM RefAkdMkkpklDosen s WHERE s.jenis= '4' and c.id=s.id_mkkpkl) as nip4,
          (SELECT s.nip FROM RefAkdMkkpklDosen s WHERE s.jenis= '5' and c.id=s.id_mkkpkl) as nip5,
          (SELECT s.nip FROM RefAkdMkkpklDosen s WHERE s.jenis= '6' and c.id=s.id_mkkpkl) as nip6,
          (SELECT s.nip FROM RefAkdMkkpklDosen s WHERE s.jenis= '7' and c.id=s.id_mkkpkl) as nip7,
          (SELECT s.nip FROM RefAkdMkkpklDosen s WHERE s.jenis= '8' and c.id=s.id_mkkpkl) as nip8,
          (SELECT s.nip FROM RefAkdMkkpklDosen s WHERE s.jenis= '9' and c.id=s.id_mkkpkl) as nip9,

          (SELECT s.nip FROM RefAkdMkkpklDosen s WHERE s.jenis= '1' and c.id=s.id_mkkpkl) as nip_loop0,
          (SELECT s.nip FROM RefAkdMkkpklDosen s WHERE s.jenis= '2' and c.id=s.id_mkkpkl) as nip_loop1,
          (SELECT s.nip FROM RefAkdMkkpklDosen s WHERE s.jenis= '3' and c.id=s.id_mkkpkl) as nip_loop2,
          (SELECT s.nip FROM RefAkdMkkpklDosen s WHERE s.jenis= '4' and c.id=s.id_mkkpkl) as nip_loop3,
          (SELECT s.nip FROM RefAkdMkkpklDosen s WHERE s.jenis= '5' and c.id=s.id_mkkpkl) as nip_loop4,
          (SELECT s.nip FROM RefAkdMkkpklDosen s WHERE s.jenis= '6' and c.id=s.id_mkkpkl) as nip_loop5,
          (SELECT s.nip FROM RefAkdMkkpklDosen s WHERE s.jenis= '7' and c.id=s.id_mkkpkl) as nip_loop6,
          (SELECT s.nip FROM RefAkdMkkpklDosen s WHERE s.jenis= '8' and c.id=s.id_mkkpkl) as nip_loop7,
          (SELECT s.nip FROM RefAkdMkkpklDosen s WHERE s.jenis= '9' and c.id=s.id_mkkpkl) as nip_loop8,

  (SELECT t.nama FROM RefAkdMkkpklDosen s LEFT JOIN RefAkdSdm t on s.nip=t.nip WHERE s.jenis= '1' and c.id=s.id_mkkpkl) as namadosen1,
  (SELECT t.nama FROM RefAkdMkkpklDosen s LEFT JOIN RefAkdSdm t on s.nip=t.nip WHERE s.jenis= '2' and c.id=s.id_mkkpkl) as namadosen2,
  (SELECT t.nama FROM RefAkdMkkpklDosen s LEFT JOIN RefAkdSdm t on s.nip=t.nip WHERE s.jenis= '3' and c.id=s.id_mkkpkl) as namadosen3,
  (SELECT t.nama FROM RefAkdMkkpklDosen s LEFT JOIN RefAkdSdm t on s.nip=t.nip WHERE s.jenis= '4' and c.id=s.id_mkkpkl) as namadosen4,
  (SELECT t.nama FROM RefAkdMkkpklDosen s LEFT JOIN RefAkdSdm t on s.nip=t.nip WHERE s.jenis= '5' and c.id=s.id_mkkpkl) as namadosen5,
  (SELECT t.nama FROM RefAkdMkkpklDosen s LEFT JOIN RefAkdSdm t on s.nip=t.nip WHERE s.jenis= '6' and c.id=s.id_mkkpkl) as namadosen6,
  (SELECT t.nama FROM RefAkdMkkpklDosen s LEFT JOIN RefAkdSdm t on s.nip=t.nip WHERE s.jenis= '7' and c.id=s.id_mkkpkl) as namadosen7,
  (SELECT t.nama FROM RefAkdMkkpklDosen s LEFT JOIN RefAkdSdm t on s.nip=t.nip WHERE s.jenis= '8' and c.id=s.id_mkkpkl) as namadosen8,
  (SELECT t.nama FROM RefAkdMkkpklDosen s LEFT JOIN RefAkdSdm t on s.nip=t.nip WHERE s.jenis= '9' and c.id=s.id_mkkpkl) as namadosen9,

          r.shareps_id,
          r.shareruang_id,
          (SELECT t.nama from RefAkdSdm t WHERE t.nip=a.nip_dosen) as dosenajar
     from RefAkdJadkulmg a
     left join RefAkdMkkpkl c
on a.thn_kur=c.thn_kur and a.kode_mk=c.kode_mk and a.ps_id=c.ps_id and a.thn_akd=c.thn_akd and a.session_id=c.session_id and a.nama_kelas=c.nama_kelas

     left join RefAkdMku b
on a.thn_kur=b.thn_kur and a.kode_mk=b.kode_mk and a.ps_id=b.ps_id

     left join RefAkdRuang r
    on a.ps_id = r.ps_id and a.ruang_id = r.ruang_id
    where a.jam_awal is not null
          and a.jam_akhir is not null
          and a.thn_akd = '$thn_akd'
          and a.session_id = '$session_id'
    order by a.jam_awal,r.shareps_id,r.shareruang_id,a.ruang_id,a.hari";
    $kuliah_jadwal = $this->modelsManager->executeQuery($query)->toArray();
    // echo "<pre>".print_r($kuliah_jadwal,1)."</pre>";die();

	    $q = "select ifnull(b.ruang_id,a.ruang_id) as ruang_id,a.nama_ruang from RefAkdRuang a left join RefAkdRuang b on b.ruang_id = a.shareruang_id where a.ps_id = '$ps_id' order by a.nama_ruang";
	    $ruang_jadwal = $this->modelsManager->executeQuery($q)->toArray();

	    $q_nip = "select 
					(SELECT s.nip FROM RefAkdMkkpklDosen s WHERE s.jenis= '1' and c.id=s.id_mkkpkl) as nip0,
					(SELECT s.nip FROM RefAkdMkkpklDosen s WHERE s.jenis= '2' and c.id=s.id_mkkpkl) as nip1,
					(SELECT s.nip FROM RefAkdMkkpklDosen s WHERE s.jenis= '3' and c.id=s.id_mkkpkl) as nip2,
					(SELECT s.nip FROM RefAkdMkkpklDosen s WHERE s.jenis= '4' and c.id=s.id_mkkpkl) as nip3,
					(SELECT s.nip FROM RefAkdMkkpklDosen s WHERE s.jenis= '5' and c.id=s.id_mkkpkl) as nip4,
					(SELECT s.nip FROM RefAkdMkkpklDosen s WHERE s.jenis= '6' and c.id=s.id_mkkpkl) as nip5,
					(SELECT s.nip FROM RefAkdMkkpklDosen s WHERE s.jenis= '7' and c.id=s.id_mkkpkl) as nip6,
					(SELECT s.nip FROM RefAkdMkkpklDosen s WHERE s.jenis= '8' and c.id=s.id_mkkpkl) as nip7,
					(SELECT s.nip FROM RefAkdMkkpklDosen s WHERE s.jenis= '9' and c.id=s.id_mkkpkl) as nip8
	             from RefAkdMkkpkl c
	            where c.thn_akd = '$thn_akd'
	              and c.session_id = '$session_id'
	              and c.kode_mk = '$kode_mk'
	              and c.nama_kelas = '$nama_kelas'
	              and c.ps_id = '$ps_id'";
	    $nipx = $this->modelsManager->executeQuery($q_nip)->toArray();

	    for ($i=0; $i < 9; $i++) { 
	    	$nip_jadwal[$i] .= $nipx[0]["nip$i"];
	    }


	    $kuliah_jadwal_data = '';
    foreach ($kuliah_jadwal as $key => $value) {
			$thn_kur = $value['thn_kur']; 
			$kode_mk = $value['kode_mk']; 
			$ps_id = $value['ps_id']; 
			$nama_mk = $value['nama']; 
			$thn_akd = $value['thn_akd']; 
			$session_id = $value['session_id']; 
			$nama_kelas = $value['nama_kelas']; 
			$id = $value['id']; 
			$sem = $value['semester']; 
			$sks = $value['sks']; 
			$hari = $value['hari']; 
			$jam_awal = $value['jam_awal']; 
			$jam_akhir = $value['jam_akhir']; 
			$ruang_id = $value['ruang_id']; 
			$nip1 = $value['nip1']; 
			$nip2 = $value['nip2']; 
			$nip3 = $value['nip3']; 
			$nip4 = $value['nip4']; 
			$nip5 = $value['nip5']; 
			$nip6 = $value['nip6']; 
			$nip7 = $value['nip7']; 
			$nip8 = $value['nip8']; 
			$nip9 = $value['nip9']; 
			$namadosen1 = $value['namadosen1']; 
			$namadosen2 = $value['namadosen2']; 
			$namadosen3 = $value['namadosen3']; 
			$namadosen4 = $value['namadosen4']; 
			$namadosen5 = $value['namadosen5']; 
			$namadosen6 = $value['namadosen6']; 
			$namadosen7 = $value['namadosen7']; 
			$namadosen8 = $value['namadosen8']; 
			$namadosen9 = $value['namadosen9']; 
			$shareps_id = $value['shareps_id']; 
      $shareruang_id = $value['shareruang_id']; 
			$dosenajar = $value['dosenajar']; 

		if ($shareps_id == "" && $shareruang_id == "") {
			$kuliah_jadwal_data["$hari|$ruang_id"] .= "$ps_id|$thn_kur|$kode_mk|$thn_akd|$session_id|$nama_kelas|$id|$sem|$jam_awal|$jam_akhir|$ruang_id|$nip1|$nip2|$nip3|$nip4|$nip5|$nip6|$nip7|$nip8|$nip9|$nama_mk|$namadosen1|$namadosen2|$namadosen3|$namadosen4|$namadosen5|$namadosen6|$namadosen7|$namadosen8|$namadosen9|$dosenajar;";
		} else {
			$kuliah_jadwal_data["$hari|$shareruang_id"] .= "$ps_id|$thn_kur|$kode_mk|$thn_akd|$session_id|$nama_kelas|$id|$sem|$jam_awal|$jam_akhir|$ruang_id|$nip1|$nip2|$nip3|$nip4|$nip5|$nip6|$nip7|$nip8|$nip9|$nama_mk|$namadosen1|$namadosen2|$namadosen3|$namadosen4|$namadosen5|$namadosen6|$namadosen7|$namadosen8|$namadosen9|$dosenajar;";
		}
    }

	$ruang_string = '';
    foreach ($ruang_jadwal as $key => $value) {
    	$ruang_string .= $value['ruang_id']."|".$value['nama_ruang'].";";
    }
    $ruang_jadwal_data = substr($ruang_string,0,-1);
    // echo "<pre>".print_r($kuliah_jadwal,1)."</pre>";die();
    // echo "<pre>".print_r($ruang_jadwal_data,1)."</pre>";
    // echo "<pre>".print_r($nip_jadwal,1)."</pre>";die();

	    $this->view->kuliah_jadwal_data = $kuliah_jadwal_data;
	    $this->view->ruang_jadwal_data = $ruang_jadwal_data;
	    $this->view->nip_jadwal = $nip_jadwal;

	    $this->view->kuliah_jadwal = $kuliah_jadwal;
	    $this->view->ruang_jadwal = $ruang_jadwal;



		$this->view->pick('akd_pra_sesi/jadkul/lihat_jadwal');
    }

    public function addJadkulAction()
    {

    	// echo "<pre>".print_r($_POST,1)."</pre>";die();
    	$get_session = $this->session->get('ps_id');
		$explode = explode('-', $get_session);
		$ps_id = $explode[1];

		$validation = new Phalcon\Validation(); 

        $validation->add('hari', new PresenceOf(array(
            'message' => 'harir tidak boleh kosong'
        )));
        $validation->add('ruang', new PresenceOf(array(
            'message' => 'ruang tidak boleh kosong'
        )));
        $validation->add('dosen', new PresenceOf(array(
            'message' => 'dosen tidak boleh kosong'
        )));
        $validation->add('awal', new PresenceOf(array(
            'message' => 'jam awal  tidak boleh kosong'
        )));
        $validation->add('akhir', new PresenceOf(array(
            'message' => 'jam akhir tidak boleh kosong'
        )));

         
        $messages = $validation->validate($_POST);
        $pesan = '';
        if (count($messages)) {
            foreach ($messages as $message) {
                $pesan .= "$message"."</br>";
            }
            $notif = array(
                'title' => 'warning',
                'text' => $pesan,
                'type' => 'warning'
            );
        }else{

        	// $jam_awal = date("H:i:s", strtotime($_POST['awal']));
        	// $jam_akhir = date("H:i:s", strtotime($_POST['akhir']));

             $jam_awal = str_replace(".",":",$_POST['awal']);
             $jam_akhir = str_replace(".",":",$_POST['akhir']);

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

             if($_POST['awal'] == '') {
                $jam_awal = "NULL";
             } else $jam_awal = "$jam_awal";
             if($_POST['akhir'] == '') {
                $jam_akhir = "NULL";
             } else $jam_akhir = "$jam_akhir";


            $thn_akd = $_POST['thn_akd'];
            $session_id = $_POST['session_id'];
            $thn_kur = $_POST['thn_kur'];
            $nama_kelas = $_POST['nama_kelas'];
            $kode_mk = $_POST['kode_mk'];
            $id = $_POST['id_jadkul'];
            $hari = $_POST['hari'];
            $ruang_id = $_POST['ruang'];
            $nip_dosen = $_POST['dosen'];

			////////////////////////////////////////
			// check tabrakan dengan jadwal lokal //
			////////////////////////////////////////
        	
        $cmd = "SELECT a.kode_mk,
                     b.thn_kur,
                     a.jam_awal,
                     a.jam_akhir,
                     a.ruang_id,
                     a.id,
                     a.nama_kelas,
                     b.nama
                from RefAkdJadkulmg a
                left join RefAkdMku b on a.kode_mk=b.kode_mk and a.thn_kur=b.thn_kur and a.ps_id=b.ps_id
           where a.thn_akd = '$thn_akd'
             and a.session_id = '$session_id'
             and a.ps_id = '$ps_id'
             and a.ps_id = '$ps_id'
             and a.hari = '$hari'
             and not (a.jam_awal >= '$jam_akhir' or a.jam_akhir <= '$jam_awal')
         and concat(a.ps_id,'-',a.thn_kur,'-',a.kode_mk,'-',a.nama_kelas,'-',a.id) != '$ps_id-$thn_kur-$kode_mk-$nama_kelas-$id'
         order by a.jam_awal";
         // echo "<pre>".print_r($cmd,1)."</pre>";
        $cek_local = $this->modelsManager->executeQuery($cmd)->toArray();
		

		$tabrakan = 0;
        $info = "";

        if (count($cek_local) > 0) {
        	foreach ($cek_local as $key => $value) {
        		if ($kode_mk == $value['kode_mk'] && $nama_kelas == $value['nama_kelas'] ) {
        			$tabrakan++;
					$info = "WAKTU TABRAKAN DENGAN : <br/>- Kelas ".$value['nama_kelas']."<br/>- Pelajaran :".$value['kode_mk'].' '.$value['nama'];
        		}
        		if ($ruang_id == $value['ruang_id']) {
        			$tabrakan++;
					$info = "WAKTU TABRAKAN DENGAN : <br/>- Kelas ".$value['nama_kelas']."<br/>- Pelajaran :".$value['kode_mk'].' '.$value['nama'];
        		}
        	}
        }

		///////////////////////////////////////////////////////
		// check tabrakan dengan jadwal non-lokal ngk di buat//
		//////////////////////////////////////////////////////

        $cmd = "SELECT shareruang_id,shareps_id,sharedb
                  from RefAkdRuang
                 where ps_id = '$ps_id'
                   and ruang_id = '$ruang_id'";
        $cek_share_ruang = $this->modelsManager->executeQuery($cmd)->toArray();


        if (count($cek_share_ruang > 0)) {
        	$shareruang_id = $cek_share_ruang[0]['shareruang_id'];
        	$shareps_id = $cek_share_ruang[0]['shareps_id'];
        	$sharedb = $cek_share_ruang[0]['sharedb'];
        	
     //    	$cmd = "SELECT a.kode_mk,
     //                    b.thn_kur,
     //                    a.jam_awal,
     //                    a.jam_akhir,
     //                    a.ruang_id,
     //                    a.id,
     //                    a.nama_kelas,
     //                    b.nama as nama_mk, c.nama
     //               from RefAkdJadkulmg a
     //               join RefAkdRuang d on d.shareps_id='10'
					// and d.shareruang_id='97' and d.ps_id=a.ps_id and d.ruang_id=a.ruang_id
     //               left join RefAkdMku b on b.kode_mk=a.kode_mk and b.thn_kur=a.thn_kur and b.ps_id=a.ps_id
     //               left join RefAkdPs c on c.id_ps=a.ps_id
     //          where a.thn_akd = '$thn_akd'
     //            and a.session_id = '$session_id'
     //            and a.hari = '$hari'
     //            and a.ruang_id = '$ruang_id'

     //            and not (a.jam_awal >= '$jam_akhir' or a.jam_akhir <= '$jam_awal')
     //        and concat(a.ps_id,'-',a.thn_kur,'-',a.kode_mk,'-',a.nama_kelas,'-',a.id) != '$ps_id-$thn_kur-$kode_mk-$nama_kelas-$id'
     //        order by a.jam_awal";

            $cmd = "SELECT a.kode_mk,
                        b.thn_kur,
                        a.jam_awal,
                        a.jam_akhir,
                        a.ruang_id,
                        a.id,
                        a.nama_kelas,
                        b.nama as nama_mk, c.nama
                   from RefAkdJadkulmg a
                   join RefAkdRuang d on d.shareps_id='10'
and d.shareruang_id='97' and d.ps_id=a.ps_id and d.ruang_id=a.ruang_id
                   left join RefAkdMku b on b.kode_mk=a.kode_mk and b.thn_kur=a.thn_kur and b.ps_id=a.ps_id
                   left join RefAkdPs c on c.id_ps=a.ps_id
              where a.thn_akd = '$thn_akd'
                and a.session_id = '$session_id'
                and a.hari = '$hari'
                and not (a.jam_awal >= '$jam_akhir' or a.jam_akhir <= '$jam_awal')
            and concat(a.ps_id,'-',a.thn_kur,'-',a.kode_mk,'-',a.nama_kelas,'-',a.id) != '$ps_id-$thn_kur-$kode_mk-$nama_kelas-$id'
            order by a.jam_awal";
            // echo "<pre>".print_r($cmd,1)."</pre>";die();
	        $cek_non_locel = $this->modelsManager->executeQuery($cmd)->toArray();
	        if (count($cek_non_locel) > 0) {
	        	foreach ($cek_non_locel as $key => $value) {
	        		$tabrakan++;
					$info = "non local WAKTU TABRAKAN DENGAN : <br/>- Kelas ".$value['nama_kelas']."<br/>- Pelajaran :".$value['kode_mk'].' '.$value['nama_mk']."<br/>- Program Studi :".$value['nama'];
	        	}
	        }

        }

	        if ($tabrakan > 0) {
	        	$notif = array(
	                'title' => 'GAGAL...!',
	                'text' => $info,
	                'type' => 'error'
	            );
	        }else{

	            $class = new RefAkdJadkulmg();
	            $class->assign(array(
	                        'ps_id' => $ps_id,
	                        'thn_akd' => $_POST['thn_akd'],
	                        'session_id' => $_POST['session_id'],
	                        'thn_kur' => $_POST['thn_kur'],
	                        'nama_kelas' => $_POST['nama_kelas'],
	                        'kode_mk' => $_POST['kode_mk'],
	                        'id' => $_POST['id_jadkul'],
	                        'hari' => $_POST['hari'],
	                        'jam_awal' => $jam_awal,
	                        'jam_akhir' => $jam_akhir,
	                        'ruang_id' => $_POST['ruang'],
	                        'nip_dosen' => $_POST['dosen'],
	                        )
	                    );

	            $class->save();
	            $notif = array(
	                'title' => 'success',
	                'text' => 'Data berhasil di Input',
	                'type' => 'success'
	            );
	        }
        }

        echo json_encode($notif);
    }

    public function gabungJadkulAction()
    {
    	$get_session = $this->session->get('ps_id');
		$explode = explode('-', $get_session);
		$ps_id = $explode[1];
    	$jam_awal = date("H:i:s", strtotime($_POST['awal']));
        $jam_akhir = date("H:i:s", strtotime($_POST['akhir']));

        $notif = array(
	                'title' => 'success',
	                'text' => 'Data berhasil di Input',
	                'type' => 'success'
	            );
        echo json_encode($notif);
    }

    public function deleteJadkulAction($id)
    {
    	$user = RefAkdJadkulmg::findFirst($id);
    	$user->delete();
    	echo json_encode(array("status" => true));
    }

    public function editJadkulAction()
    {
    	// echo "<pre>".print_r($_POST,1)."</pre>";die();
    	$get_session = $this->session->get('ps_id');
		$explode = explode('-', $get_session);
		$ps_id = $explode[1];


        $id_jadkul = $_POST['id_jadkul'];
		$qry = "SELECT * from RefAkdJadkulmg where jadkul_id = '$id_jadkul'";
		$jadwal = $this->modelsManager->executeQuery($qry);

		$q_ruang = "SELECT ruang_id, nama_ruang from RefAkdRuang where ps_id = '$ps_id' order by nama_ruang";
		$ruang = $this->modelsManager->executeQuery($q_ruang);

        $id_mkkpkl = $_POST['id_mkkpkl'];
        $q = "SELECT s.nip, concat(t.gelar_dpn,' ',t.nama,', ',t.gelar_blk) as nama FROM RefAkdMkkpklDosen s LEFT JOIN RefAkdSdm t on s.nip=t.nip WHERE s.id_mkkpkl='$id_mkkpkl' order by jenis";
		$dosen = $this->modelsManager->executeQuery($q);

    	$this->view->thn_akd = $_POST['thn_akd'];
        $this->view->session_id = $_POST['session_id'];
        $this->view->thn_kur = $_POST['thn_kur'];
        $this->view->nama = $_POST['nama'];
        $this->view->kapasitas = $_POST['kapasitas'];
        $this->view->nama_kelas = $_POST['nama_kelas'];
        $this->view->kode_mk = $_POST['kode_mk'];
        $this->view->sks = $_POST['sks'];
        $this->view->id = $_POST['id'];
        $this->view->id_mkkpkl = $_POST['id_mkkpkl'];
        $this->view->id_jadkul = $_POST['id_jadkul'];

        $this->view->awal = date("h:i A", strtotime($jadwal[0]->jam_awal));
        $this->view->akhir = date("h:i A", strtotime($jadwal[0]->jam_akhir));
        $this->view->jadwal = $jadwal;
        $this->view->ruang = $ruang;
        $this->view->dosen = $dosen;

        $this->view->pick('akd_pra_sesi/jadkul/edit_jadkul');
    }

    public function submitEditJadkulAction($value='')
    {
    	// echo "<pre>".print_r($_POST,1)."</pre>";

    	$validation = new Phalcon\Validation(); 
		$validation->add('hari', new PresenceOf(array(
            'message' => 'harir tidak boleh kosong'
        )));
        $validation->add('ruang', new PresenceOf(array(
            'message' => 'ruang tidak boleh kosong'
        )));
        $validation->add('dosen', new PresenceOf(array(
            'message' => 'dosen tidak boleh kosong'
        )));
		 
		$messages = $validation->validate($_POST);
		$pesan = '';
		//jika gagal falidasi
		if (count($messages)) {
		    foreach ($messages as $message) {
		        $pesan .= "$message"."</br>";
		    }
			$notif = array(
				'title' => 'warning',
				'text' => $pesan,
				'type' => 'warning',
			);
		}else{
			$get_session = $this->session->get('ps_id');
			$explode = explode('-', $get_session);
			$ps_id = $explode[1];
			$jam_awal = date("H:i:s", strtotime($_POST['awal']));
	        $jam_akhir = date("H:i:s", strtotime($_POST['akhir']));
	        $thn_akd = $_POST['thn_akd'];
            $session_id = $_POST['session_id'];
            $thn_kur = $_POST['thn_kur'];
            $nama_kelas = $_POST['nama_kelas'];
            $kode_mk = $_POST['kode_mk'];
            $hari = $_POST['hari'];
            $ruang_id = $_POST['ruang'];
            $id = $_POST['id'];

  //           $qry = "SELECT max(id) as id_jadkul
  //        from RefAkdJadkulmg
  //            where thn_kur = '$thn_kur'
  //              and kode_mk = '$kode_mk'
  //              and thn_akd = '$thn_akd'
  //              and session_id = '$session_id'
  //              and ps_id = '$ps_id'
  //              and nama_kelas = '$nama_kelas'";
		// $id_jadkul = $this->modelsManager->executeQuery($qry)->toArray();
  //       $id = $id_jadkul[0]['id_jadkul'];

        $cmd = "SELECT a.kode_mk,
                     a.thn_kur,
                     a.ps_id,
                     a.jam_awal,
                     a.jam_akhir,
                     a.ruang_id,
                     a.id,
                     a.nama_kelas,
                     b.nama
                from RefAkdJadkulmg a
                left join RefAkdMkkpkl c 
                on a.nama_kelas=c.nama_kelas and a.kode_mk=c.kode_mk and a.thn_kur=c.thn_kur and a.ps_id=c.ps_id 
                left join RefAkdMku b 
                  on a.kode_mk=b.kode_mk and a.thn_kur=b.thn_kur and a.ps_id=b.ps_id
           where a.thn_akd = '$thn_akd'
             and a.session_id = '$session_id'
             and a.ps_id = '$ps_id'
             and a.hari = '$hari'
             and not (a.jam_awal >= '$jam_akhir' or a.jam_akhir <= '$jam_awal')
      and concat(a.ps_id,'-',a.thn_kur,'-',a.kode_mk,'-',a.nama_kelas,'-',a.id) != '$ps_id-$thn_kur-$kode_mk-$nama_kelas-$id'
      order by a.jam_awal";


        $cek_local = $this->modelsManager->executeQuery($cmd)->toArray();		
      // echo "<pre>".print_r($cek_local,1)."</pre>";die();

		$tabrakan = 0;
        $info = "";

        if (count($cek_local) > 0) {
        	foreach ($cek_local as $key => $value) {
        		if ($kode_mk == $value['kode_mk'] && $nama_kelas == $value['nama_kelas'] && $ps_id == $value['ps_id'] && $thn_kur == $value['thn_kur'] ) {
        			$tabrakan++;
					$info = "WAKTU TABRAKAN DENGAN : <br/>- Kelas ".$value['nama_kelas']."<br/>- Pelajaran :".$value['kode_mk'].' '.$value['nama'];
        		}
        		if ($ruang_id == $value['ruang_id']) {
        			$tabrakan++;
					$info = "WAKTU TABRAKAN DENGAN : <br/>- Kelas ".$value['nama_kelas']."<br/>- Pelajaran :".$value['kode_mk'].' '.$value['nama'];
        		}
        	}
        }

		///////////////////////////////////////////////////////
		// check tabrakan dengan jadwal non-lokal ngk di buat//
		//////////////////////////////////////////////////////
        $cmd = "SELECT shareruang_id,shareps_id,sharedb
                  from RefAkdRuang
                 where ps_id = '$ps_id'
                   and ruang_id = '$ruang_id'";
        $cek_share_ruang = $this->modelsManager->executeQuery($cmd)->toArray();


        if (count($cek_share_ruang > 0)) {
        	$shareruang_id = $cek_share_ruang[0]['shareruang_id'];
        	$shareps_id = $cek_share_ruang[0]['shareps_id'];
        	$sharedb = $cek_share_ruang[0]['sharedb'];
        	
        	$cmd = "SELECT a.kode_mk,
                        b.thn_kur,
                        a.jam_awal,
                        a.jam_akhir,
                        a.ruang_id,
                        a.id,
                        a.nama_kelas,
                        b.nama as nama_mk, c.nama
                   from RefAkdJadkulmg a
                   join RefAkdRuang d on d.shareps_id='10'
and d.shareruang_id='97' and d.ps_id=a.ps_id and d.ruang_id=a.ruang_id
                   left join RefAkdMku b on b.kode_mk=a.kode_mk and b.thn_kur=a.thn_kur and b.ps_id=a.ps_id
                   left join RefAkdPs c on c.id_ps=a.ps_id
              where a.thn_akd = '$thn_akd'
                and a.session_id = '$session_id'
                and a.hari = '$hari'
                and not (a.jam_awal >= '$jam_akhir' or a.jam_akhir <= '$jam_awal')
            and concat(a.ps_id,'-',a.thn_kur,'-',a.kode_mk,'-',a.nama_kelas,'-',a.id) != '$ps_id-$thn_kur-$kode_mk-$nama_kelas-$id'
            order by a.jam_awal";
	        $cek_non_locel = $this->modelsManager->executeQuery($cmd)->toArray();
	        if (count($cek_non_locel) > 0) {
	        	foreach ($cek_non_locel as $key => $value) {
	        		$tabrakan++;
					$info = "non local WAKTU TABRAKAN DENGAN : <br/>- Kelas ".$value['nama_kelas']."<br/>- Pelajaran :".$value['kode_mk'].' '.$value['nama_mk']."<br/>- Program Studi :".$value['nama'];
	        	}
	        }

        }

		        if ($tabrakan > 0) {
		        	$notif = array(
		                'title' => 'GAGAL...!',
		                'text' => $info,
		                'type' => 'error'
		            );
		        }else{
		        
		        $idd = $_POST['id_jadkul'];
				$hari = $_POST['hari'];
				$ruang_id = $_POST['ruang'];
				$nip_dosen = $_POST['dosen'];


	            $cmd = "UPDATE RefAkdJadkulmg SET 
		                        hari = '$hari',
		                        jam_awal = '$jam_awal',
		                        jam_akhir = '$jam_akhir',
		                        ruang_id = '$ruang_id',
		                        nip_dosen = '$nip_dosen'
	                        WHERE jadkul_id = '$idd' ";
	        			$this->modelsManager->executeQuery($cmd);

				$notif = array(
					'title' => 'success',
					'text' => 'Data berhasil di Edit',
					'type' => 'success',
				);
			}
		}
		echo json_encode($notif);    
    }


}

