<?php
use Phalcon\Mvc\View;
use Phalcon\Validation;
use Phalcon\Forms\Element\Text;
use Phalcon\Validation\Validator\Date;
use Phalcon\Validation\Validator\PresenceOf;
use Phalcon\Validation\Validator\Numericality;
class AkdkrsController extends FungsiController
{

    public function initialize()
    {
      if (empty($this->session->get('uid'))) {
          $this->response->redirect('account/loginEnd');
      }
      $this->view->setRenderLevel(View::LEVEL_ACTION_VIEW);
      date_default_timezone_set('Asia/Jakarta');
    }

    public function listMkAction($value='')
    {
    	$jenis_user = $this->session->get('id_jenis');
		if ($jenis_user == '1') {
			$this->select_form();
    	}else{
			$this->ListMkDitawarkanAction();
    	}
    }

    public function select_form($value='')
    {
    	$get_session = $this->session->get('ps_id');
		$explode = explode('-', $get_session);
		$ps_id = $explode[1];
    	$user_ps = $this->session->get('id_ps');

		$sql = "SELECT a.thn_akd,
               a.session_id,
               a.nama,
               c.nama_ol,
               b.ol_id
          from RefAkdSession a
          left join RefAkdCrossKrs b 
          	on a.ps_id=b.ps_id and a.thn_akd=b.thn_akd and a.session_id=b.session_id
          left join RefAkdSessionOl c 
          	on a.ps_id=c.ps_id and a.thn_akd=c.thn_akd and a.session_id=c.session_id
         where b.ps_id = '$ps_id'
         and b.ps_allow = '$user_ps'
         order by b.thn_akd desc, b.session_id desc
         limit 10";
		$query = $this->modelsManager->executeQuery($sql);
		$this->view->krs_ol = $query;
		$this->view->pick('akd_krs/select_form');
    }

    public function psmhs_id($nomhs)
    {
    	$sql2 = "SELECT id_ps from RefAkdMhs where id_mhs = '$nomhs'";
		$dt_mhs = $this->modelsManager->executeQuery($sql2);
    }

    public function db_array($sql)
    {
    	return $this->modelsManager->executeQuery($sql)->toArray();
    }

