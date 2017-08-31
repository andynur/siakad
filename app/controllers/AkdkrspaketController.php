<?php

use Phalcon\Mvc\View;
use Phalcon\Validation;
use  Phalcon\Validation\Validator\PresenceOf;
use Phalcon\Mvc\Url;

class AkdkrspaketController extends \Phalcon\Mvc\Controller
{

    public function initialize()
    {
        if (empty($this->session->get('uid'))) {
            $this->response->redirect('account/loginEnd');
        }
    	$this->view->setRenderLevel(View::LEVEL_ACTION_VIEW);
    }

    public function dafarPaketAction($value='')
    {
    	$get_session = $this->session->get('ps_id');
		$explode = explode('-', $get_session);
		$ps_id = $explode[1];

		$q = "SELECT thn_akd,session_id,nama FROM RefAkdSession 
					where ps_id = '$ps_id' 
					order by thn_akd desc, session_id desc limit 5";
		$tahun_sesi = $this->modelsManager->executeQuery($q);

        $phql = "SELECT a.id,a.ps_id,a.paket_id,a.nama_paket,a.jml_mk,a.jml_sks, 
        		(SELECT COUNT(b.kode_mk) from RefAkdKrspaket b where b.paket_id=a.paket_id and b.ps_id=a.ps_id) as jumlah_mk,
        		(SELECT sum(c.sks) from RefAkdKrspaket c where c.paket_id=a.paket_id and c.ps_id=a.ps_id) as jumlah_sks 
        		from RefAkdKrspaketCt a";
        $paket_krs = $this->modelsManager->executeQuery($phql);
		
		$this->view->tahun_sesi = $tahun_sesi;
        $this->view->paket_krs = $paket_krs;
        $this->view->pick('akd_krs_paket/daftar_paket');
    }


