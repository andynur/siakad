<?php
use Phalcon\Mvc\View;
use Phalcon\Validation;
use Phalcon\Validation\Validator\PresenceOf;

class AkdmhsbaruController extends \Phalcon\Mvc\Controller
{
  	public function initialize()
    {
        if (empty($this->session->get('uid'))) {
            $this->response->redirect('account/loginEnd');
        }
    }

    public function indexAction()
    {
      $this->view->setRenderLevel(View::LEVEL_ACTION_VIEW);

    }

    public function mhsBaruAction()
    {
      $this->view->setRenderLevel(View::LEVEL_ACTION_VIEW);
      $this->view->pick('akd_mhs/mhs_baru/insert');

      $agama = "SELECT * FROM RefSysAgama WHERE aktif = 'Y'";
      $que = $this->modelsManager->executeQuery($agama);
      $this->view->agama = $que;

      $a = "SELECT DISTINCT (thn_kur) AS thn_kur FROM RefAkdMku ORDER BY thn_kur DESC";
      $thn = $this->modelsManager->executeQuery($a);
      $this->view->thn_kur = $thn;

      $provinsi = RefSysProvinsi::find();
      $kabupaten = RefSysKabupaten::find();
      $this->view->provinsi = $provinsi;
      $this->view->kabupaten = $kabupaten;
    }

    /////////////////
    // Update Data //
    /////////////////
    function insertAkdMhsAction()
    {

      // echo "<pre>".print_r($_POST,1)."</pre>";die();
      $this->view->setRenderLevel(View::LEVEL_ACTION_VIEW);

      $get_session = $this->session->get('ps_id');
      $explode = explode('-', $get_session);
      $ps_id = $explode[1];

      // validation
      $validation = new Phalcon\Validation();
      $validation->add('nama', new PresenceOf(array(
          'message' => 'Nama tidak boleh kosong'
      )));
      $validation->add('angkatan', new PresenceOf(array(
          'message' => 'Angkatan tidak boleh kosong'
      )));
      $validation->add('jeniskelamin', new PresenceOf(array(
          'message' => 'Jenis Kelamin tidak boleh kosong'
      )));
      $validation->add('tgl_lahir', new PresenceOf(array(
          'message' => 'Tanggal Lahir tidak boleh kosong'
      )));
      $validation->add('tempat_lahir', new PresenceOf(array(
          'message' => 'Tempat Lahir tidak boleh kosong'
      )));
      $validation->add('angkatan', new PresenceOf(array(
          'message' => 'Angkatan tidak boleh kosong'
      )));
      // /.validation

      $messages = $validation->validate($_POST);
      $pesan    = '';
      if (count($messages)) {
          foreach ($messages as $message) {
              $pesan .= "$message"."</br>";
          }
        $notif = array(
          'type'   => 'warning',
          'text'  => $pesan,
          'title'  => 'Warning',
        );
      } else {

        $mhs = new RefAkdMhs();
        $mhs->assign(array(
          'id_mhs'        => $_POST['id_mhs'],
          'angkatan'      => $_POST['angkatan'],
          'nama'          => $_POST['nama'],
          'id_agama'      => $_POST['agama'],
          'gender'        => $_POST['jeniskelamin'],
          'nik'           => $_POST['nik'],
          'alamat'     => $_POST['alamat1'],
          'kode_pos'    => $_POST['kode_pos1'],
          'kode_prop'   => $_POST['provinsi1'],
          'kode_kab'    => $_POST['kota1'],
          'telpon'        => $_POST['telepon1'],
          'alamat_asal'   => $_POST['alamat2'],
          'kdpos_asal'    => $_POST['kode_pos2'],
          'kdkab_asal'    => $_POST['kota2'],
          'kdprop_asal'   => $_POST['provinsi2'],
          'telpon_asal'   => $_POST['telepon2'],
          'tgl_lahir'     => $_POST['tgl_lahir'],
          'tempat_lahir'  => $_POST['tempat_lahir'],
          'tgl_masuk'     => $_POST['tgl_masuk'],
          'gol_darah'     => $_POST['gol_darah'],
          'id_kur'        => $_POST['kurikulum'],

          'nama_ayah'     => $_POST['nama_ayah'],
          'nama_ibu'      => $_POST['nama_ibu'],
          'nik_ayah' =>  $_POST['nik_ayah'],
          'nik_ibu' =>  $_POST['nik_ibu'],
          'agama_ayah' =>  $_POST['agama_ayah'],
          'agama_ibu' =>  $_POST['agama_ibu'],
          'edu_ayah' =>  $_POST['pendidikan_ayah'],
          'edu_ibu' =>  $_POST['pendidikan_ibu'],
          'job_ayah' =>  $_POST['pekerjaan_ayah'],
          'job_ibu' =>  $_POST['pekerjaan_ibu'],
          'penghasilan_ortu' =>  $_POST['penghasilan_ortu'],
          'kota_ortu' =>  $_POST['kota_ortu'],
          'alamat_ortu' =>  $_POST['alamat_ortu'],

          'asal_smu' =>  $_POST['nama_smu'],
          'jur_smu' =>  $_POST['jurusan'],
          'smu_prokab' =>  $_POST['provinsi3'].'-'.$_POST['kota3'],
          'alamat_sekolah' =>  $_POST['alamat_sekolah'],

          'nisn'          => $_POST['nisn'],
          'ps_id'         => $ps_id,
        ));
        $simpan = $mhs->save();

        if($simpan) {
          $notif = array(
            'title'  => 'Success',
            'type'   => 'success',
            'text'  => 'Berhasil di Tambah',
          );
        } else {
          $notif = array(
            'title'  => 'warning',
            'type'   => 'warning',
            'text'  => 'Gagal di Tambah',
          );
        }
      }
      // var_dump($ps_id);
      // var_dump($simpan);
      echo json_encode($notif);
      $this->view->disable();

    }

}
