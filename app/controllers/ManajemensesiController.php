<?php

use Phalcon\Mvc\View;
use Phalcon\Validation;
use Phalcon\Forms\Element\Text;
use Phalcon\Validation\Validator\Date;
use Phalcon\Validation\Validator\PresenceOf;
use Phalcon\Validation\Validator\Numericality;

class ManajemensesiController extends \Phalcon\Mvc\Controller
{

    public function initialize()
    {
      if (empty($this->session->get('uid'))) {
          $this->response->redirect('account/loginEnd');
      }
      $this->view->setRenderLevel(View::LEVEL_ACTION_VIEW);
      date_default_timezone_set('Asia/Jakarta');
    }

    public function manSesiAction()
    {
		$get_session = $this->session->get('ps_id');
		$explode = explode('-', $get_session);
		$ps_id = $explode[1];

		$sql = "SELECT * FROM RefAkdSessionDef order by session_cd";
		$query = $this->modelsManager->executeQuery($sql);

		$sql2 = "SELECT ps_id,thn_akd,session_id,begin_dt,end_dt,nama FROM RefAkdSession 
				where ps_id = '$ps_id' order by thn_akd desc, session_id desc";
		$query2 = $this->modelsManager->executeQuery($sql2);

		$this->view->sesi = $query;
		$this->view->man_sesi = $query2;
		$this->view->pick('akd_pra_sesi/manajemen_sesi/manajemen_sesi');
    }

    public function delKrsAction($id)
    {
    	$del = "DELETE FROM RefAkdSessionOl WHERE id = '$id' ";
        $this->modelsManager->executeQuery($del);
    	echo json_encode(array("status" => true));
    }

