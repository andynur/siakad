<?php 

$get_session = $this->session->get('ps_id');
$explode = explode('-', $get_session);
$ps_id = $explode[1];

?>
<section class="content-header">
  <h1>
    Setup Ruang <?= $this->session->get('ps_id') ?>
    <small>it all starts here</small>
  </h1>
  <ol class="breadcrumb">
    <li><a href="#"><i class="fa fa-dashboard"></i> Setup</a></li>
    <li class="active">Ruang</li>
  </ol>
</section>

<!-- Main content -->
<section class="content">
  <div class="row">
    <!-- left column -->
    <div class="col-md-6">
      <div class="box">
        <div class="box-header with-border">
          <h3 class="box-title">Form Ruang</h3>
        </div><!-- /.box-header -->
        <!-- form start -->
        <div class="form">
          <div class="box-body">
            <div class="row">
              <div class="col-lg-12">
                  <label>Nama</label>
                  <input type="text" id="nama" placeholder="nama" class="form-control">
              </div><!-- /.col-lg-6 -->
            </div><br>

          </div><!-- /.box-body -->
          <div class="box-footer">
            <button type="submit" onclick="add_ruang()" class="btn btn-info pull-right">Tambah</button>
          </div><!-- /.box-footer -->
        </div>
      </div><!-- /.box -->
    </div>

    <div class="col-md-6">
    	<div class="box">
	        <div class="box-header with-border">
	          <h3 class="box-title">RUANG BARU DARI JURUSAN LAIN</h3>
	        </div><!-- /.box-header -->
	        <!-- form start -->
	        <div class="form">
	          <div class="box-body">
	            <div class="row">
	              <div class="col-lg-12">
	                  <p>LIST RUANG :</p>
	                  <?php if ($explode[0] != "fak"): ?>
	                  	{% for val in fakultas %}
	                		<a href="javascript:void(0)" onclick="listRuangFakultas('{{val.id_fakultas}}')">Fakultas {{val.nama}}</a>
	                	{% endfor %}
	                  <?php else: ?>
	                  kosong
	                  <?php endif ?>
	              </div><!-- /.col-lg-6 -->
	            </div><br>

	          </div><!-- /.box-body -->
	          <div class="box-footer">
	          </div><!-- /.box-footer -->
	        </div>
	    </div><!-- /.box -->
    </div>

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
                <th>Aktif</th>
                <th>Action</th>
              </tr>
            </thead>
            <tbody>
            
            {% set no=1 %}
            {% for v in ruang %}
            <tr>
              <td>{{no}}</td>
              <td><span class="badge bg-green">{{v.ruang_id}}</span></td>
              <td><a href="javascript:void(0)" onclick="konfigurasi_ruang('{{v.ruang_id}}','{{v.nama_ruang}}')">{{v.nama_ruang}}</a></td>
              <td>{{v.shareps_id}}</td>
              <td>{{v.shareruang_id}}</td>
              <td>{{v.sharedb}}</td>
              <td>
                {% if v.publik === "Y" %}
                  <span class="badge bg-green">{{v.publik}}</span>
                {% else %}
                  <span class="badge bg-red">{{v.publik}}</span>
                {% endif %}
              </td>
              <td>
                <a id="edit" class="btn btn-primary btn-xs btn-flat" data-toggle="modal" data-target="#myModal{{v.ruang_id}}"><i class="glyphicon glyphicon-edit"></i> </a>
                  <!-- Modal -->
                  <div class="modal fade" id="myModal{{v.ruang_id}}" role="dialog">
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
                                  <div class="col-lg-8">
                                      <label>Nama</label>
                                      <input type="text" value="{{v.nama_ruang}}" style="width: 100%;" id="nama{{v.ruang_id}}" class="form-control">
                                  </div><!-- /.col-lg-6 -->  
                                  <div class="col-lg-4">
                                    <label>Aktif</label><br>
                                    <select class="form-control" id="aktif{{v.ruang_id}}">
                                    {% if v.publik == 'Y' %}
                                      <option value="Y" selected>Ya</option>
                                      <option value="N">Tidak</option>
                                    {% else %}
                                      <option value="Y">Ya</option>
                                      <option value="N" selected>Tidak</option>
                                    {% endif %}
                                    </select>
                                </div><!-- /.col-lg-6 -->
                                </div><br>
                              </div><!-- /.box-body -->
                            </div>
                        </div>
                        <div class="modal-footer">
                          <button type="button" onclick="edit_group('{{v.ruang_id}}')" class="btn btn-info">Edit</button>
                          <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                        </div>
                      </div>
                      
                    </div>
                  </div>
                <a id="delete" onclick="del_data('{{v.ruang_id}}')" class="btn btn-danger btn-xs btn-flat"><i class="glyphicon glyphicon-trash"></i></a> 
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


function listRuangFakultas(id_fakultas) {
    var link = '{{ url("akdruang/listRuangFakultas/") }}'+id_fakultas;
    go_page(link);
	
}

function konfigurasi_ruang(id_ruang,nama_ruang) {
    var link = '{{ url("akdruang/konfigurasiRuang?id=") }}'+id_ruang+"&nama="+nama_ruang;
    go_page(link);  
}

function add_ruang(){
	var nama = $("#nama").val();
	var ps_id = <?= $ps_id ?>;

	var datas = "nama="+nama+"&ps_id="+ps_id;
	var urel = '{{ url("akdruang/addRuang") }}';
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
		reload_page2('akdruang/ruang');
	});
}

  function del_data(id) {
    var link = '{{ url("akdruang/delRuang/") }}'+id;
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
          reload_page2('akdruang/ruang');
      });
    }).on('pnotify.cancel', function() {
       console.log('batal');
    });
  }

  function edit_group(id) {
      var nama = $("#nama"+id).val();
      var aktif = $("#aktif"+id).val();

      var datas = "nama="+nama+"&aktif="+ aktif;
      var urel = '{{ url("akdruang/editRuang/") }}'+id;
      
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
          
          reload_page2('akdruang/ruang');
           new PNotify({
               title: data.title,
               text: data.text,
               type: data.type
           });

        });
  }


</script>