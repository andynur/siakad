<?php
use Phalcon\Mvc\View;
use Phalcon\Validation;
use Phalcon\Validation\Validator\PresenceOf;
use Phalcon\Mvc\Url;

class AkdskripsiController extends \Phalcon\Mvc\Controller
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
    public function selectSesiAction()
    {
        $get_session = $this->session->get('ps_id');
        $explode = explode('-', $get_session);
        $ps_id = $explode[1];

        $q = "SELECT thn_akd,session_id,nama FROM RefAkdSession 
                    where ps_id = '$ps_id' 
                    order by thn_akd desc, session_id desc limit 5";
        $tahun_sesi = $this->modelsManager->executeQuery($q);

        $this->view->tahun_sesi      = $tahun_sesi;
        $this->view->pick('akd_skripsi/select_sesi');
    }

    public function listMhsSkripsiAction()
    {
        $get_session = $this->session->get('ps_id');
        $explode = explode('-', $get_session);
        $ps_id = $explode[1];

        $sesi = explode('-', $_POST['sesi']);
        $thn_akd = $sesi[0];
        $session_id = $sesi[1];

        $thn_akd_b = $sesi[0]-5;
        $fungsi = new FungsiController;
        $sesi_nama = $fungsi->nama_sesi($thn_akd,$session_id);

        $q = "SELECT nip,concat(gelar_dpn,nama,gelar_blk) as nama_dosen from RefAkdSdm where kelp='DOSEN' order by nama asc";
        $dosen = $this->modelsManager->executeQuery($q);

        $q = "SELECT a.nomhs,a.psmhs_id,b.nama,a.thn_akd,a.session_id,c.id as id_dosen_bimbing,c.nip,c.nip2 from RefAkdKrs a
              left join RefAkdMhs b on b.id_mhs=a.nomhs and b.id_ps=a.psmhs_id
              left join RefAkdDosenPembimbing c on a.nomhs=c.nomhs and a.psmhs_id=c.psmhs_id and a.thn_akd=c.thn_akd 
                and a.session_id=c.session_id
              where a.thn_akd='$thn_akd' and a.session_id='$session_id' and a.kode_mk='ST500' and a.nama_kelas='A'
              and a.psmhs_id like '%$ps_id'
              order by a.nomhs asc";
        $mhs_krs = $this->modelsManager->executeQuery($q)->toArray();

        $q = "SELECT a.nomhs,a.psmhs_id,a.thn_akd,a.session_id from RefAkdKrs a
                  where a.kode_mk='ST500'
                  and a.psmhs_id like '%$ps_id' and a.thn_akd <= '$thn_akd' and a.thn_akd >= '$thn_akd_b' ";
        $mhs_krs_else = $this->modelsManager->executeQuery($q)->toArray();

        foreach ($mhs_krs_else as $k => $v) {
            $key = $v['nomhs']."#".$v['psmhs_id'];
            $array = $v['thn_akd']."/".$v['session_id'];

            $total_skripsi[$key][] = $array;

            if (array_key_exists($key,$total_skripsi)) {
                $r = $total_skripsi[$key];
                array_filter($r);
                array_push($r, $array);
            }
        }

        $mhs_skripsi = [];
        foreach ($mhs_krs as $k => $v) {
            $key = $v['nomhs']."#".$v['psmhs_id'];
            $v['total_skripsi'] = count($total_skripsi[$key]);
            $mhs_skripsi[] = $v;
        }

        $this->view->sesi      = $_POST['sesi'];
        $this->view->dosen      = $dosen;
        $this->view->sesi_nama      = $sesi_nama;
        $this->view->mhs_skripsi      = $mhs_skripsi;
        $this->view->pick('akd_skripsi/mahasiswa');
    }

    public function updateDosenBimbingAction($id)
    {
        $nip = $_POST['nip'] ;
        $dosen = $_POST['dosen'] ;

        if ($dosen == 1) {
            $query = RefAkdDosenPembimbing::findFirst($id);
            $query->assign(array(
                'nip'    => $nip
            ));
            $query->save();
        }else{
            $query = RefAkdDosenPembimbing::findFirst($id);
            $query->assign(array(
                'nip2'    => $nip
            ));
            $query->save();
        }


        $notif = array(
            'type'   => 'success',
            'text'  => 'Data berhasil di Ubah',
            'title'  => 'Success',
        );

        echo json_encode($notif);
    }

    public function addDosenBimbingAction($value='')
    {
        $sesi = explode('-', $_POST['sesi']);
        $thn_akd = $sesi[0];
        $session_id = $sesi[1];

        $dosen = $_POST['dosen'] ;

        if ($dosen == 1) {
            $berita = new RefAkdDosenPembimbing();
            $berita->assign(array(
                        'nomhs' => $_POST['nomhs'],
                        'psmhs_id' => $_POST['psmhs_id'],
                        'thn_akd' => $thn_akd,
                        'session_id' => $session_id,
                        'nip' => $_POST['nip']
                        )
            );
            $berita->save();

        }else{
            
            $berita = new RefAkdDosenPembimbing();
            $berita->assign(array(
                    'nomhs' => $_POST['nomhs'],
                    'psmhs_id' => $_POST['psmhs_id'],
                    'thn_akd' => $thn_akd,
                    'session_id' => $session_id,
                    'nip2' => $_POST['nip']
                    )
                );
            $berita->save();
        }

        
        $notif = array(
            'type'   => 'success',
            'text'  => 'Data berhasil di Ubah',
            'title'  => 'Success',
        );

        echo json_encode($notif);
    }


    ///////////////////////////////////////////////////////////////////////////
    //////////////////////////// ACC SCRIPSI MHS //////////////////////////////
    ///////////////////////////////////////////////////////////////////////////

    public function selectSesiAccAction($value='')
    {
        $get_session = $this->session->get('ps_id');
        $explode = explode('-', $get_session);
        $ps_id = $explode[1];

        $q = "SELECT thn_akd,session_id,nama FROM RefAkdSession 
                    where ps_id = '$ps_id' 
                    order by thn_akd desc, session_id desc limit 5";
        $tahun_sesi = $this->modelsManager->executeQuery($q);

        $this->view->tahun_sesi      = $tahun_sesi;
        $this->view->pick('akd_skripsi/pengajuan_skripsi/select_sesi');
    }

    public function mhsPengajuanAction($value='')
    {
        $get_session = $this->session->get('ps_id');
        $explode = explode('-', $get_session);
        $ps_id = $explode[1];

        $sesi = explode('-', $_POST['sesi']);
        $thn_akd = $sesi[0];
        $session_id = $sesi[1];

        $fungsi = new FungsiController;
        $sesi_nama = $fungsi->nama_sesi($thn_akd,$session_id);

        $q = "SELECT a.id,a.nomhs,a.judul_skripsi,a.bidang_penelitian,a.perusahaan,a.kota_perusahaan,a.status,b.nama FROM RefAkdPengajuanSkripsi a
                    left join RefAkdMhs b on a.nomhs=b.id_mhs and a.psmhs_id=b.id_ps
                    where thn_akd = '$thn_akd' and session_id = '$session_id' and psmhs_id = '$ps_id' 
                    order by nomhs desc";
        $pengajuan = $this->modelsManager->executeQuery($q)->toArray();

        $this->view->sesi = $_POST['sesi'];
        $this->view->sesi_nama = $sesi_nama;
        $this->view->pengajuan = $pengajuan;
        $this->view->pick('akd_skripsi/pengajuan_skripsi/pengajuan_mhs');
    }

    public function terimaSkripsiAction($id)
    {
        $query = RefAkdPengajuanSkripsi::findFirst($id);
        $query->assign(array(
            'status'    => "Y",
            'tgl_dikoreksi'    => date('Y-m-d')
        ));
        $query->save();

        $notif = array(
            'type'   => 'success',
            'text'  => 'Skripsi berhasil di Terima',
            'title'  => 'Success',
        );

        echo json_encode($notif);
    }

    public function tolakSkripsiAction($id)
    {
        $query = RefAkdPengajuanSkripsi::findFirst($id);
        $query->assign(array(
            'status'    => "N",
            'tgl_dikoreksi'    => date('Y-m-d')
        ));
        $query->save();

        $notif = array(
            'type'   => 'success',
            'text'  => 'Skripsi berhasil di Tolak',
            'title'  => 'Success',
        );

        echo json_encode($notif);
    }
}
