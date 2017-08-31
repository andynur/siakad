<?php
use Phalcon\Mvc\View;
use Phalcon\Validation;
use Phalcon\Validation\Validator\PresenceOf;
use Phalcon\Mvc\Url;

class AkdskripsimhsController extends \Phalcon\Mvc\Controller
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
    //////////////////////////// SELECT SESI //////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////
    public function selectSesiAction()
    {
        $psmhs_id = $this->session->get('id_ps');
        $nomhs = $this->session->get('uid');

        $q = "SELECT thn_akd,session_id,nama FROM RefAkdSession 
                    where ps_id = '$psmhs_id' 
                    order by thn_akd desc, session_id desc limit 5";
        $tahun_sesi = $this->modelsManager->executeQuery($q);

        $q = "SELECT * FROM RefAkdPengajuanSkripsi 
                    where psmhs_id = '$psmhs_id' and nomhs = '$nomhs' ";
        $skripsi_mhs = $this->modelsManager->executeQuery($q)->toArray();

        $this->view->tahun_sesi      = $tahun_sesi;
        $this->view->skripsi_mhs      = $skripsi_mhs;
        $this->view->pick('akd_skripsi/mhs/select_sesi');
    }

    public function formSkripsiAction()
    {
        $psmhs_id = $this->session->get('id_ps');
        $nomhs = $this->session->get('uid');

        $sesi = explode('-', $_POST['sesi']);
        $thn_akd = $sesi[0];
        $session_id = $sesi[1];

        $fungsi = new FungsiController;
        $sesi_nama = $fungsi->nama_sesi($thn_akd,$session_id);



        $q = "SELECT nomhs,thn_akd,session_id,kode_mk,thn_kur,nama_kelas FROM RefAkdKrs 
                    where ps_id = '$psmhs_id' and nomhs = '$nomhs' and thn_akd='$thn_akd' and session_id='$session_id' and kode_mk='ST500' and nama_kelas='A' ";
        $krs = $this->modelsManager->executeQuery($q)->toArray();

        $this->view->sesi = $_POST['sesi'];
        $this->view->sesi_nama = $sesi_nama;
        // echo "<pre>".print_r($krs,1)."</pre>";die();
        if (count($krs) == 0) {
            echo "</br>";
            echo "</br>";
            echo "</br>";
            echo "<h2 class='lead' style='text-align:center;' >Anda Belum Mengambil KRS Mata Kuliah SKRIPSI</h2>";
        }else{
            echo "string";
            $this->view->pick('akd_skripsi/mhs/form_skripsi');
        }

    }

    public function addPengajuanAction($value='')
    {
        $psmhs_id = $this->session->get('id_ps');
        $nomhs = $this->session->get('uid');

        $sesi = explode('-', $_POST['sesi']);
        $thn_akd = $sesi[0];
        $session_id = $sesi[1];

        $validation = new Phalcon\Validation(); 
        $validation->add('judul', new PresenceOf(array(
            'message' => 'judul tidak boleh kosong'
        )));
        $validation->add('bidang', new PresenceOf(array(
            'message' => 'bidang Penelitian tidak boleh kosong'
        )));
        $validation->add('perusahaan', new PresenceOf(array(
            'message' => 'perusahaan tidak boleh kosong'
        )));
        $validation->add('kota_perusahaan', new PresenceOf(array(
            'message' => 'kota_perusahaan tidak boleh kosong'
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
            $query = new RefAkdPengajuanSkripsi();
            $query->assign(array(
                        'nomhs' => $nomhs,
                        'psmhs_id' => $psmhs_id,
                        'thn_akd' => $thn_akd,
                        'session_id' => $session_id,
                        'judul_skripsi' => $_POST['judul'],
                        'bidang_penelitian' => $_POST['bidang'],
                        'perusahaan' => $_POST['perusahaan'],
                        'kota_perusahaan' => $_POST['kota_perusahaan'],
                        'status' => "P",
                )
            );
            $query->save();
            $notif = array(
                'title' => 'success',
                'text' => 'Data berhasil di input',
                'type' => 'success',
            );
        }

        echo json_encode($notif);
    }

    public function editSkripsiAction($id)
    {
        $psmhs_id = $this->session->get('id_ps');
        $nomhs = $this->session->get('uid');

        $validation = new Phalcon\Validation(); 
        $validation->add('judul', new PresenceOf(array(
            'message' => 'judul tidak boleh kosong'
        )));
        $validation->add('bidang', new PresenceOf(array(
            'message' => 'bidang Penelitian tidak boleh kosong'
        )));
        $validation->add('perusahaan', new PresenceOf(array(
            'message' => 'perusahaan tidak boleh kosong'
        )));
        $validation->add('kota_perusahaan', new PresenceOf(array(
            'message' => 'kota_perusahaan tidak boleh kosong'
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
            $query = RefAkdPengajuanSkripsi::findFirstById($id);
            $query->assign(array(
                        'judul_skripsi' => $_POST['judul'],
                        'bidang_penelitian' => $_POST['bidang'],
                        'perusahaan' => $_POST['perusahaan'],
                        'kota_perusahaan' => $_POST['kota_perusahaan']
                )
            );
            $query->save();
            $notif = array(
                'title' => 'success',
                'text' => 'Data berhasil di Edit',
                'type' => 'success',
            );
        }

        echo json_encode($notif);
    }




}
