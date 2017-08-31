<?php
use Phalcon\Mvc\View;
use Phalcon\Validation;
use Phalcon\Forms\Element\Text;
use Phalcon\Validation\Validator\Date;
use Phalcon\Validation\Validator\PresenceOf;
use Phalcon\Validation\Validator\Numericality;

class AkademikController extends \Phalcon\Mvc\Controller
{
  	public function initialize()
    {
      if (empty($this->session->get('uid'))) {
          $this->response->redirect('account/loginEnd');
      }
      $this->view->setRenderLevel(View::LEVEL_ACTION_VIEW);
    }

//////////////////////////////////////////////////////////////////////////
//////////////////////// KURIKULUM ///////////////////////////////////////
//////////////////////////////////////////////////////////////////////////

    public function kurikulumAction()
    {
      $get_session = $this->session->get('ps_id');
      $explode = explode('-', $get_session);
      $ps_id = $explode[1];

      $sql = "SELECT DISTINCT (thn_kur) AS thn_kur FROM RefAkdMku where ps_id = '$ps_id' ORDER BY thn_kur DESC";
      $query = $this->modelsManager->executeQuery($sql);

      $a = "SELECT * FROM RefSysAgama";
      $agama = $this->modelsManager->executeQuery($a);

      $this->view->thn = $query;
      $this->view->agama = $agama;
      $this->view->pick('akd_akademik/kurikulum');
    }

    public function formTambahAction($thn_kur)
    {
      $get_session = $this->session->get('ps_id');
      $explode = explode('-', $get_session);
      $ps_id = $explode[1];

      $sql = "SELECT * FROM RefSysAgama";
      $agama = $this->modelsManager->executeQuery($sql);
      $this->view->agama = $agama;
      $this->view->thn_kur = $thn_kur;
      $this->view->pick('akd_akademik/form_kurikulum');
    }

    private function fileSapCheck($extension)
    {
        $allowedTypes = [
            'pdf'
        ];
        return in_array($extension, $allowedTypes);
    }

    private function fileModulCheck($extension)
    {
        $allowedTypes = [
            'pdf',
            'zip',
            'rar',
        ];
        return in_array($extension, $allowedTypes);
    }

    public function uploadSapAction($kode_mk)
    {
        $urel =  DOCUMENT_ROOT.'data/mata_kuliah/SAP/'.$kode_mk.'.pdf';
        $nama_file =  $kode_mk.'.pdf';
        // Check if the user has uploaded files
        if ($this->request->hasFiles()) {
            $files = $this->request->getUploadedFiles();

            // Print the real file names and sizes
            foreach ($files as $file) {
                
                //validasi men
                if ($this->fileSapCheck( $file->getExtension() )) {
                    if ($file->moveTo( $urel )) {
                      
                        $phql = "UPDATE RefAkdMku SET file_sap = '$nama_file' where kode_mk = '$kode_mk' ";
                        $update = $this->modelsManager->executeQuery($phql);

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
                        'text' => "Gagal Upload. File harus PDF",
                        'type' => 'warning',
                    );
                    echo json_encode($notif);
                }                
                
            }
        }
    }

    public function uploadSilabusAction($kode_mk)
    {
        $urel =  DOCUMENT_ROOT.'data/mata_kuliah/silabus/'.$kode_mk.'.pdf';
        $nama_file =  $kode_mk.'.pdf';
        // Check if the user has uploaded files
        if ($this->request->hasFiles()) {
            $files = $this->request->getUploadedFiles();

            // Print the real file names and sizes
            foreach ($files as $file) {
                
                //validasi men
                if ($this->fileSapCheck($file->getExtension())) {
                    if ($file->moveTo( $urel )) {
                      
                        $phql = "UPDATE RefAkdMku SET file_silabus = '$nama_file' where kode_mk = '$kode_mk' ";
                        $update = $this->modelsManager->executeQuery($phql);

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
                        'text' => "Gagal Upload. File harus PDF",
                        'type' => 'warning',
                    );
                    echo json_encode($notif);
                }                
                
            }
        }
    }

