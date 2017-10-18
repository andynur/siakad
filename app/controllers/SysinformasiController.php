<?php

use Phalcon\Mvc\View;
use Phalcon\Validation;
use Phalcon\Validation\Validator\PresenceOf;
use Phalcon\Mvc\Url;
use Phalcon\Mvc\Model\Query\Builder;
use Phalcon\Image\Adapter\Imagick;

class SysinformasiController extends \Phalcon\Mvc\Controller
{
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

    public function presenceOf($validation, $column, $name) 
    {
        $validation->add($column, new PresenceOf([
            'message' => '<b>'.$name.'</b> tidak boleh kosong'
        ]));
    }

    // -------------------------------------------------
    // MODUL SLIDER
    // -------------------------------------------------

    public function sliderAction()
    {
        $data = RefSlider::find(['order' => 'id DESC']);

        $this->view->data = $data;
        $this->view->pick('informasi/slider');
    }

    public function deleteSliderAction($id)
    {
        $this->view->setRenderLevel(View::LEVEL_ACTION_VIEW);        
        $data = RefSlider::findFirst($id);
        $img = $data->nama;
        $path = DOCUMENT_ROOT. 'img/galeri/' . $img;
        $thumb_path = DOCUMENT_ROOT. 'img/galeri/thumb/' . $img;
        $message = ["status" => false];
        
        if ($data->delete()) {
            unlink($path);
            unlink($thumb_path);
            $message = ["status" => true];
        }
        
        echo json_encode($message);
    }

