<?php

use Phalcon\Mvc\View;
use Phalcon\Validation;
use Phalcon\Validation\Validator\PresenceOf;
use Phalcon\Mvc\Url;
use Phalcon\Mvc\Model\Query\Builder;

class GuruController extends \Phalcon\Mvc\Controller
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
                ->addFrom('RefGuru', 'g')
                ->join('RefJenisPtk', 'g.jenis_ptk_id = j.jenis_ptk_id', 'j')
                ->join('RefStatusKepegawaian', 'g.status_kepegawaian_id = s.status_kepegawaian_id', 's')
                ->join('RefStatusKeaktifanPegawai', 'g.status_keaktifan_id = k.status_keaktifan_id', 'k')
                ->columns(['g.ptk_id, g.nama, g.nip, g.jenis_kelamin, j.jenis_ptk, s.nama AS kepegawaian, k.nama AS keaktifan, g.foto'])
                ->orderBy('g.ptk_id DESC')
                ->getQuery()
                ->execute();                

        $jenis = RefJenisPendaftaran::find(["columns" => "jenis_pendaftaran_id, nama"]);
        $siswa = RefAkdMhs::find(["columns" => "id_mhs AS siswa_id, nama, nis"]);

        $this->view->setVars([
            "data" => $data
        ]);

        $this->view->pick('guru/index');
    }

    public function addGuruAction($rombel_id)
    {
        $data = $this->modelsManager->createBuilder()
                ->addFrom('RefGuru', 'g')
                ->join('RefJenisPtk', 'g.jenis_ptk_id = j.jenis_ptk_id', 'j')
                ->join('RefStatusKepegawaian', 'g.status_kepegawaian_id = s.status_kepegawaian_id', 's')
                ->join('RefStatusKeaktifanPegawai', 'g.status_keaktifan_id = k.status_keaktifan_id', 'k')
                ->columns(['g.ptk_id, g.nama, g.nip, g.jenis_kelamin, j.jenis_ptk, s.nama AS kepegawaian, k.nama AS keaktifan, g.foto'])
                ->orderBy('g.ptk_id DESC')
                ->getQuery()
                ->execute(); 

        $provinsi = RefSysProvinsi::find();
        $kabupaten = RefSysKabupaten::find();
        $kecamatan = RefSysKecamatan::find();
        $kelurahan = RefSysKelurahan::find();
        $jenis_ptk = RefJenisPtk::find();
        $status_kepegawaian = RefStatusKepegawaian::find();
        $status_keaktifan = RefStatusKeaktifanPegawai::find();
        
        $this->view->setVars([
            "provinsi" => $provinsi,
            "kabupaten" => $kabupaten,
            "kecamatan" => $kecamatan,
            "kelurahan" => $kelurahan,
            "jenis_ptk" => $jenis_ptk,
            "status_kepegawaian" => $status_kepegawaian,
            "status_keaktifan" => $status_keaktifan,
            "url_back" => $_POST['url_back']
        ]);
        
        $this->view->pick('guru/form');
    }    

    // public function editGuruAction($id)
    // {
    //     $this->checkValidation();
        
    //     if (count($this->messages) == 0) {
    //         $data = RefGuru::findFirst($id);
    //         $this->update($data);
    //     }

    //     $notif = ['title' => $this->title, 'text' => $this->text, 'type' => $this->type];
    //     echo json_encode($notif);     
    // }    

    // public function deleteGuruAction($id)
    // {
    //     $this->view->setRenderLevel(View::LEVEL_ACTION_VIEW);
    //     $data = RefGuru::findFirst($id);
    //     $data->delete();
    //     echo json_encode(array("status" => true));
    // }

    // public function update($data, $message) 
    // {        
    //     $data->assign(array(
    //         'rombongan_belajar_id' => $_POST['rombel'],
    //         'peserta_didik_id' => $_POST['siswa'],
    //         'jenis_pendaftaran_id' => $_POST['jenis']
    //     ));            

    //     if ($data->save()) {
    //         $this->title = 'Sukses';
    //         $this->text = 'Data berhasil diubah';
    //         $this->type = 'success';
    //     } else {
    //         foreach ($errors as $error) {
    //             $this->text .= "$error"."</br>";
    //         }
    //         $this->title = 'Error!';
    //         $this->type = 'warning';
    //     }
    // }   
    
    // public function checkValidation() {
    //     $this->check = new Validation(); 

    //     $this->check->add('rombel', new PresenceOf(array(
    //         'message' => '<b>Rombel</b> tidak boleh kosong'
    //     )));                
    //     $this->check->add('siswa', new PresenceOf(array(
    //         'message' => '<b>Siswa</b> tidak boleh kosong'
    //     )));
    //     $this->check->add('jenis', new PresenceOf(array(
    //         'message' => '<b>Jenis Pendaftaran</b> tidak boleh kosong'
    //     )));

    //     $this->messages = $this->check->validate($_POST);

    //     foreach ($this->messages as $message) {
    //         $this->text .= "$message"."</br>";
    //     }
    //     $this->title = 'Gagal';
    //     $this->type = 'warning';  
    // }    
}