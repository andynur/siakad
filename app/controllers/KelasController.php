<?php

use Phalcon\Mvc\View;
use Phalcon\Validation;
use Phalcon\Validation\Validator\PresenceOf;
use Phalcon\Mvc\Url;

class KelasController extends \Phalcon\Mvc\Controller
{

    public function initialize()
    {
        if (empty($this->session->get('uid'))) {
            $this->response->redirect('account/loginEnd');
        }
        $this->view->setRenderLevel(View::LEVEL_ACTION_VIEW);
    }

    public function indexAction()
    {
        $phql = "SELECT * FROM RefKelas";
        $data = $this->modelsManager->executeQuery($phql);
        $this->view->data = $data;
        $this->view->pick('rombel/kelas');
    }

    public function addKelasAction()
    {
        $validation = new Phalcon\Validation(); 
        $validation->add('nama', new PresenceOf(array(
            'message' => 'Nama kelas tidak boleh kosong'
        )));
         
        $messages = $validation->validate($_POST);
        $pesan = '';
        if (count($messages)) {
            foreach ($messages as $message) {
                $pesan .= "$message"."</br>";
            }
            $notif = array(
                'title' => 'Gagal',
                'text' => $pesan,
                'type' => 'warning',
            );
        }else{
            $data = new RefKelas();
            $data->assign(array(
                        'nama' => $_POST['nama'],
                        )
                    );

            $data->save();
            $notif = array(
                'title' => 'Sukses',
                'text' => 'Data berhasil ditambah',
                'type' => 'success',
            );
        }

        echo json_encode($notif);
    }

    public function editKelasAction($id)
    {
        $validation = new Phalcon\Validation(); 
        $validation->add('nama', new PresenceOf(array(
            'message' => 'Nama kelas tidak boleh kosong'
        )));  
         
        $messages = $validation->validate($_POST);
        $pesan = '';
        if (count($messages)) {
            foreach ($messages as $message) {
                $pesan .= "$message"."</br>";
            }
            $notif = array(
                'title' => 'Gagal',
                'text' => $pesan,
                'type' => 'warning',
            );
        }else{
            $data = RefKelas::findFirst($id);
            $data->assign(array(
                        'nama' => $_POST['nama']
                        )
                    );

            $data->save();
            $notif = array(
                'title' => 'Sukses',
                'text' => 'Data berhasil diubah',
                'type' => 'success',
            );
        }

        echo json_encode($notif);
    }    

    public function delKelasAction($id)
    {
        $this->view->setRenderLevel(View::LEVEL_ACTION_VIEW);
        $del = RefKelas::findFirst($id);
        $del->delete();
        echo json_encode(array("status" => true));
    }

}

