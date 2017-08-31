<section class="content-header">
  <h1><button type="button" onclick="back()" class="btn bg-navy btn-flat margin"><i class="fa fa-fw fa-arrow-left"></i> Back</button></h1>
  <ol class="breadcrumb">
    <li><a href="#"><i class="fa fa-dashboard"></i> KRS</a></li>
    <li class="active">Paket</li>
  </ol>
</section>

<!-- Main content -->
<section class="content">
	<div class="row">
	  <div class="col-md-3"></div>
	  <div class="col-md-6">
	    <div class="box">
	        <div class="box-header">
	          <h3 class="box-title">EDIT PAKET</h3>
	        </div><!-- /.box-header -->
	        <div class="box-body">
	        {% for v in paket %}
	        <form method="post">
	            <table class="table table-condensed">
	              <tbody>
	                <tr>
	                  <td style="padding: 11px 6px;width: 100px; background: #eee" class="text-left"><b>ID :</b></td>
	                  	<td>{{v.paket_id}}</td>                  
	                </tr>
	                <tr>
	                  <td style="padding: 11px 6px;width: 100px; background: #eee" class="text-left"><b>Nama Paket :</b></td>
	                  	<td>
		                  	<div class="form-group has-feedback">
					            <input type="text" id="id" style="display: none;" value="{{v.id}}">
					            <input type="text" id="paket_id" style="display: none;" value="{{v.paket_id}}">
					            <input type="text" id="nama" class="form-control" value="{{v.nama_paket}}">
					            <span class="glyphicon glyphicon-book form-control-feedback"></span>
					        </div>
	                   	</td>                  
	                </tr>
	              </tbody>
	            </table>
              <button style="margin: 0;" type="button" onclick="hapus_paket('{{v.id}}')" class="btn bg-red btn-flat pull-right"><i class="fa fa-fw fa-edit"></i> Hapus</button>
              <button style="margin-right: 5px;" type="button" onclick="edit_paket('{{v.id}}')" class="btn bg-navy btn-flat pull-right"><i class="fa fa-fw fa-edit"></i> Edit</button>
	        </form>
	        {% endfor %}
	        </div>
	    </div>
	  </div>
	  <div class="col-md-3"></div>
	</div>

  <div class="row">
    <div class="col-md-2"></div>
    <div class="col-md-8">
      <div class="box">
        <div class="box-header with-border">
          <h3 class="box-title">DAFTAR MATA KULIAH</h3>
        </div><!-- /.box-header -->
        <div class="box-body">
        <form method="post">
          <table id="" class="table table-bordered table-striped">
            <thead>
              <tr>
                <th style="width: 10px">No</th>
                <th></th>
                <th>Thn Kur</th>
                <th>Kode Mk</th>
                <th>Nama Mk</th>
                <th>Sem.</th>
                <th>SKS</th>
                <th>Kelas</th>
              </tr>
            </thead>
            <tbody>
            
           	{% set no=1 %}
            {% for v in mk %}
            <tr>
              <td>{{no}}</td>
              <td><input type="checkbox" name="mk_{{id}}" id="mk_{{id}}" value="{{v.id}}"></td>
              <td>{{v.thn_kur}}</td>
              <td>{{v.kode_mk}}</td>
              <td>
              	<a href="#" data-toggle="modal" data-target="#myModal{{no}}">{{v.nama}}</a>
              	<!-- Modal -->
        				<div id="myModal{{no}}" class="modal fade" role="dialog">
        				  <div class="modal-dialog">

        				    <!-- Modal content-->
        				    <div class="modal-content">
        				      <div class="modal-header">
        				        <button type="button" class="close" data-dismiss="modal">&times;</button>
        				        <h4 class="modal-title text-navy">Modal Header</h4>
        				      </div>
        				      <div class="modal-body">
        					    <div class="form-group">
        	                      <label class="text-navy">Nama Kelas</label>
        	                      <input type="text" id="nama_kelas{{no}}" class="form-control" value="{{v.nama_kelas}}">
        	                    </div>
        				      </div>
        				      <div class="modal-footer">
        				        <button type="button" onclick="edit_mk_paket_krs('{{v.id}}','{{no}}')" class="btn btn-success">Rekam</button>
        				        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        				      </div>
        				    </div>

        				  </div>
        				</div>
              </td>
              <td>{{v.semester}}</td>
              <td>{{v.sks}}</td>
              <td>{{v.nama_kelas}}</td>
            </tr>
            {% set no=no+1 %}
            {% endfor %}

            </tbody>            
          </table>
          </form>
          <br>
          <button style="" type="button" onclick="hapus_mk()" class="btn bg-red btn-flat pull-right"><i class="fa fa-fw fa-edit"></i> Hapus</button>
          <button style="margin-right: 10px;" type="button" onclick="tambah_mk()" class="btn bg-green btn-flat pull-right"><i class="fa fa-fw fa-edit"></i> Tambah</button>
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
    var link = '{{ url("akdkrspaket/dafarPaket/") }}';
    go_page(link);
	
}

