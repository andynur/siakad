<?php

use Phalcon\Mvc\View;
use Phalcon\Validation;
use  Phalcon\Validation\Validator\PresenceOf;
use Phalcon\Mvc\Url;

class AkdpostingnilaiController extends \Phalcon\Mvc\Controller
{

    public function initialize()
    {
        if (empty($this->session->get('uid'))) {
            $this->response->redirect('account/loginEnd');
        }
    	$this->view->setRenderLevel(View::LEVEL_ACTION_VIEW);
    }

    public function selectMhsAction($value='')
    {
        $get_session = $this->session->get('ps_id');
        $explode = explode('-', $get_session);
        $ps_id = $explode[1];

        $cmd = "SELECT distinct angkatan from RefAkdMhs where id_ps in ($ps_id) order by angkatan desc";
        $angkatan = $this->modelsManager->executeQuery($cmd);

        $this->view->angkatan = $angkatan;
        $this->view->pick('akd_transkrip/posting_nilai/select_mhs');
    }

    public function cariMhsAction($value='')
    {
        $get_session = $this->session->get('ps_id');
        $explode = explode('-', $get_session);
        $ps_id = $explode[1];

        $nomhs = $_POST['nomhs'];
        $range1 = $_POST['range1'];
        $range2 = $_POST['range2'];
        $angkatan = $_POST['angkatan'];
        $mhs=[];

        if($range1 != '' && $range2 != '') {
            $angkatan_isset = ($angkatan != '') ? "and angkatan = '$angkatan'" : "";
            $cmd = "select id_mhs,id_ps,angkatan,nama,id_kur from RefAkdMhs
                      where id_mhs >= '$range1'
                        and id_mhs <= '$range2'
                        and id_ps = '$ps_id'
                        and id_status = 'A'
                        $angkatan_isset
                      order by id_mhs";
            $mhs = $this->modelsManager->executeQuery($cmd);
          
       } elseif ($nomhs != '') {
                $angkatan_isset = ($angkatan != '') ? "and angkatan = '$angkatan'" : "";
                $nomhs_array = explode("-",$nomhs);
                $qarray = implode("','",$nomhs_array);
                $cmd = "select id_mhs,id_ps,angkatan,nama,id_kur from RefAkdMhs
                   where id_mhs in ('$qarray')
                     and id_status = 'A'
                     $angkatan_isset
                     and id_ps = '$ps_id'";
                $mhs = $this->modelsManager->executeQuery($cmd);

       } elseif ($angkatan != '') {
            $cmd = "select id_mhs,id_ps,angkatan,nama,id_kur from RefAkdMhs
                      where angkatan = '$angkatan'
                        and id_ps = '$ps_id'
                        and id_status = 'A'
                      order by id_mhs";
            $mhs = $this->modelsManager->executeQuery($cmd);

       }

       $this->view->mhs = $mhs;
       $this->view->pick('akd_transkrip/posting_nilai/mahasiswa');
    }

    public function postingNilaiAction($value='')
    {
        $libtran = new FungsilibtranController;

        $get_session = $this->session->get('ps_id');
        $explode = explode('-', $get_session);
        $ps_id = $explode[1];

        $psmhs_id = $_POST['psmhs_id'];
        $nomhs = $_POST['nomhs'];
        $angkatan = $_POST['angkatan'];
        $nama = $_POST['nama'];
        $kur_mhs = $_POST['kur_mhs'];

        $cmd = "SELECT id,ps_id,
                  thn_akd,
                  session_id,
                  kode_mk,
                  thn_kur,
                  nama_kelas,
                  ambil_ke,
                  nama_mk,
                  nama_en,
                  jenis,
                  kelp,
                  sem,
                  sks,
                  nilai_huruf,
                  nilai_angka,
                  nilai_mutu,
                  ket_nilai,
                  st_hitung,
                  st_disp,
                  urut,
                  del,
                  mk_count
             from RefAkdTransdata
            where nomhs = '$nomhs'
              and psmhs_id = '$psmhs_id'
            order by urut";
        $transdata_array = $this->modelsManager->executeQuery($cmd)->toArray();

        $transdata = array();
        $ttl_sks=0;
        $ttl_nilai=0;
        foreach ($transdata_array as $key => $value) {
            $transdata[$value['kode_mk']] = $value;
            $ttl_sks += $value['sks'];
            $ttl_nilai += $value['sks']*$value['nilai_mutu'];
        }

        $kur_mhs_mk = $libtran->mkMhs($psmhs_id,$nomhs,$kur_mhs);// list semua mk yang thn kurikulum sama dengan mhs
        $data_mhs_mk_kur = array(); // kode_mk dijadikan key
        foreach ($kur_mhs_mk as $key => $value) {
            $data_mhs_mk_kur[$value['kode_mk']] = $value;
        }

        $mk_yg_blm_diambil=array();
        foreach ($data_mhs_mk_kur as $key => $value) {
            if (!array_key_exists($key,$transdata)) {
                $mk_yg_blm_diambil[] = $value;
            }
        }

        $ipk = $ttl_nilai/$ttl_sks; // IP KUMULATIF

        $this->view->psmhs_id = $psmhs_id;
        $this->view->nomhs = $nomhs;
        $this->view->angkatan = $angkatan;
        $this->view->nama = $nama;
        $this->view->kur_mhs = $kur_mhs;
        $this->view->ttl_sks = $ttl_sks;
        $this->view->mk_yg_blm_diambil = $mk_yg_blm_diambil;
        $this->view->ipk = number_format((float)$ipk, 2, '.', '');

        $this->view->transdata_array = $transdata_array;
        $this->view->pick('akd_transkrip/posting_nilai/posting_nilai');
    }

