<section class="content-header">
  <h1>
    <button type="button" onclick="back('{{sesi}}','{{id}}','{{ujian_id}}')" class="btn bg-navy btn-flat margin"><i class="fa fa-fw fa-arrow-left"></i> Back</button>
  </h1>
  <ol class="breadcrumb">
    <li><span class="text-NAVY"><?= $defujian['nama_long'] ?> - </span> <?= $sesi_nama ?></li>
  </ol>
</section>

<!-- Main content -->
<section class="content">
<form method="post">

<input type="text" name="sesi" style="display:none;" value="{{sesi}}">
<input type="text" name="id" style="display:none;" value="{{id}}">
<input type="text" name="ujian_id" style="display:none;" value="{{ujian_id}}">

  <div class="row">

    <div class="col-md-12">
      <div class="box">
        <div class="box-header with-border">
          <h3 class="box-title">Daftar MK yang di Pilih :</h3>
        </div><!-- /.box-header -->
        <div class="box-body">
          <table id="asd" class="table table-bordered table-striped">
            <thead>
              <tr>
                <th style="width: 50px;    text-align: center;">No</th>
                <th style="display: none;">asd</th>
                <th>Thn Kur</th>
                <th>Kode MK</th>
                <th>Nama MK</th>
                <th>Kelas</th>
                <th>Jml Mhs</th>
              </tr>
            </thead>
            <tbody>

            
            <?php $ttl_mhs=0; $no=1; foreach ($data_mk as $key => $value): ?>
            <?php $ttl_mhs += $value['jml_mhs']; ?>
            	
            <tr>
              <td style="text-align: center;"><?= $no ?></td>
              <td style="display: none;">
              <input type="checkbox" checked name="pilihmk_<?=$no?>" value="{{sesi}}#{{ujian_id}}#<?= $value['thn_kur'] ?>#<?= $value['kode_mk'] ?>#<?= $value['nama_kelas'] ?>#<?= $value['nama'] ?>#<?= $value['jml_mhs'] ?>">
              </td>
              <td><?= $value['thn_kur'] ?></td>
              <td><?= $value['kode_mk'] ?></td>
              <td><?= $value['nama'] ?></td>
              <td><?= $value['nama_kelas'] ?></td>
              <td><?= $value['jml_mhs'] ?></td>
            </tr>

            <?php $no++; endforeach ?>

            </tbody>            
          </table>
          Total Mahasiswa : <?= $ttl_mhs ?>

        </div><!-- /.box-body -->
      </div><!-- /.box -->
    </div>

  </div>
      

    <div class="row">
    <div class="col-md-12">
      <div class="box">
        <div class="box-header with-border">
          <h3 class="box-title">Daftar Ruang :</h3>
          <input type="text" id="kap" style="display: none;"  value="0">
          <p class="text-green">Total Kapasitas Ruang : <span id="ttl_kap"></span></p>
        </div><!-- /.box-header -->
        <div class="box-body">
          <table id="asd" class="table table-bordered">
            <thead>
              <tr>
                <th style="width: 50px;    text-align: center;">No</th>
                <th>Pilih</th>
                <th>Nama Ruang</th>
                <th>Nama Konfigurasi</th>
                <th>Kapasitas</th>
              </tr>
            </thead>
            <tbody>

            
            <?php $no=1; foreach ($ruang as $key => $value): ?>
            <?php $class = ($value['kapasitas'] > 0) ? "" : "kosong"; ?>
            <tr class="<?= $class ?>">
              <td style="text-align: center;"><?= $no ?></td>                    
              <td><input type="checkbox" class="ruang_kap_<?=$no?>" name="pilihruang_<?=$no?>" value="<?= $value['ruang_id'] ?>#<?= $value['conf_id'] ?>#<?= $value['nama_ruang'] ?>#<?= $value['kapasitas'] ?>#<?= $value['nama_conf'] ?>" onclick="jml_kap(<?=$no?>,<?= $value['kapasitas'] ?>);"></td>                    
              <td><?= $value['nama_ruang'] ?></td>                    
              <td><?= $value['nama_conf'] ?></td>                    
              <td><?= $value['kapasitas'] ?></td>                    
            </tr>

            <?php $no++; endforeach ?>

            </tbody>            
          </table>
        <button type="button" onclick="pilih_ruang()" class="btn bg-navy btn-flat margin pull-right"><i class="fa fa-fw fa-save"></i> Rekam</button>

        </div><!-- /.box-body -->
      </div><!-- /.box -->
    </div>

  </div>
</form>
</section><!-- /.content -->


<style type="text/css">
	.table>tbody>tr>td, .table>tbody>tr>th, .table>tfoot>tr>td, .table>tfoot>tr>th, .table>thead>tr>td, .table>thead>tr>th{
		padding: 0px; 
	}
	.kosong{
		background-color: seashell;
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


function jml_kap(id,kap) {
	var kapasitas = parseInt($("#kap").val());
	if ($('.ruang_kap_'+id).is(":checked")){
		var pp = kapasitas+kap;
		$("#kap").val(pp);
	}else{
		var pp = kapasitas-kap;
		$("#kap").val(pp);
	}
	var kk = parseInt($("#kap").val());

	$("#ttl_kap").html(kk);
}

function back(sesi,id,ujian_id) {
	var link = '{{ url("akdjadwalujian/listMkGabungan/") }}';
    var datas = "id="+id+"&ujian_id="+ujian_id+"&sesi="+sesi;
    go_page_data(link,datas);
}

function pilih_ruang() {
	var link = '{{ url("akdjadwalujian/urutkan/") }}';
    var datas = $('form').serialize();
    // console.log(datas);
    go_page_data(link,datas);
}


</script>