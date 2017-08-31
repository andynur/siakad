<?php
use Phalcon\Mvc\View;
use Phalcon\Validation;
use Phalcon\Validation\Validator\PresenceOf;
use Phalcon\Mvc\Url;

class AkdpendadaranController extends \Phalcon\Mvc\Controller
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
    //////////////////////////// CEK SKRIPSI //////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////
    public function selectMhsAction()
    {
        $get_session = $this->session->get('ps_id');
        $explode = explode('-', $get_session);
        $ps_id = $explode[1];

        $angkatan = "SELECT DISTINCT angkatan FROM RefAkdMhs
        WHERE id_ps = $ps_id ORDER BY angkatan DESC";
        $angkat = $this->modelsManager->executeQuery($angkatan);

        $this->view->angkatan      = $angkat;
        $this->view->pick('akd_skripsi/pendadaran/select_mhs');
    }

    public function mahasiswaAction()
    {

        $get_session= $this->session->get('ps_id');
        $explode    = explode('-', $get_session);
        $ps_id      = $explode[1];

        $nama_mhs    = $_POST['nama_mhs'];
        $nomhs    = $_POST['nomhs'];
        $angkatan   = $_POST['angkatan'];


        if($nomhs != '' ) {
            $angkatan_isset = ($angkatan != '') ? "and a.angkatan = '$angkatan'" : "";
            $cmd = "SELECT a.id_mhs,a.id_ps,a.angkatan,a.nama,a.id_kur,b.ext from RefAkdMhs a
                    left join RefAkdPs b on a.id_ps=b.id_ps
                      where a.id_mhs = '$nomhs'
                        and a.id_ps = '$ps_id'
                        $angkatan_isset
                      order by id_mhs";
            $mhs = $this->modelsManager->executeQuery($cmd);
          
       } elseif ($nama_mhs != '') {
                $angkatan_isset = ($angkatan != '') ? "and a.angkatan = '$angkatan'" : "";
                $cmd = "SELECT a.id_mhs,a.id_ps,a.angkatan,a.nama,a.id_kur,b.ext  from RefAkdMhs a
                        left join RefAkdPs b on a.id_ps=b.id_ps
                   where a.nama like '%$nama_mhs%'
                     $angkatan_isset 
                     and id_ps = '$ps_id'";
                $mhs = $this->modelsManager->executeQuery($cmd);

       } elseif ($angkatan != '') {
            $cmd = "SELECT a.id_mhs,a.id_ps,a.angkatan,a.nama,a.id_kur,b.ext from RefAkdMhs a
                    left join RefAkdPs b on a.id_ps=b.id_ps
                      where a.angkatan = '$angkatan'
                        and a.id_ps = '$ps_id'
                      order by a.id_mhs";
            $mhs = $this->modelsManager->executeQuery($cmd);

       }
        $this->view->mhs = $mhs;
        $this->view->pick('akd_skripsi/pendadaran/mahasiswa');
    }

    public function dataSkripsiAction($value='')
    {
        $get_session= $this->session->get('ps_id');
        $explode    = explode('-', $get_session);
        $ps_id      = $explode[1];

        $nomhs = $_POST['nomhs'];
        $angkatan = $_POST['angkatan'];
        $nama = $_POST['nama'];
        $psmhs_id = $_POST['psmhs_id'];

        $fungsi = new FungsiController();
        $nama_jurusan = $fungsi->nama_ps($ps_id);

        $q = "SELECT a.id,a.judul,a.ujian_ke,b.nama as nama_ujian,a.periode from RefAkdPendadaranSkripsi a 
            left join RefSysUjian b on a.ujian_id=b.id
                where a.nomhs='$nomhs' and a.psmhs_id='$psmhs_id'  ";
        $data_skripsi_mhs = $this->modelsManager->executeQuery($q);

        $this->view->nama = $nama;
        $this->view->nomhs = $nomhs;
        $this->view->psmhs_id = $psmhs_id;
        $this->view->angkatan = $angkatan;
        $this->view->data_skripsi_mhs = $data_skripsi_mhs;
        
        $this->view->pick('akd_skripsi/pendadaran/data_skripsi_mhs');
    }    

    public function formPendadaranAction($value='')
    {
        $get_session= $this->session->get('ps_id');
        $explode    = explode('-', $get_session);
        $ps_id      = $explode[1];

        $nomhs = $_POST['nomhs'];
        $nama = $_POST['nama'];
        $psmhs_id = $_POST['psmhs_id'];
        $angkatan = $_POST['angkatan'];

        $fungsi = new FungsiController();
        $nama_jurusan = $fungsi->nama_ps($ps_id);

        $ujian = RefSysUjian::find();

        $q = "SELECT nip,concat(gelar_dpn,nama,gelar_blk) as nama_dosen from RefAkdSdm where kelp='DOSEN' order by nama asc";
        $dosen = $this->modelsManager->executeQuery($q);


        $bulan = array(
            1   => 'Januari',
            2   => 'Februari',
            3   => 'Maret',
            4   => 'April',
            5   => 'Mei',
            6   => 'Juni',
            7   => 'Juli',
            8   => 'Agustus',
            9   => 'September',
            10  => 'Oktober',
            11  => 'November',
            12  => 'Desember'
        );


        $this->view->bulan = $bulan;
        $this->view->nama = $nama;
        $this->view->nomhs = $nomhs;
        $this->view->psmhs_id = $psmhs_id;
        $this->view->angkatan = $angkatan;
        $this->view->nama_jurusan = $nama_jurusan;
        $this->view->ujian = $ujian;
        $this->view->dosen = $dosen;

        $hal = 'akd_skripsi/pendadaran/form_pendadaran';        
        $this->view->pick($hal);
    }

    public function formEditPendadaranAction($id)
    {
        // echo "<pre>".print_r($_POST,1)."</pre>";die();
        $get_session= $this->session->get('ps_id');
        $explode    = explode('-', $get_session);
        $ps_id      = $explode[1];

        $nomhs = $_POST['nomhs'];
        $nama = $_POST['nama'];
        $psmhs_id = $_POST['psmhs_id'];
        $angkatan = $_POST['angkatan'];

        $fungsi = new FungsiController();
        $nama_jurusan = $fungsi->nama_ps($ps_id);

        $ujian = RefSysUjian::find();

        $q = "SELECT nip,concat(gelar_dpn,nama,gelar_blk) as nama_dosen from RefAkdSdm where kelp='DOSEN' order by nama asc";
        $dosen = $this->modelsManager->executeQuery($q);


        $bulan = array(
            1   => 'Januari',
            2   => 'Februari',
            3   => 'Maret',
            4   => 'April',
            5   => 'Mei',
            6   => 'Juni',
            7   => 'Juli',
            8   => 'Agustus',
            9   => 'September',
            10  => 'Oktober',
            11  => 'November',
            12  => 'Desember'
        );

        $q = "SELECT a.id,a.periode,a.judul,a.ujian_id,a.ujian_ke,a.pembimbing1,a.pembimbing2,b.nama as nama_ujian,a.periode from RefAkdPendadaranSkripsi a 
            left join RefSysUjian b on a.ujian_id=b.id
                where a.id='$id' ";
        $data_skripsi_mhs = $this->modelsManager->executeQuery($q)->toArray();


        $this->view->nama = $nama;
        $this->view->nomhs = $nomhs;
        $this->view->psmhs_id = $psmhs_id;
        $this->view->angkatan = $angkatan;
        $this->view->nama_jurusan = $nama_jurusan;
        
        $this->view->bulan = $bulan;
        $this->view->ujian = $ujian;
        $this->view->dosen = $dosen;
        $this->view->data_skripsi_mhs = $data_skripsi_mhs;

        $hal = 'akd_skripsi/pendadaran/edit_pendadaran';        
        $this->view->pick($hal);
    }

    public function addPendadaranAction($value='')
    {
        

        $dd1 = $_POST['dd1'];
        $mm1 = $_POST['mm1'];
        $yyyy1 = $_POST['yyyy1'];

        $validation = new Phalcon\Validation(); 
        $validation->add('dd1', new PresenceOf(array(
            'message' => 'Periode tidak boleh kosong'
        )));
        $validation->add('mm1', new PresenceOf(array(
            'message' => 'Periode tidak boleh kosong'
        )));
        $validation->add('yyyy1', new PresenceOf(array(
            'message' => 'Periode tidak boleh kosong'
        )));
        $validation->add('judul', new PresenceOf(array(
            'message' => 'Judul tidak boleh kosong'
        )));
        $validation->add('ujian_id', new PresenceOf(array(
            'message' => 'ujian_id tidak boleh kosong'
        )));
        $validation->add('ujian_ke', new PresenceOf(array(
            'message' => 'ujian_ke tidak boleh kosong'
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

            $query = new RefAkdPendadaranSkripsi();
            $query->assign(array(
                'periode' => "$yyyy1-$mm1-$dd1",
                'nomhs' => $_POST['nomhs'],
                'psmhs_id' => $_POST['psmhs_id'],
                'ujian_id' => $_POST['ujian_id'],
                'ujian_ke' => $_POST['ujian_ke'],
                'judul' => $_POST['judul'],
                'pembimbing1' => $_POST['pembimbing1'],
                'pembimbing2' => $_POST['pembimbing2']
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

    public function editPendadaranAction($id)
    {
        

        $dd1 = $_POST['dd1'];
        $mm1 = $_POST['mm1'];
        $yyyy1 = $_POST['yyyy1'];

        $validation = new Phalcon\Validation(); 
        $validation->add('dd1', new PresenceOf(array(
            'message' => 'Periode tidak boleh kosong'
        )));
        $validation->add('mm1', new PresenceOf(array(
            'message' => 'Periode tidak boleh kosong'
        )));
        $validation->add('yyyy1', new PresenceOf(array(
            'message' => 'Periode tidak boleh kosong'
        )));
        $validation->add('judul', new PresenceOf(array(
            'message' => 'Judul tidak boleh kosong'
        )));
        $validation->add('ujian_id', new PresenceOf(array(
            'message' => 'ujian_id tidak boleh kosong'
        )));
        $validation->add('ujian_ke', new PresenceOf(array(
            'message' => 'ujian_ke tidak boleh kosong'
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

            $query = RefAkdPendadaranSkripsi::findFirstById($id);
            $query->assign(array(
                'periode' => "$yyyy1-$mm1-$dd1",
                'nomhs' => $_POST['nomhs'],
                'psmhs_id' => $_POST['psmhs_id'],
                'ujian_id' => $_POST['ujian_id'],
                'ujian_ke' => $_POST['ujian_ke'],
                'judul' => $_POST['judul'],
                'pembimbing1' => $_POST['pembimbing1'],
                'pembimbing2' => $_POST['pembimbing2']
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
