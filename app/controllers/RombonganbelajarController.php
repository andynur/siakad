<?php

use Phalcon\Mvc\View;
use Phalcon\Validation;
use Phalcon\Validation\Validator\PresenceOf;
use Phalcon\Mvc\Url;
use Phalcon\Mvc\Model\Query\Builder;

class RombonganBelajarController extends \Phalcon\Mvc\Controller
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
                ->addFrom('RefRombonganBelajar', 'r')
                ->join('RefSemester', 'r.semester_id = s.semester_id', 's')
                ->join('RefKurikulum', 'r.kurikulum_id = k.kurikulum_id', 'k')
                ->join('RefTingkatPendidikan', 'r.tingkat_pendidikan_id = t.tingkat_pendidikan_id', 't')
                ->columns(['r.rombongan_belajar_id', 'r.nama AS nama_rombel', 's.nama AS nama_semester', 't.nama AS nama_tingkat', 'k.nama_kurikulum'])
                ->orderBy('r.rombongan_belajar_id DESC')
                ->groupBy('r.rombongan_belajar_id')
                ->getQuery()
                ->execute();
                    
        $semester = RefSemester::find(["columns" => "semester_id, nama"]);
        $kurikulum = RefKurikulum::find(["columns" => "kurikulum_id, nama_kurikulum"]);
        $tingkat = RefTingkatPendidikan::find(["columns" => "tingkat_pendidikan_id, nama"]);

        $this->view->data = $data;
        $this->view->semester = $semester;
        $this->view->kurikulum = $kurikulum;
        $this->view->tingkat = $tingkat;
        $this->view->pick('rombel/rombel');
    }

    public function addRombelAction()
    {        
        $this->checkValidation();
        
        if (count($this->messages) == 0) {
            $data = new RefRombonganBelajar();
            $this->save($data, 'tambah');        
        }
        
        $notif = ['title' => $this->title, 'text' => $this->text, 'type' => $this->type];
        echo json_encode($notif);        
    }

    public function editRombelAction($id)
    {
        $this->checkValidation();
        
        if (count($this->messages) == 0) {
            $data = RefRombonganBelajar::findFirst($id);
            $this->save($data, 'ubah');
        }

        $notif = ['title' => $this->title, 'text' => $this->text, 'type' => $this->type];
        echo json_encode($notif);     
    }    

    public function deleteRombelAction($id)
    {
        $this->view->setRenderLevel(View::LEVEL_ACTION_VIEW);
        $del = RefRombonganBelajar::findFirst($id);
        $del->delete();
        echo json_encode(array("status" => true));
    }

    public function save($data, $message) 
    {
        $data->assign(array(
            'nama' => $_POST['nama'],
            'tingkat_pendidikan_id' => $_POST['tingkat_pendidikan_id'],
            'semester_id' => $_POST['semester_id'],
            'kurikulum_id' => $_POST['kurikulum_id'],
            'sekolah_id' => 1,
            'prasarana_id' => 0,
            'moving_class' => 0,
            'kebutuhan_khusus_id' => 0,
            'soft_delete' => 0,
            'updater_id' => 0            
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
            'message' => '<b>Nama rombel</b> tidak boleh kosong'
        )));                
        $this->check->add('tingkat_pendidikan_id', new PresenceOf(array(
            'message' => '<b>Tingkat pendidikan</b> tidak boleh kosong'
        )));
        $this->check->add('semester_id', new PresenceOf(array(
            'message' => '<b>Semester</b> tidak boleh kosong'
        )));
        $this->check->add('kurikulum_id', new PresenceOf(array(
            'message' => '<b>Kurikulum</b> tidak boleh kosong'
        )));

        $this->messages = $this->check->validate($_POST);

        foreach ($this->messages as $message) {
            $this->text .= "$message"."</br>";
        }
        $this->title = 'Gagal';
        $this->type = 'warning';  
    }    
}