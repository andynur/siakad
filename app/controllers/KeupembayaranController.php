<?php
use Phalcon\Mvc\View;
use Phalcon\Validation;
use  Phalcon\Validation\Validator\PresenceOf;
class KeupembayaranController extends \Phalcon\Mvc\Controller
{

    public function initialize()
    {
        if (empty($this->session->get('uid'))) {
            $this->response->redirect('account/loginEnd');
        }
        $this->view->setRenderLevel(View::LEVEL_ACTION_VIEW);
    }

    public function kewajibanPembayaranAction($value='')
    {

    	$get_session = $this->session->get('ps_id');
		$explode = explode('-', $get_session);
		$ps_id = $explode[1];

    	$helper = new Helpers();
    	$data_keu = $helper->curl("http://siato.stieww.ac.id/api_keu.php");


    	$thn_akd = $_POST['thn_akd'];
		$session_id = $_POST['session_id'];
    	
    	$phql = "SELECT * from RefKeuDefkwjb  where ps_id = '$ps_id' and thn_akd = '$thn_akd' and session_id = '$session_id'
         order by def_id";
        $data_kwjb = $this->modelsManager->executeQuery($phql);

        $this->view->nama_defkwjb = $data_keu['nama_defkwjb'];
        $this->view->ses = $data_keu['ses'];
        $this->view->data_kwjb = $data_kwjb;
        $this->view->thn_akd = $thn_akd;
        $this->view->session_id = $session_id;

    	$this->view->pick('keu_pembayaran/kewajiban');
    }

    public function addDefkwjbDownloadAction($value='')
    {
    	$helper = new Helpers();
    	$get_session = $this->session->get('ps_id');
		$explode = explode('-', $get_session);
		$ps_id = $explode[1];

		$keu_sid = $_POST['keu_thn'].'-'.$_POST['keu_ses_id'];

    	$data_keu = $helper->curl("http://siato.stieww.ac.id/api_keu2.php?ps_id=$ps_id&keu_sid=$keu_sid");
    	foreach ($data_keu as $key => $value) {
			$class = new RefKeuDefkwjb();
			$class->assign(array(
				'ps_id'        => $ps_id,
				'thn_akd'        => $_POST['thn_akd'],
				'session_id'    => $_POST['session_id'],
				'keu_thn'        => $_POST['keu_thn'],
				'keu_ses_id'          => $_POST['keu_ses_id'],
				'kode_byr'       => $value['kode_byr'],
				'targetmhs'       => $value['target_mhs']
			));

          $class->save();
    	}
    	
		$notif = array(
			'title'   => 'success',
			'text'  => 'Data berhasil di input',
			'type'  => 'success',
		);
		echo json_encode($notif);
    }

    public function delDefkwjbAction($id)
    {
		$class = RefKeuDefkwjb::findFirst($id);
		$class->delete();
		echo json_encode(array("status" => true));
    }

    public function addDefkwjbAction($value='')
    {
		$get_session = $this->session->get('ps_id');
		$explode = explode('-', $get_session);
		$ps_id = $explode[1];

      // validation
      $validation = new Phalcon\Validation();
      $validation->add('targetmhs', new PresenceOf(array(
          'message' => 'Mahasiswa tidak boleh kosong'
      )));

      $messages = $validation->validate($_POST);
      $pesan    = '';
      if (count($messages)) {
        foreach ($messages as $message) {
            $pesan .= "$message"."</br>";
        }
        $notif = array(
          'title'   => 'warning',
          'text'  => $pesan,
          'type'  => 'warning',
        );
      }else{
          $class = new RefKeuDefkwjb();
          $class->assign(array(
            'ps_id'        => $ps_id,
            'thn_akd'        => $_POST['thn_akd'],
            'session_id'    => $_POST['session_id'],
            'keu_thn'        => $_POST['keu_thn'],
            'keu_ses_id'          => $_POST['keu_ses_id'],
            'kode_byr'       => $_POST['kode_byr'],
            'targetmhs'       => $_POST['targetmhs']
          ));

          $class->save();
          $notif = array(
            'title'   => 'success',
            'text'  => 'Data berhasil di input',
            'type'  => 'success',
          );
      }
      echo json_encode($notif);
    }



    public function editDefkwjbAction($id)
    {
    	//DAPATKAN ps_id dari area yang dipilih
      $get_session = $this->session->get('ps_id');
      $explode = explode('-', $get_session);
      $ps_id = $explode[1];

      // validation
      $validation = new Phalcon\Validation();
      $validation->add('targetmhs', new PresenceOf(array(
          'message' => 'Mahasiswa tidak boleh kosong'
      )));

  		$messages = $validation->validate($_POST);
  		$pesan    = '';
  		if (count($messages)) {
  		    foreach ($messages as $message) {
  		        $pesan .= "$message"."</br>";
  		    }
  			$notif = array(
	          'title'   => 'warning',
	          'text'  => $pesan,
	          'type'  => 'warning',
	        );
  		}else{
				$class = RefKeuDefkwjb::findFirst($id);
				$class->assign(array(
					'targetmhs'        => $_POST['targetmhs'],
					'kode_byr'        => $_POST['kode_byr']
				));
				$class->save();
				$notif = array(
					'title'   => 'success',
					'text'  => 'Data berhasil di input',
					'type'  => 'success',
				);
  		}
  		echo json_encode($notif);
    }

}

