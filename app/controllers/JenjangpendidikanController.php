<?php

use Phalcon\Mvc\View;
use Phalcon\Validation;
use Phalcon\Validation\Validator\PresenceOf;
use Phalcon\Mvc\Url;

class JenjangPendidikanController extends \Phalcon\Mvc\Controller
{
    protected $check;
    protected $messages;
    protected $title;
    protected $type;
    protected $text;

    public function initialize()
    {
        if (empty($this->session->get('uid'))) {
            $this->response->redirect('account/loginEnd');
        }
        
        $this->view->setRenderLevel(View::LEVEL_ACTION_VIEW);
    }

    public function indexAction()
    {
        $data = RefJenjangPendidikan::find([
            "order" => "jenjang_pendidikan_id DESC"
        ]);
        $this->view->data = $data;
        $this->view->pick('rombel/jenjang');
    }

    public function addJenjangAction()
    {        
        $this->checkValidation();
        
        if (count($this->messages) == 0) {
            $data = new RefJenjangPendidikan();
            $this->save($data, 'tambah');        
        }
        
        $notif = ['title' => $this->title, 'text' => $this->text, 'type' => $this->type];
        echo json_encode($notif);        
    }

    public function editJenjangAction($id)
    {
        $this->checkValidation();
        
        if (count($this->messages) == 0) {
            $data = RefJenjangPendidikan::findFirst($id);
            $this->save($data, 'ubah');
        }

        $notif = ['title' => $this->title, 'text' => $this->text, 'type' => $this->type];
        echo json_encode($notif);     
    }    

    public function deleteJenjangAction($id)
    {
        $this->view->setRenderLevel(View::LEVEL_ACTION_VIEW);
        $del = RefJenjangPendidikan::findFirst($id);
        $del->delete();
        echo json_encode(array("status" => true));
    }

    public function save($data, $message) 
    {
        $data->assign(array(
            'nama' => $_POST['nama'],
            'jenjang_lembaga' => $_POST['jenjang_lembaga'],
            'jenjang_orang' => $_POST['jenjang_orang']
        ));
        
        if ($data->save()) {
            $this->title = 'Sukses';
            $this->text = 'Data berhasil di' . $message;
            $this->type = 'success';
        } else {
            $errors = $data->getMessages();
            foreach ($errors as $error) {
                $this->text .= "$error"."</br>";
            }
            $this->title = 'Error!';
            $this->type = 'warning';
        }         
    }   
    
    public function checkValidation() {
        $this->check = new Validation(); 

        $this->check->add('nama', new PresenceOf(array(
            'message' => '<b>Jenjang nama</b> tidak boleh kosong'
        )));
        $this->check->add('jenjang_lembaga', new PresenceOf(array(
            'message' => '<b>Jenjang lembaga</b> tidak boleh kosong'
        )));
        $this->check->add('jenjang_orang', new PresenceOf(array(
            'message' => '<b>Jenjang orang</b> tidak boleh kosong'
        )));                

        $this->messages = $this->check->validate($_POST);

        foreach ($this->messages as $message) {
            $this->text .= "$message"."</br>";
        }
        $this->title = 'Gagal';
        $this->type = 'warning';  
    }    
}

