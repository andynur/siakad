<section class="content-header">
  <h1>
    <button type="button" onclick="back('{{sesi}}','{{id}}','{{ujian_id}}')" class="btn bg-navy btn-flat margin"><i class="fa fa-fw fa-arrow-left"></i> Back</button>
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
        <div class="box-header with-border" style="text-align: center;">
          <h2 class="box-title text-navy">Tambah Jadwal Ujian Per Mata kuliah</h2>
        </div><!-- /.box-header -->
        <div class="box-header with-border">
          <h3 class="box-title"><span class="text-aqua"><?= $defujian['nama_long'] ?></span> <?= $sesi_nama ?></h3>
        </div><!-- /.box-header -->
        <div class="box-body">
        <form method="post">
          <table id="asd" class="table table-bordered table-striped">
            <thead>
              <tr>
                <th style="width: 10px">No</th>
                <th>Thn Kur</th>
                <th>Kode MK</th>
                <th>Nama MK</th>
                <th>Kelas</th>
                <th>Dosen</th>
              </tr>
            </thead>
            <tbody>

            
            {% set no=1 %}
            {% for v in list_mk %}
            <tr>
              <td>{{no}}</td>
              <td>{{v.thn_kur}}</td>
              <td>{{v.kode_mk}}</td>
              <td> <a href="javascript:void(0)" onclick="add_jadwal('{{sesi}}','{{id}}','{{ujian_id}}','{{v.thn_kur}}','{{v.kode_mk}}','{{v.nama_kelas}}')"> {{v.nama}} </a></td>             
              <td>{{v.nama_kelas}}</td>             
              <td>{{v.namadosen1}}</td>                       
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



function back(sesi,id,ujian_id) {
	var link = '{{ url("akdjadwalujian/daftarUjian/") }}';
    var datas = "sesi="+sesi;
    go_page_data(link,datas);
}

function add_jadwal(sesi,id,ujian_id,thn_kur,kode_mk ,nama_kelas) {
	var link = '{{ url("akdjadwalujian/addJadwalForm/") }}';
    var datas = "id="+id+"&ujian_id="+ujian_id+"&sesi="+sesi+"&thn_kur="+thn_kur+"&kode_mk="+kode_mk+"&nama_kelas="+nama_kelas;
    go_page_data(link,datas);
}


</script>