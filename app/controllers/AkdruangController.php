<?php

use Phalcon\Mvc\View;
use Phalcon\Validation;
use  Phalcon\Validation\Validator\PresenceOf;
class AkdruangController extends \Phalcon\Mvc\Controller
{

    public function initialize()
    {
        if (empty($this->session->get('uid'))) {
            $this->response->redirect('account/loginEnd');
        }
        $this->view->setRenderLevel(View::LEVEL_ACTION_VIEW);
    }

    public function ruangAction($value='')
    {
    	//DAPATKAN ps_id dari area yang dipilih
    	$get_session = $this->session->get('ps_id');
    	$explode = explode('-', $get_session);
    	$ps_id = $explode[1];
    	$phql2 = "SELECT * from RefAkdRuang where ps_id = '$ps_id' ";
        $ruang = $this->modelsManager->executeQuery($phql2);
    	$fakultas = RefSysFakultas::find();

        $this->view->ruang = $ruang;
        $this->view->fakultas = $fakultas;
    	$this->view->pick('akd_ruang/ruang');
    }

    public function delRuangAction($id)
    {
    	$this->view->setRenderLevel(View::LEVEL_ACTION_VIEW);
    	$del = "DELETE FROM RefAkdRuang WHERE ruang_id = '$id' ";
        $this->modelsManager->executeQuery($del);

    	echo json_encode(array("status" => true));
    }

