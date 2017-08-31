<section class="content-header">
  <h1>KRS PAKET</h1>
  <ol class="breadcrumb">
    <li><a href="#"><i class="fa fa-dashboard"></i> KRS</a></li>
    <li class="active">Paket</li>
  </ol>
</section>

<!-- Main content -->
<section class="content">
	<div class="row">
	  <div class="col-md-3"></div>
	  <div class="col-md-6">
	    <div class="box">
	        <div class="box-header">
	          <h3 class="box-title">KRS PAKET MAHASISWA</h3>
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
	            <button style="margin: 0;" type="button" onclick="to_krs_input()" class="btn bg-navy btn-flat pull-right"><i class="fa fa-fw fa-edit"></i> Tampilkan</button>
	            </form>
	        </div>
	    </div>
	  </div>
	  <div class="col-md-3"></div>
	</div>

  <div class="row">
    <div class="col-md-2"></div>
    <div class="col-md-8">
      <div class="box">
        <div class="box-header with-border">
          <h3 class="box-title">DAFTAR PAKET</h3>
        </div><!-- /.box-header -->
        <div class="box-body">
          <table id="" class="table table-bordered table-striped">
            <thead>
              <tr>
                <th style="width: 10px">ID</th>
                <th>Nama Paket</th>
                <th>Jml MK</th>
                <th>Jml SKS</th>
              </tr>
            </thead>
            <tbody>
            
            {% set no=1 %}
            {% for v in paket_krs %}
            <tr>
				<td>{{v.id}}</td>
				<td><a href="javascript:void(0)" onclick="lihat_mk_paket('{{v.id}}','{{v.paket_id}}')">{{v.nama_paket}}</a></td>
				<td>{{v.jumlah_mk}}</td>
				{% if v.jumlah_sks != "" %}
				    <td>{{ v.jumlah_sks }}</td>
				{% else %}
				    <td>0</td>
				{% endif %}
            </tr>
            {% set no=no+1 %}
            {% endfor %}

            </tbody>            
          </table><br>
          <button style="margin-right: 10px;" type="button" data-toggle="modal" data-target="#myModal" class="btn bg-green btn-flat pull-right"><i class="fa fa-fw fa-edit"></i> Tambah</button>
        </div><!-- /.box-body -->
      </div><!-- /.box -->
    </div>

  </div>

      
</section><!-- /.content -->

<!-- Modal -->
<div id="myModal" class="modal fade" role="dialog">
  <div class="modal-dialog">

    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">Modal Header</h4>
      </div>
      <div class="modal-body">
        <div class="form-group">
			<label class="text-navy">Nama Paket</label>
			<input type="text" id="nama_paket" class="form-control" placeholder="Nama Paket">
		</div>
      </div>
      <div class="modal-footer">
      <button type="button" onclick="add_paket()" class="btn btn-success">Rekam</button>
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
      </div>
    </div>

  </div>
</div>

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
	var link = '{{ url("akdkrspaket/dafarPaket") }}';
	var data = 'data=data';
    reload_page_data();
}
function lihat_mk_paket(id,paket_id) {
	var link = '{{ url("akdkrspaket/listMkPaket/") }}';
	var datas = 'id='+id+'&paket_id='+paket_id;
    go_page_data(link,datas);
}

function add_paket() {
	var nama_paket = $("#nama_paket").val();

	var datas = "nama_paket="+nama_paket;
	var urel = '{{ url("akdkrspaket/tambahPaket/") }}';
	$.ajax({
		type: "POST",
		url: urel,
		dataType : "json",
		data: datas
	}).done(function( data ) {
		$('#myModal').modal('hide');
		$('body').removeClass('modal-open');
		$("body").css("padding-right", "0px");
		$('.modal-backdrop').remove();
		back();
	});
}

function to_krs_input() {
	var sesi = $("#sesi").val();
	var link = '{{ url("akdkrspaket/formSelectPaket/") }}';
	var datas = 'sesi='+sesi;
    go_page_data(link,datas);
}

</script>