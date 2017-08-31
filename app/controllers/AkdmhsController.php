<?php
use Phalcon\Mvc\View;
use Phalcon\Validation;
use Phalcon\Validation\Validator\PresenceOf;

class AkdmhsController extends \Phalcon\Mvc\Controller
{
  	public function initialize()
    {
        if (empty($this->session->get('uid'))) {
            $this->response->redirect('account/loginEnd');
        }
        $this->view->setRenderLevel(View::LEVEL_ACTION_VIEW);
    }

    public function indexAction()
    {
      $this->view->setRenderLevel(View::LEVEL_ACTION_VIEW);

    }

    //////////////////////////////////////////////////
    ///////////////// EDIT MAHASISWA /////////////////
    //////////////////////////////////////////////////

    public function editMhsAction()
    {

      $this->view->pick('akd_mhs/edit/search');
      $this->view->setRenderLevel(View::LEVEL_ACTION_VIEW);

    }

    public function searchEditAction()
    {

      $this->view->disable();

      $get_session = $this->session->get('ps_id');
      $explode = explode('-', $get_session);
      $ps_id = $explode[1];

      $nomhs = $_POST['nomhs'];
      $nama = $_POST['nama'];

      if (!$nomhs) {
        $nomhs = '0';
      }
      if (!$nama) {
        $nama = '0';
      }

      $nomhs_sql = (!empty($nomhs)) ? "and id_mhs = $nomhs" : "";
      $nama_sql = (!empty($nama)) ? "and nama LIKE '%$nama%'" : "";

      $sql    = "SELECT * FROM RefAkdMhs WHERE id_ps = $ps_id $nomhs_sql $nama_sql" ;
      $datas  = $this->modelsManager->executeQuery($sql);

      $data   = $datas->toArray();
      echo json_encode($data);
    }

    public function editAction($id)
    {
      // $this->view->disable();

      $this->view->setRenderLevel(View::LEVEL_ACTION_VIEW);
      $this->view->pick('akd_mhs/edit/edit');

      $agama = "SELECT * FROM RefSysAgama WHERE aktif = 'Y'";
      $que = $this->modelsManager->executeQuery($agama);
      $this->view->agama = $que;

      $a = "SELECT DISTINCT (thn_kur) AS thn_kur FROM RefAkdMku ORDER BY thn_kur DESC";
      $thn = $this->modelsManager->executeQuery($a);
      $this->view->thn_kur = $thn;

      $provinsi = RefSysProvinsi::find();
      $this->view->provinsi = $provinsi;

      if ($id) {
        $sql    = "SELECT * FROM RefAkdMhs WHERE id_mhs = $id";
        $datas  = $this->modelsManager->executeQuery($sql);
        $this->view->edit = $datas;
      } else {
        echo "fail";

      }

    }

    ///////////////
    // Kabupaten //
    ///////////////
    public function editKabAction($prov)
    {

      if($prov == '') {
        echo "string";
      } else {
        $sql = "SELECT * FROM RefSysKabupaten WHERE province_id = $prov";
        $datas = $this->modelsManager->executeQuery($sql);
        $kab = new RefSysKabupaten();
        $kabupaten = $kab->datas = $datas;
        $data = $kabupaten->toArray();
        echo json_encode($data);
        $this->view->disable();
      }

    }

