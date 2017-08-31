<?php
use Phalcon\Mvc\View;
use Phalcon\Validation;
use  Phalcon\Validation\Validator\PresenceOf;
class AkdmhsnaController extends \Phalcon\Mvc\Controller // MHS NON AKTIF
{

    public function initialize()
    {
        if (empty($this->session->get('uid'))) {
            $this->response->redirect('account/loginEnd');
        }
        $this->view->setRenderLevel(View::LEVEL_ACTION_VIEW);
    }

    public function kewajibanPembayaranAction($value='')
    {

      $get_session = $this->session->get('ps_id');
      $explode = explode('-', $get_session);
      $ps_id = $explode[1];

      $helper = new Helpers();
      $data_keu = $helper->curl("http://siato.stieww.ac.id/api_keu.php");


      $thn_akd = $_POST['thn_akd'];
      $session_id = $_POST['session_id'];

      $phql = "SELECT * from RefKeuDefkwjb  where ps_id = '$ps_id' and thn_akd = '$thn_akd' and session_id = '$session_id'
       order by def_id";
      $data_kwjb = $this->modelsManager->executeQuery($phql);

      $this->view->nama_defkwjb = $data_keu['nama_defkwjb'];
      $this->view->ses = $data_keu['ses'];
      $this->view->data_kwjb = $data_kwjb;
      $this->view->thn_akd = $thn_akd;
      $this->view->session_id = $session_id;

    	$this->view->pick('keu_pembayaran/kewajiban');
    }

    public function findAction()
    {
        $get_session = $this->session->get('ps_id');
        $explode = explode('-', $get_session);
        $ps_id = $explode[1];

        $angkatan = "SELECT DISTINCT angkatan FROM RefAkdMhs
        WHERE id_ps = $ps_id ORDER BY angkatan DESC";
        $angkat = $this->modelsManager->executeQuery($angkatan);

        $q = "SELECT thn_akd,session_id,nama FROM RefAkdSession 
          where ps_id = '$ps_id' 
          and begin_dt <= CURRENT_DATE() AND end_dt >= CURRENT_DATE()";
        $tahun_sesi = $this->modelsManager->executeQuery($q);

        $helper = new Helpers();
        $data_defkwjb = $helper->curl("http://siato.stieww.ac.id/api_keu_defkwjb.php");


        $this->view->tahun_sesi = $tahun_sesi;
        $this->view->angkatan = $angkat;
        $this->view->data_defkwjb = $data_defkwjb;

        $this->view->pick('akd_mhs/mhs_non_aktif/find');
    }

    public function mahasiswaAction()
    {
        $helper = new Helpers();
        $get_session= $this->session->get('ps_id');
        $explode    = explode('-', $get_session);
        $ps_id      = $explode[1];

        $sesi = explode('-', $_POST['sesi']);
        $thn_akd = $sesi[0];
        $session_id = $sesi[1];

        $sesi_nama = FungsiController::nama_sesi($thn_akd,$session_id);

        $bayar = explode('#', $_POST['bayar']);
        $kode_byr   = $bayar[0];
        $nama_byr = $bayar[1];
        
        $angkatan   = $_POST['angkatan'];

        $cek_krs = 'off';
        if (isset($_POST['cek_krs'])) {
          $cek_krs = 'on';
        }

        $cmd = "SELECT a.id_mhs,a.id_ps,a.angkatan,a.nama,a.id_kur, b.nama as nama_status from RefAkdMhs a
                LEFT JOIN RefAkdStatus b ON a.id_status = b.id_status_keu
                  where a.angkatan = '$angkatan'
                    and a.id_ps = '$ps_id'
                  order by a.id_mhs";
        $mhs_array = $this->modelsManager->executeQuery($cmd)->toArray();

        if ($cek_krs == 'on') {
          /* data mhs yang mahasiswanya mengambil krs*/
          $cmd = "SELECT a.id_mhs,a.nama,a.angkatan,b.thn_akd,b.session_id,b.kode_mk,b.thn_kur,b.nama_kelas, c.nama as nama_status FROM RefAkdMhs a 
                    join RefAkdKrs b on a.id_mhs = b.nomhs and a.id_ps=b.psmhs_id 
                    LEFT JOIN RefAkdStatus c ON a.id_status = c.id_status_keu
                    WHERE a.angkatan = '$angkatan' and a.id_ps = '1' and b.thn_akd='$thn_akd' and b.session_id='$session_id' 
                    GROUP by b.nomhs";
          $mhs_krs = $this->modelsManager->executeQuery($cmd)->toArray();
        

          foreach ($mhs_krs as $key => $value) {
              $mhs_aktif[$value['id_mhs']] = $value;
          }
        }

      $url = "http://siato.stieww.ac.id/api_cek_pembayaran_mhs.php?angkatan=".$angkatan."&thn_akd=".$thn_akd."&session_id=".$session_id."&kode_byr=".$kode_byr;
      $data_keu = $helper->curl($url);

        $mhs_na = array();
        foreach ($mhs_array as $key => $value) {
          if ($cek_krs == 'on') {
            if (!array_key_exists($value['id_mhs'],$mhs_aktif)) {
              $value['krs'] = 'kosong';
              $mhs_na[$value['id_mhs']] = $value;
            }else{
              $value['krs'] = '';
            }
          }else{
            $value['krs'] = '';
          }
            if (!array_key_exists($value['id_mhs'],$data_keu)) {
              $value['keu'] = 'kosong';
              $mhs_na[$value['id_mhs']] = $value;
            }else{
              $value['keu'] = '';
            }
        }

        $this->view->sesi = $_POST['sesi'];
        $this->view->sesi_nama = $sesi_nama;
        $this->view->nama_byr = $nama_byr;
        $this->view->angkatan = $angkatan;
        $this->view->mhs = $mhs_na;
        $this->view->pick('akd_mhs/mhs_non_aktif/mahasiswa');
    }

    public function submitMhsNaAction($value='')
    {
        // echo "<pre>".print_r($_POST,1)."</pre>";die();

        $sesi = explode('-', $_POST['sesi']);
        $thn_akd = $sesi[0];
        $session_id = $sesi[1];

        $nama_byr = $_POST['nama_byr'];

        foreach ($_POST['mhs'] as $key => $value) {
          $keterangan = '';
          if (array_key_exists($key,$_POST['ket_keu'])) {
            $keterangan .= 'Tidak membayar '.$nama_byr;
          }
          
          if (array_key_exists($key,$_POST['ket_krs'])) {
            $keterangan .= ' dan Tidak Melakukan KRS ';
          }
          
          $keterangan .= ' Thn = '.$thn_akd.'/'.$session_id;

          $query = new RefAkdMhsStatus();
          $query->assign(array(
              'status'       => 'NA',
              'nomhs'         => $key,
              'thn_akd'       => $thn_akd,
              'session_id'    => $session_id,
              'keterangan'    => $keterangan,
              'no_surat'      => '',
              'tgl_surat'     => date('Y-m-d')
          ));
          $query->save();

          $cmd = "UPDATE RefAkdMhs SET id_status = 'NA' WHERE id_mhs = '$key' ";
          $this->modelsManager->executeQuery($cmd);
        }

        $notif = array(
            'type'  => 'success',
            'text'  => 'Data berhasil di input',
            'title' => 'Regular Notice',
        );
        echo json_encode($notif);
    }

}

