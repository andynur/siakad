<?php
use Phalcon\Mvc\View;
use Phalcon\Validation;
use Phalcon\Validation\Validator\PresenceOf;

class AkdmhscutiController extends \Phalcon\Mvc\Controller
{

  	public function initialize()
    {
        // MENDETEKSI JIKA ADA SESSION MAKA HALAMAN BISA DI AKSESS
        if (empty($this->session->get('uid'))) {
            $this->response->redirect('account/loginEnd');
        }
        $this->view->setRenderLevel(View::LEVEL_ACTION_VIEW);
        date_default_timezone_set('Asia/Jakarta');
    }


    ///////////////////////////////////////////////////////////////////////////
    ///////////////////////////// Search Data Mhs /////////////////////////////
    ///////////////////////////////////////////////////////////////////////////
    public function findAction()
    {
        $get_session = $this->session->get('ps_id');
        $explode = explode('-', $get_session);
        $ps_id = $explode[1];

        $angkatan = "SELECT DISTINCT angkatan FROM RefAkdMhs
        WHERE id_ps = $ps_id ORDER BY angkatan DESC";

        $angkat = $this->modelsManager->executeQuery($angkatan);
        $this->view->angkatan      = $angkat;

        $this->view->pick('akd_mhs/cuti_kuliah/find');
    }

    ////////////////////////////////////////////////////////////////////////////
    ///////////////////////////////// Data Mhs /////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////
    public function dataAction()
    {

        $get_session= $this->session->get('ps_id');
        $explode    = explode('-', $get_session);
        $ps_id      = $explode[1];

        $nama_mhs    = $_POST['nama_mhs'];
        $range1    = $_POST['range1'];
        $range2       = $_POST['range2'];
        $angkatan   = $_POST['angkatan'];


        if($range1 != '' && $range2 != '') {
            $angkatan_isset = ($angkatan != '') ? "and a.angkatan = '$angkatan'" : "";
            $cmd = "SELECT a.id_mhs,a.id_ps,a.angkatan,a.nama,a.id_kur, b.nama as nama_status from RefAkdMhs a
                        LEFT JOIN RefAkdStatus b ON a.id_status = b.id_status_keu
                      where a.id_mhs >= '$range1'
                        and a.id_mhs <= '$range2'
                        and a.id_ps = '$ps_id'
                        $angkatan_isset
                      order by id_mhs";
            $mhs = $this->modelsManager->executeQuery($cmd);
          
       } elseif ($nama_mhs != '') {
                $angkatan_isset = ($angkatan != '') ? "and a.angkatan = '$angkatan'" : "";
                $cmd = "SELECT a.id_mhs,a.id_ps,a.angkatan,a.nama,a.id_kur, b.nama as nama_status from RefAkdMhs a
                        LEFT JOIN RefAkdStatus b ON a.id_status = b.id_status_keu
                   where a.id_mhs like '%$nama_mhs%'
                     $angkatan_isset 
                     and id_ps = '$ps_id'";
                $mhs = $this->modelsManager->executeQuery($cmd);

       } elseif ($angkatan != '') {
            $cmd = "SELECT a.id_mhs,a.id_ps,a.angkatan,a.nama,a.id_kur, b.nama as nama_status from RefAkdMhs a
                    LEFT JOIN RefAkdStatus b ON a.id_status = b.id_status_keu
                      where a.angkatan = '$angkatan'
                        and a.id_ps = '$ps_id'
                      order by a.id_mhs";
            $mhs = $this->modelsManager->executeQuery($cmd);

       }

       // echo "<pre>".print_r($cmd->toArray(),1)."</pre>";die();

        $this->view->mhs = $mhs;
        $this->view->pick('akd_mhs/cuti_kuliah/data');
    }

    ///////////////////////////////////////////////////////////////////////////
    //////////////////////////////// Data Cuti ////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////
    
    public function dataCutiMhsAction()
    {
        $nomhs = $_POST['nomhs'];
        $angkatan = $_POST['angkatan'];
        $nama = $_POST['nama'];
        $cmd = "SELECT * FROM RefAkdMhsCuti WHERE nomhs = '$nomhs' ORDER BY cuti_id DESC";
        $data_cuti = $this->modelsManager->executeQuery($cmd);

        $this->view->tgl_sekarang = date('Y-m-d');
        $this->view->nomhs = $nomhs;
        $this->view->angkatan = $angkatan;
        $this->view->nama = $nama;
        $this->view->data_cuti = $data_cuti;
        $this->view->pick('akd_mhs/cuti_kuliah/data_cuti');
    }