    public function formEditAction($value='')
    {
        $get_session = $this->session->get('ps_id');
        $explode = explode('-', $get_session);
        $ps_id = $explode[1];

        $psmhs_id = $_POST['psmhs_id'];
        $nomhs = $_POST['nomhs'];
        $nama = $_POST['nama'];
        $angkatan = $_POST['angkatan'];
        $kode_mk = $_POST['kode_mk'];
        $thn_kur = $_POST['thn_kur'];
        $id = $_POST['id'];

        $cmd = "SELECT * from RefAkdTransdata where id = '$id' ";
        $data = $this->modelsManager->executeQuery($cmd);

           $cmd = "SELECT a.thn_kurv,
               a.kode_mkv,
               c.nama,
               c.semester,
               c.sks,
               c.jenis,
               c.kelompok,
               a.nilai_hrfv,
               a.thn_akdv,
               a.session_idv,
               a.ps_idv,
               a.st_aktif,
               a.ambilkev
               from RefAkdTranseq a
               left join RefAkdMku c on c.ps_id = a.ps_idv
               and c.thn_kur = a.thn_kurv
               and c.kode_mk = a.kode_mkv
               where a.nomhs = '$nomhs' and a.psmhs_id = '$psmhs_id'
               and a.ps_id = '$ps_id' and a.thn_kur = '$thn_kur'
               and a.kode_mk = '$kode_mk'";
               // echo "<pre>".print_r($cmd,1)."</pre>";die();
        $data_transeq = $this->modelsManager->executeQuery($cmd)->toArray();

        $this->view->psmhs_id = $psmhs_id;
        $this->view->nomhs = $nomhs;
        $this->view->angkatan = $angkatan;
        $this->view->nama = $nama;
        $this->view->kur_mhs = $thn_kur;
        
        $this->view->data = $data;
        $this->view->data_transeq = $data_transeq;
        $this->view->pick('akd_transkrip/posting_nilai/form_edit_transdata');
    }

