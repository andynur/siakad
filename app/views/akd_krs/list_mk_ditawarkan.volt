<section class="content-header">
  <h1>
    <button type="button" onclick="back()" class="btn bg-navy btn-flat margin"><i class="fa fa-fw fa-arrow-left"></i> Back</button>
  </h1>
  <ol class="breadcrumb">
    <li><a href="#"><i class="fa fa-dashboard"></i> KRS</a></li>
    <li class="active">Mahasiswa</li>
  </ol>
</section>

<!-- Main content -->
<section class="content">
  <div class="row">
<?php 
error_reporting(E_ERROR | E_PARSE);
// echo "<pre>".print_r($pilih_jadwal,1)."</pre>"; 
// echo "<pre>".print_r($jad_mk,1)."</pre>"; 
?>
    <div class="row">
      <div class="col-md-3"></div>
      <div class="col-md-6">
        <h5 class="text-center"><span class="text-green"><?= $dt_mhs['id_mhs']?></span> <?= $dt_mhs['nama'] ?></h5>
        <h5 class="text-center">Program Studi : <?= $nama_ps?> <span class="text-red">|</span> Angkatan : <?= $dt_mhs['angkatan'] ?> <span class="text-red">|</span> Kurikulum : <?= $dt_mhs['id_kur'] ?></h5>
        <h5 class="text-center">Prasyarat : <?= $nm_pilihan_sks?> <?= $session_thn_sks?> = <span class="text-green"><?= $sys_pilihan_sks?></span></h5>
        <h5 class="text-center">Jatah SKS = <span class="text-green"><?= $jatah_sks?></span></h5>
      </div>
      <div class="col-md-3"></div>
    </div>
    <div class="col-md-1"></div>
    <div class="col-md-10">
      <div class="box">
        <div class="box-header with-border">
          <h3 class="box-title text-navy">Mata Kuliah Yang Bisa Diikuti</h3>
        </div><!-- /.box-header -->
        <div class="box-body">
        <form method="post">
         	<input type="text" id="thn_akd" name="thn_akd"  style="display: none;">
        	<input type="text" id="session_id" name="session_id"  style="display: none;">
          <table id="asd" class="table table-bordered">
            <thead>
              <tr>
                <th style="width: 10px">No</th>
                <th></th>
                <th>Kur</th>
                <th>Kode</th>
                <th>Nama</th>
                <th>Sem</th>
                <th>Sks</th>
                <th>Ke</th>
                <th>Nilai Tertinggi</th>
                <th>Kls</th>
              </tr>
            </thead>
            <tbody>
<?php  
    $helper = new Helpers();

    $no=1; foreach ($list_mk_krs_diajukan as $key => $value): 
    $mk_id = $value['ps_id'].'#'.$value['thn_kur'].'#'.$value['kode_mk'];
    
    $krs_ke = 0;
    $nilai = 0;
    if (array_key_exists($mk_id,$krsx_ke)) {
      $krs_ke = count($krsx_ke[$mk_id]);
      $nilai = $krs_nilai_tinggi[$mk_id][0]['nilai'];
    }
    if (array_key_exists($value['kode_mk'], $krs_mhs)) {$checked='checked';$class='background-color: paleturquoise;';}else{$checked='';$class='';}

    if ($krs_ke >= 1){$krs_ke_color='background-color: skyblue;';}else{$krs_ke_color='';}

    $id_mk_class = str_replace(' ', '', $value['kode_mk']);


?>
            <tr style="<?= $class ?>">
              <td style="background: #eee" class="text-center"><?= $no ?></td>          
              <td style="<?= $krs_ke_color ?>">
