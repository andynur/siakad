<section class="content-header">
  <h1>
    <button type="button" onclick="back('{{thn_akd}}','{{session_id}}')" class="btn bg-navy btn-flat margin"><i class="fa fa-fw fa-arrow-left"></i> Back</button>
  </h1>
  <ol class="breadcrumb">
    <li><a href="#"><i class="fa fa-dashboard"></i> Setup</a></li>
    <li class="">Ruang</li>
    <li class="active">Aktif</li>
  </ol>
</section>

<!-- Main content -->
<section class="content">
  <div class="row">

    <div class="col-md-1"></div>
    <div class="col-md-10">
      <div class="box">
        <div class="box-header with-border">
          <h3 class="box-title">SET Kapasitas Kelas</h3>
        </div><!-- /.box-header -->
        <div class="box-body">
        <?php //echo "<pre>".print_r($cek_mkkpkl,1)."</pre>"; ?>
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
                <th>Jumlah Dosen</th>
              </tr>
            </thead>
            <tbody>            
            {% set no=1 %}
            {% for v in mk %}

            <tr>
              <td>{{no}}</td>
              <td>{{v.thn_kur}}</td>
              <td>{{v.kode_mk}}</td>
              <td><a href="javascript:void(0)" onclick="dosen_pengajar('{{thn_akd}}','{{session_id}}','{{v.id}}','{{v.kode_mk}}','{{v.nama}}','{{v.nama_kelas}}','{{v.sks}}')">{{v.nama}}</a></td>
              <td>{{v.nama_kelas}}</td>
              <td>{{v.jml_dosen}}</td>      
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
  });

function reload() {
  var thn_akd = $('#thn_akd').val();
  var session_id = $('#session_id').val();
  var datas = "thn_akd="+thn_akd+"&session_id="+session_id;
  var link = '{{ url("manajemensesi/setDosen/") }}';
  reload_page_data(link,datas);
}

function back(thn_akd,session_id,thn_kur) {
  var datas = "thn_akd="+thn_akd+"&session_id="+session_id;
  var link = '{{ url("manajemensesi/viewSession/") }}';
  go_page_data(link,datas);
}


function dosen_pengajar(thn_akd,session_id,id,kode_mk,nama,nama_kelas,sks) {
  var datas = "thn_akd="+thn_akd+"&session_id="+session_id+"&id="+id+"&kode_mk="+kode_mk+"&nama="+nama+"&nama_kelas="+nama_kelas+"&sks="+sks;
  var link = '{{ url("manajemensesi/dosenPengajar/") }}';
  go_page_data(link,datas);
}



</script>