    ///////////////////////////////////////////////////////////////////////////
    //////////////////////////////// FORM EDIT ////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////
    
    public function formEditAction()
    {
        $nomhs = $_POST['nomhs'];
        $angkatan = $_POST['angkatan'];
        $nama = $_POST['nama'];
        $id = $_POST['id'];
        $cmd = "SELECT * FROM RefAkdMhsCuti WHERE cuti_id = '$id'";
        $data_cuti = $this->modelsManager->executeQuery($cmd)->toArray();

        $bulan = array(
            '01' => 'Januari',
            '02' => 'Februari',
            '03' => 'Maret',
            '04' => 'April',
            '05' => 'Mei',
            '06' => 'Juni',
            '07' => 'Juli',
            '08' => 'Agustus',
            '09' => 'September',
            '10' => 'Oktober',
            '11' => 'November',
            '12' => 'Desember',
        );


        $this->view->tgl_sekarang = date('Y-m-d');
        $this->view->id = $id;
        $this->view->bulan = $bulan;
        $this->view->nomhs = $nomhs;
        $this->view->angkatan = $angkatan;
        $this->view->nama = $nama;
        $this->view->data_cuti = $data_cuti;
        $this->view->pick('akd_mhs/cuti_kuliah/form_edit_cuti');
    }



    ///////////////////////////////////////////////////////////////////////////
    /////////////////////////////// Insert Cuti ///////////////////////////////
    ///////////////////////////////////////////////////////////////////////////