<input id="cekbox<?= $id_mk_class ?>" type="checkbox" onclick="modal_data('<?= $id_mk_class ?>')" <?= $checked ?> >
<div class="modal fade" id="myModal<?= $id_mk_class ?>" role="dialog">
  <div class="modal-dialog">

    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">
        <h4 class="modal-title"><?= $value['kode_mk']." - ".$value['nama'] ?></h4>
      </div>
      <div class="modal-body">
      <table class="table table-bordered" id="kelas_krs_<?= $value['kode_mk'] ?>">
          <tbody><tr>
            <th style="width: 10px">#</th>
            <th>KELAS</th>
            <th>JADWAL</th>
            <th>RUANG</th>
            <th>DOSEN</th>
            <th style="width: 20px">KAP</th>
            <th style="width: 20px">SISA</th>
            <th>Status</th>
          </tr>
        <?php 
        if (!array_key_exists($value['kode_mk'],$jad_mk)) {
          echo "<tr><td colspan=\"7\" class=\"text-red\">Blm Ada Jadwal...!</td></tr>";
        }else{
          foreach ($jad_mk[$value['kode_mk']] as $k => $v) {      
              if($v['kapasitas'] > 0) {
                  $sisa = $v['kapasitas'] - $v['jml_mhs'];
                  if($sisa < 0) $sisa = 0;
              } else $sisa = "x";

              if (array_key_exists($v['jadkul_id'], $pilih_jadwal)) {
                  $checked='checked';
                  $aktif='Aktif';
                  $sty=' style="color: #00a65a !important" ';
              }else{
                  $checked='';
                  $aktif='';
                  $sty='';
              }
        
        ?>
          <tr <?= $sty ?> >
            <td>
              <input type="radio" name="radio" value="<?= $v['nama_kelas'] ?>" <?= $checked ?>>
  <input type="text" id="thn_kur_<?=$value['kode_mk']?>_<?= $v['nama_kelas'] ?>" value="<?= $value['thn_kur'] ?>" style="display: none;" >
  <input type="text" id="jam_awal_<?=$value['kode_mk']?>_<?= $v['nama_kelas'] ?>" value="<?= $v['jam_awal'] ?>" style="display: none;" >
  <input type="text" id="jam_akhir_<?=$value['kode_mk']?>_<?= $v['nama_kelas'] ?>" value="<?= $v['jam_akhir'] ?>" style="display: none;" >
  <input type="text" id="hari_<?=$value['kode_mk']?>_<?= $v['nama_kelas'] ?>" value="<?= $v['hari'] ?>" style="display: none;" >
  <input type="text" id="sks_<?=$value['kode_mk']?>_<?= $v['nama_kelas'] ?>" value="<?= $value['sks'] ?>" style="display: none;" >
            </td>
            <td><?= $v['nama_kelas'] ?> </td>
            <td><?= $helper->hari($v['hari']).' '.$helper->jam_convert("H:i",$v['jam_awal']).'-'.$helper->jam_convert("H:i",$v['jam_akhir']) ?></td>
            <td><?= $v['namaruang'] ?></td>
            <td><?= $v['namadosen'] ?></td>
            <td><?= $v['kapasitas'] ?></td>
            <td><?= $sisa ?></td>
            <td><?= $aktif ?></td>
          </tr>
        <?php
          }
        }
        ?>
        </tbody>
      </table>
      </div>
      <div class="modal-footer">
        <button onclick="pilih('<?= $id_mk_class ?>')" type="button" class="btn btn-primary" >Pilih</button>
        <button onclick="batal('<?= $id_mk_class ?>')" type="button" class="btn btn-warning" >Batal Pilih</button>
      </div>
    </div>
    
  </div>
</div>
              </td>          
              <td><?= $value['thn_kur'] ?></td>
              <td><?= $value['kode_mk'] ?></td>          
              <td><?= $value['nama'] ?></td>          
              <td><?= $value['semester'] ?></td>          
              <td><?= $value['sks'] ?></td>                  
              <td><?= $krs_ke ?></td>                  
              <td><?= $nilai ?></td>                  
              <td><?= $value['nama_kelas'] ?></td>          
            </tr>     

            <?php $no++; endforeach ?>


            </tbody>            
          </table>
        </form>

        </div><!-- /.box-body -->
      </div><!-- /.box -->
    </div>
    <div class="col-md-1"></div>
  </div>


<!-- TABLE PRASYARAT -->
  <div class="row">
    <div class="col-md-1"></div>
    <div class="col-md-10">
      <div class="box">
        <div class="box-header with-border">
          <h3 class="box-title text-red">Mata Kuliah Terkena Prasyarat</h3>
        </div><!-- /.box-header -->
        <div class="box-body">
          <table class="table table-bordered">
            <tbody><tr>
              <th style="width: 10px">#</th>
              <th>Mata Kuliah</th>
              <th>Prasyarat</th>
              <th>Alasan</th>
            </tr>
              
            <?php $no=1; foreach ($list_prasyarat_tidak_lolos as $key => $value): ?>
            <tr>
              <td><?= $no ?></td>
              <td><b><?= $value['thn_kur'] ?></b> <span class="text-green"><?= $value['kode_mk'] ?></span> <?= $value['nama'] ?></td>
              <td><?= $value['syarat'] ?></td>
              <td><?= $value['alasan'] ?></td>
            </tr>
            <?php $no++; endforeach ?>
          
          </tbody></table>
        </div><!-- /.box-body -->
      </div>
    </div>
  </div>
</div>

</section><!-- /.content -->

<style type="text/css">
  .jad_aktif{
    background-color: lightgreen;
  }
</style>

<script type="text/javascript">
$(function () {
  $('#example2').DataTable({
      "paging": true,
      "lengthChange": true,
      "searching": true,
      "ordering": true,
      "info": true,
      "autoWidth": true
    });
});

function modal_data(kode_mk) {
	$("#myModal"+kode_mk).modal({
    backdrop: 'static',
    keyboard: false
  });
}

function go_page_data_get(link,datas){ 
  if (link=='#') {return false;}
  
  $.ajax({
        method: "GET",
        dataType: "html",
        url: link,
        data: datas,
        beforeSend: function() {
                $(".content-wrapper").css("background-color", 'white');
                $(".load").css("display", 'block');
                $(".content-wrapper2").css("display", 'none');

            },
            complete: function() {
                $(".content-wrapper").css("background-color", '#ecf0f5');
                $(".load").css("display", 'none');
                $(".content-wrapper2").css("display", 'block');
            },
        success: function(res){
            $('.content-wrapper2').html(res);
            $('.ui-pnotify-closer').click();
        }
    });
    return false;
}

