<section class="content-header">
	<h1>
		<button type="button" onclick="back()" class="btn bg-navy btn-flat"><i class="fa fa-fw fa-arrow-left"></i> Back</button>
	</h1>
	<ol class="breadcrumb">
		<li><i class="fa fa-user"></i> {{nama}} ( Nomhs : {{nomhs}}- Angkatan : {{angkatan}})</li>
	</ol>
</section>

<!-- Main content -->
<section class="content">
{% for v in data %}
<form method="post">
	<div class="row">
		<div class="col-md-5">
			<div class="box">
				<div class="box-header">
					<h3 class="box-title">EDIT DATA MATA KULIAH TRANSKRIP</h3>
				</div><!-- /.box-header -->
				<div class="box-body">
					<table class="table table-condensed">
						<tbody>
							<tr>
								<td style="padding: 11px 6px;width: 140px; background: #eee" class="text-left"><b>Kurikulum :</b></td>
								<td>{{v.thn_kur}}</td>
							</tr>
							<tr>
								<td style="padding: 11px 6px;width: 140px; background: #eee" class="text-left"><b>Kode :</b></td>
								<td>{{v.kode_mk}}</td>
							</tr>
							<tr>
								<td style="padding: 11px 6px;width: 140px; background: #eee" class="text-left"><b>Nama ID :</b></td>
								<td>
									<div class="input-group">
										<label>
											<input type="text" name="nama" value="{{v.nama_mk}}" id="nomhs">
										</label>
									</div>
								</td>
							</tr>
							<tr>
								<td style="padding: 11px 6px;width: 140px; background: #eee" class="text-left"><b>Nama EN :</b></td>
								<td>
									<div class="input-group">
										<label>
											<input type="text" name="nama_en" value="{{v.nama_en}}" id="nomhs">
										</label>
									</div>
								</td>
							</tr>
							<tr>
								<td style="padding: 11px 6px;width: 140px; background: #eee" class="text-left"><b>Semester :</b></td>
								<td>
									<div class="input-group">
										<label>
											<input type="text" name="semester" value="{{v.sem}}" id="nomhs">
										</label>
									</div>
								</td>
							</tr>
							<tr>
								<td style="padding: 11px 6px;width: 140px; background: #eee" class="text-left"><b>SKS :</b></td>
								<td>
									<div class="input-group">
										<label>
											<input type="text" name="sks" value="{{v.sks}}" id="nomhs">
										</label>
									</div>
								</td>
							</tr>								
							<tr>
								<td style="padding: 11px 6px;width: 140px; background: #eee" class="text-left"><b>Kelompok :</b></td>
								<td>
									<div class="input-group">
										<label>
											<input type="text" name="kelompok" value="{{v.kelp}}" id="nomhs">
										</label>
									</div>
								</td>
							</tr>								
							<tr>
								<td style="padding: 11px 6px;width: 140px; background: #eee" class="text-left"><b>Jenis :</b></td>
								<td>
									<div class="input-group">
										<label>
											<input type="text" value="{{v.jenis}}" name="jenis" id="nomhs">
										</label>
									</div><p>W/P, Wajib/Pilihan</p>
								</td>
							</tr>

						</tbody>
					</table>
				</div>
			</div>
		</div>

		<div class="col-md-7">
			<div class="box">
				<div class="box-header">
					<h3 class="box-title"></h3>
				</div><!-- /.box-header -->
				<div class="box-body">
					<table class="table table-condensed">
						<tbody>
							<tr>
							<td style="padding: 11px 6px;width: 185px; background: #eee" class="text-left"><b>Urut :</b></td>
								<td>
									<div class="input-group">
										<label>
											<input type="text" name="urut" value="{{v.urut}}" id="nomhs">
										</label>
									</div>
								</td>
							</tr>
							<tr>
							<td style="padding: 11px 6px;width: 185px; background: #eee" class="text-left"><b>Nilai Huruf :</b></td>
								<td>{{v.nilai_huruf}}</td>
							</tr>
							<tr>
							<td style="padding: 11px 6px;width: 185px; background: #eee" class="text-left"><b>Nilai Angka :</b></td>
								<td>{{v.nilai_angka}}</td>
							</tr>
							<tr>
							<td style="padding: 11px 6px;width: 185px; background: #eee" class="text-left"><b>Keterangan Nilai :</b></td>
								<td>
									<div class="input-group">
										<label>
											<input type="text" value="{{v.ket_nilai}}" name="ket_nilai" id="nomhs">
										</label>
									</div>
								</td>
							</tr>
							<tr>
							<td style="padding: 11px 6px;width: 185px; background: #eee" class="text-left"><b>Keterangan Nilai (En) :</b></td>
								<td>
									<div class="input-group">
										<label>
											<input type="text" value="{{v.ket_nilai_en}}" name="ket_nilai_en" id="nomhs">
										</label>
									</div>
								</td>
							</tr>
							<tr>
							<td style="padding: 11px 6px;width: 185px; background: #eee" class="text-left"><b>Pengambilan Ke :</b></td>
								<td>{{v.ambil_ke}}</td>
							</tr>
							<tr>
							<td style="padding: 11px 6px;width: 185px; background: #eee" class="text-left"><b>Number of Semester (En) :</b></td>
								<td>
									<div class="input-group">
										<label>
											<input type="text" value="{{v.nsem}}" name="semester_en" id="nomhs">
										</label>
									</div>
								</td>
							</tr>
							<tr>
							<td style="padding: 11px 6px;width: 185px; background: #eee" class="text-left"><b>Pilihan tampil :</b></td>
							<td id="frmval">
							   <input type="radio" value="nilai" name="st_disp" checked="" id="a1"><label for="a1"> Nilai</label>&nbsp;
							   <input type="radio" value="keterangan" name="st_disp" id="a2"><label for="a2"> Keterangan nilai</label>&nbsp;
							   <input type="radio" value="" name="st_disp" id="a3"><label for="a3"> Kosong</label>&nbsp;
						   </td>
							</tr>


						</tbody>
					</table>
					<button style="margin: 0;" type="button" onclick="edit_trans('{{v.id}}')" class="btn bg-navy btn-flat pull-right"><i class="fa fa-fw fa-edit"></i> Edit</button>
				</div>
			</div>
		</div>

	</div>

