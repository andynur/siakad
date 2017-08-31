<?php
use Phalcon\Mvc\View;
use Phalcon\Validation;
use Phalcon\Validation\Validator\PresenceOf;
use Phalcon\Mvc\Url;

class AkdstatusmhsController extends \Phalcon\Mvc\Controller
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
    //////////////////////////// REKAP STATUS Mhs /////////////////////////////
    ///////////////////////////////////////////////////////////////////////////
    public function rekapStatusAction()
    {
        $get_session = $this->session->get('ps_id');
        $explode = explode('-', $get_session);
        $ps_id = $explode[1];

        $this->view->pick('akd_mhs/rekap_status/rekap_status');
    }

    ///////////////////////////////////////////////////////////////////////////
    //////////////////////////// EDIT STATUS Mhs /////////////////////////////
    ///////////////////////////////////////////////////////////////////////////
    public function editStatusAction()
    {
        $get_session = $this->session->get('ps_id');
        $explode = explode('-', $get_session);
        $ps_id = $explode[1];

        $angkatan = "SELECT DISTINCT angkatan FROM RefAkdMhs
        WHERE id_ps = $ps_id ORDER BY angkatan DESC";

        $angkat = $this->modelsManager->executeQuery($angkatan);
        $this->view->angkatan      = $angkat;

        $this->view->pick('akd_mhs/edit_status/find');
    }

    public function mahasiswaEditStatusAction()
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
                   where a.nama like '%$nama_mhs%'
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

        $this->view->mhs = $mhs;
        $this->view->pick('akd_mhs/edit_status/mahasiswa');
    }

    public function dataStatusMhsAction($value='')
    {
        $nomhs = $_POST['nomhs'];
        $angkatan = $_POST['angkatan'];
        $nama = $_POST['nama'];

        $cmd = "SELECT a.id,a.nomhs,a.status,a.no_surat,a.tgl_surat,a.keterangan,b.nama FROM RefAkdMhsStatus a 
                LEFT JOIN RefAkdStatus b ON a.status = b.id_status_keu 
                WHERE a.nomhs = '$nomhs'  ORDER BY a.id DESC";
        $data_status = $this->modelsManager->executeQuery($cmd);

        $cmd = "SELECT * FROM RefAkdStatus where id_status_keu <> 'C' and id_status_keu <> 'L' ORDER BY id_status ASC";
        $status = $this->modelsManager->executeQuery($cmd);

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

        $this->view->nomhs = $nomhs;
        $this->view->angkatan = $angkatan;
        $this->view->nama = $nama;
        $this->view->data_status = $data_status;
        $this->view->status = $status;
        $this->view->bulan = $bulan;
        $this->view->pick('akd_mhs/edit_status/data_status');
    }

    public function addStatusAction($value='')
    {
        $status = $_POST['status'];
        $nomhs = $_POST['nomhs'];
        $keterangan = $_POST['keterangan'];

        $no_surat = $_POST['no_surat'];

        $tgl_surat = $_POST['tgl_surat'];
        $bln_surat = $_POST['bln_surat'];
        $thn_surat = $_POST['thn_surat'];

        $get_session = $this->session->get('ps_id');
        $explode = explode('-', $get_session);
        $ps_id = $explode[1];

        $tgl_s = $thn_surat.'-'.$bln_surat.'-'.$tgl_surat;


        // TAHUN AKD DAN SENSSION ID
        $cmd = "SELECT thn_akd,session_id FROM RefAkdSession WHERE ps_id = '$ps_id' and begin_dt <= CURRENT_DATE() AND end_dt >= CURRENT_DATE()";
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
            $query = new RefAkdMhsStatus();
            $query->assign(array(
                'status'       => $status,
                'nomhs'         => $nomhs,
                'thn_akd'       => $thn_akd,
                'session_id'    => $session_id,
                'keterangan'    => $keterangan,
                'no_surat'      => $no_surat,
                'tgl_surat'     => $tgl_s
            ));
            $query->save();

            $cmd = "UPDATE RefAkdMhs SET id_status = '$status' WHERE id_mhs = '$nomhs' ";
            $this->modelsManager->executeQuery($cmd);

            $notif = array(
                'type'  => 'success',
                'text'  => 'Data berhasil di input',
                'title' => 'Regular Notice',
            );
        }

        echo json_encode($notif);
    }


    public function delStatusAction($id)
    {
        $data = RefAkdMhsStatus::findFirst($id);

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

    public function updateStatusAction($id)
    {
        $status = $_POST['status'];
        $keterangan = $_POST['keterangan'];
        $no_surat = $_POST['no_surat'];


        $tgl_surat = $_POST['tgl_surat'];
        $bln_surat = $_POST['bln_surat'];
        $thn_surat = $_POST['thn_surat'];

        $tgl_s = $thn_surat.'-'.$bln_surat.'-'.$tgl_surat;


        // validation
        $validation = new Phalcon\Validation();
        $validation->add("keterangan", new PresenceOf(array(
            'message' => 'Keterangan tidak boleh kosong'
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
            $query = RefAkdMhsStatus::findFirst($id);
            $query->assign(array(
                'status'    => $status,
                'keterangan'    => $keterangan,
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


}
