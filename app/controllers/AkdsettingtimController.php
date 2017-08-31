<?php
use Phalcon\Mvc\View;
use Phalcon\Validation;
use Phalcon\Validation\Validator\PresenceOf;
use Phalcon\Mvc\Url;

class AkdsettingtimController extends \Phalcon\Mvc\Controller
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
    //////////////////////////// Cari Periode Tim ///////////////////////////////
    ///////////////////////////////////////////////////////////////////////////
    public function cariTimAction()
    {
        $get_session = $this->session->get('ps_id');
        $explode = explode('-', $get_session);
        $ps_id = $explode[1];

        $fungsi = new FungsiController();

        $q = "SELECT thn_akd,session_id,nama FROM RefAkdSession 
                    where ps_id = '$ps_id' 
                    order by thn_akd desc, session_id desc limit 5";
        $tahun_sesi = $this->modelsManager->executeQuery($q);

        $this->view->tahun_sesi = $tahun_sesi;
        $this->view->bulan = $fungsi->bulan();
        $this->view->pick('akd_skripsi/setting_tim/form_cari');
    }

    public function formTambahAction($value='')
    {
        $get_session = $this->session->get('ps_id');
        $explode = explode('-', $get_session);
        $ps_id = $explode[1];

        $q = "SELECT * FROM RefAkdDosenPenguji 
                    where id_ps = '$ps_id' 
                    order by nip ASC";
        $dosen = $this->modelsManager->executeQuery($q)->toArray();

        $q = "SELECT * FROM RefAkdSkripsiMk 
                    where id_ps = '$ps_id'";
        $mk = $this->modelsManager->executeQuery($q)->toArray();

        $fungsi = new FungsiController();
        $this->view->tim = $fungsi->timSkripsi();
        $this->view->dosen = $dosen;
        $this->view->mk = $mk;
        $this->view->pick('akd_skripsi/setting_tim/form_tambah');
    }

    public function dataPeriodeSkripsiAction($value='')
    {
        // echo "<pre>".print_r($_POST,1)."</pre>";
        $get_session = $this->session->get('ps_id');
        $explode = explode('-', $get_session);
        $ps_id = $explode[1];

        $date = $_POST['tgl'].'-'.$_POST['bln'].'-'.$_POST['thn'];
        $periode = date("Y-m-d", strtotime($date));

        // echo "<pre>".print_r($periode,1)."</pre>";die();

        $q = "SELECT a.id,a.tim,b.nama as nama1,c.nama as nama2,d.nama as nama3,e.mk_2 as mk1,f.mk_2 as mk2,g.mk_2 as mk3,a.tgl_skripsi,a.no_surat,a.tgl_surat
                 from RefAkdSettingSkripsi a
                 left join RefAkdDosenPenguji b on b.nip=a.uji_1 and b.id_ps=a.ps_id
                 left join RefAkdDosenPenguji c on c.nip=a.uji_2 and c.id_ps=a.ps_id
                 left join RefAkdDosenPenguji d on d.nip=a.uji_3 and d.id_ps=a.ps_id
                 left join RefAkdSkripsiMk e on e.kode_mk=a.mk_1 and e.id_ps=a.ps_id and e.thn_kur='2001'
                 left join RefAkdSkripsiMk f on f.kode_mk=a.mk_2 and f.id_ps=a.ps_id and f.thn_kur='2001'
                 left join RefAkdSkripsiMk g on g.kode_mk=a.mk_3 and g.id_ps=a.ps_id and g.thn_kur='2001'
                 where a.periode='$periode' and a.ps_id='$ps_id'";
        $data_setting = $this->modelsManager->executeQuery($q)->toArray();

        $this->view->data_setting = $data_setting;
        $this->view->pick('akd_skripsi/setting_tim/data_setting');

    }

    public function formEditAction($id)
    {
        $get_session = $this->session->get('ps_id');
        $explode = explode('-', $get_session);
        $ps_id = $explode[1];

        $q = "SELECT * FROM RefAkdDosenPenguji where id_ps = '$ps_id' order by nip ASC";
        $dosen = $this->modelsManager->executeQuery($q)->toArray();

        $q = "SELECT * FROM RefAkdSkripsiMk where id_ps = '$ps_id'";
        $mk = $this->modelsManager->executeQuery($q)->toArray();

        $q = "SELECT * FROM RefAkdSettingSkripsi where id = '$id'";
        $data_setting = $this->modelsManager->executeQuery($q)->toArray();

        $fungsi = new FungsiController();
        $this->view->tim = $fungsi->timSkripsi();
        $this->view->bulan = $fungsi->bulan();
        $this->view->dosen = $dosen;
        $this->view->mk = $mk;
        $this->view->data_setting = $data_setting;
        $this->view->pick('akd_skripsi/setting_tim/form_edit');
    }

    public function addDataAction($value='')
    {
        $get_session = $this->session->get('ps_id');
        $explode = explode('-', $get_session);
        $ps_id = $explode[1];

        $dd_periode = $_POST['dd_periode'];
        $mm_periode = $_POST['mm_periode'];
        $yyyy_periode = $_POST['yyyy_periode'];
        $tim = $_POST['tim'];
        $penguji_1 = $_POST['penguji_1'];
        $penguji_2 = $_POST['penguji_2'];
        $penguji_3 = $_POST['penguji_3'];
        $mk_1 = $_POST['mk_1'];
        $mk_2 = $_POST['mk_2'];
        $mk_3 = $_POST['mk_3'];
        $dd_skripsi = $_POST['dd_skripsi'];
        $mm_skripsi = $_POST['mm_skripsi'];
        $yyyy_skripsi = $_POST['yyyy_skripsi'];

        $jam_skripsi = $_POST['jam_skripsi'];

        $no_surat = $_POST['no_surat'];
        $dd_surat = $_POST['dd_surat'];
        $mm_surat = $_POST['mm_surat'];
        $yyyy_surat = $_POST['yyyy_surat'];

        $periode = "$yyyy_periode-$mm_periode-$dd_periode";
        $tgl_sekripsi = "$yyyy_skripsi-$mm_skripsi-$dd_skripsi";
        $tgl_surat = "$yyyy_surat-$mm_surat-$dd_surat";

        $jam_skripsi = str_replace(".",":",$jam_skripsi);

        $arr = explode(":",$jam_skripsi);
        if(count($arr) == 2) {
         $jam_skripsi .= ":00";
        } elseif (count($arr) == 1) {
         $jam_skripsi .= ":00:00";
        }

        $waktu_skripsi = "$tgl_sekripsi $jam_skripsi";

        $validation = new Phalcon\Validation(); 
        $validation->add('penguji_1', new PresenceOf(array(
            'message' => 'penguji 1 tidak boleh kosong'
        )));
        $validation->add('no_surat', new PresenceOf(array(
            'message' => 'no_surat tidak boleh kosong'
        )));
        $validation->add('mk_1', new PresenceOf(array(
            'message' => 'mk 1 tidak boleh kosong'
        )));
        $validation->add('tim', new PresenceOf(array(
            'message' => 'tim tidak boleh kosong'
        )));
        $validation->add('jam_skripsi', new PresenceOf(array(
            'message' => 'jam_skripsi tidak boleh kosong'
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
            $query = new RefAkdSettingSkripsi();
            $query->assign(array(
                        'ps_id' => $ps_id,
                        'tim' => $tim,
                        'periode' => $periode,
                        'uji_1' => $penguji_1,
                        'uji_2' => $penguji_2,
                        'uji_3' => $penguji_3,
                        'mk_1' => $mk_1,
                        'mk_2' => $mk_2,
                        'mk_3' => $mk_3,
                        'tgl_skripsi' => $waktu_skripsi,
                        'no_surat' => $no_surat,
                        'tgl_surat' => $tgl_surat
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

    public function editDataAction($id)
    {
        $get_session = $this->session->get('ps_id');
        $explode = explode('-', $get_session);
        $ps_id = $explode[1];

        $dd_periode = $_POST['dd_periode'];
        $mm_periode = $_POST['mm_periode'];
        $yyyy_periode = $_POST['yyyy_periode'];
        $tim = $_POST['tim'];
        $penguji_1 = $_POST['penguji_1'];
        $penguji_2 = $_POST['penguji_2'];
        $penguji_3 = $_POST['penguji_3'];
        $mk_1 = $_POST['mk_1'];
        $mk_2 = $_POST['mk_2'];
        $mk_3 = $_POST['mk_3'];
        $dd_skripsi = $_POST['dd_skripsi'];
        $mm_skripsi = $_POST['mm_skripsi'];
        $yyyy_skripsi = $_POST['yyyy_skripsi'];

        $jam_skripsi = $_POST['jam_skripsi'];

        $no_surat = $_POST['no_surat'];
        $dd_surat = $_POST['dd_surat'];
        $mm_surat = $_POST['mm_surat'];
        $yyyy_surat = $_POST['yyyy_surat'];

        $periode = "$yyyy_periode-$mm_periode-$dd_periode";
        $tgl_sekripsi = "$yyyy_skripsi-$mm_skripsi-$dd_skripsi";
        $tgl_surat = "$yyyy_surat-$mm_surat-$dd_surat";

        $jam_skripsi = str_replace(".",":",$jam_skripsi);

        $arr = explode(":",$jam_skripsi);
        if(count($arr) == 2) {
         $jam_skripsi .= ":00";
        } elseif (count($arr) == 1) {
         $jam_skripsi .= ":00:00";
        }

        $waktu_skripsi = "$tgl_sekripsi $jam_skripsi";

        $validation = new Phalcon\Validation(); 
        $validation->add('penguji_1', new PresenceOf(array(
            'message' => 'penguji 1 tidak boleh kosong'
        )));
        $validation->add('no_surat', new PresenceOf(array(
            'message' => 'no_surat tidak boleh kosong'
        )));
        $validation->add('mk_1', new PresenceOf(array(
            'message' => 'mk 1 tidak boleh kosong'
        )));
        $validation->add('tim', new PresenceOf(array(
            'message' => 'tim tidak boleh kosong'
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
            $query = RefAkdSettingSkripsi::findFirstById($id);
            $query->assign(array(
                        'tim' => $tim,
                        'periode' => $periode,
                        'uji_1' => $penguji_1,
                        'uji_2' => $penguji_2,
                        'uji_3' => $penguji_3,
                        'mk_1' => $mk_1,
                        'mk_2' => $mk_2,
                        'mk_3' => $mk_3,
                        'tgl_skripsi' => $waktu_skripsi,
                        'no_surat' => $no_surat,
                        'tgl_surat' => $tgl_surat
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

    
}
