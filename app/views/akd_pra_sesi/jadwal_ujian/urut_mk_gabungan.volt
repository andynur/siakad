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
                <th>Urutan</th>
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
              <td><input type="text" name="urutan_mk<?=$no?>" id="t1" size="5" maxlength="5" value=""></td>
            </tr>

            <?php $no++; endforeach ?>

            </tbody>            
          </table>
          Total Mahasiswa : <?= $ttl_mhs ?>

        </div><!-- /.box-body -->
      </div><!-- /.box -->
    </div>

  </div>
      
<?php if (!empty($data_ruang)): ?>
	
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
                <th style="display: none;">Pilih</th>
                <th>Nama Ruang</th>
                <th>Nama Konfigurasi</th>
                <th>Kapasitas</th>
                <th>Urutan</th>
              </tr>
            </thead>
            <tbody>

            
            <?php $no=1; foreach ($data_ruang as $key => $value): ?>
            <?php $class = ($value['kapasitas'] > 0) ? "" : "kosong"; ?>
            <tr class="<?= $class ?>">
              <td style="text-align: center;"><?= $no ?></td>                    
              <td style="display: none;"><input checked type="checkbox" class="ruang_kap_<?=$no?>" name="pilihruang_<?=$no?>" value="<?= $value['ruang_id'] ?>#<?= $value['conf_id'] ?>#<?= $value['nama_ruang'] ?>#<?= $value['kapasitas'] ?>#<?= $value['nama_conf'] ?>" onclick="jml_kap(<?=$no?>,<?= $value['kapasitas'] ?>);"></td>                    
              <td><?= $value['nama_ruang'] ?></td>                    
              <td><?= $value['nama_conf'] ?></td>                    
              <td><?= $value['kapasitas'] ?></td>                    
              <td><input type="text" name="urutan_ruang<?=$no?>" id="t1" size="5" maxlength="5" value=""></td>                    
            </tr>

            <?php $no++; endforeach ?>

            </tbody>            
          </table>
        </div><!-- /.box-body -->
      </div><!-- /.box -->
    </div>
  </div>

  <div class="row">
  <div class="col-md-3"></div>
  <div class="col-md-6">
    <div class="box">
        <div class="box-header">
          <h3 class="box-title">TAMBAH JADWAL UJIAN</h3>
        </div><!-- /.box-header -->
        <div class="box-body">
        <form method="post">
            <table class="table table-condensed">
              <tbody>
                <tr>
					<td style="padding: 11px 6px;width: 100px; background: #eee" class="text-left"><b>Awal :</b></td>
					<td>Tgl : <input  type="text" name="dd1" size="2" maxlength="2" value="<?= date('d') ?>">                 
					
						<select  name="mm1">
							<option value="1" selected="">Januari</option>
							<option value="2">Februari</option>
							<option value="3">Maret</option>
							<option value="4">April</option>
							<option value="5">Mei</option>
							<option value="6">Juni</option>
							<option value="7">Juli</option>
							<option value="8">Agustus</option>
							<option value="9">September</option>
							<option value="10">Oktober</option>
							<option value="11">November</option>
							<option value="12">Desember</option>
						</select>
					                
					<input  type="text" maxlength="4" name="yyyy1" size="4" value="<?= date('Y') ?>" >            
					 Jam : <input  type="text" name="t1" id="t1" size="5" maxlength="5" value=""></td>                  
                </tr>
                <tr>
					<td style="padding: 11px 6px;width: 100px; background: #eee" class="text-left"><b>Akhir :</b></td>
					<td>Tgl : <input  type="text" name="dd2" size="2" maxlength="2" value="<?= date('d') ?>">                 
					
						<select  name="mm2">
							<option value="1" selected="">Januari</option>
							<option value="2">Februari</option>
							<option value="3">Maret</option>
							<option value="4">April</option>
							<option value="5">Mei</option>
							<option value="6">Juni</option>
							<option value="7">Juli</option>
							<option value="8">Agustus</option>
							<option value="9">September</option>
							<option value="10">Oktober</option>
							<option value="11">November</option>
							<option value="12">Desember</option>
						</select>
					                
					<input  type="text" maxlength="4" name="yyyy2" size="4" value="<?= date('Y') ?>" >            
					 Jam : <input  type="text" name="t2" id="t2" size="5" maxlength="5" value=""></td>                  
                </tr>
              </tbody>
            </table>

            <button style="margin: 0;" type="button" onclick="tambah()" class="btn bg-navy btn-flat pull-right"><i class="fa fa-fw fa-edit"></i> Rekam</button>
            </form>
        </div>
    </div>
  </div>
  <div class="col-md-3"></div>
</div>

<?php else: ?>
<h2><font color="red">JUMLAH KURSI MASIH KURANG! HARAP DIPERBAIKI</font></h2>
<?php endif ?>

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

function tambah() {
	var jam1 = $("#t1").val();
	var jam2 = $("#t2").val();

	if (jam1 == '' || jam2 == '' ) {
		new PNotify({
		   title: "warning",
		   text: "jam tidak boleh kosong",
		   type: "warning"
		});
	}

	var datas = $("form").serialize();
	var link = '{{ url("akdjadwalujian/simpanGab/") }}';
	// go_page_data(link,datas);
    $.ajax({
       type: "POST",
       url: link,
       dataType : "json",
       data: datas
    }).done(function( data ) {
      	new PNotify({
		   title: data.title,
		   text: data.text,
		   type: data.type
		});
    });
}


</script>