<?php

use Phalcon\Mvc\View;
use Phalcon\Validation;
use Phalcon\Validation\Validator\PresenceOf;
use Phalcon\Mvc\Url;
use Phalcon\Mvc\Model\Query\Builder;
use Phalcon\Image\Adapter\Imagick;

class SdmController extends \Phalcon\Mvc\Controller
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

    public function indexAction($jenjang = '')
    {
        if ($jenjang == '') {
            $conditions = "";
        } else {
            $conditions = "jenjang = '$jenjang'";
        }

        $data = RefAkdSdm::find([
            "columns" => "id_sdm, nip, jenjang, nama, kelamin, foto, status_keaktifan_id, nuptk",
            "conditions" => $conditions,
            "order" => "nama"
        ]);           

        $this->view->setVars(["data" => $data]);
        $this->view->pick('sdm/index');
    }

    public function formSdmAction()
    {        
        $provinsi = RefWilayah::find([
            "columns" => "kode_wilayah, nama",
            "conditions" => "id_level_wilayah = 1",
            "order" => "nama"
        ]);
        $agama = RefAgama::find();
        $jenis_ptk = RefJenisPtk::find();
        $status_kepegawaian = RefStatusKepegawaian::find();
        $lembaga_pengangkat = RefLembagaPengangkat::find();
        $pangkat_golongan = RefPangkatGolongan::find();
        $keahlian_laboratorium = RefKeahlianLaboratorium::find();
        $sumber_gaji = RefSumberGaji::find();
        
        $this->view->setVars([
            "agama" => $agama,
            "provinsi" => $provinsi,
            "jenis_ptk" => $jenis_ptk,
            "status_kepegawaian" => $status_kepegawaian,
            "lembaga_pengangkat" => $lembaga_pengangkat,
            "pangkat_golongan" => $pangkat_golongan,
            "keahlian_laboratorium" => $keahlian_laboratorium,
            "sumber_gaji" => $sumber_gaji,            
            "url_back" => $_POST['url_back']
        ]);        

        $this->view->pick('sdm/form');
    }

    public function formEditSdmAction($id)
    {        
        $data = RefAkdSdm::findFirst($id);
        // 040110AA / 040110 / 040100 / 040000 / 040000
        $kelurahan = RefWilayah::findFirst([
            "columns" => "kode_wilayah AS id, mst_kode_wilayah, nama",
            "conditions" => "kode_wilayah = '$data->kode_wilayah'"
        ]);   
        $kecamatan = RefWilayah::findFirst([
            "columns" => "kode_wilayah AS id, mst_kode_wilayah, nama",
            "conditions" => "kode_wilayah = '$kelurahan->mst_kode_wilayah'"
            ]);        
        $kabupaten = RefWilayah::findFirst([
            "columns" => "kode_wilayah AS id, mst_kode_wilayah, nama",
            "conditions" => "kode_wilayah = '$kecamatan->mst_kode_wilayah'"
        ]);    
        $provinsi = RefWilayah::findFirst([
            "columns" => "kode_wilayah AS id, nama",
            "conditions" => "kode_wilayah = '$kabupaten->mst_kode_wilayah'"
        ]);            

        $provinsi_list = RefWilayah::find([
            "columns" => "kode_wilayah, nama",
            "conditions" => "id_level_wilayah = 1",
            "order" => "nama"
        ]);                    

        $agama = RefAgama::find();
        $jenis_ptk = RefJenisPtk::find();
        $status_kepegawaian = RefStatusKepegawaian::find();
        $lembaga_pengangkat = RefLembagaPengangkat::find();
        $pangkat_golongan = RefPangkatGolongan::find();
        $keahlian_laboratorium = RefKeahlianLaboratorium::find();
        $sumber_gaji = RefSumberGaji::find();
        
        $this->view->setVars([
            "data" => $data,
            "agama" => $agama,
            "provinsi_list" => $provinsi_list,
            "provinsi" => $provinsi,
            "kabupaten" => $kabupaten,
            "kecamatan" => $kecamatan,
            "jenis_ptk" => $jenis_ptk,
            "status_kepegawaian" => $status_kepegawaian,
            "lembaga_pengangkat" => $lembaga_pengangkat,
            "pangkat_golongan" => $pangkat_golongan,
            "keahlian_laboratorium" => $keahlian_laboratorium,
            "sumber_gaji" => $sumber_gaji,            
            "url_back" => $_POST['url_back']
        ]);        

        $this->view->pick('sdm/form_edit');
    }    

    public function addSdmAction()
    {
        $this->sdmValidation();
        
        if (count($this->messages) == 0) {
            $data = new RefAkdSdm();
            $this->save($data, 'tambah');
        }

        $notif = ['title' => $this->title, 'text' => $this->text, 'type' => $this->type];
        echo json_encode($notif);     
    } 

    public function editSdmAction($id)
    {
        $this->sdmValidation();
        
        if (count($this->messages) == 0) {
            $data = RefAkdSdm::findFirst($id);
            $this->save($data, 'ubah');
        }

        $notif = ['title' => $this->title, 'text' => $this->text, 'type' => $this->type];
        echo json_encode($notif);     
    }    

    public function deleteSdmAction($id)
    {
        $this->view->setRenderLevel(View::LEVEL_ACTION_VIEW);

        $data = RefAkdSdm::findFirst($id);
        unlink(DOCUMENT_ROOT . 'img/sdm/' . $data->foto);
        $data->delete();

        echo json_encode(["status" => true]);
    }

    public function save($data, $message) 
    {
        $img_path = DOCUMENT_ROOT. 'img/sdm/';
        $foto = '';    
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
                            // resize image to 200px
                            $image = new Imagick($path_file);
                            $image->resize(
                                200,
                                null,
                                \Phalcon\Image::WIDTH
                            )->save();                               

                            $foto = $nama_file;
                        } else {                    
                            die('gagal masuk bro!');
                        }
                    }
                } else {                            
                    if ($message == 'ubah') {
                        $foto = $foto_lama;
                    }
                }
            }
        }

        $data->assign([
            "nama" => $_POST['nama'],
            "jenjang" => $_POST['jenjang'],
            "nip" => $_POST['nip'],
            "nik" => $_POST['nik'],
            "nuptk" => $_POST['nuptk'],
            "nik" => $_POST['nik'],
            "niy_nigk" => $_POST['niy_nigk'],
            "tmp_lahir" => $_POST['tempat_lahir'],
            "tgl_lahir" => $_POST['tanggal_kirim'],
            "jenis_kelamin" => $_POST['jenis_kelamin'],
            "kode_agama" => $_POST['agama'],
            "foto" => $foto,
            "alamat" => $_POST['alamat'],
            "rt" => $_POST['rt'],
            "rw" => $_POST['rw'],
            "nama_dusun" => $_POST['dusun'],
            "desa_kelurahan" => $_POST['kelurahan'],
            "kode_wilayah" => $_POST['kode_wilayah'],
            "kode_pos" => $_POST['kode_pos'],
            "telpon" => $_POST['no_telepon_rumah'],
            "no_hp" => $_POST['no_hp'],
            "e_mail" => $_POST['email'],
            "status_kepegawaian_id" => $_POST['status_kepegawaian_id'],
            "jenis_ptk_id" => $_POST['jenis_ptk_id'],
            "status_keaktifan_id" => $_POST['status_keaktifan_id'],
            "lembaga_pengangkat_id" => $_POST['lembaga_pengangkat_id'],
            "pangkat_golongan_id" => $_POST['pangkat_golongan_id'],
            "keahlian_laboratorium_id" => $_POST['keahlian_laboratorium_id'],
            "sumber_gaji_id" => $_POST['sumber_gaji_id']
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

    public function sdmValidation() 
    {
        $check = new Validation();
 
        $this->presenceOf($check, 'nama', 'Nama Lengkap');        
        $this->presenceOf($check, 'nip', 'Isi Sdm');        
        $this->presenceOf($check, 'tempat_lahir', 'Tempat Lahir');        
        $this->presenceOf($check, 'tanggal_lahir', 'Tanggal Lahir');        
        $this->presenceOf($check, 'jenis_kelamin', 'Jenis Kelamin');        
        $this->presenceOf($check, 'jenjang', 'Jenjang');        

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
    
    public function searchWilayahAction($id)
    {
        if ($id != '') {
            $wilayah = RefWilayah::find([
                "columns" => "kode_wilayah, nama",
                "conditions" => "mst_kode_wilayah = '$id'",
                "order" => "nama"
            ]);

            echo json_encode($wilayah->toArray());
        } else {
            echo json_encode('');
        }

        $this->view->disable();
    }    

}