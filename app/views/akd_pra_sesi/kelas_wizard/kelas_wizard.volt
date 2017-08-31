<section class="content-header">
  <h1>
    <button type="button" onclick="back('{{thn_akd}}','{{session_id}}')" class="btn bg-navy btn-flat margin"><i class="fa fa-fw fa-arrow-left"></i> Back</button>
  </h1>
  <ol class="breadcrumb">
    <li><a href="#"><i class="fa fa-dashboard"></i> Setup</a></li>
    <li class="active">Kelas Wizard</li>
  </ol>
</section>

<!-- Main content -->
<section class="content">
  <div class="row">
    <!-- left column -->
    <div class="col-md-3">
      <div class="box">
        <div class="box-header with-border">
          <h3 class="box-title">PILIH KURIKULUM</h3>
        </div><!-- /.box-header -->
        <!-- form start -->
        <div class="form">
	        <form id="add_data" method="post">
	          <div class="box-body">
	            <div class="row">
	              <div class="col-md-1"></div>
	              <div class="col-md-10">
	                  <label>Tahun Kur</label>
	                  <select name="thn_kurikulum" id="thn_kur" class="form-control">   
	                	{% for v in thn %}               	
	                    	<option value="{{v.thn_kur}}">{{v.thn_kur}}</option>  
	                	{% endfor %}                                  
                    </select>
	              </div>
	            </div><br>

	          </div><!-- /.box-body -->
	          <div class="box-footer">
	            <button type="button" onclick="cari()" class="btn bg-navy btn-flat pull-right">Step 1</button>
	          </div><!-- /.box-footer -->
	        </form>
        </div>
      </div><!-- /.box -->
    </div>


    <div class="col-md-9">
      <div class="box">
        <div class="box-header">
          <h3 class="box-title">KELAS KULIAH YANG DITAWARKAN</h3>
        </div><!-- /.box-header -->
        <div class="box-body">
          <table id="" class="table table-bordered table-striped">
            <thead>
              <tr>
                <th style="width: 10px">No</th>
                <th>Kur.</th>
                <th>Kode MK</th>
                <th>Nama</th>
                <th>Kelas</th>
              </tr>
            </thead>
            <tbody>
            
            {% set no=1 %}
            {% for v in mkkpkl %}
            <tr>
              <td>{{no}}</td>
              <td>{{v.thn_kur}}</td>
              <td>{{v.kode_mk}}</td>
              <td>{{v.nama}}</td>
              <td>{{v.nama_kelas}}</td>
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
  var thn_akd = $('#thn_akd').val();
  var session_id = $('#session_id').val();
  var datas = "thn_akd="+thn_akd+"&session_id="+session_id;
  var link = '{{ url("manajemensesi/kelasWizard/") }}';
  reload_page_data(link,datas);
}


function back(thn_akd,session_id) {
	var link = '{{ url("manajemensesi/viewSession/") }}';
    var datas = "thn_akd="+thn_akd+"&session_id="+session_id;
    go_page_data(link,datas);
}

function cari() {
  var thn_akd = "{{thn_akd}}";
  var session_id = "{{session_id}}";
  var thn_kur = $('#thn_kur').val();
  var datas = "thn_akd="+thn_akd+"&session_id="+session_id+"&thn_kur="+thn_kur;
  var link = '{{ url("manajemensesi/selectKur/") }}';
  go_page_data(link,datas);
}

</script>