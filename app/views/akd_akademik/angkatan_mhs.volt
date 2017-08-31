<section class="content-header">
  <h1>
    Angkatan Mahasiswa
    <small>it all starts here</small>
  </h1>
  <ol class="breadcrumb">
    <li><a href="#"><i class="fa fa-dashboard"></i> Setup</a></li>
    <li class="active">Angkatan</li>
  </ol>
</section>

<!-- Main content -->
<section class="content">
  <div class="row">
    <!-- left column -->
    <div class="col-md-5">
      <div class="box">
        <div class="box-header with-border">
          <h3 class="box-title">Form</h3>
        </div><!-- /.box-header -->
        <!-- form start -->
        <div class="form">
	        <form id="add_data" method="post">
	          <div class="box-body">
	            <div class="row">
	              <div class="col-lg-6">
	                  <label>Angkatan id</label>
	                  <input type="number" form="add_data" name="angkatan_id" placeholder="Enter..." class="form-control">
	              </div><!-- /.col-lg-6 -->
	              <div class="col-lg-6">
	                	<label>Nama</label>
	                	<input type="text" form="add_data" name="nama" placeholder="Enter..." class="form-control">
	              </div><!-- /.col-lg-6 -->
	            </div><br>

	          </div><!-- /.box-body -->
	          <div class="box-footer">
	            <button type="button" onclick="add_group()" class="btn btn-info pull-right">Tambah</button>
	          </div><!-- /.box-footer -->
	        </form>
        </div>
      </div><!-- /.box -->
    </div>


    <div class="col-md-7">
      <div class="box">
        <div class="box-header">
          <h3 class="box-title">Data Table With Full Features</h3>
        </div><!-- /.box-header -->
        <div class="box-body">
          <table id="example2" class="table table-bordered table-striped">
            <thead>
              <tr>
                <th style="width: 10px">No</th>
                <th>Angkatan id</th>
                <th>Nama</th>
                <th>Aksi</th>
              </tr>
            </thead>
            <tbody>
            
            {% set no=1 %}
            {% for v in angkatan %}
            <tr>
              <td>{{no}}</td>
              <td><span class="badge bg-green">{{v.angkatan_id}}</span></td>
              <td>{{v.angkatan_nm}}</td>
              <td>
                <a id="edit" class="btn btn-primary btn-xs btn-flat" data-toggle="modal" data-target="#myModal{{v.angkatan_id}}"><i class="glyphicon glyphicon-edit"></i> </a>
                  <!-- Modal -->
                  <div class="modal fade" id="myModal{{v.angkatan_id}}" role="dialog">
                    <div class="modal-dialog">
                    
                      <!-- Modal content-->
                      <div class="modal-content">
                        <div class="modal-header">
                          <button type="button" class="close" data-dismiss="modal">&times;</button>
                          <h4 class="modal-title">Edit Data</h4>
                        </div>
                        <div class="modal-body" style="  border: 1px solid #eee;  width: 80%; margin: 0 auto;">
                          <div class="form">
                          	<form id="edit_data{{v.angkatan_id}}" method="post">
	                            <div class="box-body">
						            <div class="row">
						              <div class="col-lg-12">
						                  <label>Nama</label><br>
						                  <input type="text" form="edit_data{{v.angkatan_id}}" name="nama" value="{{v.angkatan_nm}}" class="form-control">
						              </div><!-- /.col-lg-6 -->
						            </div>
	                            </div><!-- /.box-body -->
                            </form>
                          </div>
                        </div>
                        <div class="modal-footer">
                          <button type="button" onclick="edit_group('{{v.angkatan_id}}')" class="btn btn-info">Edit</button>
                          <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                        </div>
                      </div>
                      
                    </div>
                  </div>
                <a id="delete" onclick="del_data('{{v.angkatan_id}}')" class="btn btn-danger btn-xs btn-flat"><i class="glyphicon glyphicon-trash"></i></a> 
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

function add_group() {
	var datas = $('#add_data').serialize();
    var urel = '{{ url("akademik/addAngkatan") }}';
    $.ajax({
       type: "POST",
       url: urel,
       dataType : "json",
       data: datas
    }).done(function( data ) {
    	new PNotify({
	      title: data.title,
	      text: data.text,
	      type: data.type
	    });
    	reload_page2('akademik/angkatanMhs');
    });
}

function edit_group(id) {
	var datas = $('#edit_data'+id).serialize();
    var urel = '{{ url("akademik/editAngkatan/") }}'+id;

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
	  
	  new PNotify({
	    title: data.title,
	    text: data.text,
	    type: data.type
	  });
	  reload_page2('akademik/angkatanMhs');
	});
}

function del_data(id) {
    var link = "<?= BASE_URL ?>akademik/delAngkatan/"+id;
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
          reload_page2('akademik/angkatanMhs');
      });
    }).on('pnotify.cancel', function() {
       console.log('batal');
    });
  }

</script>