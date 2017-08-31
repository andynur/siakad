<?php

class FungsilibtranController extends \Phalcon\Mvc\Controller
{

  public function db_array($sql)
  {
      return $this->modelsManager->executeQuery($sql)->toArray();
  }

  public function mkMhs($psmhs_id,$nomhs,$mhs_thn_kur)
  {
    $cmd = "SELECT a.ps_id,a.kode_mk,a.thn_kur,a.nama,a.nama_en,a.semester,a.sks,a.kelompok,a.jenis,a.prasyarat,a.sks_teori,a.sks_praktek,a.sks_klinik 
            from RefAkdMku a
           left join RefAkdMhs b on b.id_mhs = '$nomhs' and b.id_ps = '$psmhs_id'
           where a.ps_id = '$psmhs_id' and a.thn_kur = '$mhs_thn_kur'
           order by semester,kode_mk";
    $kur_mhs_mk = $this->modelsManager->executeQuery($cmd)->toArray();
    return $kur_mhs_mk;
  }

  function nilaiTinggi($psmhs_id,$nomhs)
  {

    //************ SELECT SEKALIGUS SEMUA YANG DIPERLUKAN *******************
    $cmd = "SELECT a.ps_id,
              a.thn_kur,
              a.kode_mk,
              b.nama,
              b.nama_en,
              a.nama_kelas,
              b.semester,
              b.sks,
              b.sks_teori,
              b.sks_praktek,
              b.jenis,
              b.kelompok,
              a.nilai,
              a.nilai_num,
              a.nilai_mutu,
              a.thn_akd,
              a.session_id,
              a.st_ambil,
              b.urut,
              a.krs_ke
         from RefAkdKrs a
         left join RefAkdMku b
         on b.kode_mk = a.kode_mk
        and b.thn_kur = a.thn_kur
        and b.ps_id = a.ps_id
         where a.nomhs = '$nomhs'
           and a.psmhs_id = '$psmhs_id'
           and a.st_ambil != 'w'
         order by a.nilai_mutu DESC,a.thn_akd,a.session_id,b.nama";

    $krs_data = $this->modelsManager->executeQuery($cmd)->toArray();

    /* $krsx KRS per matakuliah */          
    foreach ($krs_data as $k => $v) {
        $mk_id = $v['ps_id'].'#'.$v['thn_kur'].'#'.$v['kode_mk'];
        $array = array(
              'ps_id'     => $v['ps_id'],
              'thn_kur'   => $v['thn_kur'],
              'kode_mk_asli'   => $v['kode_mk'],
              'kode_mk'   => $v['kode_mk'],
              'nama'  => $v['nama'],
              'nama_en'   => $v['nama_en'],
              'nama_kelas'    => $v['nama_kelas'],
              'semester'  => $v['semester'],
              'sks'   => $v['sks'],
              'sks_teori'     => $v['sks_teori'],
              'sks_praktek'   => $v['sks_praktek'],
              'jenis'     => $v['jenis'],
              'kelompok'  => $v['kelompok'],
              'nilai'     => $v['nilai'],
              'nilai_num'     => $v['nilai_num'],
              'nilai_mutu'    => $v['nilai_mutu'],
              'thn_akd'   => $v['thn_akd'],
              'session_id'    => $v['session_id'],
              'st_ambil'  => $v['st_ambil'],
              'urut'  => $v['urut'],
              'krs_ke'  => $v['krs_ke']


        );

        $krsx[$mk_id][] = $array;

        if (array_key_exists($mk_id,$krsx)) {
            $r = $krsx[$mk_id];
            array_filter($r);
            array_push($r, $array);
        }
    }

    /* GET nilai tertinggi KRS per Matakuliah */
    $krs_nilai_tinggi = $krsx;
    foreach ($krs_nilai_tinggi as $mk_krs => $wer) {
        $mm = count($wer)-1;
        for ($i=1; $i <= $mm; $i++) { 
            unset($krs_nilai_tinggi[$mk_krs][$i]);
        }
    }
    return $krs_nilai_tinggi;
  }


}

