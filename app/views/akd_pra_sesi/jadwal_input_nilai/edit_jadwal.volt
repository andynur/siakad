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
          <h3 class="box-title"><span class="text-green">{{kode_mk}}</span> {{nama}}</h3>
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
                  <td><button style="margin: 0;" type="button" onclick="edit_jadwal_input('{{id}}')" class="btn bg-navy btn-flat  pull-right"><i class="fa fa-fw fa-edit"></i> Reset</button></td>
                </tr>
              </tbody>
            </table>
            </form>
        </div>
    </div>
  </div>
  <div class="col-md-3"></div>
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
  var link = '{{ url("manajemensesi/jadwalInputNilai/") }}';
  go_page_data(link,datas);
}


function edit_jadwal_input(id) {
	var datas = $('form').serialize();
	var link = '{{ url("manajemensesi/submitEditJadwal/") }}'+id;
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