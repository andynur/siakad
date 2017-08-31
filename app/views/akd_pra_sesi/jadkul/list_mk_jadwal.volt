<section class="content-header">
  <h1>
    <button type="button" onclick="back()" class="btn bg-navy btn-flat margin"><i class="fa fa-fw fa-arrow-left"></i> Back</button>
  </h1>
  <ol class="breadcrumb">
    <li><a href="#"><i class="fa fa-dashboard"></i> Jadwal</a></li>
    <li class="">Kuliah</li>
    <li class="active">Reguler</li>
  </ol>
</section>

<!-- Main content -->
<section class="content">
  <div class="row">

    <div class="col-md-1"></div>
    <div class="col-md-10">
      <div class="box">
        <div class="box-header with-border">
          <h3 class="box-title">List Matakuliah</h3>
        </div><!-- /.box-header -->
        <div class="box-body">
        <form method="post">
         	<input type="text" id="thn_akd" name="thn_akd" value="{{thn_akd}}" style="display: none;">
        	<input type="text" id="session_id" name="session_id" value="{{session_id}}" style="display: none;">
          <table id="asd" class="table table-bordered table-striped">
            <thead>
              <tr>
                <th style="width: 10px">No</th>
                <th>Thn Kur</th>
                <th>Kode MK</th>
                <th>Nama MK</th>
                <th>Kelas</th>
                <th>Sem</th>
                <th>Kap</th>
                <th>Dosen</th>
              </tr>
            </thead>
            <tbody>

            
            {% set no=1 %}
            {% for v in mk %}

            <tr>
              <td>{{no}}</td>
              <td>{{v.thn_kur}}</td>
              <td>{{v.kode_mk}}</td>
              <td><a href="javascript:void(0)" onclick="lihat_jadwal('{{v.thn_akd}}','{{v.session_id}}','{{v.thn_kur}}','{{v.kode_mk}}','{{v.nama_kelas}}','{{v.nama}}','{{v.sks}}','{{v.kapasitas}}','{{v.id}}','{{v.semester}}')">{{v.nama}}</a></td>             
              <td>{{v.nama_kelas}}</td>             
              <td>{{v.semester}}</td>             
              <td>{{v.kapasitas}}</td>             
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
	var link = '{{ url("akdjadkul/jadkulmg/") }}';
    go_page(link);
}

function lihat_jadwal(thn_akd,session_id,thn_kur,kode_mk,nama_kelas,nama,sks,kapasitas,id,semester) {
	var link = '{{ url("akdjadkul/lihatJadwal/") }}';
    var datas = "thn_akd="+thn_akd+"&session_id="+session_id+"&thn_kur="+thn_kur+"&kode_mk="+kode_mk+"&nama_kelas="+nama_kelas+"&nama="+nama+"&sks="+sks+"&kapasitas="+kapasitas+"&id_mkkpkl="+id+"&semester="+semester;
    go_page_data(link,datas);
}

</script>