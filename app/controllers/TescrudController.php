<?php

use Phalcon\Mvc\View;
use Phalcon\Validation;
use Phalcon\Validation\Validator\PresenceOf;
use Phalcon\Mvc\Url;

class TescrudController extends \Phalcon\Mvc\Controller
{

    public function initialize()
    {
        if (empty($this->session->get('uid'))) {
            $this->response->redirect('account/loginEnd');
        }
        $this->view->setRenderLevel(View::LEVEL_ACTION_VIEW);
    }

    public function indexAction($value='')
    {
        $phql = "SELECT * FROM TesCrud";
        $data = $this->modelsManager->executeQuery($phql);
        $this->view->data = $data;
        $this->view->pick('tes');
    }

    public function addTesAction($value='')
    {
        $validation = new Phalcon\Validation(); 
        $validation->add('nama', new PresenceOf(array(
            'message' => 'Nama tidak boleh kosong'
        )));
        $validation->add('jumlah', new PresenceOf(array(
            'message' => 'Jumlah tidak boleh kosong'
        )));
        $validation->add('tanggal', new PresenceOf(array(
            'message' => 'Tanggal tidak boleh kosong'
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
            $data = new TesCrud();
            $data->assign(array(
                        'nama' => $_POST['nama'],
                        'jumlah' => $_POST['jumlah'],                        
                        'tanggal' => $_POST['tanggal']
                        )
                    );

            $data->save();
            $notif = array(
                'title' => 'success',
                'text' => 'Data berhasil di input',
                'type' => 'success',
            );
        }

        echo json_encode($notif);
    }

    public function editTesAction($id)
    {
        $validation = new Phalcon\Validation(); 
        $validation->add('nama', new PresenceOf(array(
            'message' => 'Nama tidak boleh kosong'
        )));
        $validation->add('jumlah', new PresenceOf(array(
            'message' => 'Jumlah tidak boleh kosong'
        )));
        $validation->add('tanggal', new PresenceOf(array(
            'message' => 'Tanggal tidak boleh kosong'
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
            $data = TesCrud::findFirstById($id);
            $data->assign(array(
                        'nama' => $_POST['nama'],
                        'jumlah' => $_POST['jumlah'],
                        'tanggal' => $_POST['tanggal']
                        )
                    );

            $data->save();
            $notif = array(
                'title' => 'success',
                'text' => 'Data berhasil di input',
                'type' => 'success',
            );
        }

        echo json_encode($notif);
    }    

    public function delTesAction($id)
    {
        $this->view->setRenderLevel(View::LEVEL_ACTION_VIEW);
        $del=TesCrud::findById($id);
        $del->delete();
        echo json_encode(array("status" => true));
    }

}