    public function uploadModulAction($kode_mk)
    {
        // Check if the user has uploaded files
        if ($this->request->hasFiles()) {
            $files = $this->request->getUploadedFiles();
            // echo "<pre>".print_r($files,1)."</pre>";die();
            // Print the real file names and sizes
            foreach ($files as $file) {
              $urel =  DOCUMENT_ROOT.'data/mata_kuliah/modul/'.$kode_mk.'.'.$file->getExtension();
              $nama_file =  $kode_mk.'.'.$file->getExtension();

              // $pdf =  DOCUMENT_ROOT.'data/mata_kuliah/modul/'.$kode_mk.'.pdf';
              // $rar =  DOCUMENT_ROOT.'data/mata_kuliah/modul/'.$kode_mk.'.rar';
              // $zip =  DOCUMENT_ROOT.'data/mata_kuliah/modul/'.$kode_mk.'.zip';
              // unlink($pdf);
              // unlink($rar);
              // unlink($zip);


                //validasi men
                if ($this->fileModulCheck( $file->getExtension() )) {
                    if ($file->moveTo( $urel )) {
                      
                        $phql = "UPDATE RefAkdMku SET file_modul = '$nama_file' where kode_mk = '$kode_mk' ";
                        $update = $this->modelsManager->executeQuery($phql);

                        $notif = array(
                            'title' => 'success',
                            'text' => 'Data berhasil di Upload',
                            'type' => 'success',
                        );
                    } else {
                        $notif = array(
                            'title' => 'warning',
                            'text' => "Gagal Upload",
                            'type' => "warning",
                        );
                    }
                    echo json_encode($notif);
                } else {
                    $notif = array(
                        'title' => 'warning',
                        'text' => "Gagal Upload. File harus PDF,Zip,rar",
                        'type' => 'warning',
                    );
                    echo json_encode($notif);
                }                
                
            }
        }
    }

    public function listKurikulumAction($thn)
    {
      //DAPATKAN ps_id dari area yang dipilih
      $get_session = $this->session->get('ps_id');
      $explode = explode('-', $get_session);
      $ps_id = $explode[1];

      $a = "SELECT id_agama,nama FROM RefSysAgama";
      $agama = $this->modelsManager->executeQuery($a);
      $sql = "SELECT * FROM RefAkdMku where ps_id='$ps_id' and thn_kur = '$thn'  ";
      $query = $this->modelsManager->executeQuery($sql);

      $q = "SELECT thn_akd,session_id,nama FROM RefAkdSession 
          where ps_id = '$ps_id' 
          order by thn_akd desc, session_id desc limit 5";
      $tahun_sesi = $this->modelsManager->executeQuery($q);

      $this->view->tahun_sesi = $tahun_sesi;
      $this->view->mku = $query;
      $this->view->thn_kur = $thn;
      $this->view->agama = $agama;
      $this->view->pick('akd_akademik/list_kurikulum');
    }

    public function formEditAction($id)
    {
      $sql = "SELECT * FROM RefAkdMku where id='$id' ";
      $query = $this->modelsManager->executeQuery($sql);

      $a = "SELECT id_agama,nama FROM RefSysAgama";
      $agama = $this->modelsManager->executeQuery($a);

      $this->view->agama = $agama;
      $this->view->data = $query;
      $this->view->pick('akd_akademik/form_edit_kurikulum');
    }

    public function delKurikulumAction($id)
    {
      $user = RefAkdMku::findFirst($id);
      $user->delete();
      echo json_encode(array("status" => true));
    }



    function submitKurikulumAction($value='')
    {
      $get_session = $this->session->get('ps_id');
      $explode = explode('-', $get_session);
      $ps_id = $explode[1];

      // validation
      $validation = new Phalcon\Validation();
      $validation->add('thn_kur', new PresenceOf(array(
          'message' => 'Tahun Kurikulum tidak boleh kosong'
      )));
      $validation->add('nama', new PresenceOf(array(
          'message' => 'Nama Kurikulum tidak boleh kosong'
      )));
      $validation->add('semester', new PresenceOf(array(
          'message' => 'Semester tidak boleh kosong'
      )));
      $validation->add('jenis', new PresenceOf(array(
          'message' => 'Jenis tidak boleh kosong'
      )));
      $validation->add('kode_mk', new PresenceOf(array(
          'message' => 'kode_mk tidak boleh kosong'
      )));
      $validation->add('urut', new PresenceOf(array(
          'message' => 'Urut tidak boleh kosong'
      )));
      $validation->add('sks', new PresenceOf(array(
          'message' => 'Sks tidak boleh kosong'
      )));

      $kode_mk = $_POST['kode_mk'];

      /* cek kode mk sudah ada ato belum */
      $cmd = "SELECT kode_mk FROM RefAkdMku where kode_mk = '$kode_mk' " ;
      $cek_mk = $this->modelsManager->executeQuery($cmd)->toArray();
      if (count($cek_mk) > 0) {
        $notif = array(
          'title'   => 'warning',
          'text'  => 'Kode MK Sudah Ada di database, Silahkan Diganti Dengan kode yang lain..! ',
          'type'  => 'warning',
        );
      }else{
        // /.validation
        $messages = $validation->validate($_POST);
        $pesan    = '';
        if (count($messages)) {
          foreach ($messages as $message) {
              $pesan .= "$message"."</br>";
          }
          $notif = array(
            'title'   => 'warning',
            'text'  => $pesan,
            'type'  => 'warning',
          );
        }else{
            $kurikulum = new RefAkdMku();
            $kurikulum->assign(array(
              'ps_id'        => $ps_id,
              'kode_mk'        => str_replace(' ', '', $_POST['kode_mk']),
              'kode_agama'    => $_POST['kode_agama'],
              'thn_kur'        => $_POST['thn_kur'],
              'nama'          => $_POST['nama'],
              'nama_en'       => $_POST['nama_en'],
              'sks'           => $_POST['sks'],
              'kelompok'      => $_POST['kelompok'],
              'jenis'         => $_POST['jenis'],
              'semester'      => $_POST['semester'],
              'prasyarat'     => $_POST['prasyarat'],
              'urut'          => $_POST['urut'],
              'deskripsi'     => $_POST['diskripsi'],
              'kodemk'        => $_POST['kode_mk'],
              'sks_teori'     => $_POST['sks_teori'],
              'sks_praktek'   => $_POST['sks_praktek'],
              'sks_klinik'    => $_POST['sks_klinik'],
            ));

            $kurikulum->save();
            $notif = array(
              'title'   => 'success',
              'text'  => 'Data berhasil di input',
              'type'  => 'success',
            );
        }
      }

      echo json_encode($notif);
    }

