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
<p class="lead" style="text-align: center;">Setting Tim</p>
    <div class="col-lg-3"></div>

    <div class="col-md-6">
	    <div class="box">
	        <div class="box-header">
	          <h3 class="box-title">Periode</h3>
	        </div><!-- /.box-header -->
	        <div class="box-body">
	        <form method="post">
	            <table class="table table-condensed">
	              <tbody>
	                <tr>
	                  <td style="padding: 11px 6px;width: 100px; background: #eee" class="text-left"><b>Periode :</b></td>
	                  	<td>
		                  	<div class="row">
			                    <div class="col-lg-3">
			                      <div class="input-group">
			                        <input type="text" class="form-control" name="tgl" placeholder="Tanggal">
			                      </div><!-- /input-group -->
			                    </div><!-- /.col-lg-6 -->
			                    <div class="col-lg-6">
			                        <select name="bln" class="form-control">
			                        	<?php foreach ($bulan as $key => $v): ?>
				                        <option value="<?= $key ?>"><?= $v ?></option>
			                        	<?php endforeach ?>
				                    </select>
			                    </div><!-- /.col-lg-6 -->
			                    <div class="col-lg-3">
			                      <div class="input-group">
			                        <input type="text" class="form-control" name="thn" placeholder="Tahun">
			                      </div><!-- /input-group -->
			                    </div><!-- /.col-lg-6 -->
			                </div>
	                   	</td>                  
	                </tr>
	              </tbody>
	            </table>
	            <button style="margin: 0;" type="button" onclick="dataPeriodeSkripsi()" class="btn bg-navy btn-flat pull-right"><i class="fa fa-fw fa-search"></i> Tampilkan</button>
	        </form>
	        </div>
	    </div>
	 </div>

    </div>

    <div class="row"> 
    <div class="col-md-12 data_mhs">    
      <div class="col-md-5"></div>
      <div class="col-md-2">
          <button style="margin: 0;" type="button" onclick="tambah_setting()" class="btn bg-navy btn-flat pull-right"><i class="fa fa-fw fa-edit"></i> Tambah</button>
      </div>
	</div>
    </div>


</section><!-- /.content -->


<script type="text/javascript">

function dataPeriodeSkripsi() {
	var link = '{{ url("akdsettingtim/dataPeriodeSkripsi/") }}';
	var datas = $('form').serialize();
    // go_page_data(link,datas);
    $.ajax({
		type: "POST",
		url: link,
		dataType : "html",
		data: datas
    }).done(function( data ) {
		$('.data_mhs').html(data);
    });
}

function tambah_setting() {
	var link = '{{ url("akdsettingtim/formTambah/") }}';
    go_page(link);
}
</script>
