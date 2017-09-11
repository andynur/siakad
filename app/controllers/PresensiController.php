<?php

use Phalcon\Mvc\View;
use Phalcon\Validation;
use Phalcon\Validation\Validator\PresenceOf;
use Phalcon\Mvc\Url;
use Phalcon\Mvc\Model\Query\Builder;
use Phalcon\Http\Request\File;

class PresensiController extends \Phalcon\Mvc\Controller
{
    protected $messages;
    protected $title;
    protected $type;
    protected $text;

    public function initialize()
    {
        if (empty($this->session->get('uid'))) {
            $this->response->redirect('account/loginEnd');
        }
        
        $this->view->setRenderLevel(View::LEVEL_ACTION_VIEW);
    }
    
    public function indexAction($rombel_id)
    {
        // $data = $this->modelsManager->createBuilder()
        //         ->addFrom('RefRombelAnggota', 'a')
        //         ->join('RefRombonganBelajar', 'a.rombongan_belajar_id = r.rombongan_belajar_id', 'r')
        //         ->leftJoin('RefPresensi', 'a.rombongan_belajar_id = p.rombongan_belajar_id', 'p')
        //         ->join('RefTingkatPendidikan', 'r.tingkat_pendidikan_id = t.tingkat_pendidikan_id', 't')
        //         ->join('RefSemester', 'r.semester_id = s.semester_id', 's')
        //         ->join('RefKurikulum', 'r.kurikulum_id = k.kurikulum_id', 'k')        
        //         ->rightJoin('RefAkdMhs', 'a.peserta_didik_id = m.id_mhs', 'm')
        //         ->columns(['m.id_mhs AS murid_id', 'm.nama AS nama_murid', 'm.nis', 'm.nisn', 'm.foto', 'm.email', 'r.nama AS nama_rombel', 't.nama AS nama_tingkat', 's.semester_id', 'k.kurikulum_id', 'p.presensi_id', 'p.tanggal', 'p.waktu', 'p.tipe', 'p.presensi', 'p.status_email'])
        //         ->where('a.rombongan_belajar_id = ' . $rombel_id)
        //         ->orderBy('m.nama ASC')
        //         ->getQuery()
        //         ->execute();

        $anggota = RefRombelAnggota::find([
            "columns" => "peserta_didik_id",
            "conditions" => "rombongan_belajar_id = $rombel_id"
        ]);
        $arr_anggota = $anggota->toArray();
        
        $list_id = '';
        for ($i=0; $i < count($arr_anggota); $i++) { 
            $list_id .= $arr_anggota[$i][peserta_didik_id] . ', ';
        }
        $get_list_id = substr($list_id, 0, -2);

        $presensi = RefPresensi::find([
            "conditions" => "rombongan_belajar_id = $rombel_id AND peserta_didik_id IN ($get_list_id)"
        ]);
             
        foreach($presensi->toArray() as $p => $v){
            $hadir[$v->peserta_didik_id] = $v;
        }

        foreach($anggota as $key => $value){
            echo $hadir[$value->peserta_didik_id]->tanggal;        
        }        
                
        die();

        $semester = RefSemester::find(["columns" => "semester_id, nama"]);
        $kurikulum = RefKurikulum::find(["columns" => "kurikulum_id, nama_kurikulum"]);

        $this->view->setVars([
            "anggota" => $anggota,
            "hadir" => $hadir,
            "rombel_id" => $rombel_id,
            "semester" => $semester,
            "kurikulum" => $kurikulum
        ]);

        $this->view->pick('presensi/index');
    }
}