    function insertCutiAction($value='')
    {

        // echo "<pre>".print_r($_POST,1)."</pre>";die();
        $nomhs = $_POST['nomhs'];
        $keterangan = $_POST['keterangan'];

        $tgl_mulai = $_POST['tgl_mulai'];
        $bln_mulai = $_POST['bln_mulai'];
        $thn_mulai = $_POST['thn_mulai'];

        $tgl_akhir = $_POST['tgl_akhir'];
        $bln_akhir = $_POST['bln_akhir'];
        $thn_akhir = $_POST['thn_akhir'];

        $no_surat = $_POST['no_surat'];

        $tgl_surat = $_POST['tgl_surat'];
        $bln_surat = $_POST['bln_surat'];
        $thn_surat = $_POST['thn_surat'];

        $get_session = $this->session->get('ps_id');
        $explode = explode('-', $get_session);
        $ps_id = $explode[1];

        $tgl_m = $thn_mulai.'-'.$bln_mulai.'-'.$tgl_mulai;
        $tgl_a = $thn_akhir.'-'.$bln_akhir.'-'.$tgl_akhir;
        $tgl_s = $thn_surat.'-'.$bln_surat.'-'.$tgl_surat;


        // TAHUN AKD DAN SENSSION ID
        $cmd = "SELECT thn_akd,session_id FROM RefAkdSession WHERE begin_dt <= CURRENT_DATE() AND end_dt >= CURRENT_DATE()";
        $data_cuti = $this->modelsManager->executeQuery($cmd);
        if (count($data_cuti) > 0) {
            $thn_akd = $data_cuti[0]['thn_akd'];
            $session_id = $data_cuti[0]['session_id'];
        }else{
            $thn_akd = date('Y');
            $session_id = 1;
        }

        // validation
        $validation = new Phalcon\Validation();
        $validation->add('keterangan', new PresenceOf(array(
            'message' => 'Keterangan tidak boleh kosong'
        )));
        $validation->add('tgl_mulai', new PresenceOf(array(
            'message' => 'Tanggal Mulai tidak boleh kosong'
        )));
        $validation->add('tgl_akhir', new PresenceOf(array(
            'message' => 'Tanggal Selesai tidak boleh kosong'
        )));
        $validation->add('no_surat', new PresenceOf(array(
            'message' => 'Nomor Surat tidak boleh kosong'
        )));
        $validation->add('tgl_surat', new PresenceOf(array(
            'message' => 'Tanggal Surat tidak boleh kosong'
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
        }else{
            $query = new RefAkdMhsCuti();
            $query->assign(array(
                'thn_akd'       => $thn_akd,
                'session_id'    => $session_id,
                'nomhs'         => $nomhs,
                'keterangan'    => $keterangan,
                'tgl_start'     => $tgl_m,
                'tgl_stop'      => $tgl_a,
                'no_surat'      => $no_surat,
                'tgl_surat'     => $tgl_s
            ));
            $query->save();

            $cmd = "UPDATE RefAkdMhs SET id_status = 'C' WHERE id_mhs = '$nomhs' ";
            $this->modelsManager->executeQuery($cmd);

            $notif = array(
                'type'  => 'success',
                'text'  => 'Data berhasil di input',
                'title' => 'Regular Notice',
            );
        }

        echo json_encode($notif);

    }

    ///////////////////////////////////////////////////////////////////////////
    /////////////////////////////// Update Cuti ///////////////////////////////
    ///////////////////////////////////////////////////////////////////////////

    function updateCutiAction()
    {
        // echo "<pre>".print_r($_POST,1)."</pre>";die();

        $id = $_POST['id'];
        $keterangan = $_POST['keterangan'];
        $no_surat = $_POST['no_surat'];

        $tgl_mulai = $_POST['tgl_mulai'];
        $bln_mulai = $_POST['bln_mulai'];
        $thn_mulai = $_POST['thn_mulai'];

        $tgl_akhir = $_POST['tgl_akhir'];
        $bln_akhir = $_POST['bln_akhir'];
        $thn_akhir = $_POST['thn_akhir'];


        $tgl_surat = $_POST['tgl_surat'];
        $bln_surat = $_POST['bln_surat'];
        $thn_surat = $_POST['thn_surat'];

        $tgl_m = $thn_mulai.'-'.$bln_mulai.'-'.$tgl_mulai;
        $tgl_a = $thn_akhir.'-'.$bln_akhir.'-'.$tgl_akhir;
        $tgl_s = $thn_surat.'-'.$bln_surat.'-'.$tgl_surat;


        // validation
        $validation = new Phalcon\Validation();
        $validation->add("keterangan", new PresenceOf(array(
            'message' => 'Keterangan tidak boleh kosong'
        )));
        $validation->add("tgl_mulai", new PresenceOf(array(
            'message' => 'Tanggal Mulai tidak boleh kosong'
        )));
        $validation->add("tgl_akhir", new PresenceOf(array(
            'message' => 'Tanggal Selesai tidak boleh kosong'
        )));
        $validation->add("no_surat", new PresenceOf(array(
            'message' => 'Nomor Surat tidak boleh kosong'
        )));
        $validation->add("tgl_surat", new PresenceOf(array(
            'message' => 'Tanggal Surat tidak boleh kosong'
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
                'text'   => $pesan,
                'title'  => 'Warning',
            );
        }else{
            $query = RefAkdMhsCuti::findFirst($id);
            $query->assign(array(
                'keterangan'    => $keterangan,
                'tgl_start'     => $tgl_m,
                'tgl_stop'      => $tgl_a,
                'no_surat'      => $no_surat,
                'tgl_surat'     => $tgl_s
            ));

            if ($query->save()) {
                $notif = array(
                    'type'  => 'success',
                    'text'  => "Data berhasil di update",
                    'title' => "Regular Notice",
                );
            } else {
                $notif = array(
                    'type'  => 'warning',
                    'text'  => 'Data gagal di update',
                    'title' => 'Warning Notice',
                );
            }
        }

        echo json_encode($notif);

    }

    ///////////////////////////////////////////////////////////////////////////
    /////////////////////////////// Delete Cuti ///////////////////////////////
    ///////////////////////////////////////////////////////////////////////////

    public function deleteCutiAction($id)
    {
        $data = RefAkdMhsCuti::findFirst($id);

        // jika data berhasil dihapus
        if($data->delete()){
            $notif = array(
                'type'   => 'success',
                'text'  => 'Data berhasil di hapus',
                'title'  => 'Success',
            );
        } else {
            $notif = array(
                'type'   => 'warning',
                'text'  => 'Data gagal di hapus',
                'title'  => 'Gagal',
            );
        }
        echo json_encode($notif);

    }

}
