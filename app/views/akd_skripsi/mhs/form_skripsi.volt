<section class="content-header">
    <h1><button type="button" onclick="back()" class="btn bg-navy btn-flat margin"><i class="fa fa-fw fa-arrow-left"></i> Back</button></h1>
    <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i> Mahasiswa</a></li>
        <li class="active">Skripsi</li>
    </ol>
</section>

<!-- Main content -->
<section class="content">

    <!-- row -->
    <div class="row">
<p class="lead" style="text-align: center;">Pengajuan Skripsi {{sesi_nama}}</p>
    <div class="col-lg-2"></div>

    <div class="col-md-8">
	    <div class="box">
	        <div class="box-header">
	          <h3 class="box-title">Form Input</h3>
	        </div><!-- /.box-header -->
	        <div class="box-body">
	        <form method="post">
	        <input name="sesi" type="text" value="{{sesi}}" style="display:none">
	            <table class="table table-condensed">
	              <tbody>
	                <tr>
	                  <td style="padding: 11px 6px;width: 140px; background: #eee" class="text-left"><b>Judul Skripsi :</b></td>
	                  	<td>
		                  	<div class="form-group">
								<textarea name="judul" class="form-control" rows="3" placeholder="Judul ..."></textarea>
		                    </div>
	                   	</td>                  
	                </tr>
	                <tr>
	                  <td style="padding: 11px 6px;width: 140px; background: #eee" class="text-left"><b>Bidang Penelitian :</b></td>
	                  	<td>
		                  	<div class="form-group">
								<input name="bidang" type="text" class="form-control" placeholder="Bidang Penelitian...">
		                    </div>
	                   	</td>                  
	                </tr>
	                <tr>
	                  <td style="padding: 11px 6px;width: 140px; background: #eee" class="text-left"><b>Perusahaan :</b></td>
	                  	<td>
		                  	<div class="form-group">
								<input name="perusahaan" type="text" class="form-control" placeholder="Perusahaan ...">
		                    </div>
	                   	</td>                  
	                </tr>
	                <tr>
	                  <td style="padding: 11px 6px;width: 140px; background: #eee" class="text-left"><b>Kota Perusahaan :</b></td>
	                  	<td>
		                  	<div class="form-group">
								<input name="kota_perusahaan" type="text" class="form-control" placeholder="Kota ...">
		                    </div>
	                   	</td>                  
	                </tr>
	              </tbody>
	            </table>
	            <button style="margin: 0;" type="button" onclick="add_data_skripsi()" class="btn bg-navy btn-flat pull-right"><i class="fa fa-fw fa-edit"></i> Simpan</button>
	        </form>
	        </div>
	    </div>
	 </div>

    </div>

    <div class="row">
      <div class="col-md-12 data_mhs">
          
      </div>
    </div>


</section><!-- /.content -->


<script type="text/javascript">

function to_krs_input() {
	var sesi = $("#sesi").val();
	var datas = 'sesi='+sesi;
	var link = '{{ url("akdskripsimhs/formSkripsi/") }}';
    go_page_data(link,datas);
}

function back() {
    var link = '{{ url("akdskripsimhs/selectSesi/") }}';
    go_page(link);
}

function add_data_skripsi(id) {
    var datas = $('form').serialize();
    var link = '{{ url("akdskripsimhs/addPengajuan/") }}'+id;
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
        back();
    });
}

</script>