    public function tambahPaketAction()
    {
    	$get_session = $this->session->get('ps_id');
		$explode = explode('-', $get_session);
		$ps_id = $explode[1];

		$cmd = "SELECT max(paket_id) as max_id from RefAkdKrspaketCt where ps_id = '$ps_id'";
      	$paket_no = $this->modelsManager->executeQuery($cmd);

    	$validation = new Phalcon\Validation(); 
        $validation->add('nama_paket', new PresenceOf(array(
            'nama_paket' => 'nama_paket tidak boleh kosong'
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
                'type' => 'warning',
            );
        }else{
            $RefAkdKrspaketCt = new RefAkdKrspaketCt();
	        $RefAkdKrspaketCt->assign(array(
	            'ps_id' => $ps_id,
	            'nama_paket' => $_POST['nama_paket'],
	            'paket_id' => $paket_no[0]['max_id']+1,
	            )
	        );
	        $RefAkdKrspaketCt->save();
            $notif = array(
                'title' => 'success',
                'text' => 'Data berhasil di input',
                'type' => 'success',
            );
        }

        echo json_encode($notif);
    }

    public function editPaketAction($id)
    {
        $validation = new Phalcon\Validation(); 
        $validation->add('nama', new PresenceOf(array(
            'nama' => 'nama tidak boleh kosong'
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
                'type' => 'warning',
            );
        }else{
            $RefAkdKrspaketCt = RefAkdKrspaketCt::findFirstById($id);
            $RefAkdKrspaketCt->assign(array(
                        'nama_paket' => $_POST['nama'],
                        )
                    );

            $RefAkdKrspaketCt->save();
            $notif = array(
                'title' => 'success',
                'text' => 'Data berhasil di input',
                'type' => 'success',
            );
        }

        echo json_encode($notif);
    }

    public function hapusPaketAction($id)
    {
        $del=RefAkdKrspaketCt::findById($id);
        $del->delete();
		echo json_encode(array('status' => true));
    }

///////////////////////////////////////////////////////////////?
////////////////////// MK PAKET ///////////////////////////////?
///////////////////////////////////////////////////////////////?

    public function listMkPaketAction()
    {
    	$get_session = $this->session->get('ps_id');
		$explode = explode('-', $get_session);
		$ps_id = $explode[1];

    	$id = $_POST['id'];
    	$paket_id = $_POST['paket_id'];

    	$cmd = "SELECT a.id,a.thn_kur,a.kode_mk,b.nama,b.semester,b.sks,a.nama_kelas from RefAkdKrspaket a 
		    	left join RefAkdMku b on a.ps_id = b.ps_id and a.thn_kur = b.thn_kur and a.kode_mk = b.kode_mk
		        where a.ps_id = '$ps_id' and a.paket_id = '$paket_id'";
        $mk = $this->modelsManager->executeQuery($cmd);

        $phql = "SELECT * from RefAkdKrspaketCt where id='$id' ";
        $paket = $this->modelsManager->executeQuery($phql);
        
        $this->view->id = $id;
        $this->view->paket_id = $paket_id;
        $this->view->mk = $mk;
        $this->view->paket = $paket;
        $this->view->pick('akd_krs_paket/list_mk_paket');
    }

    public function selectMKAction($paket_id)
    {
    	$get_session = $this->session->get('ps_id');
		$explode = explode('-', $get_session);
		$ps_id = $explode[1];

		$sql = "SELECT DISTINCT (thn_kur) AS thn_kur FROM RefAkdMku where ps_id = '$ps_id' ORDER BY thn_kur DESC";
		$tahun = $this->modelsManager->executeQuery($sql);
		
		$this->view->paket_id = $paket_id;
		$this->view->id = $_POST['id'];
		$this->view->tahun = $tahun;
        $this->view->pick('akd_krs_paket/tambah_mk_paket');
    }

    public function listMKAction($thn)
    {
    	$get_session = $this->session->get('ps_id');
		$explode = explode('-', $get_session);
		$ps_id = $explode[1];

    	$sql = "SELECT * FROM RefAkdMku where ps_id='$ps_id' and thn_kur = '$thn'  ";
      	$mk = $this->modelsManager->executeQuery($sql);

      	$this->view->mk = $mk;
      	$this->view->paket_id = $_POST['paket_id'];
        $this->view->pick('akd_krs_paket/list_mk_kur');
    }

    public function tambahMkPaketAction($value='')
    {
    	$get_session = $this->session->get('ps_id');
		$explode = explode('-', $get_session);
		$ps_id = $explode[1];

    	$nama_kelas = $_POST['nama_kelas'];
		$thn_kur = $_POST['thn_kur'];
		$kode_mk = $_POST['kode_mk'];
		$paket_id = $_POST['paket_id'];
		$sks = $_POST['sks'];

		$RefAkdKrspaket = new RefAkdKrspaket();
        $RefAkdKrspaket->assign(array(
            'ps_id' => $ps_id,
            'nama_kelas' => $nama_kelas,
            'thn_kur' => $thn_kur,
            'kode_mk' => $kode_mk,
            'paket_id' => $paket_id,
            'sks' => $sks,
            )
        );
        $RefAkdKrspaket->save();

        $notif = array(
            'title' => 'success',
            'text' => 'Data berhasil di input',
            'type' => 'success',
        );
        echo json_encode($notif);
    }

    public function editMkPaketAction($id)
    {

        $RefAkdKrspaket = RefAkdKrspaket::findFirstById($id);
        $RefAkdKrspaket->assign(array(
                    'nama_kelas' => $_POST['nama_kelas'],
                    )
                );

        $RefAkdKrspaket->save();
        $notif = array(
            'title' => 'success',
            'text' => 'Data berhasil di Edit',
            'type' => 'success',
        );     
        echo json_encode($notif);
    }

    public function delMkPaketAction()
    {
		foreach ($_POST as $key => $value) {
			$mk = explode('_', $key);

			if ($mk[0] == 'mk') {
				$pos = "mk_".$mk[1];
				$id = $_POST[$pos];
		        $del=RefAkdKrspaket::findById($id);
		        $del->delete();
			}
		}
		echo json_encode(array('status' => true));
    }

/////////////////////////////////////////////////////////////////
/////////////////// TRASFER TO KRS //////////////////////////////
/////////////////////////////////////////////////////////////////

    public function formSelectPaketAction()
    {
    	$get_session = $this->session->get('ps_id');
		$explode = explode('-', $get_session);
		$ps_id = $explode[1];

    	$sesi = explode('-', $_POST['sesi']);
    	$thn_akd = $sesi[0];
    	$session_id = $sesi[1];

    	$fungsi = new FungsiController();
    	$nama_sesi = $fungsi->nama_sesi($thn_akd,$session_id);

    	$phql = "SELECT a.id,a.ps_id,a.paket_id,a.nama_paket,a.jml_mk,a.jml_sks, 
        		(SELECT COUNT(b.kode_mk) from RefAkdKrspaket b where b.paket_id=a.paket_id and b.ps_id=a.ps_id) as jumlah_mk,
        		(SELECT sum(c.sks) from RefAkdKrspaket c where c.paket_id=a.paket_id and c.ps_id=a.ps_id) as jumlah_sks 
        		from RefAkdKrspaketCt a";
        $paket_krs = $this->modelsManager->executeQuery($phql);

        $cmd = "SELECT a.thn_kur,a.kode_mk,b.nama,b.semester,b.sks,a.nama_kelas from RefAkdMkkpkl a
        left join RefAkdMku b on a.ps_id=b.ps_id and a.thn_kur=b.thn_kur and a.kode_mk=b.kode_mk
        where a.ps_id = '$ps_id'
        and a.thn_akd = '$thn_akd'
        and a.session_id = '$session_id'
        ORDER BY b.semester,b.nama,a.nama_kelas";
        $mk = $this->modelsManager->executeQuery($cmd);

        $cmd = "SELECT distinct angkatan from RefAkdMhs where id_ps in ($ps_id) order by angkatan desc";
        $angkatan = $this->modelsManager->executeQuery($cmd);

    	$this->view->angkatan = $angkatan;
        $this->view->sesi = $_POST['sesi'];
        $this->view->mk = $mk;
        $this->view->paket_krs = $paket_krs;
        $this->view->nama_sesi = $nama_sesi;
        $this->view->pick('akd_krs_paket/transfer_krs/select_paket');
    }

/////////////////// TRASFER TO KRS PER PAKET ////////////////////
/////////////////////////////////////////////////////////////////

    public function selectMhsPaketAction()
    {
    	$get_session = $this->session->get('ps_id');
		$explode = explode('-', $get_session);
		$ps_id = $explode[1];

    	$sesi = explode('-', $_POST['sesi']);
    	$thn_akd = $sesi[0];
    	$session_id = $sesi[1];
    	$paket_id = $_POST['paket_id'];

    	$fungsi = new FungsiController();
    	$nama_sesi = $fungsi->nama_sesi($thn_akd,$session_id);

    	$cmd = "SELECT a.thn_kur, a.kode_mk, b.nama, a.nama_kelas, c.kode_mk FROM RefAkdKrspaket a 
	    	LEFT JOIN RefAkdMku b ON b.ps_id = a.ps_id AND b.thn_kur = a.thn_kur AND b.kode_mk = a.kode_mk
	    	LEFT JOIN RefAkdMkkpkl c ON c.ps_id = a.ps_id AND c.thn_kur = a.thn_kur AND c.kode_mk = a.kode_mk AND c.nama_kelas = a.nama_kelas AND c.thn_akd = '$thn_akd' AND c.session_id = '$session_id' 
	    	WHERE a.ps_id = '$ps_id' AND a.paket_id = '$paket_id'";	
	    $mk_paket = $this->modelsManager->executeQuery($cmd);

	    $cmd = "SELECT distinct angkatan from RefAkdMhs where id_ps in ($ps_id) order by angkatan desc";
        $angkatan = $this->modelsManager->executeQuery($cmd);

	    $this->view->sesi = $_POST['sesi'];
	    $this->view->paket_id = $_POST['paket_id'];
	    $this->view->nama_sesi = $nama_sesi;
	    $this->view->mk_paket = $mk_paket;
	    $this->view->angkatan = $angkatan;
        $this->view->pick('akd_krs_paket/transfer_krs/form_paket_cari_mhs');
    }

    public function cariMhsPaketAction($value='')
    {
    	$get_session = $this->session->get('ps_id');
		$explode = explode('-', $get_session);
		$ps_id = $explode[1];

		$sesi = explode('-', $_POST['sesi']);
    	$thn_akd = $sesi[0];
    	$session_id = $sesi[1];
		$fungsi = new FungsiController();
    	$nama_sesi = $fungsi->nama_sesi($thn_akd,$session_id);

		$nomhs = $_POST['nomhs'];
    	$range1 = $_POST['range1'];
    	$range2 = $_POST['range2'];
    	$angkatan = $_POST['angkatan'];

    	$paket_id = $_POST['paket_id'];
    	$nama_paket = $_POST['nama'];

    	if($range1 != '' && $range2 != '') {
	    	$angkatan_isset = ($angkatan != '') ? "and angkatan = '$angkatan'" : "";
		    $cmd = "select id_mhs,id_ps,angkatan,nama from RefAkdMhs
	                  where id_mhs >= '$range1'
	                    and id_mhs <= '$range2'
	                    and id_ps = '$ps_id'
	                    and id_status = 'A'
	                    $angkatan_isset
	                  order by id_mhs";
	      
	   } elseif ($nomhs != '') {
	      $angkatan_isset = ($angkatan != '') ? "and angkatan = '$angkatan'" : "";
	      $nomhs_array = explode("-",$nomhs);
	      $qarray = implode("','",$nomhs_array);
	      $cmd = "select id_mhs,id_ps,angkatan,nama from RefAkdMhs
	               where id_mhs in ('$qarray')
	                 and id_status = 'A'
	                 $angkatan_isset
	                 and id_ps = '$ps_id'";

	   } elseif ($angkatan != '') {
	      $cmd = "select id_mhs,id_ps,angkatan,nama from RefAkdMhs
	                  where angkatan = '$angkatan'
	                    and id_ps = '$ps_id'
	                    and id_status = 'A'
	                  order by id_mhs";

	   }
	   $mhs = $this->modelsManager->executeQuery($cmd);

	   $this->view->sesi = $_POST['sesi'];
	   $this->view->paket_id = $_POST['paket_id'];
	   $this->view->nama_paket = $nama_paket;

	   $this->view->nama_sesi = $nama_sesi;
	   $this->view->mhs = $mhs;
       $this->view->pick('akd_krs_paket/transfer_krs/list_mahasiswa_per_paket');
    }

    public function simpanKrsPaketAction($value='')
    {
    	// echo "<pre>".print_r($_POST,1)."</pre>";die();
    	$get_session = $this->session->get('ps_id');
		$explode = explode('-', $get_session);
		$ps_id = $explode[1];

		$sesi = explode('-', $_POST['sesi']);
    	$thn_akd = $sesi[0];
    	$session_id = $sesi[1];

    	$paket_id = $_POST['paket_id'];
    	$jml_mhs = $_POST['jml_mhs'];
    	
    	$cmd = "SELECT ps_id,thn_kur,kode_mk,nama_kelas,sks from RefAkdKrspaket where paket_id";
    	$mk_paket = $this->modelsManager->executeQuery($cmd)->toArray();

    	foreach ($mk_paket as $key => $value) {
    		for ($i=0; $i <= $jml_mhs; $i++) { 
	    		$nama_pos = "ck".$i;
	    		if (isset($_POST[$nama_pos])) {

	    			$mhs = explode('-', $_POST[$nama_pos]);
	    			$nomhs = $mhs[0];
	    			$psmhs_id = $mhs[1];

	    			$simpan = new RefAkdKrs();
					$simpan->assign(array(
						'nomhs'		=> $nomhs,
						'psmhs_id'	=> $psmhs_id,
						'ps_id'		=> $ps_id,
						'thn_akd'   => $thn_akd,
						'session_id'=> $session_id,
						'kode_mk'	=> $value['kode_mk'],
						'thn_kur'	=> $value['value'],
						'nama_kelas'		=> $value['nama_kelas'],
						'krs_ke'		=> 1,
						'sks'		=> $value['sks'],
					));
					$simpan->save();

					$simpan_krsol = new RefAkdKrsol();
					$simpan_krsol->assign(array(
						'nomhs'		=> $nomhs,
						'psmhs_id'	=> $psmhs_id,
						'ps_id'		=> $ps_id,
						'thn_akd'   => $thn_akd,
						'session_id'=> $session_id,
						'kode_mk'	=> $value['kode_mk'],
						'thn_kur'	=> $value['thn_kur'],
						'nama_kelas'		=> $value['nama_kelas'],
						'sks'		=> $value['sks'],
					));
					$simpan_krsol->save();

					$simpan_p_mhs = new RefAkdPresensiMhs();
					$simpan_p_mhs->assign(array(
						'nomhs'		=> $nomhs,
						'psmhs_id'	=> $psmhs_id,
						'ps_id'		=> $ps_id,
						'thn_akd'   => $thn_akd,
						'session_id'=> $session_id,
						'kode_mk'	=> $value['kode_mk'],
						'thn_kur'	=> $value['thn_kur'],
						'nama_kelas'		=> $value['nama_kelas'],
					));
					$simpan_p_mhs->save();
	    		}
	    	}
    	}
    	$notif = array(
            'title' => 'success',
            'text' => 'Data berhasil di input',
            'type' => 'success',
        );
        echo json_encode($notif);
    }

/////////////////// TRASFER TO KRS PER MATA KULIAH //////////////
/////////////////////////////////////////////////////////////////
    public function selectMhsAction($value='')
    {
    	$get_session = $this->session->get('ps_id');
		$explode = explode('-', $get_session);
		$ps_id = $explode[1];

		$sesi = explode('-', $_POST['sesi']);
    	$thn_akd = $sesi[0];
    	$session_id = $sesi[1];
		$fungsi = new FungsiController();
    	$nama_sesi = $fungsi->nama_sesi($thn_akd,$session_id);

		$nomhs = $_POST['nomhs'];
    	$range1 = $_POST['range1'];
    	$range2 = $_POST['range2'];
    	$angkatan = $_POST['angkatan'];

    	$kode_mk = $_POST['kode_mk'];
		$nama = $_POST['nama'];
		$nama_kelas = $_POST['nama_kelas'];
		$thn_kur = $_POST['thn_kur'];
		$sks = $_POST['sks'];
		$semester = $_POST['semester'];

    	if($range1 != '' && $range2 != '') {
	    	$angkatan_isset = ($angkatan != '') ? "and angkatan = '$angkatan'" : "";
		    $cmd = "select id_mhs,id_ps,angkatan,nama from RefAkdMhs
	                  where id_mhs >= '$range1'
	                    and id_mhs <= '$range2'
	                    and id_ps = '$ps_id'
	                    and id_status = 'A'
	                    $angkatan_isset
	                  order by id_mhs";
	      
	   } elseif ($nomhs != '') {
	      $angkatan_isset = ($angkatan != '') ? "and angkatan = '$angkatan'" : "";
	      $nomhs_array = explode("-",$nomhs);
	      $qarray = implode("','",$nomhs_array);
	      $cmd = "select id_mhs,id_ps,angkatan,nama from RefAkdMhs
	               where id_mhs in ('$qarray')
	                 and id_status = 'A'
	                 $angkatan_isset
	                 and id_ps = '$ps_id'";

	   } elseif ($angkatan != '') {
	      $cmd = "select id_mhs,id_ps,angkatan,nama from RefAkdMhs
	                  where angkatan = '$angkatan'
	                    and id_ps = '$ps_id'
	                    and id_status = 'A'
	                  order by id_mhs";

	   }
	   $mhs = $this->modelsManager->executeQuery($cmd);

	   $this->view->sesi = $_POST['sesi'];
	   $this->view->sks = $sks;
	   $this->view->semester = $semester;
	   $this->view->nama = $nama;
	   $this->view->kode_mk = $kode_mk;
	   $this->view->nama_kelas = $nama_kelas;
	   $this->view->thn_kur = $thn_kur;

	   $this->view->nama_sesi = $nama_sesi;
	   $this->view->mhs = $mhs;
       $this->view->pick('akd_krs_paket/transfer_krs/list_mahasiswa');
    }

    public function simpanKrsAction($value='')
    {    	
    	echo "<pre>".print_r($_POST,1)."</pre>";die();
    	$get_session = $this->session->get('ps_id');
		$explode = explode('-', $get_session);
		$ps_id = $explode[1];

    	$sesi = explode('-', $_POST['sesi']);
    	$thn_akd = $sesi[0];
    	$session_id = $sesi[1];

    	$jml_mhs = $_POST['jml_mhs'];
    	for ($i=0; $i <= $jml_mhs; $i++) { 
    		$nama_pos = "ck".$i;
    		if (isset($_POST[$nama_pos])) {

    			$mhs = explode('-', $_POST[$nama_pos]);
    			$nomhs = $mhs[0];
    			$psmhs_id = $mhs[1];

    			$simpan = new RefAkdKrs();
				$simpan->assign(array(
					'nomhs'		=> $nomhs,
					'psmhs_id'	=> $psmhs_id,
					'ps_id'		=> $ps_id,
					'thn_akd'   => $thn_akd,
					'session_id'=> $session_id,
					'kode_mk'	=> $_POST['kode_mk'],
					'thn_kur'	=> $_POST['thn_kur'],
					'nama_kelas'		=> $_POST['nama_kelas'],
					'krs_ke'		=> 1,
					'sks'		=> $_POST['sks'],
				));
				$simpan->save();

				$simpan_krsol = new RefAkdKrsol();
				$simpan_krsol->assign(array(
					'nomhs'		=> $nomhs,
					'psmhs_id'	=> $psmhs_id,
					'ps_id'		=> $ps_id,
					'thn_akd'   => $thn_akd,
					'session_id'=> $session_id,
					'kode_mk'	=> $_POST['kode_mk'],
					'thn_kur'	=> $_POST['thn_kur'],
					'nama_kelas'		=> $_POST['nama_kelas'],
					'sks'		=> $_POST['sks'],
				));
				$simpan_krsol->save();

				$simpan_p_mhs = new RefAkdPresensiMhs();
				$simpan_p_mhs->assign(array(
					'nomhs'		=> $nomhs,
					'psmhs_id'	=> $psmhs_id,
					'ps_id'		=> $ps_id,
					'thn_akd'   => $thn_akd,
					'session_id'=> $session_id,
					'kode_mk'	=> $_POST['kode_mk'],
					'thn_kur'	=> $_POST['thn_kur'],
					'nama_kelas'		=> $_POST['nama_kelas'],
				));
				$simpan_p_mhs->save();
    		}
    	}
    	$notif = array(
            'title' => 'success',
            'text' => 'Data berhasil di input',
            'type' => 'success',
        );
        echo json_encode($notif);
    }
}

