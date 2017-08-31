<?php

use Phalcon\Mvc\View;
use Phalcon\Validation;
use Phalcon\Validation\Validator\PresenceOf;
use Phalcon\Mvc\Url;
use Phalcon\Mvc\Model\Query\Builder;
use Phalcon\Http\Request\File;

class PesertaDidikController extends \Phalcon\Mvc\Controller
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

    public function kelasAction($rombel_id)
    {
        $data = $this->modelsManager->createBuilder()
                ->addFrom('RefRombelAnggota', 'a')
                ->join('RefRombonganBelajar', 'a.rombongan_belajar_id = r.rombongan_belajar_id', 'r')
                ->join('RefTingkatPendidikan', 'r.tingkat_pendidikan_id = t.tingkat_pendidikan_id', 't')
                ->join('RefSemester', 'r.semester_id = s.semester_id', 's')
                ->join('RefKurikulum', 'r.kurikulum_id = k.kurikulum_id', 'k')        
                ->join('RefAkdMhs', 'a.peserta_didik_id = m.id_mhs', 'm')
                ->columns(['m.id_mhs AS siswa_id', 'm.nama AS nama_siswa', 'm.foto', 'm.nis', 'm.gender', 'm.alamat', 'm.nomor_telepon_seluler AS nomor_ibu', 'm.nomor_telepon_seluler_2 AS nomor_ayah', 'm.email', 'm.nama_ayah', 'm.nama_ibu', 'r.nama AS nama_rombel', 't.nama AS nama_tingkat', 's.semester_id', 'k.kurikulum_id'])
                ->where('a.rombongan_belajar_id = ' . $rombel_id)
                ->orderBy('m.nama ASC')
                ->getQuery()
                ->execute();

        $semester = RefSemester::find(["columns" => "semester_id, nama"]);
        $kurikulum = RefKurikulum::find(["columns" => "kurikulum_id, nama_kurikulum"]);

        $this->view->data = $data;
        $this->view->rombel_id = $rombel_id;
        $this->view->semester = $semester;
        $this->view->kurikulum = $kurikulum;
        $this->view->pick('peserta_didik/kelas');
    }

    public function addSiswaAction($rombel_id)
    {
        $rombel = $this->modelsManager->createBuilder()
                ->addFrom('RefRombonganBelajar', 'r')
                ->join('RefSemester', 'r.semester_id = s.semester_id', 's')
                ->join('RefKurikulum', 'r.kurikulum_id = k.kurikulum_id', 'k')
                ->join('RefTingkatPendidikan', 'r.tingkat_pendidikan_id = t.tingkat_pendidikan_id', 't')
                ->columns(['r.rombongan_belajar_id', 'r.nama AS nama_rombel', 's.nama AS nama_semester', 't.nama AS nama_tingkat', 'k.nama_kurikulum'])                
                ->getQuery()
                ->execute();

        $agama = RefAgama::find();
        $provinsi = RefSysProvinsi::find();
        $kabupaten = RefSysKabupaten::find();
        $kecamatan = RefSysKecamatan::find();
        $kelurahan = RefSysKelurahan::find();
        $pekerjaan = RefPekerjaan::find();
        $pendidikan = RefJenjangPendidikan::find();
        $penghasilan = RefPenghasilanOrangtuaWali::find();
        $transportasi = RefAlatTransportasi::find();
        $tinggal = RefJenisTinggal::find();
        
        $this->view->setVars([
            "agama" => $agama,
            "rombel" => $rombel,
            "provinsi" => $provinsi,
            "kabupaten" => $kabupaten,
            "kecamatan" => $kecamatan,
            "kelurahan" => $kelurahan,
            "pekerjaan" => $pekerjaan,
            "pendidikan" => $pendidikan,
            "penghasilan" => $penghasilan,
            "transportasi" => $transportasi,
            "tinggal" => $tinggal,
            "id" => $rombel_id
        ]);
        
        $this->view->pick('peserta_didik/add');
    }

    public function newSiswaAction() 
    {
        $this->checkValidation();
        
        if (count($this->messages) == 0) {
            $data = new RefAkdMhs();
            $this->save($data, 'tambah');   
        }
        
        $notif = ['title' => $this->title, 'text' => $this->text, 'type' => $this->type];
        echo json_encode($notif);        
    }

    public function save($data, $message) 
    {
        $get_session = $this->session->get('ps_id');
        $explode = explode('-', $get_session);
        $ps_id = $explode[1];
        $rombel_id = $_POST['rombel'];
        $foto = 'woman-1.png'; // default
        $path =  DOCUMENT_ROOT . 'img/mhs/';

        if ($this->request->hasFiles() == true) {
            foreach ($this->request->getUploadedFiles() as $file) {
                $ext = explode('/', $file->getRealType()) ;
                $nama_file = md5(uniqid(rand(), true)) . '.' . $ext[1];
                
                if ($this->imageCheck($file->getRealType())) {
                    if ($file->moveTo($path.$nama_file)) {
                        $foto = $nama_file;
                    } else {                    
                        die('gagal masuk bro!');
                    }
                }
            }
        } else {
            die('gk masuk piye bro');
        }

        $data->assign(array(
            'id_jenis' => 2,
            'nama' => $_POST['nama'],
            'id_ps' => $ps_id,
            'ps_kur' => 1,
            'id_agama' => 1,
            'foto' => $foto,
            'rombel_sekarang' => $rombel_id,
            'gol_darah' => $_POST['gol_darah'],
            'gender' => $_POST['gender'],
            'nik' => $_POST['nik'],
            'alamat_jalan' => $_POST['alamat_jalan'],
            'rt' => $_POST['rt'],
            'rw' => $_POST['rw'],
            'nama_dusun' => $_POST['dusun'],
            'desa_kelurahan' => $_POST['kelurahan'],
            'kode_kec' => $_POST['kecamatan'],
            'kode_kab' => $_POST['kota'],
            'kode_prop' => $_POST['provinsi'],
            'kode_pos' => $_POST['kode_pos'],
            'telpon' => $_POST['telpon'],
            'nomor_telepon_seluler' => $_POST['nomor_ayah'],
            'nomor_telepon_seluler_2' => $_POST['nomor_ibu'],
            'tgl_lahir' => $_POST['tgl_lahir'],
            'tgl_masuk' => $_POST['tgl_masuk'],
            'tempat_lahir' => $_POST['tempat_lahir'],
            'nis' => $_POST['nis'],
            'nisn' => $_POST['nisn'],
            'email' => $_POST['email'],
            'warganegara' => 1,
  
            'nama_ayah' => $_POST['nama_ayah'],
            'nama_ibu' => $_POST['nama_ibu'],
            'agama_ayah' =>  $_POST['agama_ayah'],
            'agama_ibu' =>  $_POST['agama_ibu'],
            'edu_ayah' =>  $_POST['pendidikan_ayah'],
            'edu_ibu' =>  $_POST['pendidikan_ibu'],
            'job_ayah' =>  $_POST['pekerjaan_ayah'],
            'job_ibu' =>  $_POST['pekerjaan_ibu'],
            'penghasilan_ortu' =>  $_POST['penghasilan_ayah'],
            'penghasilan_id_ibu' =>  $_POST['penghasilan_ibu'],
  
            'alamat_ortu' => $_POST['alamat_ortu'],
            'soft_delete' => 0,
            'updater_id' => 0            
        ));                              

        if ($data->save()) {
            $new_id = $data->getWriteConnection()->lastInsertId();
            $anggota = new RefRombelAnggota();
            $anggota->assign([
                'rombongan_belajar_id' => $rombel_id,
                'peserta_didik_id' => $new_id,
                'jenis_pendaftaran_id' => 1,
                'soft_delete' => 0,
                'updater_id' => 0
            ]);
            $anggota->save();            

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

    public function validation($validation, $column, $name) 
    {
        $validation->add($column, new PresenceOf([
            'message' => '<b>'.$name.'</b> tidak boleh kosong'
        ]));
    }

    public function checkValidation() 
    {
        $check = new Validation();

        $this->validation($check, 'nama', 'Nama Siswa');        
        $this->validation($check, 'tempat_lahir', 'Tempat lahir');        
        $this->validation($check, 'tgl_lahir', 'Tanggal lahir');        
        $this->validation($check, 'gender', 'Jenis kelamin');        

        $this->messages = $check->validate($_POST);

        foreach ($this->messages as $message) {
            $this->text .= "$message"."</br>";
        }
        $this->title = 'Gagal';
        $this->type = 'warning';  
    }     

    public function searchKabupatenAction($provinsi)
    {
        if ($provinsi != '') {
            $kabupaten = RefSysKabupaten::find([
                "conditions" => "province_id = $provinsi"
            ]);           

            echo json_encode($kabupaten->toArray());
        } else {
            echo json_encode('');
        }

        $this->view->disable();
    }

    public function searchKecamatanAction($kabupaten)
    {
        if ($kabupaten != '') {
            $kecamatan = RefSysKecamatan::find([
                "conditions" => "regency_id = $kabupaten"
            ]);           

            echo json_encode($kecamatan->toArray());
        } else {
            echo json_encode('');
        }

        $this->view->disable();
    }

    public function searchKelurahanAction($kecamatan)
    {
        if ($kecamatan != '') {
            $kelurahan = RefSysKelurahan::find([
                "conditions" => "district_id = $kecamatan"
            ]);           

            echo json_encode($kelurahan->toArray());
        } else {
            echo json_encode('');
        }
        
        $this->view->disable();
    }

    public function searchRombelAction($id)
    {
        $rombel = $this->modelsManager->createBuilder()
            ->addFrom('RefRombonganBelajar', 'r')
            ->join('RefSemester', 'r.semester_id = s.semester_id', 's')
            ->join('RefKurikulum', 'r.kurikulum_id = k.kurikulum_id', 'k')
            ->columns(['s.nama AS nama_semester', 'k.nama_kurikulum'])
            ->where('r.rombongan_belajar_id = ' . $id)
            ->getQuery()
            ->execute();         

        echo json_encode($rombel->toArray());
        
        $this->view->disable();
    }

}