    public function submitEditAction($id)
    {

        $validation = new Phalcon\Validation(); 
        $validation->add('nama', new PresenceOf(array(
            'message' => 'Nama id tidak boleh kosong'
        )));
        $validation->add('sks', new PresenceOf(array(
            'message' => 'sks tidak boleh kosong'
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
            $RefAkdTransdata = RefAkdTransdata::findFirstById($id);
            $RefAkdTransdata->assign(array(
                        'nama_mk'       => $_POST['nama'],
                        'nama_en'       => $_POST['nama_en'],
                        'sem'      => $_POST['semester'],
                        'sks'           => $_POST['sks'],
                        'kelp'      => $_POST['kelompok'],
                        'jenis'         => $_POST['jenis'],
                        'urut'          => $_POST['urut'],
                        'ket_nilai'     => $_POST['ket_nilai'],
                        'ket_nilai_en'  => $_POST['ket_nilai_en'],
                        'nsem'   => $_POST['semester_en'],
                        'st_disp'       => $_POST['st_disp']
                        )
                    );

            $RefAkdTransdata->save();
            $notif = array(
                'title' => 'success',
                'text' => 'Data berhasil di input',
                'type' => 'success',
            );
        }

        echo json_encode($notif);
    }



/////////////////////////////////////////////////////////////////////////////////////
/////////////////////// PENGAMBILAN BERDASARKAN NILAI_MUTU ///////////////////////////
/////////////////////////////////////////////////////////////////////////////////////
    public function db_array($sql)
    {
        return $this->modelsManager->executeQuery($sql)->toArray();
    }

    public function rebuildTranskripAction($value='')
    {
        $libtran = new FungsilibtranController;
        
        $psmhs_id = $_POST['psmhs_id'];
        $nomhs = $_POST['nomhs'];
        $kur_mhs = $_POST['kur_mhs'];

        $krs_nilai_tinggi = $libtran->nilaiTinggi($psmhs_id,$nomhs);

        $kur_mhs_mk = $libtran->mkMhs($psmhs_id,$nomhs,$kur_mhs);// list semua mk yang thn kurikulum sama dengan mhs

        // kode_mk dijadikan key
        foreach ($kur_mhs_mk as $key => $value) {
            $data_mhs_mk_kur[$value['kode_mk']] = $value;
        }

        $mapmku = $this->db_array("SELECT * from RefAkdMapmku");
        foreach ($mapmku as $k => $v) {
            $bbb = $v['ps_idA'].'#'.$v['ps_idB'].'#'.$v['kurA'].'#'.$v['kurB'];
            $array = array(
                'mkA0' =>  $v['mkA0'],
                'mkA1' =>  $v['mkA1'],
                'mkA2' =>  $v['mkA2'],
                'mkB0' =>  $v['mkB0'],
                'mkB1' =>  $v['mkB1'],
                'mkB2' =>  $v['mkB2'],
            );

            $data_mapping[$bbb][] = $array;

            if (array_key_exists($bbb,$data_mapping)) {
                $m = $data_mapping[$bbb];
                array_filter($m);
                array_push($m, $array);
            }
        }

        foreach ($krs_nilai_tinggi as $key => $value) {
            $thn_kur_mk = explode('#', $key);
            if ($thn_kur_mk[0].'#'.$thn_kur_mk[1] != $psmhs_id.'#'.$kur_mhs) {                 
                $kodemk = $thn_kur_mk[2];
                $kur_nilainya = $thn_kur_mk[1];
                $ps_nilainya = $thn_kur_mk[0];

                $kk = $ps_nilainya.'#'.$psmhs_id.'#'.$kur_nilainya.'#'.$kur_mhs;
                // echo "<pre>".print_r($vcx[$kk],1)."</pre>";
                foreach ($data_mapping[$kk] as $a => $b) {
                    if ($b['mkA0'] == $kodemk || $b['mkA1'] == $kodemk || $b['mkA2'] == $kodemk ) {
                        $n_mk[] = $b['mkB0'];
                        $n_mk[] = $b['mkB1'];
                        $n_mk[] = $b['mkB2'];
                    }
                }

                $edr = array_filter($n_mk);
                $count_mkmap = count($edr);

                $value[0]['kode_mk'] = $edr[0];
                $map = $value;
                $key_mk = $edr[0];

                $val2 = $value;
                $val3 = $value;

                if ($count_mkmap == 2) {
                    $val2[0]['kode_mk'] = $edr[1];
                    $map2 = $val2;
                    $key_mk2 = $edr[1];
                }elseif($count_mkmap == 3){

                    $val2[0]['kode_mk'] = $edr[1];
                    $val3[0]['kode_mk'] = $edr[2];

                    $map2 = $val2;
                    $map3 = $val3;

                    $key_mk2 = $edr[1];
                    $key_mk3 = $edr[2];             
                }
            }else{
                $map = $value;
                $map2 = $value;
                $map3 = $value;
                $key_mk = $thn_kur_mk[2];
                $key_mk2 = $thn_kur_mk[2];
                $key_mk3 = $thn_kur_mk[2];
            }
            $conv_nilai[$key_mk.'#'.$map[0]['thn_kur']] = $map;
            $conv_nilai[$key_mk2.'#'.$map2[0]['thn_kur']] = $map2;
            $conv_nilai[$key_mk3.'#'.$map3[0]['thn_kur']] = $map3;

        }

        foreach ($conv_nilai as $mk => $v) {
            foreach ($v as $key => $value) {
              $map_nilai_mk[$mk] = $value;
            }
        }

        $transdata = [];
        foreach ($map_nilai_mk as $key => $value) {
            $transdata[$value['kode_mk']] = $value;
        }

        foreach ($map_nilai_mk as $key => $value) {
           if (array_key_exists($value['kode_mk'],$transdata)) {
               if ($transdata[$value['kode_mk']]['nilai_mutu'] <=  $value['nilai_mutu']) {
                   $transdata[$value['kode_mk']] = $value;
               }
           }
        }
        

        //Delete All
        
       $cmd = "DELETE from RefAkdTranseq where nomhs = '$nomhs' and psmhs_id = '$psmhs_id'";
       $del_RefAkdTranseq = $this->modelsManager->executeQuery($cmd);

       $cmd = "DELETE from RefAkdTransdata where nomhs = '$nomhs' and psmhs_id = '$psmhs_id'";
       $del_RefAkdTransdata = $this->modelsManager->executeQuery($cmd);

        $urut=1;
        foreach ($transdata as $key => $value) {

            $RefAkdTranseq = new RefAkdTranseq();
            $RefAkdTranseq->assign(array(
                        'nomhs' => $nomhs,
                        'psmhs_id' => $psmhs_id,
                        'ps_id' => $data_mhs_mk_kur[$key]['ps_id'],
                        'thn_kur' => $data_mhs_mk_kur[$key]['thn_kur'],
                        'kode_mk' => $data_mhs_mk_kur[$key]['kode_mk'],
                        'ps_idv' => $value['ps_id'],
                        'thn_akdv' => $value['thn_akd'],
                        'session_idv' => $value['session_id'],
                        'thn_kurv' => $value['thn_kur'],
                        'kode_mkv' => $value['kode_mk_asli'],
                        'ambilkev' => $value['krs_ke'],
                        'nilai_hrfv' => $value['nilai'],
                        'nilai_ankv' => $value['nilai_num']
                        )
                    );

            $RefAkdTranseq->save();

            $RefAkdTransdata = new RefAkdTransdata();
            $RefAkdTransdata->assign(array(
                        'nomhs' => $nomhs,
                        'psmhs_id' => $psmhs_id,
                        'ps_id' => $data_mhs_mk_kur[$key]['ps_id'],
                        'thn_akd' => $value['thn_akd'],
                        'session_id' => $value['session_id'],
                        'kode_mk' => $data_mhs_mk_kur[$key]['kode_mk'],
                        'thn_kur' => $data_mhs_mk_kur[$key]['thn_kur'],
                        'nama_kelas' => $value['nama_kelas'],
                        'ambil_ke' => $value['krs_ke'],
                        'nama_mk' => $data_mhs_mk_kur[$key]['nama'],
                        'nama_en' => $data_mhs_mk_kur[$key]['nama_en'],
                        'jenis' => $data_mhs_mk_kur[$key]['jenis'],
                        'kelp' => $data_mhs_mk_kur[$key]['kelompok'],
                        'sem' => $data_mhs_mk_kur[$key]['semester'],
                        'sks' => $data_mhs_mk_kur[$key]['sks'],
                        'nilai_huruf' => $value['nilai'],
                        'nilai_angka' => $value['nilai_num'],
                        'nilai_mutu' => $value['nilai_mutu'],
                        'ket_nilai' => '',
                        'st_hitung' => 'Y',
                        'st_disp' => 'nilai',
                        'urut' => $urut,
                        'del' => 'N',
                        'mk_count' => $value['krs_ke'],
                        'dpst_st' => 'N'
                        )
                    );

            $RefAkdTransdata->save();
        $urut++;
        }

        $notif = array(
            'title' => 'success',
            'text' => 'MK berhasil batal di Posting..!',
            'type' => 'success'
        );
        echo json_encode($notif);
    }

    public function dropZeroAction($value='')
    {
        $psmhs_id = $_POST['psmhs_id'];
        $nomhs = $_POST['nomhs'];

        $cmd = "UPDATE RefAkdTransdata set del = 'Y' where nomhs = '$nomhs' and psmhs_id = '$psmhs_id' and nilai_angka = 0";
        $dropZero = $this->modelsManager->executeQuery($cmd);

        $notif = array(
            'title' => 'success',
            'text' => 'dropZero berhasil..!',
            'type' => 'success'
        );
        echo json_encode($notif);
    }

    public function nonAktifAction($value='')
    {
        $id = $_POST['id'];
        $cmd = "UPDATE RefAkdTransdata set del = 'Y' where id = '$id' ";
        $this->modelsManager->executeQuery($cmd);
        $notif = array(
            'title' => 'success',
            'text' => 'Non Aktifkan berhasil..!',
            'type' => 'success'
        );
        echo json_encode($notif);
    }

    public function aktifkanAction($value='')
    {
        $id = $_POST['id'];
        $cmd = "UPDATE RefAkdTransdata set del = 'N' where id = '$id' ";
        $this->modelsManager->executeQuery($cmd);
        $notif = array(
            'title' => 'success',
            'text' => 'Aktifkan berhasil..!',
            'type' => 'success'
        );
        echo json_encode($notif);
    }

    

}

