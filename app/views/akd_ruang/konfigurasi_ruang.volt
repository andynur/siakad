<?php 

$get_session = $this->session->get('ps_id');
$explode = explode('-', $get_session);
$ps_id = $explode[1];

?>
<section class="content-header">
  <h1>
    <button type="button" onclick="back()" class="btn bg-navy btn-flat margin"><i class="fa fa-fw fa-arrow-left"></i> Back</button>
  </h1>
  <ol class="breadcrumb">
    <li><a href="#"><i class="fa fa-dashboard"></i> Ruang</a></li>
    <li class="active">Konfigurasi</li>
  </ol>
</section>

<section class="content-header">
  <h1>
    Konfigurasi Ruang  <a href="#"><?= $nama_ruang ?></a>
  </h1>
</section>


<!-- Main content -->
<section class="content">
  <div class="row">
    <!-- left column -->
    <div class="col-md-3">
      <div class="box">
        <div class="box-header with-border">
          <h3 class="box-title">Form Konfigurasi</h3>
        </div><!-- /.box-header -->
        <!-- form start -->
        <div class="form">
          <div class="box-body">
            <div class="row">
              <div class="col-lg-12">
                  <label>Nama Konfigurasi</label>
                  <input type="text" id="nama" placeholder="nama" class="form-control">
                  <input type="text" id="ruang_id" value="<?= $ruang_id ?>" style="display:none;" class="form-control">
              </div><!-- /.col-lg-6 -->
            </div><br>

          </div><!-- /.box-body -->
          <div class="box-footer">
            <button type="submit" onclick="add_confruang('<?= $ruang_id ?>','<?= $nama_ruang ?>')" class="btn btn-info pull-right">Tambah</button>
          </div><!-- /.box-footer -->
        </div>
      </div><!-- /.box -->
    </div>


    <div class="col-md-9">
      <div class="box">
        <div class="box-header with-border">
          <h3 class="box-title">Bordered Table</h3>
        </div><!-- /.box-header -->
        <div class="box-body">
          <table id="example2" class="table table-bordered table-striped">
            <thead>
              <tr>
                <th style="width: 10px">No</th>
                <th>Configurasi Id</th>
                <th>Nama</th>
                <th>Volume</th>
                <th>Action</th>
              </tr>
            </thead>
            <tbody>
            
            {% set no=1 %}
            {% for v in ruang %}
            <tr>
              <td>{{no}}</td>
              <td><span class="badge bg-green">{{v.conf_id}}</span></td>
              <td><a href="javascript:void(0)" onclick="matrix_ruang('{{v.conf_id}}','{{v.nama_conf}}','<?= $ruang_id ?>','<?= $nama_ruang ?>')">{{v.nama_conf}}</a></td>
              <td>{{v.volume}}</td>
              <td>
                <a id="edit" class="btn btn-primary btn-xs btn-flat" data-toggle="modal" data-target="#myModal{{v.conf_id}}"><i class="glyphicon glyphicon-edit"></i> </a>
                  <!-- Modal -->
                  <div class="modal fade" id="myModal{{v.conf_id}}" role="dialog">
                    <div class="modal-dialog">
                    
                      <!-- Modal content-->
                      <div class="modal-content">
                        <div class="modal-header">
                          <button type="button" class="close" data-dismiss="modal">&times;</button>
                          <h4 class="modal-title">Edit Data</h4>
                        </div>
                        <div class="modal-body" style="  border: 1px solid #eee;  width: 80%; margin: 0 auto;">
                            <div class="form">
                              <div class="box-body">
                                <div class="row">
                                  <div class="col-lg-12">
					                  <label>Nama Konfigurasi</label>
					                  <input type="text" value="{{v.nama_conf}}" id="nama{{v.conf_id}}" placeholder="nama" class="form-control">
					              </div>
                                </div><br>
                              </div><!-- /.box-body -->
                            </div>
                        </div>
                        <div class="modal-footer">
                          <button type="button" onclick="edit_confruang('{{v.conf_id}}','<?= $ruang_id ?>','<?= $nama_ruang ?>')" class="btn btn-info">Edit</button>
                          <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                        </div>
                      </div>
                      
                    </div>
                  </div>
                <a id="delete" onclick="del_data('{{v.conf_id}}','<?= $ruang_id ?>','<?= $nama_ruang ?>')" class="btn btn-danger btn-xs btn-flat"><i class="glyphicon glyphicon-trash"></i></a> 
              </td>
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


function back() {
    var link = '{{ url("akdruang/ruang/") }}';
    go_page(link);	
}


function matrix_ruang(conf_id,nama_conf,id_ruang,nama_ruang) {
    var link = '{{ url("akdruang/matrixRuang/") }}';
    var datas = "conf_id="+conf_id+"&nama_conf="+nama_conf+"&nama_ruang="+nama_ruang+"&id_ruang="+id_ruang;
    go_page_data(link,datas);  
}

function add_confruang(id_ruang,nama_ruang){
	var nama = $("#nama").val();
	var ruang_id = $("#ruang_id").val();
	var ps_id = <?= $ps_id ?>;

	var datas = "nama="+nama+"&ps_id="+ps_id+"&ruang_id="+ruang_id;
	var urel = '{{ url("akdruang/addConfruang") }}';
	$.ajax({
		type: "POST",
		url: urel,
		dataType : "json",
		data: datas
	}).done(function( data ) {
		// console.log(data);
		new PNotify({
           title: data.title,
           text: data.text,
           type: data.type
       	});
       	var link_reload = '{{ url("akdruang/konfigurasiRuang?id=") }}'+id_ruang+"&nama="+nama_ruang;
		reload_page2(link_reload);  
	});
}

  function del_data(id,id_ruang,nama_ruang) {
    var link = '{{ url("akdruang/delConfruang/") }}'+id;
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
         type: "GET",
         url: link,
         dataType : "json",
      }).done(function( data ) {
          new PNotify({
             title: 'Regular Notice',
             text: 'data telah dihapus',
             type:'success'
          });
        var link_reload = '{{ url("akdruang/konfigurasiRuang?id=") }}'+id_ruang+"&nama="+nama_ruang;
		reload_page2(link_reload);
      });
    }).on('pnotify.cancel', function() {
       console.log('batal');
    });
  }

  function edit_confruang(id,id_ruang,nama_ruang) {
      var nama = $("#nama"+id).val();

      var datas = "nama="+nama;
      var urel = '{{ url("akdruang/editConfruang/") }}'+id;
      
        $.ajax({
           type: "POST",
           url: urel,
           dataType : "json",
           data: datas
        }).done(function( data ) {
			$('#myModal'+id).modal('hide');
			$('body').removeClass('modal-open');
			$("body").css("padding-right", "0px");
			$('.modal-backdrop').remove();
          
          	var link_reload = '{{ url("akdruang/konfigurasiRuang?id=") }}'+id_ruang+"&nama="+nama_ruang;
			reload_page2(link_reload);
           	new PNotify({
               title: data.title,
               text: data.text,
               type: data.type
           	});

        });
  }


</script>