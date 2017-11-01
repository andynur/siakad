<?php

use Phalcon\Mvc\View;
use Phalcon\Validation;
use Phalcon\Validation\Validator\PresenceOf;
use Phalcon\Mvc\Url;
use Phalcon\Mvc\Model\Query\Builder;
use Phalcon\Image\Adapter\Imagick;

class PengumumanController extends \Phalcon\Mvc\Controller
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
                ->addFrom('RefPengumuman', 'p')
                ->join('ViewUser', 'p.pengirim_uid = u.login', 'u')
                ->columns(['p.pengumuman_id', 'p.judul', 'p.isi', 'p.tanggal', 'u.login', 'u.nama', 'u.foto', 'p.tujuan', 'p.lampiran', 'p.status'])
                ->orderBy('p.pengumuman_id DESC')
                ->getQuery()
                ->execute();

        $rombel = $this->modelsManager->createBuilder()
                ->addFrom('RefRombonganBelajar', 'r')
                ->join('RefTingkatPendidikan', 'r.tingkat_pendidikan_id = t.tingkat_pendidikan_id', 't')
                ->columns(['r.rombongan_belajar_id AS id', 'r.nama', 't.nama AS tingkat'])
                ->where('r.tipe = "umum"')
                ->orderBy('t.nama ASC')
                ->getQuery()
                ->execute();                

        $this->view->setVars([
            "data" => $data,
            "rombel" => $rombel
        ]);

        $this->view->pick('pengumuman/index');
    }

    public function getPengumumanAction($id)
    {
        $this->view->disable();

        $data = RefPengumuman::findFirst($id);

        echo json_encode($data);
    }

    public function addPengumumanAction()
    {        
        $this->checkValidation();
        
        if (count($this->messages) == 0) {
            $data = new RefPengumuman();
            $this->save($data, 'tambah');        
        }
        
        $notif = ['title' => $this->title, 'text' => $this->text, 'type' => $this->type];
        echo json_encode($notif);        
    }

    public function editPengumumanAction($id)
    {
        $this->checkValidation();
        
        if (count($this->messages) == 0) {
            $data = RefPengumuman::findFirst($id);
            $this->save($data, 'ubah');
        }

        $notif = ['title' => $this->title, 'text' => $this->text, 'type' => $this->type];
        echo json_encode($notif);     
    }    

    public function deletePengumumanAction($id)
    {
        $this->view->setRenderLevel(View::LEVEL_ACTION_VIEW);

        $data = RefPengumuman::findFirst($id);
        unlink(DOCUMENT_ROOT . 'img/pengumuman/' . $data->lampiran);
        $data->delete();

        echo json_encode(["status" => true]);
    }

    public function save($data, $message) 
    {
        $img_path = DOCUMENT_ROOT. 'img/pengumuman/';
        $foto_lama = $_POST['foto_lama'];     
        
        if ($this->request->hasFiles()) {
            foreach ($this->request->getUploadedFiles() as $file) {
                // check if file is uploaded
                if ($file->getSize() > 0) {                    
                    // add new image
                    $ext = $file->getExtension();
                    $nama_file = md5(uniqid(rand(), true)) . '.' . $ext;
                    $path_file = $img_path . $nama_file;   

                    if ($this->imageCheck($file->getRealType())) {
                        if ($file->moveTo($path_file)) {
                            // resize image to 600px
                            $image = new Imagick($path_file);
                            $image->resize(
                                600,
                                null,
                                \Phalcon\Image::WIDTH
                            )->save();                               

                            $foto = $nama_file;
                        } else {                    
                            die('gagal masuk bro!');
                        }
                    }
                } else {
                    $foto = '';                

                    if ($message == 'ubah') {
                        $foto = $foto_lama;
                    }
                }
            }
        }

        $data->assign([
            'judul' => $_POST['judul'],
            'isi' => $_POST['isi'],
            'tanggal' => $_POST['tgl_kirim'],
            'pengirim_uid' => $this->session->get('uid'),
            'tujuan' => $_POST['tujuan_hidden'],
            'lampiran' => $foto,
            'status' => $_POST['status'],
        ]);
        
        if ($data->save()) {
            // remove old image                  
            if ($foto != $foto_lama) {
                unlink($img_path . $foto_lama);
            }            

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

    public function presenceOf($validation, $column, $name) 
    {
        $validation->add($column, new PresenceOf([
            'message' => '<b>'.$name.'</b> tidak boleh kosong'
        ]));
    }

    public function checkValidation() 
    {
        $check = new Validation();
 
        $this->presenceOf($check, 'judul', 'Judul Pengumuman');        
        $this->presenceOf($check, 'isi', 'Isi Pengumuman');        
        $this->presenceOf($check, 'tujuan', 'Tujuan');        
        $this->presenceOf($check, 'tanggal', 'Tanggal Kirim');        
        $this->presenceOf($check, 'status', 'Status');        

        $this->messages = $check->validate($_POST);

        foreach ($this->messages as $message) {
            $this->text .= "$message"."</br>";
        }
        $this->title = 'Gagal';
        $this->type = 'warning';  
    }  

    private function imageCheck($extension)
    {
        $allowedTypes = [
            'image/gif',
            'image/jpg',
            'image/png',
            'image/jpeg'
        ];

        return in_array($extension, $allowedTypes);
    }    
}