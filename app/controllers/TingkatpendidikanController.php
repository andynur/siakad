<?php

use Phalcon\Mvc\View;
use Phalcon\Validation;
use Phalcon\Validation\Validator\PresenceOf;
use Phalcon\Mvc\Url;
use Phalcon\Mvc\Model\Query\Builder;

class TingkatPendidikanController extends \Phalcon\Mvc\Controller
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
        $data = $this->modelsManager->createBuilder()
                ->addFrom('RefTingkatPendidikan', 't')
                ->join('RefJenjangPendidikan', 't.jenjang_pendidikan_id = j.jenjang_pendidikan_id', 'j')
                ->columns(['t.tingkat_pendidikan_id', 't.kode', 't.nama', 'j.nama AS nama_jenjang'])
                ->orderBy('t.tingkat_pendidikan_id DESC')
                ->getQuery()
                ->execute();
                    
        $jenjang = RefJenjangPendidikan::find([
            "columns" => "jenjang_pendidikan_id, nama"
        ]);

        $this->view->data = $data;
        $this->view->jenjang = $jenjang;
        $this->view->pick('rombel/tingkat');
    }

    public function addTingkatAction()
    {        
        $this->checkValidation();
        
        if (count($this->messages) == 0) {
            $data = new RefTingkatPendidikan();
            $this->save($data, 'tambah');        
        }
        
        $notif = ['title' => $this->title, 'text' => $this->text, 'type' => $this->type];
        echo json_encode($notif);        
    }

    public function editTingkatAction($id)
    {
        $this->checkValidation();
        
        if (count($this->messages) == 0) {
            $data = RefTingkatPendidikan::findFirst($id);
            $this->save($data, 'ubah');
        }

        $notif = ['title' => $this->title, 'text' => $this->text, 'type' => $this->type];
        echo json_encode($notif);     
    }    

    public function deleteTingkatAction($id)
    {
        $this->view->setRenderLevel(View::LEVEL_ACTION_VIEW);
        $del = RefTingkatPendidikan::findFirst($id);
        $del->delete();
        echo json_encode(array("status" => true));
    }

    public function save($data, $message) 
    {
        $data->assign(array(
            'jenjang_pendidikan_id' => $_POST['jenjang_pendidikan_id'],
            'kode' => $_POST['kode'],
            'nama' => $_POST['nama']
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
            'message' => '<b>Tingkat pendidikan</b> tidak boleh kosong'
        )));                
        $this->check->add('jenjang_pendidikan_id', new PresenceOf(array(
            'message' => '<b>Jenjang pendidikan</b> tidak boleh kosong'
        )));
        $this->check->add('kode', new PresenceOf(array(
            'message' => '<b>Kode</b> tidak boleh kosong'
        )));

        $this->messages = $this->check->validate($_POST);

        foreach ($this->messages as $message) {
            $this->text .= "$message"."</br>";
        }
        $this->title = 'Gagal';
        $this->type = 'warning';  
    }    
}

