<section class="content-header">
  <h1><button type="button" onclick="back()" class="btn bg-navy btn-flat margin"><i class="fa fa-fw fa-arrow-left"></i> Back</button></h1>
  <ol class="breadcrumb">
    <li><a href="#"><i class="fa fa-dashboard"></i> {{nama_sesi}}</a></li>
  </ol>
</section>

<!-- Main content -->
<section class="content">

  <div class="row">
    <div class="col-md-2"></div>
    <div class="col-md-8">
      <div class="box">
        <div class="box-header with-border">
          <h3 class="box-title">MODE 1 : PILIH PAKET</h3>
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
				<td><a href="javascript:void(0)" onclick="select_mhs_paket('{{v.id}}','{{v.paket_id}}')">{{v.nama_paket}}</a></td>
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
        </div><!-- /.box-body -->
      </div><!-- /.box -->
    </div>

  </div>

  <div class="row">
    <div class="col-md-1"></div>
    <div class="col-md-10">
      <div class="box">
        <div class="box-header with-border">
          <h3 class="box-title">MODE 2 : PILIH KELAS</h3>
        </div><!-- /.box-header -->
        <div class="box-body">
          <table id="" class="table table-bordered table-striped">
            <thead>
              <tr>
                <th style="width: 10px">No</th>
				<th>Kode Mk</th>
				<th>Nama Mk</th>
				<th>Sem.</th>
				<th>SKS</th>
				<th>Kelas</th>
              </tr>
            </thead>
            <tbody>
            
            {% set no=1 %}
            {% for v in mk %}
            <tr>
				<td>{{no}}</td>
				<td>{{v.kode_mk}}</td>
				<td class="text-aqua">
					<a href="#" data-toggle="modal" data-controls-modal="your_div_id" data-backdrop="static" data-keyboard="false" data-target="#myModal{{no}}">{{v.nama}}</a>
					<input type="text" id="kode_mk{{no}}" style="display: none" value="{{v.kode_mk}}">
					<input type="text" id="nama{{no}}" style="display: none" value="{{v.nama}}">
					<input type="text" id="nama_kelas{{no}}" style="display: none" value="{{v.nama_kelas}}">
					<input type="text" id="thn_kur{{no}}" style="display: none" value="{{v.thn_kur}}">
					<input type="text" id="sks{{no}}" style="display: none" value="{{v.sks}}">
					<input type="text" id="semester{{no}}" style="display: none" value="{{v.semester}}">
					<!-- Modal -->
					<div id="myModal{{no}}" class="modal fade text-navy" role="dialog">
					  <div class="modal-dialog">

					    <!-- Modal content-->
					    <div class="modal-content">
					      <div class="modal-header">
					        <button type="button" class="close" data-dismiss="modal">&times;</button>
					        <h4 class="modal-title text-navy">Modal Header</h4>
					      </div>
					      <div class="modal-body">
						    <table class="table">
							    <tbody>
							      <tr>
							        <td>Nomor Mahasiswa :</td>
							        <td><input type="text" class="form-control" id="nomhs{{no}}" placeholder="Enter..."></td>
							        <td></td>
							        <td></td>
							      </tr>
							      <tr class="form-horizontal">
							        <td>Range Nomor Mahasiswa :</td>
							        <td><input type="text" class="form-control" id="range1{{no}}" placeholder="Enter..."></td>
							        <td><label for="inputEmail3" class="col-sm-2 control-label">S/D</label></td>
							        <td><input type="text" class="form-control" id="range2{{no}}" placeholder="Enter..."></td>
							      </tr>
							      <tr>
							        <td>Angkatan :</td>
							        <td><select id="angkatan{{no}}" class="form-control">
								            <option value="">- pilih tahun -</option>
								            {% for a in angkatan %}
								            <option value="{{a.angkatan}}">{{a.angkatan}}</option>
								            {% endfor %}
								        </select>
								    </td>
							        <td></td>
							        <td></td>
							      </tr>
							    </tbody>
							 </table>
					      </div>
					      <div class="modal-footer">
					        <button type="button" onclick="select_mhs('{{no}}')" class="btn btn-success">Cari</button>
					        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
					      </div>
					    </div>

					  </div>
					</div>
				</td>
				<td>{{v.semester}}</td>
				<td>{{v.sks}}</td>
				<td>{{v.nama_kelas}}</td>
            </tr>
            {% set no=no+1 %}
            {% endfor %}

            </tbody>            
          </table><br>
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

function back() {
    var link = '{{ url("akdkrspaket/dafarPaket/") }}';
    go_page(link);
}

function select_mhs_paket(id,paket_id,nama) {
	var sesi = "{{sesi}}";
	var link = '{{ url("akdkrspaket/selectMhsPaket/") }}';
	var datas = 'id='+id+'&nama='+nama+'&paket_id='+paket_id+'&sesi='+sesi;
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

function select_mhs(no) {
	var nomhs = $("#nomhs"+no).val();
	var range1 = $("#range1"+no).val();
	var range2 = $("#range2"+no).val();
	var angkatan = $("#angkatan"+no).val();

	if (nomhs != '' || angkatan != '' || range1 != '' && range2 != '') {
		
		var kode_mk = $("#kode_mk"+no).val();
		var nama = $("#nama"+no).val();
		var nama_kelas = $("#nama_kelas"+no).val();
		var thn_kur = $("#thn_kur"+no).val();
		var sks = $("#sks"+no).val();
		var semester = $("#semester"+no).val();
		var sesi = "{{sesi}}";

		var datas = "nomhs="+nomhs+"&range1="+range1+"&range2="+range2+"&angkatan="+angkatan+"&sesi="+sesi+"&kode_mk="+kode_mk+"&nama="+nama+"&nama_kelas="+nama_kelas+"&thn_kur="+thn_kur+"&sks="+sks+"&semester="+semester;
		var link = '{{ url("akdkrspaket/selectMhs/") }}';
		$('#myModal'+no).modal('hide');
		$('body').removeClass('modal-open');
		$("body").css("padding-right", "0px");
		$('.modal-backdrop').remove();

		go_page_data(link,datas);
	}else{
		new PNotify({
			title: 'Regular Notice',
			text: 'Form Pilih MHS tidak boleh kosong!',
			type:'warning'
		});
	}
	
	
}

</script>