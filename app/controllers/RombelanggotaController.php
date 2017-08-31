<?php

use Phalcon\Mvc\View;
use Phalcon\Validation;
use Phalcon\Validation\Validator\PresenceOf;
use Phalcon\Mvc\Url;
use Phalcon\Mvc\Model\Query\Builder;

class RombelAnggotaController extends \Phalcon\Mvc\Controller
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
                ->addFrom('RefRombelAnggota', 'a')
                ->join('RefRombonganBelajar', 'a.rombongan_belajar_id = r.rombongan_belajar_id', 'r')
                ->join('RefTingkatPendidikan', 'r.tingkat_pendidikan_id = t.tingkat_pendidikan_id', 't')
                ->join('RefSemester', 'r.semester_id = s.semester_id', 's')
                ->join('RefAkdMhs', 'a.peserta_didik_id = p.id_mhs', 'p')
                ->join('RefJenisPendaftaran', 'a.jenis_pendaftaran_id = j.jenis_pendaftaran_id', 'j')
                ->columns(['a.anggota_rombel_id', 'r.nama AS nama_rombel', 't.nama AS nama_tingkat', 's.nama AS nama_semester', 'p.id_mhs AS siswa_id', 'p.nama AS nama_siswa', 'p.nis', 'j.nama AS nama_jenis'])
                ->orderBy('a.anggota_rombel_id DESC')
                ->getQuery()
                ->execute();
                    
        $rombel = $this->modelsManager->createBuilder()
                ->addFrom('RefRombonganBelajar', 'r')
                ->join('RefSemester', 'r.semester_id = s.semester_id', 's')
                ->join('RefTingkatPendidikan', 'r.tingkat_pendidikan_id = t.tingkat_pendidikan_id', 't')
                ->columns(['r.rombongan_belajar_id', 'r.nama AS nama_rombel', 's.nama AS nama_semester', 't.nama AS nama_tingkat'])
                ->groupBy('r.rombongan_belajar_id')
                ->getQuery()
                ->execute();

        $jenis = RefJenisPendaftaran::find(["columns" => "jenis_pendaftaran_id, nama"]);
        $siswa = RefAkdMhs::find(["columns" => "id_mhs AS siswa_id, nama, nis"]);

        $this->view->data = $data;
        $this->view->rombel = $rombel;
        $this->view->siswa = $siswa;
        $this->view->jenis = $jenis;
        $this->view->pick('rombel/anggota');
    }

    public function addRombelAnggotaAction()
    {        
        $this->checkValidation();
        
        if (count($this->messages) == 0) {
            $exp_siswa = explode(",", $_POST['siswa']);
            
            for ($i=0; $i < count($exp_siswa); $i++) { 
                $data = new RefRombelAnggota();
                $data->assign(array(
                    'rombongan_belajar_id' => $_POST['rombel'],
                    'peserta_didik_id' => $exp_siswa[$i],
                    'jenis_pendaftaran_id' => $_POST['jenis'],
                    'soft_delete' => 0,
                    'updater_id' => 0
                ));            
                $data->save();            
            }             

            $errors = $data->getMessages();

            if ($errors == '' || $errors == null) {
                $this->title = 'Sukses';
                $this->text = 'Data berhasil ditambah';
                $this->type = 'success';
            } else {
                foreach ($errors as $error) {
                    $this->text .= "$error"."</br>";
                }
                $this->title = 'Error!';
                $this->type = 'warning';
            }
        }        

        $notif = ['title' => $this->title, 'text' => $this->text, 'type' => $this->type];
        echo json_encode($notif);        
    }

    public function editRombelAnggotaAction($id)
    {
        $this->checkValidation();
        
        if (count($this->messages) == 0) {
            $data = RefRombelAnggota::findFirst($id);
            $this->update($data);
        }

        $notif = ['title' => $this->title, 'text' => $this->text, 'type' => $this->type];
        echo json_encode($notif);     
    }    

    public function deleteRombelAnggotaAction($id)
    {
        $this->view->setRenderLevel(View::LEVEL_ACTION_VIEW);
        $data = RefRombelAnggota::findFirst($id);
        $data->delete();
        echo json_encode(array("status" => true));
    }

    public function update($data, $message) 
    {        
        $data->assign(array(
            'rombongan_belajar_id' => $_POST['rombel'],
            'peserta_didik_id' => $_POST['siswa'],
            'jenis_pendaftaran_id' => $_POST['jenis']
        ));            

        if ($data->save()) {
            $this->title = 'Sukses';
            $this->text = 'Data berhasil diubah';
            $this->type = 'success';
        } else {
            foreach ($errors as $error) {
                $this->text .= "$error"."</br>";
            }
            $this->title = 'Error!';
            $this->type = 'warning';
        }
    }   
    
    public function checkValidation() {
        $this->check = new Validation(); 

        $this->check->add('rombel', new PresenceOf(array(
            'message' => '<b>Rombel</b> tidak boleh kosong'
        )));                
        $this->check->add('siswa', new PresenceOf(array(
            'message' => '<b>Siswa</b> tidak boleh kosong'
        )));
        $this->check->add('jenis', new PresenceOf(array(
            'message' => '<b>Jenis Pendaftaran</b> tidak boleh kosong'
        )));

        $this->messages = $this->check->validate($_POST);

        foreach ($this->messages as $message) {
            $this->text .= "$message"."</br>";
        }
        $this->title = 'Gagal';
        $this->type = 'warning';  
    }    
}