    // update Data
    function editKurikulumAction($id)
    {

      // echo "<pre>".print_r($_POST,1)."</pre>";die();

      //DAPATKAN ps_id dari area yang dipilih
      $get_session = $this->session->get('ps_id');
      $explode = explode('-', $get_session);
      $ps_id = $explode[1];

      // validation
      $validation = new Phalcon\Validation();
      $validation->add('nama', new PresenceOf(array(
          'message' => 'Nama Kurikulum tidak boleh kosong'
      )));
      $validation->add('semester', new PresenceOf(array(
          'message' => 'Semester tidak boleh kosong'
      )));
      $validation->add('jenis', new PresenceOf(array(
          'message' => 'Jenis tidak boleh kosong'
      )));

      $validation->add('urut', new PresenceOf(array(
          'message' => 'Urut tidak boleh kosong'
      )));
      $validation->add('sks', new PresenceOf(array(
          'message' => 'Sks tidak boleh kosong'
      )));
  		$messages = $validation->validate($_POST);
  		$pesan    = '';
  		if (count($messages)) {
  		    foreach ($messages as $message) {
  		        $pesan .= "$message"."</br>";
  		    }
  			$notif = array(
          'title'   => 'warning',
          'text'  => $pesan,
          'type'  => 'warning',
        );
  		}else{
  			$kurikulum = RefAkdMku::findFirst($id);
        $kurikulum->assign(array(
          'ps_id'        => $ps_id,
            'kode_agama'    => $_POST['kode_agama'],
            'nama'          => $_POST['nama'],
            'nama_en'       => $_POST['nama_en'],
            'sks'           => $_POST['sks'],
            'kelompok'      => $_POST['kelompok'],
            'jenis'         => $_POST['jenis'],
            'semester'      => $_POST['semester'],
            'prasyarat'     => $_POST['prasyarat'],
            'urut'          => $_POST['urut'],
            'deskripsi'     => $_POST['deskripsi'],
            'sks_teori'     => $_POST['sks_teori'],
            'sks_praktek'   => $_POST['sks_praktek'],
            'sks_klinik'    => $_POST['sks_klinik'],
        ));
        $kurikulum->save();
          $notif = array(
            'title'   => 'success',
            'text'  => 'Data berhasil di input',
            'type'  => 'success',
          );
  		}
  		echo json_encode($notif);
    }
//////////////////////////////////////////////////////////////////////////
//////////////////////// UPLOAD MODUL PER KELAS //////////////////////////
//////////////////////////////////////////////////////////////////////////


    public function listKelasMkAction($value='')
    {
      // echo "<pre>".print_r($_POST,1)."</pre>";
      $get_session = $this->session->get('ps_id');
      $explode = explode('-', $get_session);
      $ps_id = $explode[1];

      $sesi = explode('-', $_POST['sesi']);
      $thn_akd = $sesi[0];
      $session_id = $sesi[1];

      $kode_mk = $_POST['kode_mk'];
      $thn_kur = $_POST['thn_kur'];

      $cmd = "SELECT a.kode_mk,a.thn_kur,a.nama_kelas,b.nama,c.file from RefAkdMkkpkl a 
              join RefAkdMku b on b.ps_id = a.ps_id AND b.thn_kur = a.thn_kur AND b.kode_mk = a.kode_mk 
              left join RefAkdUploadModul c on a.ps_id = c.ps_id AND a.thn_kur = c.thn_kur AND a.kode_mk = c.kode_mk 
                  AND a.nama_kelas = c.nama_kelas AND a.thn_akd = c.thn_akd AND a.session_id = c.session_id
              where a.ps_id = '$ps_id' 
              and a.thn_kur = '$thn_kur' 
              and a.kode_mk = '$kode_mk' 
              and a.thn_akd = '$thn_akd' 
              and a.session_id='$session_id'  ";
      $mk_kelas = $this->modelsManager->executeQuery($cmd);

      $fungsi = new FungsiController();
      $nama_sesi = $fungsi->nama_sesi($thn_akd,$session_id);

      $this->view->sesi = $_POST['sesi'];
      $this->view->thn_kur = $thn_kur;
      $this->view->kode_mk = $kode_mk;

      $this->view->nama_sesi = $nama_sesi;
      $this->view->mk_kelas = $mk_kelas;
      $this->view->pick('akd_akademik/modul_upload/select_kelas');
    }

