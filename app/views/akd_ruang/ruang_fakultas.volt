<?php 

$get_session = $this->session->get('ps_id');
$explode = explode('-', $get_session);
$ps_id = $explode[1];

?>
<section class="content-header">
  <h1>
    <button type="button" onclick="back()" class="btn bg-navy btn-flat"><i class="fa fa-fw fa-arrow-left"></i> Back</button>
  </h1>
  <ol class="breadcrumb">
    <li><a href="#"><i class="fa fa-dashboard"></i> Setup</a></li>
    <li class="active">Ruang</li>
  </ol>
</section>

<!-- Main content -->
<section class="content">
  <div class="row">

    <div class="col-md-12">
      <div class="box">
        <div class="box-header with-border">
          <h3 class="box-title">Bordered Table</h3>
        </div><!-- /.box-header -->
        <div class="box-body">
          <table id="example2" class="table table-bordered table-striped">
            <thead>
              <tr>
                <th style="width: 10px">No</th>
                <th>Id Ruang</th>
                <th>Nama</th>
                <th>PSID</th>
                <th>RuangID</th>
                <th>DB</th>
              </tr>
            </thead>
            <tbody>
            
            {% set no=1 %}
            {% for v in ruang %}
            <tr>
              <td>{{no}}</td>
              <td><span class="badge bg-green">{{v.ruang_id}}</span></td>
              <td><a href="javascript:void(0)" onclick="add_ruang_dari_fak('{{v.ps_id}}', '{{v.ruang_id}}', '{{v.nama_ruang}}' )">{{v.nama_ruang}}</a></td>
              <td>{{v.shareps_id}}</td>
              <td>{{v.shareruang_id}}</td>
              <td>{{v.sharedb}}</td>             
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


function listRuangFakultas(id_fakultas) {
    var link = '{{ url("akdruang/listRuangFakultas/") }}'+id_fakultas;
    go_page(link);	
}

function back(argument) {
  var link = '{{ url("akdruang/ruang/") }}';
  go_page(link);  
}

function add_ruang_dari_fak(ps_id, id_ruang, nama_ruang) {
  var link = '{{ url("akdruang/addRuangDariFakultas/") }}';
  (new PNotify({
        title: 'Confirmation Needed',
        text: 'Apakah Anda Yakin menghapus data ini?',
        icon: 'glyphicon glyphicon-question-sign',
        hide: false,
        confirm: {
            confirm: true
        },
        buttons: {
            closer: false,
            sticker: false
        },
        history: {
            history: false
        }
    })).get().on('pnotify.confirm', function() {
        $.ajax({
         type: "POST",
         url: link,
         dataType : "json",
         data : "ps_id="+ps_id+"&id_ruang="+id_ruang+"&nama_ruang="+nama_ruang,
      }).done(function( data ) {
          new PNotify({
             title: 'Regular Notice',
             text: 'Tambah Ruang Berhasil',
             type:'success'
          });
          reload_page2('akdruang/ruang');
      });
    }).on('pnotify.cancel', function() {
       console.log('batal');
    });
}
</script>