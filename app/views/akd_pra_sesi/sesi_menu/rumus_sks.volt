<section class="content-header">
  <h1>
    <button type="button" onclick="back('{{thn_akd}}','{{session_id}}')" class="btn bg-navy btn-flat margin"><i class="fa fa-fw fa-arrow-left"></i> Back</button>
  </h1>
  <ol class="breadcrumb">
    <li><a href="#"><i class="fa fa-dashboard"></i> Setup</a></li>
    <li class="active">Kelas Wizard</li>
  </ol>
</section>

<!-- Main content -->
<section class="content">
  <div class="row">
    <!-- left column -->
    <div class="col-md-4">
      <div class="box">
        <div class="box-header with-border">
          <h3 class="box-title">Buat Jatah SKS Baru</h3>
        </div><!-- /.box-header -->
        <!-- form start -->
        <div class="form">
	        <form id="add_data" method="post">
	        <input type="text" name="thn_akd" value="{{thn_akd}}" style="display:none;">
	        <input type="text" name="session_id" value="{{session_id}}" style="display:none;">
	        <input type="text" name="count_defujian" value="{{count_defujian}}" style="display:none;">
	          <div class="box-body">
	            <div class="row">
	              <div class="col-md-1"></div>
	              <div class="col-md-10">
	              	<div class="form-group">
	                  <label>Jatah SKS</label>
	                  <input name="jatah_sks" type="text" class="form-control" placeholder="Enter ...">
                    </div>
                    <div class="form-group">
	                  <label>Batas Bawah</label>
	                  <input name="batas_bawah" type="text" class="form-control" placeholder="Enter ...">
                    </div>
                    <div class="form-group">
	                  <label>Batas Atas</label>
	                  <input name="batas_atas" type="text" class="form-control" placeholder="Enter ...">
                    </div>
	              </div>
	            </div>
	          </div><!-- /.box-body -->
	          <div class="box-footer">
	            <button type="button" onclick="add_defujian()" class="btn bg-navy btn-flat pull-right">Rekam</button>
	          </div><!-- /.box-footer -->
	        </form>
        </div>
      </div><!-- /.box -->
    </div>


    <div class="col-md-8">
      <div class="box">
        <div class="box-header">
          <h3 class="box-title">Definisi Jangkauan Nilai - Jatah SKS</h3>
        </div><!-- /.box-header -->
        <div class="box-body">
          <table id="" class="table table-bordered table-striped">
            <thead>
              <tr>
                <th style="width: 10px">No</th>
                <th>Jatah SKS</th>
                <th>Batas Bawah</th>
                <th>Batas Atas</th>
                <th>Action</th>
              </tr>
            </thead>
            <tbody>
            
            {% set no=1 %}
            {% for v in ip %}
            <tr>
              <td>{{no}}</td>
              <td>{{v.jatahsks}}</td>
              <td>{{v.vstart}}</td>
              <td>{{v.vstop}}</td>
              <td>
              	<a id="edit" class="btn btn-primary btn-xs btn-flat" data-toggle="modal" data-target="#myModal{{v.def_id}}"><i class="glyphicon glyphicon-edit"></i> </a>
                  <!-- Modal -->
                  <div class="modal fade" id="myModal{{v.def_id}}" role="dialog">
                    <div class="modal-dialog modal-md">
                    
                      <!-- Modal content-->
                      <div class="modal-content">
                        <div class="modal-header">
                          <button type="button" class="close" data-dismiss="modal">&times;</button>
                          <h4 class="modal-title">Edit Data</h4>
                        </div>
                        <div class="modal-body" style="  border: 1px solid #eee;  width: 80%; margin: 0 auto;">
                       		<div class="row">
				              <div class="col-md-1"></div>
				              <div class="col-md-10">
				              	<div class="form-group">
				                  <label>Jatah SKS</label>
				                  <input id="jatahsks{{v.def_id}}" type="text" class="form-control" value="{{v.jatahsks}}">
			                    </div>
			                    <div class="form-group">
				                  <label>Batas Bawah</label>
				                  <input id="vstart{{v.def_id}}" type="text" class="form-control" value="{{v.vstart}}">
			                    </div>
			                     <div class="form-group">
				                  <label>Batas Atas</label>
				                  <input id="vstop{{v.def_id}}" type="text" class="form-control" value="{{v.vstop}}">
			                    </div>
				              </div>
				            </div>
                        </div>
                        <div class="modal-footer">
                          <button type="button" onclick="edit_defujian('{{v.def_id}}')" class="btn btn-info">Edit</button>
                          <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                        </div>
                      </div>
                      
                    </div>
                  </div>
                  <a id="delete" onclick="delete_data('{{v.def_id}}')" class="btn btn-danger btn-xs btn-flat"><i class="glyphicon glyphicon-trash"></i></a> 
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

function reload() {
  var thn_akd = "{{thn_akd}}";
  var session_id = "{{session_id}}";
  var datas = "thn_akd="+thn_akd+"&session_id="+session_id;
  var link = '{{ url("manajemensesi/rumusSks/") }}';
  reload_page_data(link,datas);
}


function back(thn_akd,session_id) {
	var link = '{{ url("manajemensesi/viewSession/") }}';
    var datas = "thn_akd="+thn_akd+"&session_id="+session_id;
    go_page_data(link,datas);
}

function add_defujian() {
  var link = '{{ url("manajemensesi/addRumusSks/") }}';
	var datas = $('#add_data').serialize();
	$.ajax({
       type: "POST",
       url: link,
       dataType : "json",
       data: datas
    }).done(function( data ) {
    	new PNotify({
		   title: data.title,
		   text: data.text,
		   type: data.type
		});
    	reload();
    });
}

function edit_defujian(id) {
	var jatahsks = $("#jatahsks"+id).val();
	var vstart = $("#vstart"+id).val();
	var vstop = $("#vstop"+id).val();

	var datas = "jatah_sks="+jatahsks+"&batas_bawah="+vstart+"&batas_atas="+vstop;
 	var link = '{{ url("manajemensesi/editRumusSks/") }}'+id;
	$.ajax({
       type: "POST",
       url: link,
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
    	reload();
    });
}

  function delete_data(id){
    var urel = '{{ url("manajemensesi/deleteRumusSks") }}/'+id;
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
            dataType: "JSON",
            url: urel,
            success: function(data){ 
                new PNotify({
                     title: 'Regular Notice',
                     text: 'data telah dihapus',
                     type:'success'
                 });
                reload();
            }
        });
    }).on('pnotify.cancel', function() {
       console.log('batal');
    });
  }

</script>