function batal(kode_mk) {
  $('#cekbox'+kode_mk).removeAttr('checked');

  var kelas_id = "kelas_krs_"+kode_mk;
  var kelas = $("#"+kelas_id+" input[type='radio']:checked").val();

  var thn_kur_id = "thn_kur_"+kode_mk+'_'+kelas;
  var thn_kur = $("#"+thn_kur_id).val();

  var ps_id = "{{ps_id}}";
  var psmhs_id = "{{psmhs_id}}";
  var thn_akd = "{{thn_akd}}";
  var session_id = "{{session_id}}";

  var nomhs = "<?= $dt_mhs['id_mhs']?>";

  var urel = '{{ url("akdkrsmhs/delKrs/") }}';
  var datas = "ps_id="+ps_id+"&psmhs_id="+psmhs_id+"&thn_akd="+thn_akd+"&kode_mk="+kode_mk+"&session_id="+session_id+"&thn_kur="+thn_kur+"&nomhs="+nomhs+"&kelas="+kelas;
  $.ajax({
     type: "POST",
     url: urel,
     dataType : "json",
     data: datas
  }).done(function( data ) {
      new PNotify({
        title: data.title,
        text: data.text,
        type: data.type
      });
      reload(nomhs);
  });

  $('#myModal'+kode_mk).modal('hide');
  $('body').removeClass('modal-open');
  $("body").css("padding-right", "0px");
  $('.modal-backdrop').remove();
}

function reload(nomhs) {
  var krs_ol = "{{thn_akd}}-{{session_id}}-{{ol_id}}";
  var datas = "krs_ol="+krs_ol+"&nomhs="+nomhs;
  var link = '{{ url("prediskrs/DataKrsReload/") }}';
  reload_page_data_get(link,datas);
}

function pilih(kode_mk) {
  var kelas_id = "kelas_krs_"+kode_mk;
  var kelas = $("#"+kelas_id+" input[type='radio']:checked").val();

  var thn_kur_id = "thn_kur_"+kode_mk+'_'+kelas;
  var thn_kur = $("#"+thn_kur_id).val();

  var jam_awal_id = "jam_awal_"+kode_mk+'_'+kelas;
  var jam_awal = $("#"+jam_awal_id).val();

  var jam_akhir_id = "jam_akhir_"+kode_mk+'_'+kelas;
  var jam_akhir = $("#"+jam_akhir_id).val();

  var hari_id = "hari_"+kode_mk+'_'+kelas;
  var hari = $("#"+hari_id).val();

  var sks_id = "sks_"+kode_mk+'_'+kelas;
  var sks = $("#"+sks_id).val();

  var ps_id = "{{ps_id}}";
  var psmhs_id = "{{psmhs_id}}";
  var thn_akd = "{{thn_akd}}";
  var session_id = "{{session_id}}";

  var nomhs = "<?= $dt_mhs['id_mhs']?>";
  var krs_ol = "{{thn_akd}}-{{session_id}}-{{ol_id}}";
  // console.log(jam_akhir);

  var urel = '{{ url("akdkrsmhs/addKrs/") }}';
  var datas = "ps_id="+ps_id+"&psmhs_id="+psmhs_id+"&thn_akd="+thn_akd+"&kode_mk="+kode_mk+"&session_id="+session_id+"&thn_kur="+thn_kur+"&nomhs="+nomhs+"&kelas="+kelas+"&jam_awal="+jam_awal+"&jam_akhir="+jam_akhir+"&hari="+hari+"&sks="+sks+"&krs_ol="+krs_ol;
  $.ajax({
     type: "POST",
     url: urel,
     dataType : "json",
     data: datas
  }).done(function( data ) {
      new PNotify({
        title: data.title,
        text: data.text,
        type: data.type
      });
      reload(nomhs);
  });

  $('#cekbox'+kode_mk).prop('checked', true);
  $('#myModal'+kode_mk).modal('hide');
  $('body').removeClass('modal-open');
  $("body").css("padding-right", "0px");
  $('.modal-backdrop').remove();
}

function back() {
	var link = '{{ url("akdkrs/listMk/") }}';
    go_page(link);
}

function lihat_jadwal(thn_akd,session_id,thn_kur,kode_mk,nama_kelas,nama,sks,kapasitas,id,semester) {
	var link = '{{ url("akdjadkul/lihatJadwal/") }}';
    var datas = "thn_akd="+thn_akd+"&session_id="+session_id+"&thn_kur="+thn_kur+"&kode_mk="+kode_mk+"&nama_kelas="+nama_kelas+"&nama="+nama+"&sks="+sks+"&kapasitas="+kapasitas+"&id_mkkpkl="+id+"&semester="+semester;
    go_page_data(link,datas);
}

</script>