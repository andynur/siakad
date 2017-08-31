<section class="content-header">
    <h1>
        Skripsi Mahasiswa
        <small>it all starts here</small>
    </h1>
    <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i> Mahasiswa</a></li>
        <li class="active">Skripsi</li>
    </ol>
</section>

<!-- Main content -->
<section class="content">

    <!-- row -->
    <div class="row">
<p class="lead" style="text-align: center;">Sesi Skripsi</p>
    <div class="col-lg-3"></div>

    <div class="col-md-6">
	    <div class="box">
	        <div class="box-header">
	          <h3 class="box-title">Select Sesi</h3>
	        </div><!-- /.box-header -->
	        <div class="box-body">
	        <form method="post">
	            <table class="table table-condensed">
	              <tbody>
	                <tr>
	                  <td style="padding: 11px 6px;width: 100px; background: #eee" class="text-left"><b>Sesi :</b></td>
	                  	<td>
		                  	<div class="input-group">
		                      <div class="input-group-addon">
		                        <i class="fa fa-calendar"></i>
		                      </div>
		                      <select style="width:80%;" id="sesi" class="form-control">
		                       	{% for val in tahun_sesi %}
			                        <option value="{{val.thn_akd}}-{{val.session_id}}" >{{val.nama}} {{ helper.format_thn_akd(val.thn_akd) }}</option>
			                    {% endfor %}   
		                      </select>
		                    </div><!-- /.input group -->
	                   	</td>                  
	                </tr>
	              </tbody>
	            </table>
	            <button style="margin: 0;" type="button" onclick="form_skripsi()" class="btn bg-navy btn-flat pull-right"><i class="fa fa-fw fa-edit"></i> Pengajuan</button>
	        </form>
	        </div>
	    </div>
	 </div>

    </div>

<div class="row">
    <div class="col-md-12">
        <div class="box">
            <div class="box-header">
              <h3 class="box-title">Skripsi Yang Pernah Di Ajukan</h3>
            </div><!-- /.box-header -->

            <div class="box-body">
                <table class="table table-bordered" id="table" style="padding-right:0; margin-right:0;">
                    <thead>
                        <tr>
                            <td width="50">NO</td>
                            <td width="70">Sesi</td>
                            <td>Judul</td>
                            <td>Bidang Penelitian</td>
                            <td>Perusahaan</td>
                            <td>Kota</td>
                            <td>Status</td>
                            <td>Tgl Dikoreksi</td>
                            </td>
                        </tr>
                    </thead>
                    <tbody>
                        <?php $no = 1 ?>
                        <?php foreach ($skripsi_mhs as $key => $v): ?>
                        <tr>
                            <td><?= $no ?></td>
                            <td><?= $v['thn_akd'] ?>/<?= $v['session_id'] ?></td>
                            <td><a href="" data-toggle="modal" data-target="#myModal<?= $no ?>"><?= $v['judul_skripsi'] ?></a></td>
                            <td><?= $v['bidang_penelitian'] ?></td>
                            <td><?= $v['perusahaan'] ?></td>
                            <td><?= $v['kota_perusahaan'] ?></td>
                            <td>
                            	<?php if ($v['status'] == 'P'): ?>
                            		<span class="text-aqua">Pengajuan</span>
                            	<?php elseif($v['status'] == 'Y'): ?>
                            		<span class="text-green">Diterima</span>
                            	<?php elseif($v['status'] == 'N'): ?>
                            		<span class="text-red">Ditolak</span>
                            	<?php endif ?>
                            </td>
                            <td>
                            	<?php if ($v['status'] == 'P'): ?>
                            		<span class="text-aqua">Pengajuan</span>
                            	<?php elseif($v['status'] == 'Y'): ?>
                            		<span class="text-green"><?= $v['tgl_dikoreksi'] ?></span>
                            	<?php elseif($v['status'] == 'N'): ?>
                            		<span class="text-red"><?= $v['tgl_dikoreksi'] ?></span>
                            	<?php endif ?>
                            </td>
                        </tr>
<!-- Modal -->
<div id="myModal<?= $no ?>" class="modal fade" role="dialog">
  <div class="modal-dialog">

    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">Edit Pengajuan Skripsi</h4>
      </div>
      <div class="modal-body">

      	<div class="form-group">
      		<label>Judul Skripsi :</label>
			<textarea id="judul<?= $no ?>" class="form-control" rows="3"><?= $v['judul_skripsi'] ?></textarea>
        </div>

      	<div class="form-group">
      		<label>Bidang Penelitian :</label>
			<input id="bidang<?= $no ?>" type="text" class="form-control" value="<?= $v['bidang_penelitian'] ?>">
        </div>

      	<div class="form-group">
      		<label>Perusahaan :</label>
			<input id="perusahaan<?= $no ?>" type="text" class="form-control" value="<?= $v['perusahaan'] ?>">
        </div>

      	<div class="form-group">
      		<label>Kota Perusahaan :</label>
			<input id="kota_perusahaan<?= $no ?>" type="text" class="form-control" value="<?= $v['kota_perusahaan'] ?>">
        </div>

      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        <button type="button" onclick="edit_skripsi('<?= $no ?>','<?= $v['id'] ?>')" class="btn bg-navy btn-flat"><i class="fa fa-fw fa-edit"></i> Edit</button>
      </div>
    </div>

  </div>
</div>
                        <?php $no++; endforeach ?>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>


</section><!-- /.content -->


<script type="text/javascript">

function form_skripsi() {
	var sesi = $("#sesi").val();
	var datas = 'sesi='+sesi;
	var link = '{{ url("akdskripsimhs/formSkripsi/") }}';
    go_page_data(link,datas);
}

function reload() {
    var link = '{{ url("akdskripsimhs/selectSesi/") }}';
    go_page(link);
}

function edit_skripsi(id,id_data) {
	var judul = $("#judul"+id).val();
	var bidang = $("#bidang"+id).val();
	var perusahaan = $("#perusahaan"+id).val();
	var kota_perusahaan = $("#kota_perusahaan"+id).val();
	
	var datas = 'judul='+judul+'&bidang='+bidang+'&perusahaan='+perusahaan+'&kota_perusahaan='+kota_perusahaan;
	var link = '{{ url("akdskripsimhs/editSkripsi/") }}'+id_data;

	$.ajax({
        type: "POST",
        url: link,
        dataType : "json",
        data: datas
    }).done(function( data ) {
    	$('#myModal'+id).modal('hide');
		$('body').removeClass('modal-open');
		$("body").css("padding-right", "0px");
		$('.modal-backdrop').remove();      
        new PNotify({
            title: data.title,
            text: data.text,
            type: data.type
        });
        reload();
    });
}

</script>
