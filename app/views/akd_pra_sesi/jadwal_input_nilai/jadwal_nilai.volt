<section class="content-header">
  <h1>
    <button type="button" onclick="back('{{thn_akd}}','{{session_id}}')" class="btn bg-navy btn-flat margin"><i class="fa fa-fw fa-arrow-left"></i> Back</button>
  </h1>
  <ol class="breadcrumb">
    <li><a href="#"><i class="fa fa-dashboard"></i> Setup</a></li>
    <li class="">Jadwal</li>
    <li class="active">Input Nilai</li>
  </ol>
</section>

<!-- Main content -->
<section class="content">

<div class="row">
  <div class="col-md-3"></div>
  <div class="col-md-6">
    <div class="box">
        <div class="box-header">
          <h3 class="box-title">Reset All Jadwal Mata Kuliah</h3>
        </div><!-- /.box-header -->
        <div class="box-body">
        <form method="post">
            <table class="table table-condensed">
              <tbody>
                <tr>
                  <td style="padding: 11px 6px;width: 100px; background: #eee" class="text-left"><b>Reset Awal :</b></td>
                  	<td>
	                  	<div class="input-group">
	                      <div class="input-group-addon">
	                        <i class="fa fa-calendar"></i>
	                      </div>
	                      <input name="start" type="text" class="form-control pull-right" id="tgl_picker">
	                    </div><!-- /.input group -->
                   	</td>                
                  	<td>
	                	<div class="bootstrap-timepicker">
		                  	<div class="input-group">
		                      <div class="input-group-addon">
		                        <i class="fa fa-clock-o"></i>
		                      </div>
		                      <input name="start_time" type="text" class="form-control pull-right timepicker">
		                    </div
	                    </div>
                   	</td>  
                </tr>
                <tr>
                  <td style="padding: 11px 6px;width: 100px; background: #eee" class="text-left"><b>Reset Akhir :</b></td>
                  	<td>
	                  	<div class="input-group">
	                      <div class="input-group-addon">
	                        <i class="fa fa-calendar"></i>
	                      </div>
	                      <input name="end" type="text" class="form-control pull-right" id="tgl_picker2">
	                    </div><!-- /.input group -->
                   	</td>                
                  	<td>
	                	<div class="bootstrap-timepicker">
		                  	<div class="input-group">
		                      <div class="input-group-addon">
		                        <i class="fa fa-clock-o"></i>
		                      </div>
		                      <input name="end_time" type="text" class="form-control pull-right timepicker2">
		                    </div
	                    </div>
                   	</td>  
                </tr>
                <tr>
                  <td></td>
                  <td></td>
                  <td><button style="margin: 0;" type="button" onclick="reset_jadwal_nilai()" class="btn bg-navy btn-flat pull-right"><i class="fa fa-fw fa-edit"></i> Reset</button></td>
                </tr>
              </tbody>
            </table>
            </form>
        </div>
    </div>
  </div>
  <div class="col-md-3"></div>
</div>

  <div class="row">
    <div class="col-md-1"></div>
    <div class="col-md-10">
      <div class="box">
        <div class="box-header with-border">
          <h3 class="box-title">SET Kapasitas Kelas</h3>
        </div><!-- /.box-header -->
        <div class="box-body">
        <form method="post">
         	<input type="text" id="thn_akd" name="thn_akd" value="{{thn_akd}}" style="display: none;">
        	<input type="text" id="session_id" name="session_id" value="{{session_id}}" style="display: none;">
          <table id="" class="table table-bordered">
            <thead>
              <tr>
                <th style="width: 10px">No</th>
                <th>Thn Kur</th>
                <th>Kode</th>
                <th>Nama</th>
                <th>Kelas</th>
                <th>Dosen</th>
              </tr>
            </thead>
            <tbody>            
            {% set no=1 %}
            {% for v in mk %}
            <tr class="<?= $class ?>">
              <td>{{no}}</td>
              <td>{{v.thn_kur}}</td>
              <td>{{v.kode_mk}}</td>
              <td><a href="javascript:void(0)" onclick="edit_jadwal('{{thn_akd}}','{{session_id}}','{{v.id}}','{{v.kode_mk}}','{{v.nama}}')">{{v.nama}}</a></td>
              <td>{{v.nama_kelas}}</td>
              <td>{{v.dosen}}</td>
            </tr>                   
            {% set no=no+1 %}
            {% endfor %}

            </tbody>            
          </table>
        </form>

        </div><!-- /.box-body -->
      </div><!-- /.box -->
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

    $("#tgl_picker").datepicker();
	$("#tgl_picker2").datepicker();

	$("#tgl_picker").datepicker( "setDate" , "{{start}}" );
	$("#tgl_picker2").datepicker( "setDate" , "{{end}}" );

		$(".timepicker").timepicker({
		showInputs: false,
		defaultTime: '{{start_time}}'
	});
	$(".timepicker2").timepicker({
		showInputs: false,
		defaultTime: '{{end_time}}'
	});
});

function reload() {
  var thn_akd = "{{thn_akd}}";
  var session_id = "{{session_id}}";
  var datas = "thn_akd="+thn_akd+"&session_id="+session_id;
  var link = '{{ url("manajemensesi/jadwalInputNilai/") }}';
  reload_page_data(link,datas);
}

function back(thn_akd,session_id) {
  var datas = "thn_akd="+thn_akd+"&session_id="+session_id;
  var link = '{{ url("manajemensesi/viewSession/") }}';
  go_page_data(link,datas);
}

function edit_jadwal(thn_akd,session_id,id,kode_mk,nama) {
  var datas = "thn_akd="+thn_akd+"&session_id="+session_id+"&id="+id+"&kode_mk="+kode_mk+"&nama="+nama;
  var link = '{{ url("manajemensesi/editJadwal/") }}';
  go_page_data(link,datas);
}


function reset_jadwal_nilai() {
	var datas = $('form').serialize();
	var link = '{{ url("manajemensesi/resetJadwal/") }}';
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
		reload();

    });
}


</script>