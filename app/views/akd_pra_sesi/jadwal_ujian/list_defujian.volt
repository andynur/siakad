<section class="content-header">
  <h1>
   <button type="button" onclick="back()" class="btn bg-navy btn-flat margin"><i class="fa fa-fw fa-arrow-left"></i> Back</button>
  </h1>
  <ol class="breadcrumb">
    <li><a href="#"><i class="fa fa-dashboard"></i> Setup</a></li>
    <li class="active">Manajemen</li>
  </ol>
</section>

<!-- Main content -->
<section class="content">
  <div class="row">
    <!-- left column -->
    <div class="col-md-4">
      <div class="box">
        <div class="box-header with-border">
          <h3 class="box-title">Form Session</h3>
        </div><!-- /.box-header -->
        <!-- form start -->
        <div class="form">
          <div class="box-body">
            <div class="row">
              <div class="col-lg-8">
                  <label>Tahun Akademik</label>
                  <input type="text" id="thn_akd" value="asd" class="form-control">
              </div><!-- /.col-lg-6 -->
            </div><br>

            <div class="row">
              <div class="col-lg-10">
                  <label>Nama Sesi</label>
                  <select class="form-control" id="session_id">
                      <option value="asd">asd</option>
                  </select>
              </div>
            </div>

          </div><!-- /.box-body -->
          <div class="box-footer">
            <button type="submit" onclick="add_sesi()" class="btn btn-info pull-right">Baru</button>
          </div><!-- /.box-footer -->
        </div>
      </div><!-- /.box -->
    </div>


    <div class="col-md-8">
      <div class="box">
        <div class="box-header">
          <h3 class="box-title">Data Table With Full Features</h3>
        </div><!-- /.box-header -->
        <div class="box-body">
          <table id="" class="table table-bordered table-striped">
            <thead>
              <tr>
                <th style="width: 10px">No</th>
                <th>Nama Ujian</th>
                <th>New</th>
              </tr>
            </thead>
            <tbody>
            
            {% set no=1 %}
            {% for v in defujian %}

            <tr>
              <td>{{no}}</td>
              <td><a href="javascript:void(0)" onclick="list_mk('{{v.id}}','{{v.ujian_id}}','{{sesi}}')">{{v.nama_long}}</a></td>
              <td><a href="javascript:void(0)" onclick="list_mk_gab('{{v.id}}','{{v.ujian_id}}','{{sesi}}')">Buat Jadwal Gabungan</a></td>
            </tr>

            {% set no=no+1 %}
            {% endfor %}

            </tbody>            
          </table>
        </div><!-- /.box-body -->
      </div><!-- /.box -->
    </div>
  </div>
      
</section><!-- /.content -->

<script type="text/javascript">

$(function () {
    $('[data-toggle="tooltip"]').tooltip()
		$(".select2").select2();

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
	var link = '{{ url("akdjadwalujian/jaduji/") }}';
    go_page_data(link);
}

function add_sesi() {
    var thn_akd = $("#thn_akd").val();
    var session_id = $("#session_id").val();

    var datas = "thn_akd="+thn_akd+"&session_id="+session_id;
    var urel = '{{ url("manajemensesi/addSesi") }}';
    $.ajax({
       type: "POST",
       url: urel,
       dataType : "json",
       data: datas
    }).done(function( data ) {
      	new PNotify({
	      title: data.title,
	      text: data.text,
	      type: data.type
	    });
    	reload_page2('manajemensesi/manSesi');
    });
}

function list_mk(id,ujian_id,sesi) {
  var link = '{{ url("akdjadwalujian/listmk/") }}';
    var datas = "id="+id+"&ujian_id="+ujian_id+"&sesi="+sesi;
    go_page_data(link,datas);
}

function list_mk_gab(id,ujian_id,sesi) {
	var link = '{{ url("akdjadwalujian/listMkGabungan/") }}';
    var datas = "id="+id+"&ujian_id="+ujian_id+"&sesi="+sesi;
    go_page_data(link,datas);
}
</script>