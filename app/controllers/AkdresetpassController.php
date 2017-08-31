<?php

use Phalcon\Mvc\View;
use Phalcon\Validation;
use  Phalcon\Validation\Validator\PresenceOf;
class AkdresetpassController extends \Phalcon\Mvc\Controller
{

    public function initialize()
    {
        if (empty($this->session->get('uid'))) {
            $this->response->redirect('account/loginEnd');
        }
        $this->view->setRenderLevel(View::LEVEL_ACTION_VIEW);
    }

    public function sdmPassAction()
    {
        $this->view->pick('akd_reset_pass/sdm');
    }

    public function cekAction()
    {
    	$pass = $_POST['pass'];
    	$nip = $this->session->get('nip');

    	$validation = new Phalcon\Validation(); 
		$validation->add('pass', new PresenceOf(array(
		    'message' => 'password tidak boleh kosong'
		)));
		 
		$messages = $validation->validate($_POST);
		$pesan = '';
		//jika gagal falidasi
		if (count($messages)) {
		    foreach ($messages as $message) {
		        $pesan .= "$message"."</br>";
		    }
			$notif = array(
				'status' => false
			);
		}else{
			 $user = RefUser::findFirst(
                [
                    "nip = :nip: AND passwd = :passwd: AND aktif = 'Y'",
                    "bind" => [
                        "nip"    => $nip,
                        "passwd" => md5($pass),
                    ]
                ]
            );			
			if ($user !== false) {
				$notif = array(
					'status' => true
				);
			}else{
				$notif = array(
					'status' => false
				);
			}
		}
		echo json_encode($notif);
    }

    public function listDosenAction()
    {
    	$phql = "SELECT a.nip,a.id_status,CONCAT(a.gelar_dpn, ' ',a.nama, ' ', a.gelar_blk) as namag, a.kelamin from RefAkdSdm AS a ORDER BY a.nama ASC";
        $sdm = $this->modelsManager->executeQuery($phql);
        $this->view->sdm = $sdm;
        $this->view->pick('akd_reset_pass/list_sdm');
    }

    public function rubahPassAction()
    {
    	$nip_yang_di_ganti = $_POST['nip_yang_di_ganti'];
    	$pass = $_POST['pass'];
    	$nip = $this->session->get('nip');

    	$validation = new Phalcon\Validation(); 
		$validation->add('pass', new PresenceOf(array(
		    'message' => 'password tidak boleh kosong',
		)));
		 
		$messages = $validation->validate($_POST);
		$pesan = '';
		//jika gagal falidasi
		if (count($messages)) {
		    foreach ($messages as $message) {
		        $pesan .= "$message"."</br>";
		    }
			$notif = array(
				'status' => false,
				'pass' => "false",
				'nip' => "qwe",
			);
		}else{
			$user = RefUser::findFirst(
                [
                    "nip = :nip: AND passwd = :passwd:",
                    "bind" => [
                        "nip"    => $nip,
                        "passwd" => md5($pass),
                    ]
                ]
            );			
			if ($user !== false) {
				$digits = 5;
				$rand = rand(pow(10, $digits-1), pow(10, $digits)-1);
				$pas = md5($rand);
				$this->db->execute("UPDATE ref_user SET `passwd`=? WHERE nip = ? ",array($pas,$nip_yang_di_ganti));
				//send respond
				$notif = array(
					'status' => true,
					'pass' => base64_encode($rand),
					'nip' => $nip_yang_di_ganti
				);

			}else{
				$notif = array(
					'status' => false,
					'pass' => "false",
					'nip' => "123",
				);
			}
		}
		echo json_encode($notif);
    }

    public function viewPassAction()
    {
    	$nip = $_POST['nip'];
    	$pass = $_POST['pass'];
    	$phql = "SELECT a.nip,a.id_status,CONCAT(a.gelar_dpn, ' ',a.nama, ' ', a.gelar_blk) as namag, a.kelamin from RefAkdSdm AS a WHERE nip = :nip:";
        $sdm = $this->modelsManager->executeQuery($phql,
        	[
        		"nip" => "$nip",
        	]
        );
        $this->view->sdm = $sdm;
        $this->view->pass = $pass;
        $this->view->nip = $nip;
        $this->view->nama = $sdm->a->namag;
        $this->view->pick('akd_reset_pass/view_pass');
    }

////////////////////////////////////////////////////////////////
////////////////////// MHS PASSWORD ////////////////////////////
////////////////////////////////////////////////////////////////

    public function mhsPassAction()
    {
    	$this->view->pick('akd_reset_pass/mhs');
    }

    public function cariMhsAction()
    {
    	$this->view->pick('akd_reset_pass/cari_mhs');
    }

    public function getTglLahir($no_mhs)
    {
    	$phql = "SELECT nama,tgl_lahir FROM RefAkdMhs WHERE id_mhs = :no_mhs:";
		$rows = $this->modelsManager->executeQuery($phql,["no_mhs" => "$no_mhs",]);
		foreach ($rows as $row) {
			$newDate = date("d-m-Y", strtotime($row->tgl_lahir));
			$return = str_replace('-', '', $newDate);
			return $return;
		}
    }

    public function resetMhsAction($value='')
    {
		$radio = $_POST["radio"];
		$no_mhs = $_POST["no_mhs"];
		$range1 = $_POST["range1"];
		$range2 = $_POST["range2"];
		$angkatan = $_POST["angkatan"];
		$notif = array(
			'status' => false,
		);

		if ($radio == "mhs") {
			$tgl = $this->getTglLahir($no_mhs);
			$pass = md5($tgl);
			$this->db->execute("UPDATE ref_user SET `passwd`=? WHERE nip = ? ",array($pass,$no_mhs));
			$notif = array(
				'status' => true,
			);
		} elseif($radio == "range") {

			for ($i=$range1; $i <= $range2 ; $i++) { 
				$tgl = $this->getTglLahir($i);
				$pass = md5($tgl);
				$this->db->execute("UPDATE ref_user SET `passwd`=? WHERE nip = ? ",array($pass,$i));
			}
			$notif = array(
				'status' => true,
			);
		}elseif ($radio == "angkatan") {
			//blm ada angakatan jadi blm di buat
			$notif = array(
				'status' => false,
			);
		}
		echo json_encode($notif);
    }

    public function berhasilMhsAction($value='')
    {
    	$radio = $_POST["radio"];
		$no_mhs = $_POST["no_mhs"];
		$range1 = $_POST["range1"];
		$range2 = $_POST["range2"];
		$angkatan = $_POST["angkatan"];

		$this->view->radio = $radio;
		$this->view->no_mhs = $no_mhs;
		$this->view->range1 = $range1;
		$this->view->range2 = $range2;
		$this->view->angkatan = $angkatan;
        $this->view->pick('akd_reset_pass/berhasil_mhs');
    }
}

