<?php

use Phalcon\Mvc\View;
use Phalcon\Validation;
use Phalcon\Forms\Element\Text;
use Phalcon\Validation\Validator\Date;
use Phalcon\Validation\Validator\PresenceOf;
use Phalcon\Validation\Validator\Numericality;

class AkddosenwaliController extends \Phalcon\Mvc\Controller
{

	public function initialize()
    {
      if (empty($this->session->get('uid'))) {
          $this->response->redirect('account/loginEnd');
      }
      $this->view->setRenderLevel(View::LEVEL_ACTION_VIEW);
    }

    public function listDosenAction($value='')
    {
		$sql = "SELECT concat(a.nama,', ',a.gelar_blk) as nama,
				a.gelar_dpn,
				a.nip,
                  count(b.nomhs) as jml_mhs
				from RefAkdSdm a 
					left join RefAkdWaliMhs b
					on b.nip = a.nip
				where a.kelp = 'DOSEN'
				group by a.nip
				order by a.nama";
		$query = $this->modelsManager->executeQuery($sql);

		$this->view->dosen = $query;
		$this->view->pick('akd_akademik/dosen_wali/dosen_wali');
    }

    public function dosenWaliAction($nip)
    {
    	$get_session = $this->session->get('ps_id');
		$explode = explode('-', $get_session);
		$ps_id = $explode[1];

        $sql = "SELECT b.id,a.id_mhs, a.nama, a.angkatan, b.thn_akd, b.session_id from RefAkdMhs a 
			        left join RefAkdWaliMhs b 
			        	on b.nomhs = a.id_mhs 
			        	and b.psmhs_id = a.id_ps 
			        where b.nip = '$nip' 
			        	and b.psmhs_id = '$ps_id' 
			        	and b.aktif = 'Y' 
			        order by a.angkatan,a.id_mhs ";

		$aktif_y = $this->modelsManager->executeQuery($sql);

		$sqlN = "SELECT b.id,a.id_mhs, a.nama, a.angkatan, b.thn_akd, b.session_id from RefAkdMhs a 
			        left join RefAkdWaliMhs b 
			        	on b.nomhs = a.id_mhs 
			        	and b.psmhs_id = a.id_ps 
			        where b.nip = '$nip' 
			        	and b.psmhs_id = '$ps_id' 
			        	and b.aktif = 'N' 
			        order by a.angkatan,a.id_mhs ";

		$aktif_n = $this->modelsManager->executeQuery($sqlN);

		$this->view->nip = $nip;
		$this->view->mhs_aktif = $aktif_y;
		$this->view->mhs_not = $aktif_n;
		$this->view->pick('akd_akademik/dosen_wali/view_dosen_wali');
    }

    public function delMhsBimbinganAction()
    {
    	$explode = explode(',', $_POST['radio']);
    	foreach ($explode as $val) {
	    	$del = "DELETE FROM RefAkdWaliMhs WHERE id = '$val' ";
	        $this->modelsManager->executeQuery($del);
    	}
    	echo json_encode(array("status" => true));
    }

    public function cariMhsAction($nip)
    {
    	$get_session = $this->session->get('ps_id');
		$explode = explode('-', $get_session);
		$ps_id = $explode[1];

    	$radio = $_POST["radio"];
		$no_mhs = $_POST["no_mhs"];
		$range1 = $_POST["range1"];
		$range2 = $_POST["range2"];
		$angkatan = $_POST["angkatan"];


		if ($radio == "nomhs") {
			$where = "and a.id_mhs = '$no_mhs' ";
		} elseif($radio == "range") {
			$where = "and a.id_mhs >= '$range1' and a.id_mhs <= '$range2' ";
		}elseif ($radio == "angkatan") {
			//blm ada angakatan jadi blm di buat		
			$where = " and a.angkatan='$angkatan'";	
		}

		$q = "SELECT a.id_mhs,
						a.nama,
						a.angkatan,
						concat(c.nama,', ',c.gelar_blk) as nama_dsn,
						c.nip
		             from RefAkdMhs a
		        left join RefAkdWaliMhs b
		               on b.nomhs = a.id_mhs
		              and b.psmhs_id = a.id_ps
		        left join RefAkdSdm c
		               on c.nip = b.nip
		            where a.id_ps = '$ps_id' $where";
        $query = $this->modelsManager->executeQuery($q);

        $cmd = "SELECT distinct thn_akd,
	               session_id, nama
		          from RefAkdSession
		        where ps_id = '$ps_id'
        		order by thn_akd desc, session_id desc ";
        $session = $this->modelsManager->executeQuery($cmd);

		$this->view->mhs = $query;
		$this->view->nip = $nip;
		$this->view->session = $session;
		$this->view->pick('akd_akademik/dosen_wali/cari_mhs');
    }

    public function addMhsBimbinganAction($value='')
    {
    	// echo "<pre>".print_r(explode(',', $_POST['nomhs']),1)."</pre>";die();

    	$get_session = $this->session->get('ps_id');
		$explode = explode('-', $get_session);
		$ps_id = $explode[1];

    	$session = explode('-', $_POST['session']);
    	$nip = $_POST['nip'];

    	$explode = explode(',', $_POST['nomhs']);
    	foreach ($explode as $val) {
	    	$class = new RefAkdWaliMhs();
	        $class->assign(array(
                    'nomhs' => $val,
                    'psmhs_id' => $ps_id,
                    'nip' => $nip,
                    'thn_akd' => $session[0],
                    'session_id' => $session[1],
                )
            );

	        $class->save();
    	}
    	echo json_encode(array("status" => true));
    }

    public function nonAktifMhsAction()
    {
    	$explode = explode(',', $_POST['id']);
    	foreach ($explode as $val) {
	    	$update = "UPDATE RefAkdWaliMhs SET aktif = 'N' WHERE id = '$val' ";
	        $this->modelsManager->executeQuery($update);
    	}
    	echo json_encode(array("status" => true));
    }

    public function aktifMhsAction()
    {
    	$explode = explode(',', $_POST['id']);
    	foreach ($explode as $val) {
	    	$update = "UPDATE RefAkdWaliMhs SET aktif = 'Y' WHERE id = '$val' ";
	        $this->modelsManager->executeQuery($update);
    	}
    	echo json_encode(array("status" => true));
    }

}

