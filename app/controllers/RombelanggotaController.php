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

    public function indexAction($rombel_id = '', $semester_id = '20171')
    {
        $id_ps = $this->session->get('id_ps');
        $usergroup = explode(',', substr($this->session->get('usergroup'), 1, -1));
        $list_ps = substr($id_ps, 1, -1);
        
        // ambil data tingkat berdasar list program studi
        $data_tingkat = RefAkdPs::find([
            "columns" => "id_tingkat",
            "conditions" => "id_ps IN ($list_ps)"
        ]);

        foreach ($data_tingkat as $tingkat) {
            $list_tingkat .= $tingkat["id_tingkat"] . ',';
        }

        $list_tingkat = substr($list_tingkat, 0, -1);

        if ($rombel_id == '') {
            $conditions = "t.tingkat_pendidikan_id IN ($list_tingkat)";
        } else {        
            $conditions = "r.rombongan_belajar_id IN ($rombel_id)";
        }        
        
        $option_conditions = "t.tingkat_pendidikan_id IN ($list_tingkat)";

        $data = $this->modelsManager->createBuilder()
                ->addFrom('RefRombelAnggota', 'a')
                ->join('RefRombonganBelajar', 'a.rombongan_belajar_id = r.rombongan_belajar_id', 'r')
                ->join('RefTingkatPendidikan', 'r.tingkat_pendidikan_id = t.tingkat_pendidikan_id', 't')
                ->join('RefSemester', 'a.semester_id = s.semester_id', 's')
                ->join('RefAkdMhs', 'a.peserta_didik_id = p.id_mhs', 'p')
                ->join('RefJenisPendaftaran', 'a.jenis_pendaftaran_id = j.jenis_pendaftaran_id', 'j')
                ->columns(['a.anggota_rombel_id', 'r.rombongan_belajar_id AS rombel_id', 'r.nama AS nama_rombel', 't.nama AS nama_tingkat', 's.nama AS nama_semester', 'p.id_mhs AS siswa_id', 'p.nama AS nama_siswa', 'p.nis', 'p.foto', 'j.nama AS nama_jenis'])
                ->where($conditions)
                ->andWhere('a.semester_id = ' . $semester_id)
                ->orderBy('r.nama')
                ->getQuery()
                ->execute();
                    
        $rombel = $this->modelsManager->createBuilder()
                ->addFrom('RefRombonganBelajar', 'r')
                ->join('RefSemester', 'r.semester_id = s.semester_id', 's')
                ->join('RefTingkatPendidikan', 'r.tingkat_pendidikan_id = t.tingkat_pendidikan_id', 't')
                ->columns(['r.rombongan_belajar_id', 'r.nama AS nama_rombel', 's.nama AS nama_semester', 't.nama AS nama_tingkat'])
                ->where($option_conditions)
                ->groupBy('r.rombongan_belajar_id')
                ->orderBy('t.nama')
                ->getQuery()
                ->execute();

        $jenis = RefJenisPendaftaran::find(["columns" => "jenis_pendaftaran_id, nama"]);
        $siswa = RefAkdMhs::find(["columns" => "id_mhs AS siswa_id, nama, nis"]);
        $semester = RefSemester::find([
            "columns" => "semester_id , nama",
            "conditions" => "nama NOT LIKE '%-%'",
            "order" => "nama DESC"
        ]);

        $this->view->setVars([
            "data" => $data,
            "rombel" => $rombel,
            "siswa" => $siswa,
            "semester" => $semester,
            "jenis" => $jenis,
            "rombel_id" => $rombel_id,
            "semester_id" => $semester_id
        ]);        
        
        $this->view->pick('rombel/anggota');
    }

    public function addRombelAnggotaAction()
    {        
        $this->checkValidation();
        
        if (count($this->messages) == 0) {
            $exp_siswa = explode(",", $_POST['siswa_id_hidden']);
            
            for ($i=0; $i < count($exp_siswa); $i++) { 
                $data = new RefRombelAnggota();
                $data->assign(array(
                    'rombongan_belajar_id' => $_POST['rombongan_belajar_id'],
                    'semester_id' => $_POST['semester_id'],
                    'peserta_didik_id' => $exp_siswa[$i],
                    'jenis_pendaftaran_id' => $_POST['jenis_pendaftaran_id'],
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
            'rombongan_belajar_id' => $_POST['rombongan_belajar_id'],
            'semester_id' => $_POST['semester_id'],
            'peserta_didik_id' => $_POST['siswa_id'],
            'jenis_pendaftaran_id' => $_POST['jenis_pendaftaran_id']
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
    
    public function presenceOf($validation, $column, $name) 
    {
        $validation->add($column, new PresenceOf([
            'message' => '<b>'.$name.'</b> tidak boleh kosong'
        ]));
    }

    public function checkValidation() 
    {
        $check = new Validation();

        $this->presenceOf($check, 'rombongan_belajar_id', 'Rombel');        
        $this->presenceOf($check, 'semester_id', 'Semester');        
        $this->presenceOf($check, 'siswa_id', 'Murid');        
        $this->presenceOf($check, 'jenis_pendaftaran_id', 'Jenis Pendaftaran');        

        $this->messages = $check->validate($_POST);

        foreach ($this->messages as $message) {
            $this->text .= "$message"."</br>";
        }
        $this->title = 'Gagal';
        $this->type = 'warning';  
    }     
}