function reload() {
	var id = "{{id}}";
	var paket_id = "{{paket_id}}";
	var link = '{{ url("akdkrspaket/listMkPaket/") }}';
	var datas = 'id='+id+'&paket_id='+paket_id;
    reload_page_data(link,datas);
}

function edit_paket(id){
	var nama = $("#nama").val();

	var datas = "nama="+nama+"&id="+id;
	var urel = '{{ url("akdkrspaket/editPaket/") }}'+id;
	$.ajax({
		type: "POST",
		url: urel,
		dataType : "json",
		data: datas
	}).done(function( data ) {
		reload();
		new PNotify({
           title: data.title,
           text: data.text,
           type: data.type
       	});
	});
}

  function hapus_paket(id) {
    var link = '{{ url("akdkrspaket/hapusPaket/") }}'+id;
    (new PNotify({
        title: 'Confirmation Needed',
        text: 'Apakah Anda Yakin menghapus Paket ini?',
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
          back();
      });
    }).on('pnotify.cancel', function() {
       console.log('batal');
    });
  }


function tambah_mk() {
	var paket_id = $("#paket_id").val();
	var id = $("#id").val();
	var datas = "id="+id;
	var link = '{{ url("akdkrspaket/selectMK/") }}'+paket_id;
    go_page_data(link,datas);
}

function edit_mk_paket_krs(id,no) {
	var nama_kelas = $("#nama_kelas"+no).val();

	var datas = "nama_kelas="+nama_kelas;
	var urel = '{{ url("akdkrspaket/editMkPaket/") }}'+id;
	$.ajax({
		type: "POST",
		url: urel,
		dataType : "json",
		data: datas
	}).done(function( data ) {
		$('#myModal'+no).modal('hide');
		$('body').removeClass('modal-open');
		$("body").css("padding-right", "0px");
		$('.modal-backdrop').remove();
		reload();
		new PNotify({
           title: data.title,
           text: data.text,
           type: data.type
       	});
	});
}


function hapus_mk() {
  var mk =[];
  $('input[type=checkbox]:checked').each(function(index){
    mk.push($(this).val());
  });

  var datas = $('form').serialize();
  var link = '{{ url("akdkrspaket/delMkPaket/") }}';
  console.log(datas);
  if (mk.length == 0) {
    new PNotify({
      title: 'Regular Notice',
      text: 'Pilih Mata Kuliah yang akan di Hapus',
      type:'warning'
    });
  }else{

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
             data : datas,
        }).done(function( data ) {
            new PNotify({
               title: 'Regular Notice',
               text: 'Mata Kuliah telah Di Di hapus',
               type:'success'
            });
            reload();
        });
    }).on('pnotify.cancel', function() {
       console.log('batal');
    });     
  }
}




</script>