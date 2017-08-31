<section class="content-header">
  <h1>
    Dosen Pembimbing
    <small>it all starts here</small>
  </h1>
  <ol class="breadcrumb">
    <li><a href="#"><i class="fa fa-dashboard"></i> Setup</a></li>
    <li class="active">Pembimbing</li>
  </ol>
</section>

<!-- Main content -->
<section class="content">
  <div class="row">
    <!-- left column -->
    
    <div class="col-md-2"></div>
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
                <th style="">NIP</th>
                <th>Nama</th>
                <th>JML MHS</th>
              </tr>
            </thead>
            <tbody>
            
            {% set no=1 %}
            {% for v in dosen %}
            <tr>
              <td>{{no}}</td>
              <td>{{v.nip}}</td>
              <td>
              {% if v.gelar_dpn != '' %}
              		<a href="javascript:void(0)" onclick="dsn_wali('{{v.nip}}')">{{v.gelar_dpn}}. {{v.nama}}</a>
              	{% else %}
              		<a href="javascript:void(0)" onclick="dsn_wali('{{v.nip}}')">{{v.nama}}</a>
              	{% endif %}
              </td>
              <td>{{v.jml_mhs}}</td>
            </tr>
            {% set no=no+1 %}
            {% endfor %}

            </tbody>            
          </table>
        </div><!-- /.box-body -->
      </div><!-- /.box -->
    </div>
    <div class="col-md-2"></div>
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

function dsn_wali(nip) {
	var link = '{{ url("akddosenwali/dosenWali/") }}'+nip;
  go_page(link);
}


  
</script>