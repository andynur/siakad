<?php

use Phalcon\Mvc\View;
use Phalcon\Validation;
use  Phalcon\Validation\Validator\PresenceOf;
use Phalcon\Mvc\Url;

class SysinformasiController extends \Phalcon\Mvc\Controller
{

    public function initialize()
    {
        if (empty($this->session->get('uid'))) {
            $this->response->redirect('account/loginEnd');
        }
    	$this->view->setRenderLevel(View::LEVEL_ACTION_VIEW);
    }

    public function sliderAction($value='')
    {
        $phql = "SELECT id,nama,aktif from RefSlider";
        $slider = $this->modelsManager->executeQuery($phql);
        $this->view->slider = $slider;
        $this->view->pick('informasi/slider');
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

    public function delSliderImageAction()
    {
        $id = $_POST['id'];
        $nama_file = $_POST['nama'];
        $urel =  DOCUMENT_ROOT.'slider/'.$nama_file;
        //delete image gan
        unlink($urel);

        $this->view->setRenderLevel(View::LEVEL_ACTION_VIEW);
        $del=RefSlider::findById($id);
        $del->delete();
        echo json_encode(array("status" => true));
    }

    public function uploadSliderAction($value='')
    {
        $urel =  DOCUMENT_ROOT.'slider/';
        // Check if the user has uploaded files
        if ($this->request->hasFiles()) {
            $files = $this->request->getUploadedFiles();

            // Print the real file names and sizes
            foreach ($files as $file) {

                //validasi men
                if ($this->imageCheck($file->getRealType())) {
                    if ($file->moveTo( $urel.$file->getName())) {
                        $slider = new RefSlider();
                        $slider->assign(array(
                                    'nama' => $file->getName(),
                                    'aktif' => "Y"
                                    )
                                );

                        $slider->save();
                        $notif = array(
                            'title' => 'success',
                            'text' => 'Data berhasil di Upload',
                            'type' => 'success',
                        );
                    } else {
                        $notif = array(
                            'title' => 'warning',
                            'text' => "Gagal Upload",
                            'type' => 'warning',
                        );
                    }
                    echo json_encode($notif);
                } else {
                    $notif = array(
                        'title' => 'warning',
                        'text' => "Gagal Upload. File harus Image",
                        'type' => 'warning',
                    );
                    echo json_encode($notif);
                }                
                
            }
        }
    }

    public function editSliderAction($id)
    {
        $berita = RefSlider::findFirstById($id);
        $berita->assign(array(
                    'aktif' => $_POST['aktif']
                    )
                );

        $berita->save();
        $notif = array(
            'title' => 'success',
            'text' => 'Data berhasil di input',
            'type' => 'success',
        );

        echo json_encode($notif);
    }

    ////////////////////////////////
    ///////////BERITA////////
    ///////////////////////////////


    public function beritaAction($value='')
    {
        $phql = "SELECT id,judul,berita,tampil from RefBerita where jenis = 'pengumuman' ";
        $berita = $this->modelsManager->executeQuery($phql);
        $this->view->berita = $berita;
        $this->view->pick('informasi/berita');
        // $data_user = LogAktifitasUser::find();
        // foreach ($data_user as $key => $value) {
        //     echo "<pre>".print_r($value->nama,1)."</pre>";
        // }die();
        // $exp = explode('/', $_SERVER['REQUEST_URI']);
        // array_shift($exp);
        // array_shift($exp);
        // $action = implode('/', $exp);

    }

    public function editBeritaAction($id)
    {

        $validation = new Phalcon\Validation(); 
        $validation->add('berita', new PresenceOf(array(
            'message' => 'Berita tidak boleh kosong'
        )));
        $validation->add('judul', new PresenceOf(array(
            'message' => 'Judul tidak boleh kosong'
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
            $berita = RefBerita::findFirstById($id);
            $berita->assign(array(
                        'judul' => $_POST['judul'],
                        'berita' => $_POST['berita'],
                        'tampil' => $_POST['tampil']
                        )
                    );

            $berita->save();
            $notif = array(
                'title' => 'success',
                'text' => 'Data berhasil di input',
                'type' => 'success',
            );
        }

        echo json_encode($notif);
    }

    public function addBeritaAction($value='')
    {
        $validation = new Phalcon\Validation(); 
        $validation->add('judul', new PresenceOf(array(
            'message' => 'Judul tidak boleh kosong'
        )));
        $validation->add('berita', new PresenceOf(array(
            'message' => 'Berita tidak boleh kosong'
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
            $berita = new RefBerita();
            $berita->assign(array(
                        'judul' => $_POST['judul'],
                        'berita' => $_POST['berita'],
                        'jenis' => 'pengumuman',
                        'tampil' => 'Y'
                        )
                    );

            $berita->save();
            $notif = array(
                'title' => 'success',
                'text' => 'Data berhasil di input',
                'type' => 'success',
            );
        }

        echo json_encode($notif);
    }

    ////////////////////////////////
    ///////////TEXT BERJALAN////////
    ///////////////////////////////

    public function textBerjalanAction($value='')
    {
        $phql = "SELECT id,berita,tampil from RefBerita where jenis = 'teks_berjalan' ";
        $berita = $this->modelsManager->executeQuery($phql);
        $this->view->berita = $berita;
        $this->view->pick('informasi/text_berjalan');
    }
    public function delBeritaBerjalanAction($id)
    {
        $this->view->setRenderLevel(View::LEVEL_ACTION_VIEW);
        $del=RefBerita::findById($id);
        $del->delete();
        echo json_encode(array("status" => true));
    }


    public function editBeritaBerjalanAction($id)
    {

        $validation = new Phalcon\Validation(); 
        $validation->add('berita', new PresenceOf(array(
            'message' => 'Berita tidak boleh kosong'
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
            $berita = RefBerita::findFirstById($id);
            $berita->assign(array(
                        'berita' => $_POST['berita'],
                        'tampil' => $_POST['tampil']
                        )
                    );

            $berita->save();
            $notif = array(
                'title' => 'success',
                'text' => 'Data berhasil di input',
                'type' => 'success',
            );
        }

        echo json_encode($notif);
    }

    public function addBeritaBerjalanAction($value='')
    {
        $validation = new Phalcon\Validation(); 
        $validation->add('berita', new PresenceOf(array(
            'message' => 'Berita tidak boleh kosong'
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
            $berita = new RefBerita();
            $berita->assign(array(
                        'berita' => $_POST['berita'],
                        'jenis' => 'teks_berjalan',
                        'tampil' => 'Y'
                        )
                    );

            $berita->save();
            $notif = array(
                'title' => 'success',
                'text' => 'Data berhasil di input',
                'type' => 'success',
            );
        }

        echo json_encode($notif);
    }

}