    public function uploadModulKelasAction($value='')
    {
      // echo "<pre>".print_r($_GET,1)."</pre>";die();
      $kode_mk = $_GET['kode_mk'];
      $nama_kelas = $_GET['nama_kelas'];
      // Check if the user has uploaded files
        if ($this->request->hasFiles()) {
            $files = $this->request->getUploadedFiles();
            // echo "<pre>".print_r($files,1)."</pre>";die();
            // Print the real file names and sizes
            foreach ($files as $file) {
              $urel =  DOCUMENT_ROOT.'data/mata_kuliah/modul_kelas/'.$kode_mk.'-'.$nama_kelas.'.'.$file->getExtension();
              $nama_file =  $kode_mk.'-'.$nama_kelas.'.'.$file->getExtension();

              // $pdf =  DOCUMENT_ROOT.'data/mata_kuliah/modul_kelas/'.$kode_mk.'-'.$nama_kelas.'.pdf';
              // $rar =  DOCUMENT_ROOT.'data/mata_kuliah/modul_kelas/'.$kode_mk.'-'.$nama_kelas.'.rar';
              // $zip =  DOCUMENT_ROOT.'data/mata_kuliah/modul_kelas/'.$kode_mk.'-'.$nama_kelas.'.zip';
              // unlink($pdf);
              // unlink($rar);
              // unlink($zip);


                //validasi men
                if ($this->fileModulCheck( $file->getExtension() )) {
                    if ($file->moveTo( $urel )) {

                        $notif = array(
                            'title' => 'success',
                            'text' => 'Data berhasil di Upload',
                            'type' => 'success',
                            'file' => $nama_file,
                        );
                    } else {
                        $notif = array(
                            'title' => 'warning',
                            'text' => "Gagal Upload",
                            'type' => "warning",
                            'file' => "",
                        );
                    }
                    echo json_encode($notif);
                } else {
                    $notif = array(
                        'title' => 'warning',
                        'text' => "Gagal Upload. File harus PDF,Zip,rar",
                        'type' => 'warning',
                        'file' => '',
                    );
                    echo json_encode($notif);
                }                
                
            }
        }
    }

    public function dataUploadModulKelasAction($value='')
    {
      $get_session = $this->session->get('ps_id');
      $explode = explode('-', $get_session);
      $ps_id = $explode[1];

      $sesi = explode('-', $_POST['sesi']);
      $thn_akd = $sesi[0];
      $session_id = $sesi[1];

      $kode_mk    = $_POST['kode_mk'];
      $nama_kelas = $_POST['nama_kelas'];
      $thn_kur    = $_POST['thn_kur'];

      $cmd = "SELECT * from RefAkdUploadModul where kode_mk='$kode_mk' and thn_akd='$thn_akd' and session_id='$session_id' and thn_kur='$thn_kur' and ps_id='$ps_id' and nama_kelas='$nama_kelas' ";
      $cek = $this->modelsManager->executeQuery($cmd)->toArray();

      if (count($cek) > 0) {
         $rr = "tidak ngapa-ngapain";
      }else{
        $RefAkdUploadModul = new RefAkdUploadModul();
        $RefAkdUploadModul->assign(array(
          'ps_id'        => $ps_id,
            'kode_mk'    => $_POST['kode_mk'],
            'nama_kelas' => $_POST['nama_kelas'],
            'thn_kur'    => $_POST['thn_kur'],
            'thn_akd'    => $thn_akd,
            'session_id' => $session_id,
            'file' => $_POST['file']
        ));
        $RefAkdUploadModul->save();
      }

    }



//////////////////////////////////////////////////////////////////////////
//////////////////////// LINK VIDEO INPUT/ //////////////////////////////
//////////////////////////////////////////////////////////////////////////



