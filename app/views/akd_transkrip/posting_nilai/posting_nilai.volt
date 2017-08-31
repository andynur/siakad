<section class="content-header">
	<h1>
    <button type="button" onclick="back()" class="btn bg-navy btn-flat"><i class="fa fa-fw fa-arrow-left"></i> Back</button>
  </h1>
  <ol class="breadcrumb">
    <li><i class="fa fa-user"></i> {{nama}} ( Nomhs : {{nomhs}} - Angkatan : {{angkatan}})</li>
  </ol>
</section>

<!-- Main content -->
<section class="content">

<div class="row">
  <div class="col-md-4">
    <div class="box">
        <div class="box-body">
			<?php if (count($transdata_array) == 0): ?>
        		<p>Total SKS : 0</p>
        		<p>IP Komulatif : 0</p>
			<?php else: ?>
        		<p>Total SKS : {{ttl_sks}}</p>
        		<p>IP Komulatif : {{ipk}}</p>
			<?php endif ?>
        	<div class="col-md-6"><button onclick="rebuild_transkrip('{{psmhs_id}}','{{nomhs}}','{{kur_mhs}}')" class="btn btn-block btn-info btn-xs">Rebuild Transkrip</button></div>
        	<div class="col-md-6"><button onclick="drop_zero('{{psmhs_id}}','{{nomhs}}')" class="btn btn-block btn-danger btn-xs">Drop Zero</button></div>
        </div>
    </div>
  </div>

</div>


<?php if (count($transdata_array) != 0): ?>
<div class="row">
  <div class="col-md-12">
    <div class="box">
        <div class="box-header">
          <h3 class="box-title">Transkrip Mhs</h3>
        </div><!-- /.box-header -->
        <div class="box-body">
        	<table id="" class="table table-bordered table-striped">
				<thead>
				  <tr>
				    <th style="width: 10px">No</th>
				    <th>Kur</th>
				    <th class="text-center">Kode Mk</th>
				    <th>Nama Mk</th>
				    <th class="text-center" >Sem</th>
				    <th class="text-center" >SKS</th>
				    <th class="text-center" >W/P</th>
				    <th class="text-center" >Kelp</th>
				    <th class="text-center" >Nilai</th>
				    <th class="text-center" >C</th>
				    <th class="text-center" style="width: 20px;">A</th>
				  </tr>
				</thead>
				<tbody>

        		<?php $no=1; foreach ($transdata_array as $k => $v): ?>

				<tr>
					<td style="padding: 2px;"><?= $no ?></td>
					<td style="padding: 2px;"><?= $v['ps_id'].' / '.$v['thn_kur'] ?></td>
					<td style="padding: 2px;" class="text-center"><?= $v['kode_mk'] ?></td>
					<td style="padding: 2px;"><a href="javascript:void(0)" onclick="edit_transdata('<?= $v['id'] ?>','<?= $v['ps_id'] ?>','{{psmhs_id}}','{{nomhs}}','<?= $v['kode_mk'] ?>','<?= $v['thn_kur'] ?>')"><?= $v['nama_mk'] ?></a></td>
					<td style="padding: 2px;" class="text-center"><?= $v['sem'] ?></td>
					<td style="padding: 2px;" class="text-center"><?= $v['sks'] ?></td>
					<td style="padding: 2px;" class="text-center"><?= $v['jenis'] ?></td>
					<td style="padding: 2px;" class="text-center"><?= $v['kelp'] ?></td>
					<td style="padding: 2px;" class="text-center"><?= $v['nilai_huruf'] ?></td>
					<td style="padding: 2px;" class="text-center"><?= $v['mk_count'] ?></td>
					<?php if ($v['del'] != 'Y'): ?>
						<td style="padding: 2px;">
						<a href="javascript:void(0)"><span data-toggle="tooltip" onclick="non_aktif('<?= $v['id'] ?>')" title="Non Aktifkan" class="badge bg-green">0</span></a>
						</td>
        			<?php else: ?>
						<td style="padding: 2px;">
						<a href="javascript:void(0)"><span data-toggle="tooltip" onclick="aktifkan('<?= $v['id'] ?>')" title="Aktifkan" class="badge bg-red">0</span></a>

							
						</td>
        			<?php endif ?>
				</tr>

        		<?php $no++; endforeach ?>

				</tbody>            
			</table>
        		
        </div>
    </div>
  </div>
</div>

