<?php
use Phalcon\Mvc\View;
use Phalcon\Validation;
use Phalcon\Validation\Validator\PresenceOf;
use Phalcon\Mvc\Url;

class AkdisitimController extends \Phalcon\Mvc\Controller
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
    public function formCariAction()
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
        
        $this->view->pick('akd_skripsi/isi_tim/form_cari');
    }

    public function dataPeriodeSkripsiAction($value='')
    {
        $fungsi = new FungsiController();

        $get_session = $this->session->get('ps_id');
        $explode = explode('-', $get_session);
        $ps_id = $explode[1];

        $date = $_POST['tgl'].'-'.$_POST['bln'].'-'.$_POST['thn'];
        $periode = date("Y-m-d", strtotime($date));

        $cmd = "SELECT a.id,a.nomhs,a.ujian_ke,a.judul,a.tim,concat(c.gelar_dpn,' ',c.nama,c.gelar_blk) as dosen1
        ,concat(d.gelar_dpn,' ',d.nama,d.gelar_blk) as dosen2 ,b.nama from RefAkdPendadaranSkripsi a
        left join RefAkdMhs b on b.id_mhs=a.nomhs and b.id_ps=a.psmhs_id
        left join RefAkdSdm c on c.nip=a.pembimbing1
        left join RefAkdSdm d on d.nip=a.pembimbing2
        where a.psmhs_id like '$ps_id' and periode='$periode' order by a.pembimbing1 asc,a.ujian_ke asc,a.nomhs asc";
        $data_skripsi = $this->modelsManager->executeQuery($cmd)->toArray();

        $this->view->data_skripsi = $data_skripsi;
        $this->view->tim = $fungsi->timSkripsi();
        $this->view->pick('akd_skripsi/isi_tim/data_skripsi');

    }

    public function editTimAction($id)
    {
        $query = RefAkdPendadaranSkripsi::findFirst($id);
        $query->assign(array(
            'tim'    => $_POST['tim'],
        ));
        $query->save();

        $notif = array(
            'type'   => 'success',
            'text'  => 'Data berhasil di Ubah',
            'title'  => 'Success',
        );

        echo json_encode($notif);
    }

    
}