    public function listKelasMkVideoAction($value='')
    {
      // echo "<pre>".print_r($_POST,1)."</pre>";
      $get_session = $this->session->get('ps_id');
      $explode = explode('-', $get_session);
      $ps_id = $explode[1];

      $sesi = explode('-', $_POST['sesi']);
      $thn_akd = $sesi[0];
      $session_id = $sesi[1];

      $kode_mk = $_POST['kode_mk'];
      $thn_kur = $_POST['thn_kur'];

      $cmd = "SELECT a.kode_mk,a.thn_kur,a.nama_kelas,b.nama,c.link,c.id as id_link from RefAkdMkkpkl a 
              join RefAkdMku b on b.ps_id = a.ps_id AND b.thn_kur = a.thn_kur AND b.kode_mk = a.kode_mk 
              left join RefAkdLinkVideoKls c on a.ps_id = c.ps_id AND a.thn_kur = c.thn_kur AND a.kode_mk = c.kode_mk 
                  AND a.nama_kelas = c.nama_kelas AND a.thn_akd = c.thn_akd AND a.session_id = c.session_id
              where a.ps_id = '$ps_id' 
              and a.thn_kur = '$thn_kur' 
              and a.kode_mk = '$kode_mk' 
              and a.thn_akd = '$thn_akd' 
              and a.session_id='$session_id'  ";
      $mk_kelas = $this->modelsManager->executeQuery($cmd);

      $fungsi = new FungsiController();
      $nama_sesi = $fungsi->nama_sesi($thn_akd,$session_id);

      $this->view->sesi = $_POST['sesi'];
      $this->view->thn_kur = $thn_kur;
      $this->view->kode_mk = $kode_mk;

      $this->view->nama_sesi = $nama_sesi;
      $this->view->mk_kelas = $mk_kelas;
      $this->view->pick('akd_akademik/link_video/select_kelas');
    }

    public function simpanLinkAction($value='')
    {
      // echo "<pre>".print_r($_POST,1)."</pre>";die();
        $get_session = $this->session->get('ps_id');
        $explode = explode('-', $get_session);
        $ps_id = $explode[1];

        $sesi = explode('-', $_POST['sesi']);
        $thn_akd = $sesi[0];
        $session_id = $sesi[1];

        $RefAkdLinkVideoKls = new RefAkdLinkVideoKls();
        $RefAkdLinkVideoKls->assign(array(
          'ps_id'        => $ps_id,
            'kode_mk'    => $_POST['kode_mk'],
            'nama_kelas' => $_POST['nama_kelas'],
            'thn_kur'    => $_POST['thn_kur'],
            'thn_akd'    => $thn_akd,
            'session_id' => $session_id,
            'link' => $_POST['link']
        ));
        $RefAkdLinkVideoKls->save();

        $notif = array(
            'title' => 'success',
            'text' => 'Data berhasil di simpan',
            'type' => 'success',
        );
        echo json_encode($notif);
    }

    public function editLinkAction($value='')
    {
      // echo "<pre>".print_r($_POST,1)."</pre>";die();
        $id = $_POST['id'];

        $RefAkdLinkVideoKls = RefAkdLinkVideoKls::findFirst($id);
        $RefAkdLinkVideoKls->assign(array(
            'link'    => $_POST['link']

        ));
        $RefAkdLinkVideoKls->save();

        $notif = array(
            'title' => 'success',
            'text' => 'Data berhasil di Edit',
            'type' => 'success',
        );
        echo json_encode($notif);
    }










//////////////////////////////////////////////////////////////////////////
//////////////////////// PEMETAAN KURIKULUM //////////////////////////////
//////////////////////////////////////////////////////////////////////////

    public function pemetaanKurikulumAction($value='')
    {
      $get_session = $this->session->get('ps_id');
      $explode = explode('-', $get_session);
      $ps_id = $explode[1];

      $cmd = "SELECT distinct thn_kur from RefAkdMku where ps_id = '$ps_id' order by thn_kur desc";
      $tujuan = $this->modelsManager->executeQuery($cmd);

      $q = "SELECT distinct a.thn_kur,a.ps_id,b.nama from RefAkdMku a join RefAkdPs b on a.ps_id=b.id_ps order by a.ps_id,a.thn_kur desc";
      $asal = $this->modelsManager->executeQuery($q);

      $pemetaan_ps = "SELECT distinct a.ps_idA,a.ps_idB,a.kurA,a.kurB,b.nama as namaA,c.nama as namaB from RefAkdMapmku a 
        join RefAkdPs b on a.ps_idA=b.id_ps 
        join RefAkdPs c on a.ps_idB=c.id_ps 
          where ps_idB = '$ps_id' order by ps_idA,kurA,ps_idB,kurB";
      $daftar_pemetaan_ps = $this->modelsManager->executeQuery($pemetaan_ps);

      $this->view->thn = $tujuan;
      $this->view->asal = $asal;
      $this->view->daftar_pemetaan_ps = $daftar_pemetaan_ps;
      $this->view->pick('akd_akademik/pemetaan_kurikulum');
    }