    public function addRuangAction($value='')
    {
    	$validation = new Phalcon\Validation(); 
		$validation->add('nama', new PresenceOf(array(
		    'message' => 'Nama tidak boleh kosong'
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
			$RefAkdRuang = new RefAkdRuang();
            $RefAkdRuang->assign(array(
                        'ps_id' => $_POST['ps_id'],
                        'nama_ruang' => $_POST['nama'],
                        'publik' => 'y'
                        )
                    );

            $RefAkdRuang->save();
			$notif = array(
				'title' => 'success',
                'text' => 'Data berhasil di input',
                'type' => 'success',
			);
		}

		echo json_encode($notif);
    }

    function editRuangAction($id)
    {
    	$validation = new Phalcon\Validation(); 
		$validation->add('nama', new PresenceOf(array(
		    'message' => 'Nama tidak boleh kosong'
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
			$nama_ruang = $_POST['nama'];
            $publik = $_POST['aktif'];
	        $this->db->execute("UPDATE ref_akd_ruang SET `nama_ruang`=?,`publik`=? WHERE ruang_id = ? ",array($nama_ruang,$publik,$id));

           	$notif = array(
				'title' => 'success',
				'text' => 'Data berhasil di Edit',
				'type' => 'success',
			);
            
		}

		echo json_encode($notif);
		
    }

////////////////////////////////////////////////
////////////////LIST RUANG DARI FAKULTAS////////
////////////////////////////////////////////////
    public function listRuangFakultasAction($id)
    {
    	$phql2 = "SELECT * from RefAkdRuang where ps_id = '$id' and publik = 'Y' ";
        $ruang = $this->modelsManager->executeQuery($phql2);
        $this->view->ruang = $ruang;
    	$this->view->pick('akd_ruang/ruang_fakultas');
    }

    public function addRuangDariFakultasAction($value='')
    {
    	$get_session = $this->session->get('ps_id');
    	$explode = explode('-', $get_session);
    	$ps_id = $explode[1];

    	$RefAkdRuang = new RefAkdRuang();
        $RefAkdRuang->assign(array(
                    'ps_id' => $ps_id,
                    'nama_ruang' => $_POST['nama_ruang'],
                    'shareps_id' => $_POST['ps_id'],
                    'shareruang_id' => $_POST['id_ruang'],
                    'sharedb' => '',
                    'publik' => 'y',
                    )
                );

        $RefAkdRuang->save();
		$notif = array(
			'title' => 'success',
            'text' => 'Data berhasil di input',
            'type' => 'success',
		);
		echo json_encode($notif);
    }

////////////////////////////////////////////////
////////////////KONFIGURASI RUANG///////////////
////////////////////////////////////////////////

    public function konfigurasiRuangAction()
    {
    	$id_ruang = $_GET['id'];
    	$nama_ruang = $_GET['nama'];

    	$get_session = $this->session->get('ps_id');
    	$explode = explode('-', $get_session);
    	$ps_id = $explode[1];

    	$phql2 = "SELECT * from RefAkdConfruang where ps_id = '$ps_id' and ruang_id = '$id_ruang' ";
        $ruang = $this->modelsManager->executeQuery($phql2);

        $this->view->ruang = $ruang;
        $this->view->ruang_id = $id_ruang;
        $this->view->nama_ruang = $nama_ruang;
    	$this->view->pick('akd_ruang/konfigurasi_ruang');
    }

    public function delConfruangAction($id)
    {
    	$this->view->setRenderLevel(View::LEVEL_ACTION_VIEW);
    	$del = "DELETE FROM RefAkdConfruang WHERE conf_id = '$id' ";
        $this->modelsManager->executeQuery($del);

    	echo json_encode(array("status" => true));
    }

    public function addConfruangAction($value='')
    {
    	$validation = new Phalcon\Validation(); 
		$validation->add('nama', new PresenceOf(array(
		    'message' => 'Nama tidak boleh kosong'
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
			$class = new RefAkdConfruang();
            $class->assign(array(
                        'ps_id' => $_POST['ps_id'],
                        'ruang_id' => $_POST['ruang_id'],
                        'nama_conf' => $_POST['nama'],
                        'volume' => 0
                        )
                    );

            $class->save();
			$notif = array(
				'title' => 'success',
                'text' => 'Data berhasil di input',
                'type' => 'success',
			);
		}
		echo json_encode($notif);
    }

    function editConfruangAction($id)
    {
    	$validation = new Phalcon\Validation(); 
		$validation->add('nama', new PresenceOf(array(
		    'message' => 'Nama tidak boleh kosong'
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
			$nama = $_POST['nama'];
	        $this->db->execute("UPDATE ref_akd_confruang SET `nama_conf`=? WHERE conf_id = ? ",array($nama,$id));

           	$notif = array(
				'title' => 'success',
				'text' => 'Data berhasil di Edit',
				'type' => 'success',
			);
            
		}
		echo json_encode($notif);		
    }

////////////////////////////////////////////////
////////////////KONFIGURASI RUANG///////////////
////////////////////////////////////////////////
    public function matrixRuangAction()
    {
    	$get_session = $this->session->get('ps_id');
    	$explode = explode('-', $get_session);

    	$ps_id = $explode[1];
    	$conf_id = $_POST['conf_id'];
    	$nama_conf = $_POST['nama_conf'];
    	$id_ruang = $_POST['id_ruang'];
    	$nama_ruang = $_POST['nama_ruang'];

    	$phql2 = "SELECT * from RefAkdMtrxruang where ps_id = '$ps_id' and ruang_id = '$id_ruang' and conf_id = '$conf_id' ORDER BY no_kursi ASC";
        $mtrx = $this->modelsManager->executeQuery($phql2);

        $this->view->mtrx = $mtrx;
        $this->view->conf_id = $conf_id;
        $this->view->nama_conf = $nama_conf;

        $this->view->id_ruang = $id_ruang;
        $this->view->nama_ruang = $nama_ruang;
    	$this->view->pick('akd_ruang/matrix_ruang');
    }

    public function delMatrixAction($value='')
    {
    	$conf_id = $_POST['conf_id'];
    	$id_ruang = $_POST['id_ruang'];
    	$explode = explode(',', $_POST['no_kursi']);
    	foreach ($explode as $key) {
	    	$del = "DELETE FROM RefAkdMtrxruang WHERE conf_id = '$conf_id' and ruang_id = '$id_ruang' and no_kursi = '$key'  ";
	        $this->modelsManager->executeQuery($del);
	        $this->db->execute("UPDATE ref_akd_confruang SET `volume`= volume-1 WHERE conf_id = ? ",array($conf_id));
    	}
    	echo json_encode(array("status" => true));
    }

    function editMatrixAction()
    {
    	$validation = new Phalcon\Validation(); 
		$validation->add('nama', new PresenceOf(array(
		    'message' => 'Nama tidak boleh kosong'
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
			$conf_id = $_POST['conf_id'];
			$id_ruang = $_POST['id_ruang'];
			$no_kursi = $_POST['no_kursi'];
			$nama = $_POST['nama'];
$this->db->execute("UPDATE ref_akd_mtrxruang SET `nama_kursi`=? WHERE conf_id = ? and ruang_id = ? and no_kursi =? and ps_id = ?",array($nama,$conf_id, $id_ruang,$no_kursi,$ps_id));

           	$notif = array(
				'title' => 'success',
				'text' => 'Data berhasil di Edit',
				'type' => 'success',
			);
            
		}
		echo json_encode($notif);		
    }

    public function addMatrixAction($value='')
    {

    	$validation = new Phalcon\Validation(); 
		$validation->add('kolom', new PresenceOf(array(
		    'message' => 'kolom tidak boleh kosong'
		)));
		$validation->add('baris', new PresenceOf(array(
		    'message' => 'baris tidak boleh kosong'
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

$radio = $_POST['radio'];
$x = $_POST['kolom'];
$ruang_id = $_POST['ruang_id'];
$y = $_POST['baris'];
$conf_id = $_POST['conf_id'];

$get_session = $this->session->get('ps_id');
$explode = explode('-', $get_session);

$ps_id = $explode[1];
$no_kursi = 1;
$kursi_array = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";

$del = "DELETE FROM RefAkdMtrxruang WHERE conf_id = '$conf_id' ";
$this->modelsManager->executeQuery($del);

			if ($radio == 'urut_kolom' ) {
				$toggle = 0;
		         for($i = 1; $i <= $x; $i++) {
		            if($toggle == 0) {
		               $toggle = 1;
		               for($j = 1; $j <= $y; $j++) {
		                  $ikursi = ($i-1) % 26;
		                  $inama = $kursi_array[$ikursi];
		                  $nama_kursi = "$j$inama";

						    $class = new RefAkdMtrxruang();
				            $class->assign(array(
				                        'ps_id' => $ps_id,
				                        'ruang_id' => $ruang_id,
				                        'conf_id' => $conf_id,
				                        'no_kursi' => $no_kursi,
				                        'x' => $i,
				                        'y' => $j,
				                        'nama_kursi' => $nama_kursi
				                        )
				                    );
				            $class->save();

		                  $no_kursi++;
		               }
		            } else {
		               $toggle = 0;
		               for($j = $y; $j >= 1; $j--) {
		                  $ikursi = ($i-1) % 26;
		                  $inama = $kursi_array[$ikursi];
		                  $nama_kursi = "$j$inama";

						    $class = new RefAkdMtrxruang();
				            $class->assign(array(
				                        'ps_id' => $ps_id,
				                        'ruang_id' => $ruang_id,
				                        'conf_id' => $conf_id,
				                        'no_kursi' => $no_kursi,
				                        'x' => $i,
				                        'y' => $j,
				                        'nama_kursi' => $nama_kursi
				                        )
				                    );
				            $class->save();

		                  $no_kursi++;
		               }
		            }
		        }
			}else {
				$toggle = 0;
		        for($j = 1; $j <= $y; $j++) {
		            if($toggle == 0) {
		               $toggle = 1;
		               for($i = 1; $i <= $x; $i++) {
		//                  $nama_kursi = "$i.$j";
		                  $ikursi = ($i-1) % 26;
		                  $inama = $kursi_array[$ikursi];
		                  $nama_kursi = "$j$inama";
		                  	$class = new RefAkdMtrxruang();
				            $class->assign(array(
				                        'ps_id' => $ps_id,
				                        'ruang_id' => $ruang_id,
				                        'conf_id' => $conf_id,
				                        'no_kursi' => $no_kursi,
				                        'x' => $i,
				                        'y' => $j,
				                        'nama_kursi' => $nama_kursi
				                        )
				                    );
				            $class->save();
		                  $no_kursi++;
		               }
		            } else {
		               $toggle = 0;
		               for($i = $x; $i >= 1; $i--) {
		//                  $nama_kursi = "$i.$j";
		                  $ikursi = ($i-1) % 26;
		                  $inama = $kursi_array[$ikursi];
		                  $nama_kursi = "$j$inama";
		                  	$class = new RefAkdMtrxruang();
				            $class->assign(array(
				                        'ps_id' => $ps_id,
				                        'ruang_id' => $ruang_id,
				                        'conf_id' => $conf_id,
				                        'no_kursi' => $no_kursi,
				                        'x' => $i,
				                        'y' => $j,
				                        'nama_kursi' => $nama_kursi
				                        )
				                    );
				            $class->save();
		                  $no_kursi++;
		               }
		            }
		        }
			}
			$volume = $x * $y;
			$this->db->execute("UPDATE ref_akd_confruang SET `volume`=? WHERE conf_id = ? ",array($volume,$conf_id));

			$notif = array(
				'title' => 'success',
                'text' => 'Data berhasil di input',
                'type' => 'success',
			);
		}
		echo json_encode($notif);
    }

}

