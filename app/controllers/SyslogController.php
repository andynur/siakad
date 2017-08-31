<?php

use Phalcon\Mvc\View;
use Phalcon\Validation;
use Phalcon\Forms\Element\Text;
use Phalcon\Validation\Validator\Date;
use Phalcon\Validation\Validator\PresenceOf;
use Phalcon\Validation\Validator\Numericality;
class SyslogController extends \Phalcon\Mvc\Controller
{
	public function initialize()
    {
      if (empty($this->session->get('uid'))) {
          $this->response->redirect('account/loginEnd');
      }
      $this->view->setRenderLevel(View::LEVEL_ACTION_VIEW);
    }

    public function logAktifitasUserAction()
    {
    	// echo "<pre>".print_r($_POST,1)."</pre>";
    	//simpan ke mongoDB colection log_aktifitas_user
        $ins=new LogAktifitasUser();
        $ins->ip   		= $_POST['ip'];
        $ins->time   	= $_POST['time'];
        $ins->nip   	= $_POST['nip'];
        $ins->nama   	= $_POST['nama'];
        $ins->id_jenis  = $_POST['id_jenis'];
        $ins->area      = $_POST['area'];
        $ins->link      = $_POST['link'];
        $ins->save();
    }

}