    public function vewMapAction()
    {
      $get_session = $this->session->get('ps_id');
      $explode = explode('-', $get_session);
      $ps_id = $explode[1];

      $asal = explode('/', $_POST['asal']);
      $ps_idA = $asal[0];
      $kurA = $asal[1];

      $ps_idB = $ps_id;
      $kurB = $_POST['tujuan'];

      $cmdA = "SELECT a.kode_mk,a.nama,a.jenis,a.kelompok from RefAkdMku a where a.ps_id = '$ps_idA' and a.thn_kur = '$kurA' order by a.nama";
      $qA = $this->modelsManager->executeQuery($cmdA);
      foreach ($qA as $key) {
        $MKA[$key->kode_mk] = $key->nama."/".$key->jenis."/".$key->kelompok;
      }

      $cmdB = "SELECT a.kode_mk,a.nama,a.jenis,a.kelompok from RefAkdMku a where a.ps_id = '$ps_idB' and a.thn_kur = '$kurB' order by a.nama";
      $qB = $this->modelsManager->executeQuery($cmdB);
      foreach ($qB as $key) {
        $MKB[$key->kode_mk] = $key->nama."/".$key->jenis."/".$key->kelompok;
      }

      $cmd = "SELECT a.map_id,
                  a.mkA0,
                  a.mkA1,
                  a.mkA2,
                  a.mkB0,
                  a.mkB1,
                  a.mkB2,
                  c.nama as nama_mkA0,
                  d.nama as nama_mkA1,
                  e.nama as nama_mkA2,
                  f.nama as nama_mkB0,
                  g.nama as nama_mkB1,
                  h.nama as nama_mkB2
             from RefAkdMapmku a
             left join RefAkdMku b on b.kode_mk = a.mkB0
                            and b.ps_id = a.ps_idB
                            and b.thn_kur = a.kurB
             LEFT JOIN RefAkdMku c on a.mkA0 = c.kode_mk
             LEFT JOIN RefAkdMku d on a.mkA1 = d.kode_mk
             LEFT JOIN RefAkdMku e on a.mkA2 = e.kode_mk
             LEFT JOIN RefAkdMku f on a.mkB0 = f.kode_mk
             LEFT JOIN RefAkdMku g on a.mkB1 = g.kode_mk
             LEFT JOIN RefAkdMku h on a.mkB2 = h.kode_mk
            where a.kurA = '$kurA'
              and a.kurB = '$kurB'
              and a.ps_idA = '$ps_idA'
              and a.ps_idB = '$ps_idB'
            order by b.nama";
      $map = $this->modelsManager->executeQuery($cmd)->toArray();
      // echo "<pre>".print_r($map,1)."</pre>";

      // delete key,value dari MKA dan MKB jika sudah di mapping
      foreach ($map as $key => $value) {

        for($i=0;$i<=2;$i++) {
          $colA = "mkA$i";
          if($value[$colA] != '') {
            echo "<pre>".print_r($value[$colA],1)."</pre>";
             unset($MKA[$value[$colA]]);
          }

          $colB = "mkB$i";
          if($value[$colB] != '') {
            echo "<pre>".print_r($value[$colB],1)."</pre>";
             unset($MKB[$value[$colB]]);
          }       
        }

      }

      $this->view->ps_idA = $ps_idA;
      $this->view->kurA = $kurA;
      $this->view->ps_idB = $ps_idB;
      $this->view->kurB = $kurB;
      
      $this->view->MKA = $MKA;
      $this->view->MKB = $MKB;
      $this->view->map = $map;
      $this->view->pick('akd_akademik/view_map');
    }