    /////////////////
    // Update Data //
    /////////////////
    function updateAkdMhsAction($id)
    {
      $this->view->setRenderLevel(View::LEVEL_ACTION_VIEW);

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

        $mhs = RefAkdMhs::findFirst($id);
        $mhs->assign(array(
          'angkatan'      => $_POST['angkatan'],
          'nama'          => $_POST['nama'],
          'id_agama'      => $_POST['agama'],
          'gender'        => $_POST['jeniskelamin'],
          'nik'           => $_POST['nik'],
          'alamat'     => $_POST['alamat1'],
          'kode_posyk'    => $_POST['kode_pos1'],
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
          'tgl_lulus'     => $_POST['tgl_lulus'],
          'tgl_masuk'     => $_POST['tgl_masuk'],
          'gol_darah'     => $_POST['gol_darah'],
          'id_kur'        => $_POST['kurikulum'],
          'nama_ayah'     => $_POST['nama_ayah'],
          'nama_ibu'      => $_POST['nama_ibu'],
          'alamat_ortu'   => $_POST['alamat_ortu'],
          'kota_ortu'     => $_POST['kota_ortu'],
          'kode_pos_ortu' => $_POST['kode_pos_ortu'],
          'asal_smu'      => $_POST['asal_sekolah'],
          'alamat_sekolah'=> $_POST['alamat_sekolah'],
          'nisn'          => $_POST['nisn'],
          'judul_skripsi' => $_POST['judul_skripsi'],
        ));
        $simpan = $mhs->save();

        if($simpan) {
          $notif = array(
            'title'  => 'Success',
            'type'   => 'success',
            'text'  => 'Berhasil di Update',
          );
        } else {
          $notif = array(
            'title'  => 'warning',
            'type'   => 'warning',
            'text'  => 'Gagal di Update',
          );
        }
      }
        // echo print_r($sdm);
      echo json_encode($notif);
      $this->view->disable();

    }

    ////////////////////////////////////////////////////
    ///////////////// SEARCH MAHASISWA /////////////////
    ////////////////////////////////////////////////////

    public function searchMhsAction()
    {
      $get_session = $this->session->get('ps_id');
      $explode = explode('-', $get_session);
      $ps_id = $explode[1];

      $this->view->pick('akd_mhs/search/search');

      $sql    = "SELECT DISTINCT (angkatan) AS angkatan FROM RefAkdMhs WHERE id_ps = '$ps_id' ORDER BY angkatan DESC";
      $datas  = $this->modelsManager->executeQuery($sql);
      $this->view->angkatan = $datas;


    }

    public function searchAction()
    {
      $this->view->disable();

      $get_session = $this->session->get('ps_id');
      $explode = explode('-', $get_session);
      $ps_id = $explode[1];

      $nomhs = $_POST['nomhs'];
      $nama = $_POST['nama'];
      $angkatan = $_POST['angkatan'];

      if (!$nomhs) {
        $nomhs = '0';
      }
      if (!$nama) {
        $nama = '0';
      }

      $nomhs_sql = (!empty($nomhs)) ? "and id_mhs = $nomhs" : "";
      $angkatan_sql = (!empty($angkatan)) ? "and angkatan = $angkatan" : "";
      $nama_sql = (!empty($nama)) ? "and nama LIKE '%$nama%'" : "";

      $sql    = "SELECT * FROM RefAkdMhs WHERE id_ps = $ps_id $nomhs_sql $angkatan_sql $nama_sql" ;
      $datas  = $this->modelsManager->executeQuery($sql);

      $data   = $datas->toArray();
      echo json_encode($data);
    }

    //////////////////////////////////////////////////////////
    ///////////////////// Data Mahasiswa /////////////////////
    //////////////////////////////////////////////////////////
    public function dataAction($id)
    {
      // $this->view->disable();
      $this->view->setRenderLevel(View::LEVEL_ACTION_VIEW);
      $this->view->pick('akd_mhs/search/data');

      $get_session = $this->session->get('ps_id');
      $explode = explode('-', $get_session);
      $ps_id = $explode[1];

      // tahun
      $a = "SELECT DISTINCT (thn_kur) AS thn_kur FROM RefAkdMku ORDER BY thn_kur DESC";
      $thn = $this->modelsManager->executeQuery($a);
      $this->view->thn_kur = $thn;

      // profil Mahasiswa
      $id_p = 'ps-'.$ps_id;
      $join4 = "SELECT label_menu AS mhs FROM RefAkdMhs JOIN RefArea
      WHERE RefArea.ps_id = '$id_p' AND id_mhs = $id";
      $query = $this->modelsManager->executeQuery($join4);
      $arr = $query->toArray();
      $m = $arr[0]['mhs'];
      $explode = explode(" ", $m);
      $akd = $explode[1]." ".$explode[2];
      $this->view->profil_mhs = $akd;

      $sql    = "SELECT * FROM RefAkdMhs WHERE id_mhs = $id";
      $datas  = $this->modelsManager->executeQuery($sql);
      $this->view->edit = $datas;

      // profil agama
      $join1 = "SELECT RefAkdMhs.id_mhs AS id_mhs, RefSysAgama.nama AS agama FROM RefAkdMhs JOIN RefSysAgama
      WHERE RefAkdMhs.id_agama = RefSysAgama.id_agama AND
        id_mhs = $id";
      $query = $this->modelsManager->executeQuery($join1);
      $this->view->profil_agama = $query;

      // profil Provinsi 1
      $join2 = "SELECT RefSysProvinsi.name AS provinsi FROM RefAkdMhs JOIN RefSysProvinsi
      WHERE RefAkdMhs.kode_prop = RefSysProvinsi.id AND id_mhs = $id";
      $query = $this->modelsManager->executeQuery($join2);
      $this->view->profil_prov = $query;

      // profil Kabupaten 1
      $join3 = "SELECT RefSysKabupaten.name AS kabupaten FROM RefAkdMhs JOIN RefSysKabupaten
      WHERE RefAkdMhs.kode_kab = RefSysKabupaten.id AND id_mhs = $id";
      $query = $this->modelsManager->executeQuery($join3);
      $this->view->profil_kota = $query;

      // profil Provinsi 2
      $join2 = "SELECT RefSysProvinsi.name AS provinsi FROM RefAkdMhs JOIN RefSysProvinsi
      WHERE RefAkdMhs.kdprop_asal = RefSysProvinsi.id AND id_mhs = $id";
      $query = $this->modelsManager->executeQuery($join2);
      $this->view->profil_prov2 = $query;

      // profil Kabupaten 2
      $join3 = "SELECT RefSysKabupaten.name AS kabupaten FROM RefAkdMhs JOIN RefSysKabupaten
      WHERE RefAkdMhs.kdkab_asal = RefSysKabupaten.id AND id_mhs = $id";
      $query = $this->modelsManager->executeQuery($join3);
      $this->view->profil_kota2 = $query;

      // profil Dosen Wali
      $join4 = "SELECT RefAkdSdm.nama AS dosen FROM RefAkdMhs JOIN RefAkdSdm
      WHERE RefAkdMhs.id_dosen_wali = RefAkdSdm.nip AND RefAkdMhs.id_mhs = $id";
      $query = $this->modelsManager->executeQuery($join4);
      $this->view->profil_dosen_wali = $query;
      echo "<pre>".print_r($query,1)."</pre>";

      // profil Mahasiswa
      $id_p = 'ps-'.$ps_id;
      $join4 = "SELECT label_menu AS mhs FROM RefAkdMhs JOIN RefArea
      WHERE RefArea.ps_id = '$id_p' AND id_mhs = $id";
      $query = $this->modelsManager->executeQuery($join4);
      $arr = $query->toArray();
      $m = $arr[0]['mhs'];
      $explode = explode(" ", $m);
      $akd = $explode[1]." ".$explode[2];
      $this->view->profil_mhs = $akd;

    }

    ///////////////////////////////////////////////////
    ///////////////////// Biodata /////////////////////
    ///////////////////////////////////////////////////
    public function krs_khsAction($id)
    {
      $this->view->setRenderLevel(View::LEVEL_ACTION_VIEW);
      $this->view->pick('akd_mhs/search/krs_khs');
      // $this->view->disable();

      $get_session = $this->session->get('ps_id');
      $explode = explode('-', $get_session);
      $ps_id = $explode[1];

      // tahun
      $a = "SELECT DISTINCT (thn_kur) AS thn_kur FROM RefAkdMku ORDER BY thn_kur DESC";
      $thn = $this->modelsManager->executeQuery($a);
      $this->view->thn_kur = $thn;

      // profil Mahasiswa
      $id_p = 'ps-'.$ps_id;
      $join4 = "SELECT label_menu AS mhs FROM RefAkdMhs JOIN RefArea
      WHERE RefArea.ps_id = '$id_p' AND id_mhs = $id";
      $query = $this->modelsManager->executeQuery($join4);
      $arr = $query->toArray();
      $m = $arr[0]['mhs'];
      $explode = explode(" ", $m);
      $akd = $explode[1]." ".$explode[2];
      $this->view->profil_mhs = $akd;

      $sql    = "SELECT * FROM RefAkdMhs WHERE id_mhs = $id";
      $datas  = $this->modelsManager->executeQuery($sql);
      $this->view->edit = $datas;

      // profil agama
      $join1 = "SELECT RefAkdMhs.id_mhs AS id_mhs, RefSysAgama.nama AS agama FROM RefAkdMhs JOIN RefSysAgama
      WHERE RefAkdMhs.id_agama = RefSysAgama.id_agama AND
        id_mhs = $id";
      $query = $this->modelsManager->executeQuery($join1);
      $this->view->profil_agama = $query;

      // profil Provinsi 1
      $join2 = "SELECT RefSysProvinsi.name AS provinsi FROM RefAkdMhs JOIN RefSysProvinsi
      WHERE RefAkdMhs.kode_prop = RefSysProvinsi.id AND id_mhs = $id";
      $query = $this->modelsManager->executeQuery($join2);
      $this->view->profil_prov = $query;

      // profil Kabupaten 1
      $join3 = "SELECT RefSysKabupaten.name AS kabupaten FROM RefAkdMhs JOIN RefSysKabupaten
      WHERE RefAkdMhs.kode_kab = RefSysKabupaten.id AND id_mhs = $id";
      $query = $this->modelsManager->executeQuery($join3);
      $this->view->profil_kota = $query;

      // profil Provinsi 2
      $join2 = "SELECT RefSysProvinsi.name AS provinsi FROM RefAkdMhs JOIN RefSysProvinsi
      WHERE RefAkdMhs.kdprop_asal = RefSysProvinsi.id AND id_mhs = $id";
      $query = $this->modelsManager->executeQuery($join2);
      $this->view->profil_prov2 = $query;

      // profil Kabupaten 2
      $join3 = "SELECT RefSysKabupaten.name AS kabupaten FROM RefAkdMhs JOIN RefSysKabupaten
      WHERE RefAkdMhs.kdkab_asal = RefSysKabupaten.id AND id_mhs = $id";
      $query = $this->modelsManager->executeQuery($join3);
      $this->view->profil_kota2 = $query;

      // profil Dosen Wali
      $join4 = "SELECT RefAkdSdm.nama AS dosen FROM RefAkdMhs JOIN RefAkdSdm
      WHERE RefAkdMhs.id_dosen_wali = RefAkdSdm.nip AND RefAkdMhs.id_mhs = $id";
      $query = $this->modelsManager->executeQuery($join4);
      $this->view->profil_dosen_wali = $query;
      // echo "<pre>".print_r($query,1)."</pre>";

      // profil Mahasiswa
      $id_p = 'ps-'.$ps_id;
      $join4 = "SELECT label_menu AS mhs FROM RefAkdMhs JOIN RefArea
      WHERE RefArea.ps_id = '$id_p' AND id_mhs = $id";
      $query = $this->modelsManager->executeQuery($join4);
      $arr = $query->toArray();
      $m = $arr[0]['mhs'];
      $explode = explode(" ", $m);
      $akd = $explode[1]." ".$explode[2];
      $this->view->profil_mhs = $akd;

    }

}
