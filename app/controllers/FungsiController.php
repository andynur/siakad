<?php

class FungsiController extends \Phalcon\Mvc\Controller
{
	public function bulan()
	{
		$bulan = array(
            '1' => 'Januari',
            '2' => 'Februari',
            '3' => 'Maret',
            '4' => 'April',
            '5' => 'Mei',
            '6' => 'Juni',
            '7' => 'Juli',
            '8' => 'Agustus',
            '9' => 'September',
            '10' => 'Oktober',
            '11' => 'November',
            '12' => 'Desember',
        );
        return $bulan;
	}

	public function timSkripsi()
	{
		$tim = array(
            '1' => 'A',
            '2' => 'B',
            '3' => 'C',
            '4' => 'D',
            '5' => 'E',
            '6' => 'F',
            '7' => 'G',
            '8' => 'H',
            '9' => 'I',
            '10' => 'J',
            '11' => 'K',
            '12' => 'L',
        );
        return $tim;
	}

    public function conf_nilai($value='')
    {
    	$cmd = "SELECT nilai,nilai_angka from RefSysNilai";
		$conf_nilai = $this->modelsManager->executeQuery($cmd)->toArray();
		foreach ($conf_nilai as $key => $value) {
			$n[$value['nilai']] = $value['nilai_angka'];
		}
		return $n;
    }

    public function nilai_mhs($nomhs,$psmhs_id)
    {
    	$cmd = "SELECT a.kode_mk,a.nilai FROM RefAkdKrs a where a.nomhs='$nomhs' and a.psmhs_id='$psmhs_id'";
    	$nilai = $this->modelsManager->executeQuery($cmd)->toArray();
    	foreach ($nilai as $k => $v) {
    		$n[$v['kode_mk']] = $v['nilai'];
    	}
    	return $n;
    }

    public function daftar_cekal($ps_id,$thn_akd,$session_id)
    {
    	$cmd = "SELECT * from RefAkdDaftarCekal where ps_id = '$ps_id' and thn_akd = '$thn_akd' and session_id = '$session_id' ";
    	$data = $this->modelsManager->executeQuery($cmd)->toArray();
    	$n = [];
    	foreach ($data as $k => $v) {
    		$n[] = $v['nomhs'];
    	}
    	return $n;
    }

    public function nama_ps($id)
    {
    	$cmd = "SELECT nama FROM RefAkdPs a where a.id_ps='$id'";
    	$nama = $this->modelsManager->executeQuery($cmd)->toArray();
    	return $nama[0]['nama'];
    }

    public function nama_sesi($thn_akd,$session_id)
    {
    	$helper = new Helpers();
    	$cmd = "SELECT nama FROM RefAkdSession a where a.thn_akd='$thn_akd' and a.session_id='$session_id'";
    	$nama = $this->modelsManager->executeQuery($cmd)->toArray();
    	return $nama[0]['nama'].' '.$helper->format_thn_akd($thn_akd);
    }

    public function krs_data2($nomhs)
    {
    	//************ SELECT SEKALIGUS SEMUA YANG DIPERLUKAN *******************
    	//************ [1#2017#AH217] => Array *******************
			
		$cmd = "SELECT a.id,a.thn_akd,
					a.session_id,
					a.nama_kelas,
					a.ps_id,
					a.kode_mk,
					a.thn_kur,
					a.nilai,
					b.nilai_angka
				from RefAkdKrs a join RefSysNilai b on a.nilai=b.nilai where nomhs = '$nomhs' order by b.nilai_angka desc";
		$krs_data = $this->modelsManager->executeQuery($cmd)->toArray();
		return $krs_data;
    }

    public function nilai_tertinggi_krs($nomhs)
    {

		$krs_data = $this->krs_data2($nomhs);

		/* $krsx
	       KRS per matakuliah
	    */
		
		foreach ($krs_data as $k => $v) {
			$mk_id = $v['ps_id'].'#'.$v['thn_kur'].'#'.$v['kode_mk'];
			$array = array(
				'id' =>  $v['id'],
				'kode_mk' =>  $v['kode_mk'],
				'nilai' =>  $v['nilai'],
				'nilai_angka' =>  $v['nilai_angka']
			);

			$krsx[$mk_id][] = $array;

			if (array_key_exists($mk_id,$krsx)) {
				$r = $krsx[$mk_id];
				array_filter($r);
				array_push($r, $array);
			}
		}

		$krs_nilai_tinggi = $krsx;
		foreach ($krs_nilai_tinggi as $mk_krs => $wer) {
			for ($i=1; $i <= count($wer)-1; $i++) { 
				unset($krs_nilai_tinggi[$mk_krs][$i]);
			}
		}

		return $krs_nilai_tinggi; 
    }

    public function nilai_tertinggi_krs_mk($nomhs)
    {
    	$krs_data = $this->krs_data2($nomhs);
		
		foreach ($krs_data as $k => $v) {
			$array = array(
				'id' =>  $v['id'],
				'kode_mk' =>  $v['kode_mk'],
				'nilai' =>  $v['nilai'],
				'nilai_angka' =>  $v['nilai_angka']
			);

			$krs_nilai[$v['kode_mk']][] = $array;

			if (array_key_exists($v['kode_mk'],$krs_nilai)) {
				$s = $krs_nilai[$v['kode_mk']];
				array_filter($s);
				array_push($s, $array);
			}
		}

		//************ NILAI TERTINGGI PER MK *******************
		$nli = $krs_nilai;
		foreach ($nli as $mk_krs => $wer) {
			for ($i=1; $i <= count($wer)-1; $i++) { 
				unset($nli[$mk_krs][$i]);
			}
		}
		foreach ($nli as $mk => $v) {
			foreach ($v as $key => $value) {
				$ff[$mk] = $value;
			}
		}

		return $ff;
    }

}