    public function autoPemetaanAction()
    {
      $get_session = $this->session->get('ps_id');
      $explode = explode('-', $get_session);
      $ps_id = $explode[1];

      $asal = explode('/', $_POST['asal']);
      $ps_idA = $asal[0];
      $kurA = $asal[1];

      $ps_idB = $ps_id;
      $kurB = $_POST['tujuan'];

      $del = "DELETE from RefAkdMapmku where kurA = '$kurA' and kurB = '$kurB' and ps_idA = '$ps_idA' and ps_idB = '$ps_idB'";
      $this->modelsManager->executeQuery($del);

      $this->db->execute("INSERT into ref_akd_mapmku (ps_idA,ps_idB,kurA,kurB,mkA0,mkB0) 
      select a.ps_id, 
        b.ps_id, 
        a.thn_kur, 
        b.thn_kur, 
        a.kode_mk, 
        b.kode_mk 
          from ref_akd_mku a 
          left join ref_akd_mku b on b.nama = a.nama 
          where a.ps_id = '$ps_idA' 
            and a.thn_kur = '$kurA' 
            and b.ps_id = '$ps_idB' 
            and b.thn_kur = '$kurB' 
            group by b.nama");
      echo json_encode(array("status" => true));
    }

    public function pemetaanManualAction($value='')
    {
      $get_session = $this->session->get('ps_id');
      $explode = explode('-', $get_session);
      $ps_id = $explode[1];

      $asal = explode('/', $_POST['asal']);
      $ps_idA = $asal[0];
      $kurA = $asal[1];

      $ps_idB = $ps_id;
      $kurB = $_POST['tujuan'];

      $q = "SELECT kode_mk, nama from RefAkdMku
           where ps_id = '$ps_idA'
             and thn_kur = '$kurA'
           order by nama";
      $asal = $this->modelsManager->executeQuery($q);

      $cmd = "SELECT kode_mk, nama from RefAkdMku
           where ps_id = '$ps_idB'
             and thn_kur = '$kurB'
           order by nama";
      $tujuan = $this->modelsManager->executeQuery($cmd);


      $this->view->ps_idA = $ps_idA;
      $this->view->kurA = $kurA;
      $this->view->ps_idB = $ps_idB;
      $this->view->kurB = $kurB;
      $this->view->asal = $asal;
      $this->view->tujuan = $tujuan;
      $this->view->pick('akd_akademik/pemetaan_manual');
    }

    public function seveMapmkuAction()
    {
      $get_session = $this->session->get('ps_id');
      $explode = explode('-', $get_session);
      $ps_id = $explode[1];

      $asal = explode('/', $_POST['asal']);
      $ps_idA = $asal[0];
      $kurA = $asal[1];

      $ps_idB = $ps_id;
      $kurB = $_POST['tujuan'];

      $validation = new Phalcon\Validation();
      $validation->add('mkA0', new PresenceOf(array(
          'message' => 'mkA0 Kurikulum tidak boleh kosong'
      )));
      $validation->add('mkB0', new PresenceOf(array(
          'message' => 'mkB0 Kurikulum tidak boleh kosong'
      )));

      $messages = $validation->validate($_POST);
      $pesan    = '';
      if (count($messages)) {
        foreach ($messages as $message) {
            $pesan .= "$message"."</br>";
        }
        $notif = array(
          'status'   => false,
          'title'   => 'warning',
          'text'  => $pesan,
          'type'  => 'warning',
        );
      }else{
          $mapmku = new RefAkdMapmku();
          $mapmku->assign(array(
            'ps_idA' => $ps_idA,
            'ps_idB' => $ps_idB,
            'kurA' => $kurA,
            'kurB' => $kurB,
            'mkA0' => $_POST['mkA0'],
            'mkA1' => $_POST['mkA1'],
            'mkA2' => $_POST['mkA2'],
            'mkB0' => $_POST['mkB0'],
            'mkB1' => $_POST['mkB1'],
            'mkB2' => $_POST['mkB2'],
            'catatan' => $_POST['catatan'],
          ));

          $mapmku->save();
          $notif = array(
            'status'   => true,
            'title'   => 'success',
            'text'  => 'Data berhasil di input',
            'type'  => 'success',
          );
        }
        echo json_encode($notif);
    }

    public function editPemetaanAction($map_id)
    {
      $cmd = "SELECT * from RefAkdMapmku a where a.map_id = '$map_id'";
      $data = $this->modelsManager->executeQuery($cmd);
      $ps_idA = $data[0]->ps_idA;
      $ps_idB = $data[0]->ps_idB;
      $kurA = $data[0]->kurA;
      $kurB = $data[0]->kurB;
      
       $q = "SELECT kode_mk, nama from RefAkdMku
           where ps_id = '$ps_idA'
             and thn_kur = '$kurA'
           order by nama";
      $asal = $this->modelsManager->executeQuery($q);

      $cmd = "SELECT kode_mk, nama from RefAkdMku
           where ps_id = '$ps_idB'
             and thn_kur = '$kurB'
           order by nama";
      $tujuan = $this->modelsManager->executeQuery($cmd);

      $this->view->data = $data;
      $this->view->asal = $asal;
      $this->view->tujuan = $tujuan;
      $this->view->pick('akd_akademik/edit_pemetaan');
      // echo "<pre>".print_r($data,1)."</pre>";

    }

    public function submitEditPemetaanAction($id)
    {
      // echo "<pre>".print_r($id,1)."</pre>";die();
      $get_session = $this->session->get('ps_id');
      $explode = explode('-', $get_session);
      $ps_id = $explode[1];

      $validation = new Phalcon\Validation();
      $validation->add('mkA0', new PresenceOf(array(
          'message' => 'mkA0 Kurikulum tidak boleh kosong'
      )));
      $validation->add('mkB0', new PresenceOf(array(
          'message' => 'mkB0 Kurikulum tidak boleh kosong'
      )));

      $messages = $validation->validate($_POST);
      $pesan    = '';
      if (count($messages)) {
        foreach ($messages as $message) {
            $pesan .= "$message"."</br>";
        }
        $notif = array(
          'status'   => false,
          'title'   => 'warning',
          'text'  => $pesan,
          'type'  => 'warning',
        );
      }else{
          $mkA0 = $_POST['mkA0'];
          $mkA1 = $_POST['mkA1'];
          $mkA2 = $_POST['mkA2'];
          $mkB0 = $_POST['mkB0'];
          $mkB1 = $_POST['mkB1'];
          $mkB2 = $_POST['mkB2'];
          $catatan = $_POST['catatan'];

          $this->db->execute("UPDATE ref_akd_mapmku SET 
                              `mkA0`=?,
                              `mkA1`=?,
                              `mkA2`=?,
                              `mkB0`=?,
                              `mkB1`=?,
                              `mkB2`=?,
                              `catatan`=? 
                              WHERE map_id = ? ",array($mkA0,$mkA1,$mkA2,$mkB0,$mkB1,$mkB2,$catatan,$id));

          $notif = array(
            'status'   => true,
            'title'   => 'success',
            'text'  => 'Data berhasil di input',
            'type'  => 'success',
          );
        }
        echo json_encode($notif);
    }


//////////////////////////////////////////////////////////////////////////
//////////////////////// ANGKATAN MAHASISWA //////////////////////////////
//////////////////////////////////////////////////////////////////////////

    public function angkatanMhsAction()
    {
      $get_session = $this->session->get('ps_id');
      $explode = explode('-', $get_session);
      $ps_id = $explode[1];
      
      $phql = "SELECT * from RefAkdAngkatanMhs where psmhs_id = '$ps_id' ";
      $angkatan = $this->modelsManager->executeQuery($phql);
      $this->view->angkatan = $angkatan;
      $this->view->pick('akd_akademik/angkatan_mhs');
    }

    public function delAngkatanAction($id)
    {
      $get_session = $this->session->get('ps_id');
      $explode = explode('-', $get_session);
      $ps_id = $explode[1];

      $del = "DELETE from RefAkdAngkatanMhs where psmhs_id = '$ps_id' and angkatan_id = '$id'";
      $this->modelsManager->executeQuery($del);    
       $notif = array(
          'status'   => true,
      );
      echo json_encode($notif);
    }

    public function addAngkatanAction()
    {
      $get_session = $this->session->get('ps_id');
      $explode = explode('-', $get_session);
      $ps_id = $explode[1];

      $validation = new Phalcon\Validation();
      $validation->add('angkatan_id', new PresenceOf(array(
          'message' => 'angkatan_id Kurikulum tidak boleh kosong'
      )));
      $validation->add('nama', new PresenceOf(array(
          'message' => 'nama Kurikulum tidak boleh kosong'
      )));

      $messages = $validation->validate($_POST);
      $pesan    = '';
      if (count($messages)) {
        foreach ($messages as $message) {
            $pesan .= "$message"."</br>";
        }
        $notif = array(
          'title'   => 'warning',
          'text'  => $pesan,
          'type'  => 'warning',
        );
      }else{
          $angkatan_id = $_POST['angkatan_id'];
          $nama = $_POST['nama'];

          $class = new RefAkdAngkatanMhs();
          $class->assign(array(
            'psmhs_id' => $ps_id,
            'angkatan_id' => $angkatan_id,
            'angkatan_nm' => $nama,
          ));

          $class->save();


          $notif = array(
            'title'   => 'success',
            'text'  => 'Data berhasil di input',
            'type'  => 'success',
          );
        }
        echo json_encode($notif);
    }

  function editAngkatanAction($id)
  {
      $get_session = $this->session->get('ps_id');
      $explode = explode('-', $get_session);
      $ps_id = $explode[1];

      $validation = new Phalcon\Validation(); 
      $validation->add('nama', new PresenceOf(array(
          'message' => 'Nama Area tidak boleh kosong'
      )));
       
      $messages = $validation->validate($_POST);
      $pesan = '';
      //jika gagal falidasi
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
          $nama = $_POST['nama'];

          $this->db->execute("UPDATE ref_akd_angkatan_mhs SET 
                              `angkatan_nm`=?
                              WHERE psmhs_id = ? and angkatan_id = ? ",array($nama,$ps_id,$id));

        $notif = array(
          'title' => 'success',
          'text' => 'Data berhasil di Edit',
          'type' => 'success',
        );
      }

      echo json_encode($notif);    
  }

}