<div class="row">
  <div class="col-md-12">
    <div class="box">
        <div class="box-header">
          <h3 class="box-title">Mata kuliah <span class="text-green">(kurikulum {{kur_mhs}})</span> yang belum diambil:</h3>
        </div><!-- /.box-header -->
        <div class="box-body">
        	<table id="" class="table table-bordered table-striped">
				<thead>
				  <tr>
				    <th style="width: 10px">No</th>
				    <th>Kur</th>
				    <th class="text-center">Kode Mk</th>
				    <th>Nama Mk</th>
				    <th class="text-center" >Sem</th>
				    <th class="text-center" >SKS</th>
				    <th class="text-center" >W/P</th>
				    <th class="text-center" >Kelp</th>
				  </tr>
				</thead>
				<tbody>

        		<?php $no=1; foreach ($mk_yg_blm_diambil as $k => $v): ?>

				<tr>
					<td style="padding: 2px;"><?= $no ?></td>
					<td style="padding: 2px;"><?= $v['ps_id'].' / '.$v['thn_kur'] ?></td>
					<td style="padding: 2px;" class="text-center"><?= $v['kode_mk'] ?></td>
					<td style="padding: 2px;"><?= $v['nama'] ?></td>
					<td style="padding: 2px;" class="text-center"><?= $v['semester'] ?></td>
					<td style="padding: 2px;" class="text-center"><?= $v['sks'] ?></td>
					<td style="padding: 2px;" class="text-center"><?= $v['jenis'] ?></td>
					<td style="padding: 2px;" class="text-center"><?= $v['kelompok'] ?></td>
				</tr>

        		<?php $no++; endforeach ?>

				</tbody>            
			</table>
        		
        </div>
    </div>
  </div>
</div>

<?php endif ?>
      
</section><!-- /.content -->


<style type="text/css">
	.over{
		/*background: crimson;*/
    	color: crimson;
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

function reload() {
	psmhs_id = "{{psmhs_id}}";
    nomhs = "{{nomhs}}";
    angkatan = "{{angkatan}}";
    nama = "{{nama}}";
    kur_mhs = "{{kur_mhs}}";
	var link = '{{ url("akdpostingnilai/postingNilai/") }}';
	var datas = 'psmhs_id='+psmhs_id+'&nomhs='+nomhs+'&nama='+nama+'&angkatan='+angkatan+'&kur_mhs='+kur_mhs;
	reload_page_data(link,datas);
}

function back() {
	var link = '{{ url("akdpostingnilai/selectMhs/") }}';
	go_page(link);
}


function edit_transdata(id,ps_id,psmhs_id,nomhs,kode_mk,thn_kur) {
	nama = "{{nama}}";
	angkatan = "{{angkatan}}";
	var link = '{{ url("akdpostingnilai/formEdit/") }}';
	var datas = 'id='+id+'&ps_id='+ps_id+'&psmhs_id='+psmhs_id+'&nomhs='+nomhs+'&kode_mk='+kode_mk+'&thn_kur='+thn_kur+'&nama='+nama+'&angkatan='+angkatan;
	go_page_data(link,datas);
}


function rebuild_transkrip(psmhs_id,nomhs,kur_mhs) {
	var link = '{{ url("akdpostingnilai/rebuildTranskrip/") }}';
	var datas = 'psmhs_id='+psmhs_id+'&nomhs='+nomhs+'&kur_mhs='+kur_mhs;
	// go_page_data(link,datas);
	$.ajax({
		type: "POST",
		url: link,
		dataType : "json",
		data: datas
	}).done(function( data ) {
		reload();
	});
}

function drop_zero(psmhs_id,nomhs) {
	var link = '{{ url("akdpostingnilai/dropZero/") }}';
	var datas = 'psmhs_id='+psmhs_id+'&nomhs='+nomhs;
	$.ajax({
		type: "POST",
		url: link,
		dataType : "json",
		data: datas
	}).done(function( data ) {
		reload();
	});
}

function non_aktif(id) {
	var link = '{{ url("akdpostingnilai/nonAktif/") }}';
	var datas = 'id='+id;
	$.ajax({
		type: "POST",
		url: link,
		dataType : "json",
		data: datas
	}).done(function( data ) {
		reload();
	});
}

function aktifkan(id) {
	var link = '{{ url("akdpostingnilai/aktifkan/") }}';
	var datas = 'id='+id;
	$.ajax({
		type: "POST",
		url: link,
		dataType : "json",
		data: datas
	}).done(function( data ) {
		reload();
	});
}


</script>