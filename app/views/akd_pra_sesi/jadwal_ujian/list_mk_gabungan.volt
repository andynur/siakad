<section class="content-header">
  <h1>
    <button type="button" onclick="back('{{sesi}}','{{id}}','{{ujian_id}}')" class="btn bg-navy btn-flat margin"><i class="fa fa-fw fa-arrow-left"></i> Back</button>
  </h1>
  <ol class="breadcrumb">
    <li><span class="text-NAVY"><?= $defujian['nama_long'] ?> - </span> <?= $sesi_nama ?></li>
  </ol>
</section>

<!-- Main content -->
<section class="content">
  <div class="row">

    <div class="col-md-12">
      <div class="box">
      	<div class="box-header with-border" style="text-align: center;">
          <h2 class="box-title text-navy">Tambah Jadwal Ujian Gabungan Mata kuliah</h2>
        </div><!-- /.box-header -->
        <div class="box-body">
        <form method="post">
        <input type="text" name="sesi" style="display:none;" value="{{sesi}}">
        <input type="text" name="id" style="display:none;" value="{{id}}">
        <input type="text" name="ujian_id" style="display:none;" value="{{ujian_id}}">
          <table id="asd" class="table table-bordered table-striped">
            <thead>
              <tr>
                <th style="width: 10px">No</th>
                <th>Pilih</th>
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
              <td>
              <input type="checkbox" name="pilihmk_{{no}}" value="{{sesi}}#{{ujian_id}}#{{v.thn_kur}}#{{v.kode_mk}}#{{v.nama_kelas}}#{{v.nama}}#{{v.jml_mhs}}">
              </td>
              <td>{{v.thn_kur}}</td>
              <td>{{v.kode_mk}}</td>
              <td>  {{v.nama}} </td>             
              <td>{{v.nama_kelas}}</td>             
              <td>{{v.namadosen1}}</td>                       
            </tr>
            {% set no=no+1 %}
            {% endfor %}

            </tbody>            
          </table>
        </form>
          <button type="button" onclick="add_jadwal_gab()" class="btn bg-navy btn-flat margin pull-right"><i class="fa fa-fw fa-save"></i> Simpan</button>
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
	var id = "{{id}}";
	var ujian_id = "{{ujian_id}}";
	var sesi = "{{sesi}}";
	var link = '{{ url("akdjadwalujian/listMkGabungan/") }}';
	var datas = "id="+id+"&ujian_id="+ujian_id+"&sesi="+sesi;
	reload_page_data(link,datas);
}

function back(sesi,id,ujian_id) {
	var link = '{{ url("akdjadwalujian/daftarUjian/") }}';
    var datas = "sesi="+sesi;
    go_page_data(link,datas);
}

function add_jadwal_gab() {
	var mk =[];
	$('input[type=checkbox]:checked').each(function(index){
	  mk.push($(this).val());
	});
	var datas = $('form').serialize();

	if (mk.length == 0) {
		new PNotify({
			title: 'Regular Notice',
			text: 'Pilih Mata Kuliah yang akan di Gabung',
			type:'warning'
		});
    }else{
		var link = '{{ url("akdjadwalujian/gabPilihRuang/") }}';
    	go_page_data(link,datas);
    }

}


</script>