<section class="content-header">
  <h1>
    Manajemen Sesi
    <small>it all starts here</small>
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
                  <input type="text" id="thn_akd" value="<?= date('Y'); ?>/<?= date('Y')+1; ?>" class="form-control">
              </div><!-- /.col-lg-6 -->
            </div><br>

            <div class="row">
              <div class="col-lg-10">
                  <label>Nama Sesi</label>
                  <select class="form-control" id="session_id">
                    {% for v in sesi %}
                      <option value="{{v.session_cd}}">{{v.nama_session}}</option>
                    {% endfor %}
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
          <table id="example2" class="table table-bordered table-striped">
            <thead>
              <tr>
                <th style="width: 10px">No</th>
                <th>Nama Sesi</th>
                <th>Tanggal Mulai</th>
                <th>Tanggal Akhir</th>
                <th>Status</th>
              </tr>
            </thead>
            <tbody>
            
            {% set no=1 %}
            {% for v in man_sesi %}
            <tr>
              <td>{{no}}</td>
              <td><a href="javascript:void(0)" onclick="view_session('{{v.thn_akd}}','{{v.session_id}}')">{{v.nama}} {{ helper.format_thn_akd(v.thn_akd) }}</a></td>
              <td>{{v.begin_dt}}</td>
              <td>{{v.end_dt}}</td>
              <td>Aktif</td>
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

function view_session(thn_akd,session_id) {
	var link = '{{ url("manajemensesi/viewSession/") }}';
    var datas = "thn_akd="+thn_akd+"&session_id="+session_id;
    go_page_data(link,datas);
}
</script>