    public function addSliderAction()
    {
        $this->sliderValidation();    

        if (count($this->messages) == 0) {        
            $path =  DOCUMENT_ROOT . 'img/galeri/';
            
            if ($this->request->hasFiles()) {
                $files = $this->request->getUploadedFiles();

                foreach ($files as $file) {
                    $ext = $file->getExtension();
                    $nama_file = md5(uniqid(rand(), true)) . '.' . $ext;
                    $path_file = $path . $nama_file;   

                    if ($this->imageCheck($file->getRealType())) {
                        if ($file->moveTo($path_file)) {
                            // resize image to 1000px
                            $image = new Imagick($path_file);
                            $image->resize(
                                1000,
                                null,
                                \Phalcon\Image::WIDTH
                            )->save();                            
                            // resize for thumbnail image
                            $thumbnail = new Imagick($path_file);
                            $new_thumbnail = $path . '/thumb/' . $nama_file;
                            $thumbnail->resize(
                                150,
                                null,
                                \Phalcon\Image::WIDTH
                            )->save($new_thumbnail);

                            $foto = $nama_file;
                        } else {                    
                            die('gagal masuk bro!');
                        }
                    }
                }

                $data = new RefSlider();
                $data->assign([
                    'nama' => $foto, 
                    'judul' => $_POST['judul'], 
                    'deskripsi' => $_POST['deskripsi'], 
                    'aktif' => $_POST['aktif']
                ]);
        
                if ($data->save()) {
                    $this->title = 'Sukses';
                    $this->text = 'Data berhasil diupload';
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
        }

        $notif = ['title' => $this->title, 'text' => $this->text, 'type' => $this->type];
        echo json_encode($notif);             
    }

    public function sliderValidation() 
    {
        $check = new Validation();

        $this->presenceOf($check, 'judul', 'Judul Foto');        
        $this->presenceOf($check, 'deskripsi', 'Deskripsi foto');

        $this->messages = $check->validate($_POST);

        foreach ($this->messages as $message) {
            $this->text .= "$message"."</br>";
        }
        $this->title = 'Gagal';
        $this->type = 'warning';  
    }
    
    public function editSliderAction($id)
    {
        $this->sliderValidation();  

        if (count($this->messages) == 0) {        
            $path = DOCUMENT_ROOT. 'img/galeri/';
            $thumb_path = DOCUMENT_ROOT. 'img/galeri/thumb/';       
            $foto_lama = $_POST['foto_lama'];     
            
            if ($this->request->hasFiles()) {
                foreach ($this->request->getUploadedFiles() as $file) {
                    // check if file updated
                    if ($file->getSize() > 0) {
                        // remove old image                      
                        unlink($path . $foto_lama);
                        unlink($thumb_path . $foto_lama);
                        
                        // add new image
                        $ext = $file->getExtension();
                        $nama_file = md5(uniqid(rand(), true)) . '.' . $ext;
                        $path_file = $path . $nama_file;   

                        if ($this->imageCheck($file->getRealType())) {
                            if ($file->moveTo($path_file)) {
                                // resize image to 1000px
                                $image = new Imagick($path_file);
                                $image->resize(
                                    1000,
                                    null,
                                    \Phalcon\Image::WIDTH
                                )->save();                               
                                // resize for thumbnail image
                                $thumbnail = new Imagick($path_file);
                                $new_thumbnail = $path . '/thumb/' . $nama_file;
                                $thumbnail->resize(
                                    150,
                                    null,
                                    \Phalcon\Image::WIDTH
                                )->save($new_thumbnail);
                                // foto name for database
                                $foto = $nama_file;
                            } else {                    
                                die('gagal masuk bro!');
                            }
                        }
                    } else {
                        $foto = $foto_lama;
                    }
                }
            }
            
            $data = RefSlider::findFirst($id);            
            $data->assign([
                'nama' => $foto, 
                'judul' => $_POST['judul'], 
                'deskripsi' => $_POST['deskripsi'], 
                'aktif' => $_POST['aktif']
            ]);
    
            if ($data->save()) {
                $this->title = 'Sukses';
                $this->text = 'Data berhasil diupdate';
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

        $notif = ['title' => $this->title, 'text' => $this->text, 'type' => $this->type];
        echo json_encode($notif); 
    }

    // -------------------------------------------------
    // MODUL BERITA
    // -------------------------------------------------

    public function beritaAction($jenis)
    {
        $data = RefBerita::find([
            "conditions" => "jenis = '$jenis'",
            "order" => "id DESC"
        ]);
        
        $this->view->data = $data;
        $this->view->jenis = $jenis;
        
        $pickWiew = 'informasi/berita';
        
        if ($jenis == 'teks_berjalan') {
            $pickWiew = 'informasi/text_berjalan';
        } 

        $this->view->pick($pickWiew);
    }

    public function addBeritaAction($jenis)
    {        
        $this->beritaValidation();
        
        if (count($this->messages) == 0) {
            $data = new RefBerita();
            $this->saveBerita($data, $jenis, 'tambah');        
        }
        
        $notif = ['title' => $this->title, 'text' => $this->text, 'type' => $this->type];
        echo json_encode($notif);        
    }

    public function editBeritaAction($id, $jenis)
    {
        $this->beritaValidation();
        
        if (count($this->messages) == 0) {
            $data = RefBerita::findFirst($id);
            $this->saveBerita($data, $jenis, 'ubah');
        }

        $notif = ['title' => $this->title, 'text' => $this->text, 'type' => $this->type];
        echo json_encode($notif);     
    }    

    public function deleteBeritaAction($id)
    {
        $this->view->setRenderLevel(View::LEVEL_ACTION_VIEW);

        $data = RefBerita::findFirst($id);
        $data->delete();

        echo json_encode(["status" => true]);
    }

    public function saveBerita($data, $jenis, $message) 
    {
        if ($_POST['tgl_publikasi']) {
            $publikasi = $_POST['tgl_publikasi'];
        } else {
            $publikasi = date('Y-m-d');
        }

        $data->assign(array(
            'berita' => $_POST['berita'],
            'jenis' => $jenis,
            'tgl_publikasi' => $publikasi,
            'tampil' => $_POST['aktif']
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
    
    public function beritaValidation() 
    {
        $check = new Validation();
 
        $this->presenceOf($check, 'berita', 'Isi Berita');        

        $this->messages = $check->validate($_POST);

        foreach ($this->messages as $message) {
            $this->text .= "$message"."</br>";
        }
        $this->title = 'Gagal';
        $this->type = 'warning';  
    } 

}

