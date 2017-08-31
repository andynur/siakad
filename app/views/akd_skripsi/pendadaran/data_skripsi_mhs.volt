<section class="content-header">
  <h1>
    <button type="button" onclick="back()" class="btn bg-navy btn-flat"><i class="fa fa-fw fa-arrow-left"></i> Back</button>
  </h1>
  <ol class="breadcrumb">
    <li><a href="#"><i class="fa fa-dashboard"></i> Mahasiswa</a></li>
    <li class="active">Skripsi</li>
  </ol>
</section>

<!-- Main content -->
<section class="content">
  <div class="row">

    <div class="col-md-12">
      <div class="box">
        <div class="box-header with-border">
          <h3 class="box-title">Nama : ( {{nomhs}} ) {{nama}} | Angkatan : {{angkatan}}</h3>
          <button type="button" onclick="tambah('{{nama}}','{{nomhs}}','{{psmhs_id}}','{{angkatan}}')" class="btn bg-navy pull-right btn-flat"><i class="fa fa-fw fa-plus"></i> Tambah</button>
        </div><!-- /.box-header -->
        <div class="box-body">
          <table id="" class="table table-bordered table-striped">
            <thead>
              <tr>
                <th style="width: 10px">No</th>
                <th width="100">Periode</th>
                <th width="200">Ujian Id</th>
                <th width="100">Ujian ke</th>
                <th>Judul</th>
              </tr>
            </thead>
            <tbody>
            
            {% set no=1 %}
            {% for v in data_skripsi_mhs %}
            <tr>
              <td>{{no}}</td>
              <td>{{v.periode}}</td>
              <td>{{v.nama_ujian}}</td>          
              <td>{{v.ujian_ke}}</td>          
              <td><a href="javascript:void(0)" onclick="edit_pendadaran('{{nama}}','{{nomhs}}','{{psmhs_id}}','{{angkatan}}','{{v.id}}')">{{v.judul}}</a></td>
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

function back() {
    var link = '{{ url("akdpendadaran/selectMhs/") }}';
    go_page(link);
}

function tambah(nama,nomhs,psmhs_id,angkatan) {
    var link = '{{ url("akdpendadaran/formPendadaran/") }}';
    var datas = 'nama='+nama+'&nomhs='+nomhs+'&psmhs_id='+psmhs_id+'&angkatan='+angkatan;
    go_page_data(link,datas);
}

function edit_pendadaran(nama,nomhs,psmhs_id,angkatan,id) {
	var link = '{{ url("akdpendadaran/formEditPendadaran/") }}'+id;
    var datas = 'nama='+nama+'&nomhs='+nomhs+'&psmhs_id='+psmhs_id+'&angkatan='+angkatan;
    go_page_data(link,datas);
}


</script>