    public function addSesiAction($value='')
    {
    	$validation = new Phalcon\Validation(); 
		$validation->add('thn_akd', new PresenceOf(array(
		    'message' => 'thn_akd tidak boleh kosong'
		)));
		$validation->add('session_id', new PresenceOf(array(
		    'message' => 'sesi tidak boleh kosong'
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

			list($thn_akd,$year1) = explode("/",$_POST['thn_akd']);
			$session_id = $_POST['session_id'];

			$sql = "SELECT session_id from RefAkdSession
			            where thn_akd = '$thn_akd'
			              and session_id = '$session_id'
			              and ps_id = '$ps_id'";
			$query = $this->modelsManager->executeQuery($sql)->toArray();
			// echo "<pre>".print_r(count($query),1)."</pre>";
			if (count($query) == 0) {	

				$this->db->execute("INSERT into ref_akd_session (thn_akd,session_id,nama,ps_id)
						         select '$thn_akd',session_cd,nama_session,'$ps_id'
						         from ref_akd_session_def where session_cd = '$session_id' ");


				// di aplikasi lama ada cek di table defaultps..
				// kalo ini aku langsungkan
				$class = new RefAkdCrossKrs();
	            $class->assign(array(
	                        'ps_id' => $ps_id,
	                        'thn_akd' => $thn_akd,
	                        'session_id' => $session_id,
	                        'ps_allow' => $ps_id
	                        )
	                    );

	            $class->save();
				$notif = array(
					'title' => 'success',
	                'text' => 'Data berhasil di input',
	                'type' => 'success',
				);
			} else {
				$notif = array(
					'title' => 'warning',
	                'text' => 'Data Sudah ada di database',
	                'type' => 'warning',
				);
			}								
		}
		echo json_encode($notif);
    }

    public function viewSessionAction()
    {
		$get_session = $this->session->get('ps_id');
		$explode = explode('-', $get_session);
		$ps_id = $explode[1];

		$thn_akd = $_POST['thn_akd'];
		$session_id = $_POST['session_id'];

		$sql = "SELECT * FROM RefAkdSession where thn_akd = '$thn_akd' and session_id = '$session_id' and ps_id = '$ps_id' ";
		$query = $this->modelsManager->executeQuery($sql);

		$q = "SELECT thn_akd,session_id,nama FROM RefAkdSession 
					where ps_id = '$ps_id' 
					order by thn_akd desc, session_id desc limit 5";
		$tahun_sesi = $this->modelsManager->executeQuery($q);

		$cmd = "SELECT ol_id,nama_ol,
         date_format(olstart_dttm,'%H:%i %d-%m-%Y') as start,
         date_format(olstop_dttm,'%H:%i %d-%m-%Y') as akhir
        from RefAkdSessionOl
        where thn_akd = '$thn_akd'
           and session_id = '$session_id'
           and ps_id = '$ps_id'
         order by ol_id";
		$krs_ol = $this->modelsManager->executeQuery($cmd);

		$this->view->begin_dt = date("m/d/Y", strtotime($query[0]->begin_dt));
		$this->view->end_dt = date("m/d/Y", strtotime($query[0]->end_dt));
		$this->view->libcheck_dt = date("m/d/Y", strtotime($query[0]->libcheck_dt));
		$this->view->session = $query;
		$this->view->krs_ol = $krs_ol;
		$this->view->tahun_sesi = $tahun_sesi;

		$this->view->pick('akd_pra_sesi/manajemen_sesi/update_sesi');
    }

    public function UpdateSessionAction()
    {
    	// echo "<pre>".print_r($_POST,1)."</pre>";die();
    	$get_session = $this->session->get('ps_id');
		$explode = explode('-', $get_session);
		$ps_id = $explode[1];

    	$begin_dt = date("Y-m-d", strtotime($_POST['begin_dt']));
		$end_dt = date("Y-m-d", strtotime($_POST['end_dt']));
		$libcheck_dt = date("Y-m-d", strtotime($_POST['libcheck_dt']));

		$thn_akd = $_POST['thn_akd'];
		$session_id = $_POST['session_id'];
		$exp = explode('-', $_POST['p_session']);
		$pthn_akd = $exp[0];
		$psession_id = $exp[1];
		$ip_pin_krs = $_POST['ip_pin_krs'];

		if( isset($_POST['pin_krs_wali']) ){
			$pin_krs_wali = "Y";
		}else $pin_krs_wali = 'N' ;

		if( isset($_POST['max_sks_wali']) ){
			$max_sks_wali = "Y";
		}else $max_sks_wali = 'N' ;

		if( isset($_POST['ips_check']) ){
			$ips_check = "Y";
		}else $ips_check = 'N' ;

		if( isset($_POST['ipk_check']) ){
			$ipk_check = "Y";
		}else $ipk_check = 'N' ;

		if( isset($_POST['spp_check']) ){
			$spp_check = "Y";
		}else $spp_check = 'N' ;

		if( isset($_POST['blockkrs']) ){
			$blockkrs = "Y";
		}else $blockkrs = 'N' ;

		if( isset($_POST['libcheck']) ){
			$libcheck = "Y";
		}else $libcheck = 'N' ;

		if( isset($_POST['evaldosen_check']) ){
			$evaldosen_check = "Y";
		}else $evaldosen_check = 'N' ;

		$evaldosen = explode('-', $_POST['evaldosen_check_sesi']);
		$evaldosen_thn_akd = $evaldosen[0];
		$evaldosen_session_id = $evaldosen[1];

    	$exec = $this->db->execute("UPDATE ref_akd_session
            set begin_dt = '$begin_dt',
                end_dt = '$end_dt',
                pthn_akd = '$pthn_akd',
                psession_id = '$psession_id',
                libcheck = '$libcheck',
                libcheck_dt = '$libcheck_dt',
                ip_pin_krs = '$ip_pin_krs',
                pin_krs_wali = '$pin_krs_wali',
                max_sks_wali = '$max_sks_wali',
                ips_check = '$ips_check',
                ipk_check = '$ipk_check',
                spp_check = '$spp_check',
                blockkrs = '$blockkrs',
                evaldosen_check = '$evaldosen_check',
                evaldosen_thn_akd = '$evaldosen_thn_akd',
                evaldosen_session_id = '$evaldosen_session_id'
          where thn_akd = '$thn_akd'
            and session_id = '$session_id'
            and ps_id = '$ps_id'");
    	if ($exec == true) {
		    $notif = array(
				'title' => 'success',
		        'text' => 'Data Berhasil di Edit',
		        'type' => 'success',
			);
    	} else {
    		$notif = array(
				'title' => 'warning',
		        'text' => 'Data Gagal di edit',
		        'type' => 'warning',
			);
    	}    	
		echo json_encode($notif);
    }

////////////////////////////////////////////////////////////////
////////////////////// KRS ONLINE //////////////////////////////
////////////////////////////////////////////////////////////////
    public function krsOnlineAction()
    {
    	// echo "<pre>".print_r($_POST,1)."</pre>";die();
    	$get_session = $this->session->get('ps_id');
		$explode = explode('-', $get_session);
		$ps_id = $explode[1];

		$thn_akd = $_POST['thn_akd'];
		$session_id = $_POST['session_id'];
		$ol_id = $_POST['id'];

		$sql = "SELECT * FROM RefAkdSessionOl where thn_akd = '$thn_akd' and session_id = '$session_id' and ol_id = '$ol_id' and ps_id = '$ps_id' ";
		         // echo "<pre>".print_r($sql,1)."</pre>";die();

		$query = $this->modelsManager->executeQuery($sql);

		$this->view->start = date("m/d/Y", strtotime($query[0]->olstart_dttm));
		$this->view->start_time = date("h:i a", strtotime($query[0]->olstart_dttm));
		$this->view->end = date("m/d/Y", strtotime($query[0]->olstop_dttm));
		$this->view->end_time = date("h:i A", strtotime($query[0]->olstop_dttm));

		// echo "<pre>".print_r(date("h:i A", strtotime($query[0]->olstart_dttm)),1)."</pre>";die();

		$this->view->krs_ol = $query;
		$this->view->pick('akd_pra_sesi/krs_online/krs_online');
    }

    public function editKrsAction()
    {
    	// echo "<pre>".print_r($_POST,1)."</pre>";die();

    	if( isset($_POST['aktif']) ){
			$aktif = "Y";
		}else $aktif = 'N' ;
		if( isset($_POST['jatahfix']) ){
			$jatahfix = "Y";
		}else $jatahfix = 'N' ;
		if( isset($_POST['batalmk']) ){
			$batalmk = "Y";
		}else $batalmk = 'N' ;
		if( isset($_POST['pindahkls']) ){
			$pindahkls = "Y";
		}else $pindahkls = 'N' ;
		if( isset($_POST['gantimk']) ){
			$gantimk = "Y";
		}else $gantimk = 'N' ;
		if( isset($_POST['pinjaman']) ){
			$pinjaman = "Y";
		}else $pinjaman = 'N' ;

		$id = $_POST['id'];

		$start = date("Y-m-d", strtotime($_POST['start']));
		$start_time = date("H:i:s", strtotime($_POST['start_time']));
		$end = date("Y-m-d", strtotime($_POST['end']));
		$end_time = date("H:i:s", strtotime($_POST['end_time']));

		$thn_akd = $_POST['thn_akd'];
    	$session_id = $_POST['session_id'];

		$olstart_dttm = date("Y-m-d H:i:s", strtotime($start.' '.$start_time));
		$olstop_dttm = date("Y-m-d H:i:s", strtotime($end.' '.$end_time));
    	$nama_ol = $_POST['nama_ol'];
    	$mkmax = $_POST['mkmax'];
    	$sksmax = $_POST['sksmax'];
    	$mkbarumax = $_POST['mkbarumax'];
    	$mkulangmax = $_POST['mkulangmax'];
    	$sksbarumax = $_POST['sksbarumax'];
    	$sksulangmax = $_POST['sksulangmax'];
    	$mkpenalti = $_POST['mkpenalti'];
    	$skspenalti = $_POST['skspenalti'];
    	$npinjaman = $_POST['npinjaman'];

    	$exec = $this->db->execute("UPDATE ref_akd_session_ol
            set nama_ol = '$nama_ol',
                aktif = '$aktif',
                mkmax = '$mkmax',
                mkbarumax = '$mkbarumax',
                mkulangmax = '$mkulangmax',
                sksmax = '$sksmax',
                sksbarumax = '$sksbarumax',
                sksulangmax = '$sksulangmax',
                olstart_dttm = '$olstart_dttm',
                olstop_dttm = '$olstop_dttm',
                jatahfix = '$jatahfix',
                skspenalti = '$skspenalti',
                mkpenalti = '$mkpenalti',
                batalmk = '$batalmk',
                pindahkls = '$pindahkls',
                gantimk = '$gantimk',
                pinjaman = '$pinjaman',
                npinjaman = '$npinjaman'
          where id = '$id' ");
    	if ($exec == true) {
		    $notif = array(
				'title' => 'success',
		        'text' => 'Data Berhasil di Edit',
		        'type' => 'success',
			);
    	} else {
    		$notif = array(
				'title' => 'warning',
		        'text' => 'Data Gagal di edit',
		        'type' => 'warning',
			);
    	}    	
		echo json_encode($notif);
    }

    public function addKrsOnlineAction($value='')
    {
    	$get_session = $this->session->get('ps_id');
		$explode = explode('-', $get_session);
		$ps_id = $explode[1];

    	$thn_akd = $_POST['thn_akd'];
    	$session_id = $_POST['session_id'];

    	$cmd = "SELECT max(ol_id) as ol from RefAkdSessionOl where
				ps_id = '$ps_id' and thn_akd = '$thn_akd' and session_id = '$session_id'";
		$query = $this->modelsManager->executeQuery($cmd)->toArray();

		if (count($query) != 0) {
			$max_ol_id = $query[0]['ol']+1;
			$class = new RefAkdSessionOl();
            $class->assign(array(
                        'ps_id' => $ps_id,
                        'thn_akd' => $thn_akd,
                        'session_id' => $session_id,
                        'ol_id' => $max_ol_id,
                        'nama_ol' => 'Online '.$max_ol_id
                        )
                    );

            $class->save();
		} else {
			$max_ol_id = 1;
			$class->assign(array(
                        'ps_id' => $ps_id,
                        'thn_akd' => $thn_akd,
                        'session_id' => $session_id,
                        'ol_id' => $max_ol_id,
                        'nama_ol' => 'Online '.$max_ol_id
                        )
                    );
            $class->save();
		}		
		$notif = array(
		        'status' => true,
		        'id' => $max_ol_id
		);
		echo json_encode($notif);
    }
///////////////////////////////////////////////////////////////////////////
///////////////////////// KRS Lintas Program //////////////////////////////
///////////////////////////////////////////////////////////////////////////


    public function aktifKrsAction($value='')
    {
    	$get_session = $this->session->get('ps_id');
		$explode = explode('-', $get_session);
		$ps_id = $explode[1];

    	$thn_akd = $_POST['thn_akd'];
    	$session_id = $_POST['session_id'];

    	$cmd = "SELECT a.id_ps,a.nama,b.nama as jenjang,c.nama as jurusan,d.nama as fak FROM RefAkdPs a JOIN RefSysJenjang b on a.id_jenjang = b.id_jenjang join RefSysJurusan c on a.id_jurusan = c.id_jurusan JOIN RefSysFakultas d on a.id_fakultas = d.id_fakultas where a.id_aktif = 'Y'";
		$ps = $this->modelsManager->executeQuery($cmd)->toArray();

		$q = "SELECT ol_id,nama_ol
			 from RefAkdSessionOl
		where ps_id = '$ps_id'
		  and thn_akd = '$thn_akd'
		  and session_id = '$session_id'
		  order by ol_id";
		$krs_ol = $this->modelsManager->executeQuery($q)->toArray();
		foreach ($krs_ol as $key => $value) {
			$krs[$value['ol_id']] = $value['nama_ol'];
		}

		$qry = "SELECT ps_allow,ol_id,mhsprasyt
			 from RefAkdCrossKrs
		where ps_id = '$ps_id'
		  and thn_akd = '$thn_akd'
		  and session_id = '$session_id'";
		$cross = $this->modelsManager->executeQuery($qry)->toArray();
		// echo "<pre>".print_r($cross,1)."</pre>";die();

		$this->view->thn_akd = $thn_akd;
		$this->view->session_id = $session_id;
		$this->view->ps = $ps;
		$this->view->krs_ol = $krs;
		$this->view->cross = $cross;

		$this->view->pick('akd_pra_sesi/krs_ps/krs_ps');
    }

    public function simpanKrsPsAction()
    {
    	// echo "<pre>".print_r($_POST,1)."</pre>";die();
    	$get_session = $this->session->get('ps_id');
		$explode = explode('-', $get_session);
		$ps_id = $explode[1];

    	$thn_akd = $_POST['thn_akd'];
    	$session_id = $_POST['session_id'];

    	$del = "DELETE from RefAkdCrossKrs where ps_id = '$ps_id'
                  and thn_akd = '$thn_akd'
                  and session_id = '$session_id'";
		$this->modelsManager->executeQuery($del);

    	//PUSING REK...! Susah jelas,ne 
		for ($i=1; $i <= $_POST['jml_krs_ol'] ; $i++) { 
			// echo "<pre>".print_r($i,1)."</pre>";
	    	$cmd = "SELECT id_ps,nama FROM RefAkdPs WHERE id_aktif = 'Y'";
			$ps = $this->modelsManager->executeQuery($cmd)->toArray();
			foreach ($ps as $key => $value) {
				$ps = $value['id_ps'];
				$box = "cek_".$value['id_ps'].'-'.$i;
				$mhsprasyt = "mhsprasyt_".$value['id_ps'].'-'.$i;

				if( isset($_POST[$box]) ){
					$ol_id = $i;
					$mhsprasyt_dt = $_POST[$mhsprasyt];

					$class = new RefAkdCrossKrs();
		            $class->assign(array(
		                        'ps_id' => $ps_id,
		                        'thn_akd' => $thn_akd,
		                        'session_id' => $session_id,
		                        'ps_allow' => $ps,
		                        'ol_id' => $ol_id,
		                        'mhsprasyt' => $mhsprasyt_dt
		                        )
		                    );

		            $class->save();
					// echo "<pre>".print_r($box.$_POST[$box],1)."</pre>";
					// echo "<pre>".print_r($mhsprasyt.$_POST[$mhsprasyt],1)."</pre>";
				}	
			}
		}
		$notif = array(
		        'status' => true,
		);
		echo json_encode($notif);
    }

///////////////////////////////////////////////////////////////////////////
///////////////////////// RUANG AKTIF //////////////////////////////
///////////////////////////////////////////////////////////////////////////

	public function ruangAktifAction()
	{
		$get_session = $this->session->get('ps_id');
		$explode = explode('-', $get_session);
		$ps_id = $explode[1];

    	$thn_akd = $_POST['thn_akd'];
    	$session_id = $_POST['session_id'];

    	$cmd = "SELECT ruang_id,nama_ruang,shareps_id,sharedb
			        from RefAkdRuang where ps_id = '$ps_id'
			        order by nama_ruang";
        $ruang = $this->modelsManager->executeQuery($cmd);

        $qry = "SELECT ruang_id	 from RefAkdRuangAktif where ps_id = '$ps_id'
				     and thn_akd = '$thn_akd'
			        and session_id = '$session_id'";
        $r_aktif = $this->modelsManager->executeQuery($qry)->toArray();
        $data_ruang_aktif = [];
        foreach ($r_aktif as $key => $value) {
        	$data_ruang_aktif[] = $value['ruang_id'];
        }

        $this->view->thn_akd = $thn_akd;
        $this->view->session_id = $session_id;
        $this->view->ruang = $ruang;
        $this->view->r_aktif = $data_ruang_aktif;
		$this->view->pick('akd_pra_sesi/sesi_menu/ruang_aktif');
	}

	public function addRuangAktifAction()
	{
		$get_session = $this->session->get('ps_id');
		$explode = explode('-', $get_session);
		$ps_id = $explode[1];

    	$thn_akd = $_POST['thn_akd'];
    	$session_id = $_POST['session_id'];

		$del = "DELETE from RefAkdRuangAktif where ps_id = '$ps_id'
           and session_id = '$session_id'
           and thn_akd = '$thn_akd'";
        $this->modelsManager->executeQuery($del);

		foreach ($_POST as $key => $value) {
			$ruang_id = explode('_', $key);

			if ($ruang_id[0] == 'ruang') {
				$class = new RefAkdRuangAktif();
	            $class->assign(array(
	                'ps_id' => $ps_id,
	                'thn_akd' => $thn_akd,
	                'session_id' => $session_id,
	                'ruang_id' => $ruang_id[1]
	                )
	            );
	            $class->save();
			}
		}
		echo json_encode(array('status' => true));
	}

///////////////////////////////////////////////////////////////////////////
///////////////////////// DOSEN AKTIF //////////////////////////////
///////////////////////////////////////////////////////////////////////////

	public function dosenAktifAction()
	{
		$get_session = $this->session->get('ps_id');
		$explode = explode('-', $get_session);
		$ps_id = $explode[1];

    	$thn_akd = $_POST['thn_akd'];
    	$session_id = $_POST['session_id'];

    	$cmd = "SELECT a.nip,concat(a.gelar_dpn,' ',a.nama,', ',a.gelar_blk) as nama from RefAkdSdm a
					where a.kelp = 'DOSEN'
					order by a.nama";
        $sdm = $this->modelsManager->executeQuery($cmd);

        $qry = "SELECT nip from RefAkdSdmAktif where ps_id = '$ps_id'";
        $s_aktif = $this->modelsManager->executeQuery($qry)->toArray();

        $data_sdm_aktif = [];
        foreach ($s_aktif as $key => $value) {
        	$data_sdm_aktif[] = $value['nip'];
        }

        $this->view->thn_akd = $thn_akd;
        $this->view->session_id = $session_id;
        $this->view->sdm = $sdm;
        $this->view->s_aktif = $data_sdm_aktif;
		$this->view->pick('akd_pra_sesi/sesi_menu/dosen_aktif');
	}

	public function addSdmAktifAction()
	{
		$get_session = $this->session->get('ps_id');
		$explode = explode('-', $get_session);
		$ps_id = $explode[1];

    	$thn_akd = $_POST['thn_akd'];
    	$session_id = $_POST['session_id'];

		$del = "DELETE from RefAkdSdmAktif where ps_id = '$ps_id' ";
        $this->modelsManager->executeQuery($del);

		foreach ($_POST as $key => $value) {
			$dosen = explode('_', $key);

			if ($dosen[0] == 'dosen') {
				$class = new RefAkdSdmAktif();
	            $class->assign(array(
	                'ps_id' => $ps_id,
	                'nip' => $dosen[1]
	                )
	            );
	            $class->save();
			}
		}
		echo json_encode(array('status' => true));
	}

///////////////////////////////////////////////////////////////////////////
/////////////////////////////// KELAS WIZARD //////////////////////////////
///////////////////////////////////////////////////////////////////////////

	public function kelasWizardAction()
	{
		$get_session = $this->session->get('ps_id');
		$explode = explode('-', $get_session);
		$ps_id = $explode[1];

    	$thn_akd = $_POST['thn_akd'];
    	$session_id = $_POST['session_id'];

    	$cmd = "SELECT distinct thn_kur from RefAkdMku where ps_id = '$ps_id' order by thn_kur desc";
        $thn = $this->modelsManager->executeQuery($cmd);

        $q = "SELECT b.thn_kur,
               b.kode_mk,
               a.nama,
               b.nama_kelas
				from RefAkdMkkpkl b left join RefAkdMku a
				on b.kode_mk = a.kode_mk and b.thn_kur = a.thn_kur and b.ps_id = a.ps_id 
				where b.thn_akd = '$thn_akd'
				      and b.session_id = '$session_id'
				      and b.thn_akd is not null 
				      and b.session_id is not null
				      and b.ps_id = '$ps_id'
				order by a.nama,a.thn_kur,a.urut,a.kode_mk,b.nama_kelas";
				// echo "<pre>".print_r($q,1)."</pre>";die();
        $mkkpkl = $this->modelsManager->executeQuery($q);

        $this->view->thn_akd = $thn_akd;
        $this->view->session_id = $session_id;
        $this->view->thn = $thn;
        $this->view->mkkpkl = $mkkpkl;
		$this->view->pick('akd_pra_sesi/kelas_wizard/kelas_wizard');
	}

	// list MK berdasarkan tahun yang di sellec untuk dijadikan MK yang di tawarkan
	public function selectKurAction($value='')
	{
		$get_session = $this->session->get('ps_id');
		$explode = explode('-', $get_session);
		$ps_id = $explode[1];

    	$thn_akd = $_POST['thn_akd'];
    	$session_id = $_POST['session_id'];

    	$thn_kur = $_POST['thn_kur'];

    	$cmd = "SELECT kode_mk,nama,semester,sks,jenis,kelompok from RefAkdMku where ps_id = '$ps_id' and thn_kur = '$thn_kur' order by nama,semester";
        $mk = $this->modelsManager->executeQuery($cmd);

    	$qry = "select a.kode_mk,
               a.nama,
               a.semester,
               a.sks,
               b.thn_akd,
               b.session_id
          from RefAkdMku a
          left join RefAkdMkstatus b 
               on a.kode_mk = b.kode_mk
               and b.ps_id = a.ps_id
               and b.thn_kur = a.thn_kur
               and b.thn_akd = '$thn_akd'
               and b.session_id = '$session_id'
         where a.thn_kur = '$thn_kur'
               and a.ps_id = '$ps_id'
         order by a.nama,a.semester,a.kode_mk";
        $mk_select = $this->modelsManager->executeQuery($qry);

        $q = "SELECT kode_mk,nama_kelas from RefAkdMkkpkl
               where ps_id = '$ps_id'
                 and thn_akd = '$thn_akd'
                 and session_id = '$session_id'
                 and thn_kur = '$thn_kur'
                 ";
        $cek_mkkpkl = $this->modelsManager->executeQuery($q)->toArray();
        $data_mk_aktif = [];
        foreach ($cek_mkkpkl as $key => $value) {
        	$data_mk_aktif[$value['kode_mk']][] = $value['nama_kelas'];
        }

        $this->view->thn_akd = $thn_akd;
        $this->view->session_id = $session_id;
        $this->view->thn_kur = $thn_kur;
        $this->view->mk = $mk;
        $this->view->cek_mkkpkl = $data_mk_aktif;
        $this->view->mk_select = $mk_select;
		$this->view->pick('akd_pra_sesi/kelas_wizard/select_mk');
	}

	public function simpanMkAction($value='')
	{
		// if (!isset($_POST['thn_kur'])) {
		// 	echo "terjadi kesalahan link.!";die();
		// }
		// echo "<pre>".print_r($_POST,1)."</pre>";

		$get_session = $this->session->get('ps_id');
		$explode = explode('-', $get_session);
		$ps_id = $explode[1];

    	$thn_akd = $_POST['thn_akd'];
    	$session_id = $_POST['session_id'];

    	$thn_kur = $_POST['thn_kur'];

		$cmd = "SELECT ps_allow from RefAkdCrossKrs
            where ps_id = '$ps_id'
              and thn_akd = '$thn_akd'
              and session_id = '$session_id'";

        $ps_allow = $this->modelsManager->executeQuery($cmd)->toArray();
        // echo "<pre>".print_r($ps_allow,1)."</pre>";die();

        		$del = "DELETE from RefAkdMkstatus 
    					where ps_id = '$ps_id' 
        				and thn_kur = '$thn_kur' 
        				and thn_akd = '$thn_akd' 
        				and session_id = '$session_id' ";

        		$this->modelsManager->executeQuery($del);

        		$del_mkkpkl = "DELETE from RefAkdMkkpkl 
        				where ps_id = '$ps_id' 
        				and thn_kur = '$thn_kur' 
        				and thn_akd = '$thn_akd' 
        				and session_id = '$session_id' ";

        		$this->modelsManager->executeQuery($del_mkkpkl);

        $expl = explode(',', $_POST['mk']);
    	foreach ($expl as $v) {

    		$mkstatus = new RefAkdMkstatus();
            $mkstatus->assign(array(
                'kode_mk' => $v,
                'thn_kur' => $thn_kur,
                'ps_id' => $ps_id,
                'thn_akd' => $thn_akd,
                'session_id' => $session_id
                )
            );
            $mkstatus->save();

            foreach (explode(',', $_POST['nama_'.$v]) as $nama_kelas) {
	            $mkkpkl = new RefAkdMkkpkl();
	            $mkkpkl->assign(array(
	                'nama_kelas' => $nama_kelas,
	                'kode_mk' => $v,
	                'thn_kur' => $thn_kur,
	                'ps_id' => $ps_id,
	                'thn_akd' => $thn_akd,
	                'session_id' => $session_id
	                )
	            );
	            $mkkpkl->save();
	        }
        }
	        
        foreach ($ps_allow as $key => $value) {

        	$allow_ps = $value['ps_allow'];

        		$del2 = "DELETE from RefAkdPsMkstatus 
        				where ps_id = '$ps_id' 
        				and thn_kur = '$thn_kur' 
        				and thn_akd = '$thn_akd' 
        				and ps_allow = '$allow_ps' 
        				and session_id = '$session_id' ";
        		$this->modelsManager->executeQuery($del2);

				$del_psmkkpkl = "DELETE from RefAkdPsMkkpkl 
        				where ps_id = '$ps_id' 
        				and thn_kur = '$thn_kur' 
        				and thn_akd = '$thn_akd' 
        				and ps_allow = '$allow_ps' 
        				and session_id = '$session_id' ";
        		$this->modelsManager->executeQuery($del_psmkkpkl);

        	foreach ($expl as $v) {
        		foreach (explode(',', $_POST['nama_'.$v]) as $nama_kelas) {

		            $ps_mkkpkl = new RefAkdPsMkkpkl();
		            $ps_mkkpkl->assign(array(
		              	'nama_kelas' => $nama_kelas,
		                'kode_mk' => $v,
		                'thn_kur' => $thn_kur,
		                'ps_id' => $ps_id,
		                'ps_allow' => $allow_ps,
		                'thn_akd' => $thn_akd,
		                'session_id' => $session_id
		                )
		            );
		            $ps_mkkpkl->save();
	            }

	            $ps_mkstatus = new RefAkdPsMkstatus();
	            $ps_mkstatus->assign(array(
	                'kode_mk' => $v,
	                'thn_kur' => $thn_kur,
	                'ps_id' => $ps_id,
	                'ps_allow' => $allow_ps,
	                'thn_akd' => $thn_akd,
	                'session_id' => $session_id
	                )
	            );
	            $ps_mkstatus->save();
        	}
        }
        echo json_encode(array('status' => true));
	}

///////////////////////////////////////////////////////////////////////////
////////////////////////////// PILIH MATA KULIAH //////////////////////////
///////////////////////////////////////////////////////////////////////////

	public function pilihMkAction($value='')
	{
		$get_session = $this->session->get('ps_id');
		$explode = explode('-', $get_session);
		$ps_id = $explode[1];

    	$thn_akd = $_POST['thn_akd'];
    	$session_id = $_POST['session_id'];

    	$cmd = "SELECT distinct thn_kur from RefAkdMku where ps_id = '$ps_id' order by thn_kur desc";
        $thn = $this->modelsManager->executeQuery($cmd);

        //cek Matakulaih
        $thn_array = $this->modelsManager->executeQuery($cmd)->toArray();
        if (count($thn_array) == 0) {
        	echo "Data Matakuliah Masih Kosong!";die();
        }

        if( isset($_POST['thn_kur']) ){
			$thn_kur = $_POST['thn_kur'];
		}else{
			$thn_kur = $thn[0]->thn_kur;
		}

        $q = "SELECT a.kode_mk,
               a.nama,
               a.semester,
               a.sks,
               b.thn_akd,
               b.session_id
          from RefAkdMku a
          left join RefAkdMkstatus b 
               on a.kode_mk = b.kode_mk
               and b.ps_id = a.ps_id
               and b.thn_kur = a.thn_kur
               and b.thn_akd = '$thn_akd'
               and b.session_id = '$session_id'
         where a.thn_kur = '$thn_kur'
               and a.ps_id = '$ps_id'
         order by a.nama,a.semester,a.kode_mk";
        $mk = $this->modelsManager->executeQuery($q);

        $this->view->thn_akd = $thn_akd;
        $this->view->session_id = $session_id;
        $this->view->thn_kur = $thn_kur;
    	$this->view->thn = $thn;
    	$this->view->mk = $mk;

		$this->view->pick('akd_pra_sesi/sesi_menu/pilih_mk');
	}
///////////////////////////////////////////////////////////////////////////
////////////////////////////// SET JML KLS ///////////////////////////////
///////////////////////////////////////////////////////////////////////////

	public function setKapasitasKelasAction()
	{
		$get_session = $this->session->get('ps_id');
		$explode = explode('-', $get_session);
		$ps_id = $explode[1];
    	$thn_akd = $_POST['thn_akd'];
    	$session_id = $_POST['session_id'];

		$q = "SELECT b.id, b.thn_kur,
               b.kode_mk,
               a.nama,
               b.nama_kelas,
               b.jml_mhs,
               b.kapasitas,
               b.thn_akd,
               b.session_id
			from RefAkdMkkpkl b left join RefAkdMku a
			on b.kode_mk=a.kode_mk and b.thn_kur=a.thn_kur and b.ps_id=a.ps_id
			where b.thn_akd = '$thn_akd'
			      and b.session_id = '$session_id'
			      and b.thn_akd is not null 
			      and b.session_id is not null
			      and b.ps_id = '$ps_id'
			order by a.nama,a.thn_kur,a.urut,a.kode_mk,b.nama_kelas";
        $mk = $this->modelsManager->executeQuery($q);
        // echo "<pre>".print_r($mk,1)."</pre>";
        $this->view->thn_akd = $thn_akd;
        $this->view->session_id = $session_id;
    	$this->view->mk = $mk;

		$this->view->pick('akd_pra_sesi/kelas_wizard/set_kapasitas_kls');
	}

	public function submitKapasitasAction($id)
	{
		//update kapasitas kelas baik nya pakai where nama_kls,thn_kur,kode_mk,thn_akd,session_ID
		//tapi disini aku menggunakan id..
		//nanti kalau error tinggal di ganti where,nya
		$get_session = $this->session->get('ps_id');
		$explode = explode('-', $get_session);
		$ps_id = $explode[1];

    	$kap = $_POST['kap'];
    	$jml_mhs = $_POST['jml_mhs'];

		$kapasitas = ($jml_mhs > $kap ? $jml_mhs : $kap);
    	$class = RefAkdMkkpkl::findFirstById($id);
        $class->assign(array(
                    'kapasitas' => $kapasitas
                    )
                );

        $class->save();

        $ps_mkkpkl = RefAkdPsMkkpkl::findFirstById($id);
        $ps_mkkpkl->assign(array(
                    'kapasitas' => $kapasitas
                    )
                );

        $ps_mkkpkl->save();

        $notif = array(
            'title' => 'success',
            'text' => 'Data berhasil di input',
            'type' => 'success',
        );
        echo json_encode($notif);
	}
///////////////////////////////////////////////////////////////////////////
///////////////////////// MHS Aktif-NonAktif //////////////////////////////
///////////////////////////////////////////////////////////////////////////

	public function setAktifMhsAction()
	{
		$get_session = $this->session->get('ps_id');
		$explode = explode('-', $get_session);
		$ps_id = $explode[1];
    	$thn_akd = $_POST['thn_akd'];
    	$session_id = $_POST['session_id'];

		$q = "SELECT b.id, b.thn_kur,
               b.kode_mk,
               a.nama,
               b.nama_kelas,
               b.prasyt_ang,
               b.thn_akd,
               b.session_id
			from RefAkdPsMkkpkl b left join RefAkdMku a
			on b.kode_mk=a.kode_mk and b.thn_kur=a.thn_kur and b.ps_id=a.ps_id
			where b.thn_akd = '$thn_akd'
			      and b.session_id = '$session_id'
			      and b.thn_akd is not null 
			      and b.session_id is not null
			      and b.ps_id = '$ps_id'
			order by a.nama,a.thn_kur,a.urut,a.kode_mk,b.nama_kelas";
        $mk = $this->modelsManager->executeQuery($q);
        // echo "<pre>".print_r($mk,1)."</pre>";
        $this->view->thn_akd = $thn_akd;
        $this->view->session_id = $session_id;
    	$this->view->mk = $mk;

		$this->view->pick('akd_pra_sesi/kelas_wizard/mhs_kelas');
	}

	public function submitAktifMhsAction($id)
	{
		$get_session = $this->session->get('ps_id');
		$explode = explode('-', $get_session);
		$ps_id = $explode[1];

    	$prasyt = $_POST['prasyt'];

        $ps_mkkpkl = RefAkdPsMkkpkl::findFirstById($id);
        $ps_mkkpkl->assign(array(
                    'prasyt_ang' => $prasyt
                    )
                );

        $ps_mkkpkl->save();

        $notif = array(
            'title' => 'success',
            'text' => 'Data berhasil di input',
            'type' => 'success',
        );
        echo json_encode($notif);
	}
///////////////////////////////////////////////////////////////////////////
////////////////////////////// SET JML KLS ///////////////////////////////
///////////////////////////////////////////////////////////////////////////

	public function setDosenAction()
	{
		$get_session = $this->session->get('ps_id');
		$explode = explode('-', $get_session);
		$ps_id = $explode[1];
    	$thn_akd = $_POST['thn_akd'];
    	$session_id = $_POST['session_id'];

		$q = "SELECT b.id, b.thn_kur,
               b.kode_mk,
               a.nama,
               b.nama_kelas,
               b.jml_mhs,
               a.sks,
               b.kapasitas,
               b.thn_akd,
               b.session_id,
               (select count(c.nip) from RefAkdMkkpklDosen c where c.nip <> '' and c.id_mkkpkl=b.id ) as jml_dosen
			from RefAkdMkkpkl b 
			left join RefAkdMku a on b.kode_mk=a.kode_mk and b.thn_kur=a.thn_kur and b.ps_id=a.ps_id
			where b.thn_akd = '$thn_akd'
			      and b.session_id = '$session_id'
			      and b.thn_akd is not null 
			      and b.session_id is not null
			      and b.ps_id = '$ps_id'
			order by a.nama,a.thn_kur,a.urut,a.kode_mk,b.nama_kelas";
        $mk = $this->modelsManager->executeQuery($q);
        // echo "<pre>".print_r($mk,1)."</pre>";die();
        $this->view->thn_akd = $thn_akd;
        $this->view->session_id = $session_id;
    	$this->view->mk = $mk;

		$this->view->pick('akd_pra_sesi/kelas_wizard/set_dosen_kls');
	}

	public function dosenPengajarAction()
	{
		$get_session = $this->session->get('ps_id');
		$explode = explode('-', $get_session);
		$ps_id = $explode[1];
    	$thn_akd = $_POST['thn_akd'];
    	$session_id = $_POST['session_id'];
    	$id = $_POST['id'];
    	$kode_mk = $_POST['kode_mk'];
    	$nama = $_POST['nama'];
    	$nama_kelas = $_POST['nama_kelas'];
    	$sks = $_POST['sks'];

		// echo "<pre>".print_r($_POST,1)."</pre>";die();
		$q = "SELECT * from RefAkdMkkpklDosen where id_mkkpkl='$id'	order by jenis";
        $dosen = $this->modelsManager->executeQuery($q)->toArray();
        $dsn = [];
        foreach ($dosen as $key => $value) {
        	$dsn[$value['jenis']] = array(
        		'id_mkkpkl' => $value['id_mkkpkl'], 
        		'nip' => $value['nip'], 
        		'sks' => $value['sks'], 
        		'aktif' => $value['aktif'], 
        		);
        }

		$cmd = "SELECT * from RefAkdSdm";
        $sdm = $this->modelsManager->executeQuery($cmd);

        $this->view->thn_akd = $thn_akd;
        $this->view->session_id = $session_id;
        $this->view->kode_mk = $kode_mk;
        $this->view->nama = $nama;
        $this->view->nama_kelas = $nama_kelas;
        $this->view->sks = $sks;
        $this->view->id = $id;

    	$this->view->dosen = $dsn;
    	$this->view->sdm = $sdm;

		$this->view->pick('akd_pra_sesi/kelas_wizard/dosen_pengajar');
	}

	public function addDosenAjarAction($value='')
	{
		// echo "<pre>".print_r($_POST,1)."</pre>";die();
		$id_mkkpkl = $_POST['id'];
		$cmd = "SELECT * from RefAkdMkkpklDosen where id_mkkpkl = '$id_mkkpkl' ";
        $cek_dosen = $this->modelsManager->executeQuery($cmd)->toArray();
		$aktif = explode(',', $_POST['jenis']);
		$jml_sks = '';

		for ($i=1; $i <= 9 ; $i++) { 
			$jml_sks += $_POST['sks_'.$i];
		}
		// echo "<pre>".print_r($jml_sks,1)."</pre>";die();
		if ($jml_sks > $_POST['sks']) {
			$notif = array(
	            'title' => 'warning',
	            'text' => 'SKS tidak boleh Melebihi SKS Matakuliah',
	            'type' => 'warning',
	        );
		}else{
	        if (count($cek_dosen) == 0) {

				for ($i=1; $i <= 9 ; $i++) { 

					//if ceckbox aktif value Y = colomb aktif
					if (in_array($i, $aktif)) {
						$class = new RefAkdMkkpklDosen();
	            		$class->assign(array(
	                        'id_mkkpkl' => $id_mkkpkl,
	                        'jenis' => $i,
	                        'nip' => $_POST['dosen_'.$i],
	                        'sks' => $_POST['sks_'.$i],
	                        'aktif' => 'Y'
	                        )
	                    );
	            		$class->save();
					} else {
						$class = new RefAkdMkkpklDosen();
	            		$class->assign(array(
	                        'id_mkkpkl' => $id_mkkpkl,
	                        'jenis' => $i,
	                        'nip' => $_POST['dosen_'.$i],
	                        'sks' => $_POST['sks_'.$i],
	                        'aktif' => 'N'
	                        )
	                    );
	            		$class->save();
					}	
				}
				$notif = array(
		            'title' => 'success',
		            'text' => 'Data berhasil di input',
		            'type' => 'success',
		        );

	        } else {
	        	for ($i=1; $i <= 9 ; $i++) { 
					//if ceckbox aktif value Y = colomb aktif
					$dosen = $_POST['dosen_'.$i];
					$sks = $_POST['sks_'.$i];
					$Y = 'Y';
					$N = 'N';

					if (in_array($i, $aktif)) {

						$cmd = "UPDATE RefAkdMkkpklDosen SET 
		                        nip = '$dosen',
		                        sks = '$sks',
		                        aktif = 'Y'
	                        WHERE id_mkkpkl = '$id_mkkpkl' and jenis = '$i' ";
	        			// echo "<pre>".print_r($cmd,1)."</pre>";
	        			$this->modelsManager->executeQuery($cmd);

					} else {
						$cmd = "UPDATE RefAkdMkkpklDosen SET 
		                        nip = '$dosen',
		                        sks = '$sks',
		                        aktif = 'N'
	                        WHERE id_mkkpkl = '$id_mkkpkl' and jenis = '$i' ";
	                    // echo "<pre>".print_r($cmd,1)."</pre>";
	                    $this->modelsManager->executeQuery($cmd);

					}	
				}
				$notif = array(
		            'title' => 'success',
		            'text' => 'Data berhasil di input',
		            'type' => 'success',
		        );
	        }			
		}	    
	    echo json_encode($notif);        
	}

///////////////////////////////////////////////////////////////////////////
///////////////////////// TRANSFER PESERTA KELAS //////////////////////////
///////////////////////////////////////////////////////////////////////////

	public function transferPesertaKelasAction($value='')
	{
		$get_session = $this->session->get('ps_id');
		$explode = explode('-', $get_session);
		$ps_id = $explode[1];
    	$thn_akd = $_POST['thn_akd'];
    	$session_id = $_POST['session_id'];

    	   $cmd = "SELECT a.thn_kur,
                  a.kode_mk,
                  b.nama,
                  b.semester,
                  b.sks,
                  a.nama_kelas,
                  a.jml_mhs,
(SELECT t.nama FROM RefAkdMkkpklDosen s LEFT JOIN RefAkdSdm t on s.nip=t.nip WHERE s.jenis= '1' and a.id=s.id_mkkpkl) as dosen
             from RefAkdMkkpkl a
             left join RefAkdMku b
             on a.kode_mk=b.kode_mk and a.thn_kur=b.thn_kur and a.ps_id=b.ps_id
             and a.session_id = '$session_id'
           where a.thn_akd = '$thn_akd'
             and a.ps_id = '$ps_id'
           group by a.thn_kur,a.kode_mk,a.nama_kelas
             order by b.nama,b.semester,b.kode_mk,a.nama_kelas,b.thn_kur";
        $mk = $this->modelsManager->executeQuery($cmd);
        // echo "<pre>".print_r($mk,1)."</pre>";die();

        $this->view->thn_akd = $thn_akd;
        $this->view->session_id = $session_id;
        $this->view->mk = $mk;

		$this->view->pick('akd_pra_sesi/transfer_peserta_kelas/transfer_peserta');
	}

///////////////////////////////////////////////////////////////////////////
///////////////////////// TRANSFER PESERTA KELAS //////////////////////////
///////////////////////////////////////////////////////////////////////////


	public function jadwalInputNilaiAction($value='')
	{
		$get_session = $this->session->get('ps_id');
		$explode = explode('-', $get_session);
		$ps_id = $explode[1];
    	$thn_akd = $_POST['thn_akd'];
    	$session_id = $_POST['session_id'];

    	   $cmd = "SELECT a.id,a.thn_kur,
                  a.kode_mk,
                  b.nama,
                  b.semester,
                  b.sks,
                  a.nama_kelas,
                  a.jml_mhs,
(SELECT t.nama FROM RefAkdMkkpklDosen s LEFT JOIN RefAkdSdm t on s.nip=t.nip WHERE s.jenis= '1' and a.id=s.id_mkkpkl) as dosen
             from RefAkdMkkpkl a
             left join RefAkdMku b
             on a.kode_mk=b.kode_mk and a.thn_kur=b.thn_kur and a.ps_id=b.ps_id
           where a.thn_akd = '$thn_akd'
             and a.session_id = '$session_id'
             and a.ps_id = '$ps_id'
           group by a.thn_kur,a.kode_mk,a.nama_kelas
             order by b.nama,b.semester,b.kode_mk,a.nama_kelas,b.thn_kur";
        $mk = $this->modelsManager->executeQuery($cmd);

        $q = "SELECT distinct inputnilai0,inputnilai1 from RefAkdMkkpkl
         where thn_akd = '$thn_akd'
           and session_id = '$session_id'
           and ps_id = '$ps_id'";
        $tgl_input_nilai = $this->modelsManager->executeQuery($q)->toArray();
        // echo "<pre>".print_r(date("h:i a", strtotime($tgl_input_nilai[0]['inputnilai0'])),1)."</pre>";die();

        if (count($tgl_input_nilai) == 1) {
        	$this->view->start = date("m/d/Y", strtotime($tgl_input_nilai[0]['inputnilai0']));
			$this->view->end = date("m/d/Y", strtotime($tgl_input_nilai[0]['inputnilai1']));
			$this->view->start_time = date("h:i A", strtotime($tgl_input_nilai[0]['inputnilai0']));
			$this->view->end_time = date("h:i A", strtotime($tgl_input_nilai[0]['inputnilai1']));
        } else {
	        $this->view->start = '';
			$this->view->end = '';
			$this->view->start_time = '';
			$this->view->end_time = '';
        }
        

        $this->view->thn_akd = $thn_akd;
        $this->view->session_id = $session_id;
        $this->view->mk = $mk;

		$this->view->pick('akd_pra_sesi/jadwal_input_nilai/jadwal_nilai');
	}

	public function resetJadwalAction()
	{
		$get_session = $this->session->get('ps_id');
		$explode = explode('-', $get_session);
		$ps_id = $explode[1];
    	$thn_akd = $_POST['thn_akd'];
    	$session_id = $_POST['session_id'];

    	$inputnilai0 = date("Y-m-d H:i:s", strtotime($_POST['start'].' '.$_POST['start_time']));
		$inputnilai1 = date("Y-m-d H:i:s", strtotime($_POST['end'].' '.$_POST['end_time']));

		$validation = new Phalcon\Validation(); 
        $validation->add('start', new PresenceOf(array(
            'message' => 'Reset Awal tidak boleh kosong'
        )));
        $validation->add('end', new PresenceOf(array(
            'message' => 'Reset Akhir Group tidak boleh kosong'
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
            $exec = $this->db->execute("UPDATE ref_akd_mkkpkl
            set inputnilai0 = '$inputnilai0',
                inputnilai1 = '$inputnilai1'
	          where thn_akd = '$thn_akd'
	             and session_id = '$session_id'
	             and ps_id = '$ps_id' ");
            $notif = array(
                'title' => 'success',
                'text' => 'Data berhasil di Input',
                'type' => 'success'
            );
        }

        echo json_encode($notif);
	}

	public function editJadwalAction($value='')
	{
		$get_session = $this->session->get('ps_id');
		$explode = explode('-', $get_session);
		$ps_id = $explode[1];
    	$thn_akd = $_POST['thn_akd'];
    	$session_id = $_POST['session_id'];
    	$id = $_POST['id'];
    	$kode_mk = $_POST['kode_mk'];
    	$nama = $_POST['nama'];

    	$cmd = "SELECT inputnilai0,inputnilai1 from RefAkdMkkpkl where id = '$id' ";
        $mk = $this->modelsManager->executeQuery($cmd)->toArray();

        $this->view->start = date("m/d/Y", strtotime($mk[0]['inputnilai0']));
		$this->view->end = date("m/d/Y", strtotime($mk[0]['inputnilai1']));
		$this->view->start_time = date("h:i A", strtotime($mk[0]['inputnilai0']));
		$this->view->end_time = date("h:i A", strtotime($mk[0]['inputnilai1']));
		$this->view->thn_akd = $thn_akd;
        $this->view->session_id = $session_id;
        $this->view->id = $id;
        $this->view->kode_mk = $kode_mk;
        $this->view->nama = $nama;

		$this->view->pick('akd_pra_sesi/jadwal_input_nilai/edit_jadwal');
	}

	public function submitEditJadwalAction($id)
	{
		$get_session = $this->session->get('ps_id');
		$explode = explode('-', $get_session);
		$ps_id = $explode[1];

    	$inputnilai0 = date("Y-m-d H:i:s", strtotime($_POST['start'].' '.$_POST['start_time']));
		$inputnilai1 = date("Y-m-d H:i:s", strtotime($_POST['end'].' '.$_POST['end_time']));

		$validation = new Phalcon\Validation(); 
        $validation->add('start', new PresenceOf(array(
            'message' => 'Reset Awal tidak boleh kosong'
        )));
        $validation->add('end', new PresenceOf(array(
            'message' => 'Reset Akhir Group tidak boleh kosong'
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
            $exec = $this->db->execute("UPDATE ref_akd_mkkpkl
            set inputnilai0 = '$inputnilai0',
                inputnilai1 = '$inputnilai1'
	          where id = '$id' ");
            $notif = array(
                'title' => 'success',
                'text' => 'Data berhasil di Input',
                'type' => 'success'
            );
        }

        echo json_encode($notif);
	}

///////////////////////////////////////////////////////////////////////////
///////////////////////////// DEFINISI UJIAN /////////////////////////////
///////////////////////////////////////////////////////////////////////////

	public function definisiUjianAction()
	{
		$get_session = $this->session->get('ps_id');
		$explode = explode('-', $get_session);
		$ps_id = $explode[1];
    	$thn_akd = $_POST['thn_akd'];
    	$session_id = $_POST['session_id'];

    	$cmd = "SELECT * from RefAkdDefujian where thn_akd = '$thn_akd' and session_id = '$session_id' and ps_id = '$ps_id' ";
        $definisi_ujian = $this->modelsManager->executeQuery($cmd);

        $count = $this->modelsManager->executeQuery($cmd)->toArray();

        $this->view->count_defujian = count($count);
        $this->view->thn_akd = $thn_akd;
        $this->view->session_id = $session_id;
        $this->view->definisi_ujian = $definisi_ujian;
		$this->view->pick('akd_pra_sesi/sesi_menu/definisi_ujian');
	}

	function addDefujianAction()
	{
		$get_session = $this->session->get('ps_id');
		$explode = explode('-', $get_session);
		$ps_id = $explode[1];

		$validation = new Phalcon\Validation(); 
        $validation->add('nama_panjang', new PresenceOf(array(
            'message' => 'nama_panjang tidak boleh kosong'
        )));
        $validation->add('nama_pendek', new PresenceOf(array(
            'message' => 'nama_pendek tidak boleh kosong'
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
            $class = new RefAkdDefujian();
            $class->assign(array(
                        'ps_id' => $ps_id,
                        'thn_akd' => $_POST['thn_akd'],
                        'session_id' => $_POST['session_id'],
                        'ujian_id' => $_POST['count_defujian']+1,
                        'nama_long' => $_POST['nama_panjang'],
                        'nama_sort' => $_POST['nama_pendek']
                        )
                    );

            $class->save();
            $notif = array(
                'title' => 'success',
                'text' => 'Data berhasil di Input',
                'type' => 'success'
            );
        }

        echo json_encode($notif);
	}
	public function deleteDefUjianAction($id)
    {
    	$user = RefAkdDefujian::findFirst($id);
    	$user->delete();
    	echo json_encode(array("status" => true));
    }
    public function editDefujianAction($id)
    {
    	$validation = new Phalcon\Validation(); 
		$validation->add('nama_panjang', new PresenceOf(array(
		    'message' => 'nama_panjang tidak boleh kosong'
		)));
		$validation->add('nama_pendek', new PresenceOf(array(
		    'message' => 'nama_pendek tidak boleh kosong'
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
			$acl = RefAkdDefujian::findFirstById($id);
            $acl->assign(array(
                        'nama_long' => $_POST['nama_panjang'],
                        'nama_sort' => $_POST['nama_pendek']
                        )
                    );

            $acl->save();
			$notif = array(
				'title' => 'success',
				'text' => 'Data berhasil di Edit',
				'type' => 'success',
			);
		}

		echo json_encode($notif);
    }


///////////////////////////////////////////////////////////////////////////
///////////////////////////// RUMUS SKS //////////////////////////////////
///////////////////////////////////////////////////////////////////////////
    public function rumusSksAction()
    {
    	$get_session = $this->session->get('ps_id');
		$explode = explode('-', $get_session);
		$ps_id = $explode[1];
    	$thn_akd = $_POST['thn_akd'];
    	$session_id = $_POST['session_id'];

    	$cmd = "SELECT * from RefAkdDefRangeIp where thn_akd = '$thn_akd' and session_id = '$session_id' and ps_id = '$ps_id' ";
        $ip = $this->modelsManager->executeQuery($cmd);

        $this->view->thn_akd = $thn_akd;
        $this->view->session_id = $session_id;
        $this->view->ip = $ip;
		$this->view->pick('akd_pra_sesi/sesi_menu/rumus_sks');
    }

    function addRumusSksAction()
	{
		$get_session = $this->session->get('ps_id');
		$explode = explode('-', $get_session);
		$ps_id = $explode[1];

		$validation = new Phalcon\Validation(); 
        $validation->add('jatah_sks', new PresenceOf(array(
            'message' => 'jatah_sks tidak boleh kosong'
        )));
        $validation->add('batas_bawah', new PresenceOf(array(
            'message' => 'batas_bawah tidak boleh kosong'
        )));
        $validation->add('batas_atas', new PresenceOf(array(
            'message' => 'batas_atas tidak boleh kosong'
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
            $class = new RefAkdDefRangeIp();
            $class->assign(array(
                        'ps_id' => $ps_id,
                        'thn_akd' => $_POST['thn_akd'],
                        'session_id' => $_POST['session_id'],
                        'jatahsks' => $_POST['jatah_sks'],
                        'vstart' => $_POST['batas_bawah'],
                        'vstop' => $_POST['batas_atas']
                        )
                    );

            $class->save();
            $notif = array(
                'title' => 'success',
                'text' => 'Data berhasil di Input',
                'type' => 'success'
            );
        }

        echo json_encode($notif);
	}
	public function deleteRumusSksAction($id)
    {
    	$user = RefAkdDefRangeIp::findFirst($id);
    	$user->delete();
    	echo json_encode(array("status" => true));
    }
    public function editRumusSksAction($id)
    {
    	$validation = new Phalcon\Validation(); 
		$validation->add('jatah_sks', new PresenceOf(array(
            'message' => 'jatah_sks tidak boleh kosong'
        )));
        $validation->add('batas_bawah', new PresenceOf(array(
            'message' => 'batas_bawah tidak boleh kosong'
        )));
        $validation->add('batas_atas', new PresenceOf(array(
            'message' => 'batas_atas tidak boleh kosong'
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
			$jatahsks = $_POST['jatah_sks'];
			$vstart = $_POST['batas_bawah'];
			$vstop = $_POST['batas_atas'];
			$exec = $this->db->execute("UPDATE ref_akd_def_range_ip
	            set jatahsks = '$jatahsks',
	                vstart = '$vstart',
	                vstop = '$vstop'
		          where def_id = '$id' ");

			$notif = array(
				'title' => 'success',
				'text' => 'Data berhasil di Edit',
				'type' => 'success',
			);
		}

		echo json_encode($notif);
    }
///////////////////////////////////////////////////////////////////////////
///////////////////////////// DAFTAR CEKAL //////////////////////////////////
///////////////////////////////////////////////////////////////////////////

    public function daftarCekalAction($value='')
    {
    	$get_session = $this->session->get('ps_id');
		$explode = explode('-', $get_session);
		$ps_id = $explode[1];
    	$thn_akd = $_POST['thn_akd'];
    	$session_id = $_POST['session_id'];

    	$cmd = "SELECT b.id,a.id_mhs, a.id_ps, a.nama, b.alasan from RefAkdMhs a 
	    		left join RefAkdDaftarCekal b 
	    		on a.id_mhs=b.nomhs and a.id_ps=b.psmhs_id 
	    		where b.ps_id = '$ps_id' and b.thn_akd = '$thn_akd' and b.session_id = '$session_id' order by a.id_mhs";
        $daftar_cekal = $this->modelsManager->executeQuery($cmd);

        $this->view->thn_akd = $thn_akd;
        $this->view->session_id = $session_id;
        $this->view->daftar_cekal = $daftar_cekal;
		$this->view->pick('akd_pra_sesi/sesi_menu/daftar_cekal');
    }

    function addDaftarCekalAction()
	{

		$get_session = $this->session->get('ps_id');
		$explode = explode('-', $get_session);
		$ps_id = $explode[1];

		$validation = new Phalcon\Validation(); 
        $validation->add('mhs', new PresenceOf(array(
            'message' => 'mhs tidak boleh kosong'
        )));
        $validation->add('alasan', new PresenceOf(array(
            'message' => 'Alasan tidak boleh kosong'
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
        	$exp = explode(',', $_POST['mhs']);
        	$id_mhs = "";
        	foreach ($exp as $v) {
        		$id_mhs .= "'$v',";
        	}
        	$nomhs = rtrim($id_mhs,",");
    		$cmd = "SELECT * from RefAkdMhs where id_mhs in ($nomhs) ";
    		$mhs = $this->modelsManager->executeQuery($cmd)->toArray();
    		if (count($mhs) == 0) {
    			$notif = array(
	                'title' => 'warning',
	                'text' => 'Nomor MHS salah, silahkan input dengan benar',
	                'type' => 'warning'
            	);
    		}else{
    			$cmd = "SELECT * from RefAkdDaftarCekal where nomhs in ($nomhs) ";
    			$cek = $this->modelsManager->executeQuery($cmd)->toArray();
    			if (count($cek) > 0) {
					$notif = array(
		                'title' => 'Duplicated',
		                'text' => 'Nomhs sudah pernah di input. silahkan di teliti dahulu',
		                'type' => 'warning'
		            );
    			}else{
		    		foreach ($mhs as $key => $value) {
			            $class = new RefAkdDaftarCekal();
			            $class->assign(array(
			                        'ps_id' => $ps_id,
			                        'thn_akd' => $_POST['thn_akd'],
			                        'session_id' => $_POST['session_id'],
			                        'nomhs' => $value['id_mhs'],
			                        'alasan' => $_POST['alasan'],
			                        'psmhs_id' => $value['id_ps']
			                        )
			                    );

			            $class->save();
		    		}
		            $notif = array(
		                'title' => 'success',
		                'text' => 'Data berhasil di Input',
		                'type' => 'success'
		            );
    			}
    		}

        }

        echo json_encode($notif);
	}
	public function deleteDaftarCekalAction()
    {
    	$exp = explode(',', $_POST['mhs']);
    	foreach ($exp as $value) {
	    	$user = RefAkdDaftarCekal::findFirst($value);
	    	$user->delete();
    	}
	    echo json_encode(array("status" => true));
    }
    public function editDaftarCekalAction($id)
    {
    	$validation = new Phalcon\Validation(); 
		$validation->add('jatah_sks', new PresenceOf(array(
            'message' => 'jatah_sks tidak boleh kosong'
        )));
        $validation->add('batas_bawah', new PresenceOf(array(
            'message' => 'batas_bawah tidak boleh kosong'
        )));
        $validation->add('batas_atas', new PresenceOf(array(
            'message' => 'batas_atas tidak boleh kosong'
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
			$jatahsks = $_POST['jatah_sks'];
			$vstart = $_POST['batas_bawah'];
			$vstop = $_POST['batas_atas'];
			$exec = $this->db->execute("UPDATE ref_akd_def_range_ip
	            set jatahsks = '$jatahsks',
	                vstart = '$vstart',
	                vstop = '$vstop'
		          where def_id = '$id' ");

			$notif = array(
				'title' => 'success',
				'text' => 'Data berhasil di Edit',
				'type' => 'success',
			);
		}

		echo json_encode($notif);
    }

}