    public function ListMkDitawarkanAction($value='')
    {
    	$fungsi = new FungsiController;

    	$get_session = $this->session->get('ps_id');
		$explode = explode('-', $get_session);
		$ps_id = $explode[1];
		$psmhs_id = $explode[1];

		$nomhs = $_POST['nomhs'];
		$krs_ol = explode('-', $_POST['krs_ol']);
		$thn_akd = $krs_ol[0];
		$session_id = $krs_ol[1];
		$ol_id = $krs_ol[2];


		$sql2 = "SELECT angkatan,id_agama,nama,id_kur,ps_kur from RefAkdMhs where id_mhs = '$nomhs' and id_ps = '$ps_id'";
		$dt_mhs = $this->modelsManager->executeQuery($sql2)->toArray();
		if (count($dt_mhs) == 0) {
			$this->view->angka = "404";
			$this->view->pesan1 = "Oops! Data not found.";
			$this->view->pesan2 = "Nomhs Tidak Ditemukan, silahkan masukkan nomhs dengan benar!";
			$halaman = 'error/error';
		}else{

			$session = $this->db_array("SELECT * from RefAkdSession where ps_id = '$ps_id' and thn_akd = '$thn_akd' and session_id = '$session_id'");

			if ($session[0]['ips_check'] == 'Y') {
				$pthn_akd = $session[0]['pthn_akd'];
				$psession_id = $session[0]['psession_id'];
			}
			
			$rekap_smstr = $this->db_array("SELECT * from RefAkdRekapsemester where nomhs = '$nomhs' and ps_id = '$ps_id' and psmhs_id = '$psmhs_id' and thn_akd = '$pthn_akd' and session_id = '$psession_id'");

			$ipk = 0.00;
			$ips = 0.00;
			$sks_kum = 0;
			$sks_sem = 0;
			if (count($rekap_smstr) > 0) {
				$ipk = $rekap_smstr[0]['ipk'];
				$ips = $rekap_smstr[0]['ips'];
				$sks_kum = $rekap_smstr[0]['skskum'];
				$sks_sem = $rekap_smstr[0]['skssem'];
			}

			if ($session[0]['ips_check'] == 'Y' and $session[0]['ipk_check'] == 'Y') {
				if ($ipk > $ips) {
					$sys_pilihan_sks = $ipk;
				}else{
					$sys_pilihan_sks = $ips;
				}
			}elseif ($session[0]['ips_check'] == 'Y' ) {
				$sys_pilihan_sks = $ips;
			}elseif ($session[0]['ipk_check'] == 'Y') {
				$sys_pilihan_sks = $ipk;
			}

			$sks = $this->db_array("SELECT jatahsks from RefAkdDefRangeIp where ps_id = '$ps_id' and thn_akd = '$thn_akd' and session_id = '$session_id' and vstart <= $sys_pilihan_sks and vstop >= $sys_pilihan_sks ");

			//**************** SELECTING SKS jatah mahasiswa tergantung nilai = filter ke rangeIP *********************
			$this->view->sks = $sks;
			$this->view->nama_ps = $fungsi->nama_ps($ps_id);
			$this->view->dt_mhs = $dt_mhs[0];
			$this->view->dt_mhs = $dt_mhs[0];

			echo "<pre>".print_r($fungsi->nama_ps($ps_id),1)."</pre>";
			echo "<pre>".print_r($dt_mhs[0],1)."</pre>";die();
			$thn_kur = $dt_mhs[0]['id_kur'];
			//**************** SELECT Jatah MK SESI yang dipilih lalu masukkan ke mhs *********************
			$cmd = "SELECT a.pthn_akd,
	               a.psession_id,
	               a.pin_krs_wali,
	               a.max_sks_wali,
	               a.ips_check,
	               a.ipk_check,
	               a.spp_check,
	               a.kpinjaman,
	               b.mkmax,
	               b.mkbarumax,
	               b.mkulangmax,
	               b.sksmax,
	               b.sksbarumax,
	               b.sksulangmax,
	               b.nama_ol,
	               b.batalmk, 
	               b.jatahfix,
	               b.skspenalti,
	               b.mkpenalti
	          from RefAkdSessionOl b
	          left join RefAkdSession a on a.ps_id=b.ps_id and a.thn_akd=b.thn_akd and a.session_id=b.session_id
	         where b.thn_akd = '$thn_akd'
	               and b.session_id = '$session_id'
	               and b.ps_id = '$ps_id'
	               and b.ol_id = '$ol_id'";
			$dt_ol = $this->modelsManager->executeQuery($cmd)->toArray();
			echo "<pre>".print_r($dt_ol,1)."</pre>";die();
	               
			//**************** CEK JATAH MK MHS Jika KOSONG Di INPUT *********************
	        $cmd = "SELECT mkmax,mkbarumax,mkulangmax,sksmax,sksbarumax,sksulangmax,skspenalti,mkpenalti
			   from RefAkdMhsJatahMk where nomhs = '$nomhs' and psmhs_id = '$psmhs_id'
			   and ps_id = '$ps_id' and thn_akd = '$thn_akd' and session_id = '$session_id'";
			$jatah_mhs_sks = $this->modelsManager->executeQuery($cmd)->toArray();

			if (count($jatah_mhs_sks) == 0) {
				$input = new RefAkdMhsJatahMk();
	            $input->assign(array(
                    'nomhs' => $nomhs,
                    'psmhs_id' => $psmhs_id,
                    'ps_id' => $ps_id,
                    'thn_akd' => $thn_akd,
                    'session_id' => $session_id,
                    'ol_id' => $ol_id,
                    'mkmax' => $dt_ol[0]['mkmax'],
                    'mkbarumax' => $dt_ol[0]['mkbarumax'],
                    'mkulangmax' => $dt_ol[0]['mkulangmax'],
                    'sksmax' => $dt_ol[0]['sksmax'],
                    'sksbarumax' => $dt_ol[0]['sksbarumax'],
                    'sksulangmax' => $dt_ol[0]['sksulangmax'],
                    'skspenalti' => $dt_ol[0]['skspenalti'],
                    'mkpenalti' => $dt_ol[0]['mkpenalti']
                    )
                );
	            $input->save();
			}
			//**************** SELECT MK YANG DIAMBIL SESI INI *********************
			$cmd = "SELECT mkmax,mkbarumax,mkulangmax,sksmax,sksbarumax,sksulangmax,skspenalti,mkpenalti
			   from RefAkdMhsJatahMk where nomhs = '$nomhs' and psmhs_id = '$psmhs_id'
			   and ps_id = '$ps_id' and thn_akd = '$thn_akd' and session_id = '$session_id'";
			$jatah_mhs_sks = $this->modelsManager->executeQuery($cmd)->toArray();

			//************ SELECT SEKALIGUS SEMUA YANG DIPERLUKAN *******************
			
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

			/* $krsx
		       KRS per matakuliah
		    */
			$helper = new Helpers();
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
			
			$cmd = "SELECT a.ps_id,
                  a.thn_kur,
                  a.kode_mk,
                  b.nama,
                  b.nama_en,
                  a.nama_kelas,
                  b.semester,
                  b.sks,
                  b.jenis,
                  b.kelompok,
                  a.nilai,
                  a.nilai_num,
                  a.thn_akd,
                  a.session_id,
                  a.st_ambil,
                  b.urut
             from RefAkdKrs a
             left join RefAkdMku b
             on b.kode_mk = a.kode_mk
            and b.thn_kur = a.thn_kur
            and b.ps_id = a.ps_id
             where a.nomhs = '$nomhs'
               and a.psmhs_id = '$psmhs_id'
               and a.st_ambil != 'W'
             order by a.thn_akd,a.session_id,b.nama";

			$krs = $this->modelsManager->executeQuery($cmd)->toArray();


			$cmd = "SELECT jadkul_id,thn_akd,session_id,nama_kelas,ps_id,kode_mk,nama,thn_kur,semester,sks from ViewListMkKrs d
			        where thn_akd = '$thn_akd' 
			          and session_id = '$session_id'
			          and nama_kelas is not null
			          and ps_id = '$ps_id'
			          and ps_allow = '$psmhs_id' group by kode_mk";
			$list_mk_krs_diajukan = $this->modelsManager->executeQuery($cmd)->toArray();


			// prasyarat MK
			$cmd = "SELECT thn_kur,kode_mk, prasyarat from RefAkdMku where ps_id='$psmhs_id' and thn_kur='$thn_kur' and prasyarat!=''";
			$srt = $this->modelsManager->executeQuery($cmd)->toArray();
			foreach ($srt as $key => $value) {
				$psrt[$value['kode_mk']] = $value['prasyarat'];
			}

			// foreach ($list_mk_krs_diajukan as $key => $value) {
			// 	$ok=1;
			// 	foreach ($variable as $key => $value) {
					
			// 	}
			// }


	        $c0=explode(">=",strtoupper(trim($psrt['AH217'])));
	        foreach ($c0 as $k10 => $n10) {
	          if ($k10>0) { $d0[]=">="; }
	          
		        $c1=explode(">",$n10);
		        foreach ($c1 as $k11 => $n11) {
		          if ($k11>0) { $d0[]=">"; }

			        $c2=explode(" AND ",$n11);
			        foreach ($c2 as $k2 => $n2) {
			          if ($k2>0) { $d0[]=" AND "; }

				        $c3=explode(" OR ",$n2);
				        foreach ($c3 as $k3 => $n3) {
				          if ($k3>0) { $d0[]=" OR "; }

					        $c4=explode("(",$n3);
					        foreach ($c4 as $k4 => $n4) {
					          if ($k4>0) { $d0[]="("; }

						        $c5=explode(")",$n4);
						        foreach ($c5 as $k5 => $n5) {
						          if ($k5>0) { $d0[]=")"; }
						          if ("$n5"!="") {
						            $d0[]=$n5;
						          }
						        }
					        }
				        }
			        }
		        }
	        }

// 	    foreach ($d0 as $k10 => $n10) {
//           if ("$n10"!=">=" and "$n10"!=">"
//             and "$n10"!=" AND " and "$n10"!=" OR "
//             and "$n10"!="(" and "$n10"!=")") {
//             if ("$n10"=="#IPK") { $d0[$k10]=3.00; } else {
//               if ("$n10"=="#SKS") { $d0[$k10]=20; } else {
//                 list(,,,$v8)=explode("|",$anilai[$n10]);
                
//                 if ("$v8"!="") { $d0[$k10]=$v8; } else {
//                   $v8=$anil[$n10];
//                   if ("$v8"!="") { $d0[$k10]=$v8; } else {
// //                    if ($n10>0) { $d0[$k10]=$n10; } else {
//                       $d0[$k10]=0;
// //                    }
//                   }
//                 }
//               }
//             }
//           }
//         }
        // echo "<pre>".print_r($fungsi->nilai_mhs($nomhs,$psmhs_id),1)."</pre>";die();
			        // echo "<pre>".print_r($d0,1)."</pre>";die();


			$cmd = "SELECT * from ViewListMkKrs d
			        where thn_akd = '$thn_akd' 
			          and session_id = '$session_id'
			          and nama_kelas is not null
			          and ps_id = '$ps_id'
			          and ps_allow = '$psmhs_id'";

			$jadwal_mk_krs_diajukan = $this->modelsManager->executeQuery($cmd)->toArray();
			// echo "<pre>".print_r($jadwal_mk_krs_diajukan,1)."</pre>";die();


			foreach ($jadwal_mk_krs_diajukan as $k => $v) {
				$mk_id = $v['kode_mk'];

				$jad_mk[$mk_id][] = $v;
				if (array_key_exists($mk_id,$krsx)) {
					$r = $jad_mk[$mk_id];
					array_filter($r);
					array_push($r, $v);
				}
			}
			// echo "<pre>".print_r($jad_mk,1)."</pre>";die();

			$cmd = "SELECT b.jadkul_id,a.kode_mk,
		               a.thn_kur,
		               a.thn_akd,
		               a.session_id,
		               b.nama,
                       b.semester,
                       b.sks,
                       a.nama_kelas,
                       b.jam_awal,
                       b.jam_akhir
		          from RefAkdKrsol a join ViewListMkKrs b
			on a.thn_akd=b.thn_akd and a.session_id=b.session_id and a.nama_kelas=b.nama_kelas and a.ps_id=b.ps_id and a.kode_mk=b.kode_mk and a.thn_kur=b.thn_kur
		         where a.nomhs = '$nomhs'
		           and a.psmhs_id = '$psmhs_id'
		           and a.st_ambil != 'w'
		           and a.thn_akd = '$thn_akd'
		           and a.session_id = '$session_id'";

			$krs_mhs = $this->modelsManager->executeQuery($cmd)->toArray();
			// echo "<pre>".print_r($cmd,1)."</pre>";die();
			foreach ($krs_mhs as $key => $value) {
				$pilih[$value['kode_mk']] = $value;
				$pilih_jadwal[$value['jadkul_id']] = $value;
			}
			// echo "<pre>".print_r($pilih,1)."</pre>";die();


			$this->view->krsx = $krsx;
			$this->view->mhs = $dt_mhs;
			$this->view->krs_mhs = $pilih;
			$this->view->pilih_jadwal = $pilih_jadwal;
			$this->view->jad_mk = $jad_mk;
			$this->view->list_mk_krs_diajukan = $list_mk_krs_diajukan;
			$this->view->jadwal_mk_krs_diajukan = $jadwal_mk_krs_diajukan;
			$halaman = 'akd_krs/list_mk_ditawarkan';
			
		}
		$this->view->pick($halaman);
    }

}