</form>
{% endfor %}

<div class="row">
  <div class="col-md-12">
    <div class="box">
        <div class="box-header">
          <h3 class="box-title">DAFTAR MATA KULIAH EQUIVALEN. CLICK NAMA UNTUK PILIH.</h3>
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
				    <th class="text-center" >Sesi</th>
				  </tr>
				</thead>
				<tbody>

        		<?php $no=1; foreach ($data_transeq as $k => $v): ?>

				<tr>
					<td style="padding: 2px;"><?= $no ?></td>
					<td style="padding: 2px;"><?= $v['ps_idv'].' / '.$v['thn_kurv'] ?></td>
					<td style="padding: 2px;" class="text-center"><?= $v['kode_mkv'] ?></td>
					<td style="padding: 2px;"><?= $v['nama'] ?></td>
					<td style="padding: 2px;" class="text-center"><?= $v['semester'] ?></td>
					<td style="padding: 2px;" class="text-center"><?= $v['sks'] ?></td>
					<td style="padding: 2px;" class="text-center"><?= $v['jenis'] ?></td>
					<td style="padding: 2px;" class="text-center"><?= $v['kelompok'] ?></td>
					<td style="padding: 2px;" class="text-center"><?= $v['nilai_hrfv'] ?></td>
					<td style="padding: 2px;" class="text-center"><?= $v['ambilkev'] ?></td>
					<td style="padding: 2px;" class="text-center"><?= $v['thn_akdv'] ?>/<?= $v['session_idv'] ?></td>
				</tr>

        		<?php $no++; endforeach ?>

				</tbody>            
			</table>
        		
        </div>
    </div>
  </div>
</div>

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

	function back() {
		psmhs_id = "{{psmhs_id}}";
		nomhs = "{{nomhs}}";
		angkatan = "{{angkatan}}";
		nama = "{{nama}}";
		kur_mhs = "{{kur_mhs}}";
		var link = '{{ url("akdpostingnilai/postingNilai/") }}';
		var datas = 'psmhs_id='+psmhs_id+'&nomhs='+nomhs+'&nama='+nama+'&angkatan='+angkatan+'&kur_mhs='+kur_mhs;
		go_page_data(link,datas);
	}

	function edit_trans(id) {
		var link = '{{ url("akdpostingnilai/submitEdit/") }}'+id;
		var datas = $('form').serialize();
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