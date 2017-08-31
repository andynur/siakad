<table id="" class="table table-bordered table-striped">
    <thead>
		<tr>
			<th style="width: 10px">No</th>
			<th>Kode Mk</th>
			<th>Nama Mk</th>
			<th>Sem.</th>
			<th>SKS</th>
			<th>W/P</th>
			<th>KLP</th>
			<th>Urut</th>
		</tr>
    </thead>
    <tbody>
    
   	{% set no=1 %}
    {% for v in mk %}
		<tr>
			<td>{{no}}</td>
			<td class="text-center">{{v.kode_mk}}</td>
			<td class="text-aqua">
				<a href="#" data-toggle="modal" data-target="#myModal{{no}}">{{v.nama}}</a>
				<!-- Modal -->
				<div id="myModal{{no}}" class="modal fade" role="dialog">
				  <div class="modal-dialog">

				    <!-- Modal content-->
				    <div class="modal-content">
				      <div class="modal-header">
				        <button type="button" class="close" data-dismiss="modal">&times;</button>
				        <h4 class="modal-title text-navy">Modal Header</h4>
				      </div>
				      <div class="modal-body">
					    <div class="form-group">
	                      <label class="text-navy">Nama Kelas</label>
	                      <input type="text" id="nama_kelas{{no}}" class="form-control" value="A">
	                      <input type="text" id="thn_kur{{no}}" class="form-control" style="display:none;" value="{{v.thn_kur}}">
	                      <input type="text" id="kode_mk{{no}}" class="form-control" style="display:none;" value="{{v.kode_mk}}">
	                      <input type="text" id="paket_id{{no}}" class="form-control" style="display:none;" value="{{paket_id}}">
	                      <input type="text" id="sks{{no}}" class="form-control" style="display:none;" value="{{v.sks}}">
	                    </div>
				      </div>
				      <div class="modal-footer">
				        <button type="button" onclick="add_mk_paket_krs('{{no}}')" class="btn btn-success">Rekam</button>
				        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
				      </div>
				    </div>

				  </div>
				</div>
			</td>
			<td class="text-center">{{v.semester}}</td>
			<td class="text-center">{{v.sks}}</td>
			<td class="text-center">{{v.jenis}}</td>
			<td class="text-center">{{v.kelompok}}</td>
			<td class="text-center">{{v.urut}}</td>
		</tr>
    {% set no=no+1 %}
    {% endfor %}

    </tbody>            
</table>

<script type="text/javascript">

function add_mk_paket_krs(no) {
	var nama_kelas = $("#nama_kelas"+no).val();
	var thn_kur = $("#thn_kur"+no).val();
	var kode_mk = $("#kode_mk"+no).val();
	var paket_id = $("#paket_id"+no).val();
	var sks = $("#sks"+no).val();

	var datas = "nama_kelas="+nama_kelas+"&thn_kur="+thn_kur+"&kode_mk="+kode_mk+"&paket_id="+paket_id+"&sks="+sks;
	var urel = '{{ url("akdkrspaket/tambahMkPaket/") }}';
	$.ajax({
		type: "POST",
		url: urel,
		dataType : "json",
		data: datas
	}).done(function( data ) {
		$('#myModal'+no).modal('hide');
		$('body').removeClass('modal-open');
		$("body").css("padding-right", "0px");
		$('.modal-backdrop').remove();
		back();
	});
}


</script>