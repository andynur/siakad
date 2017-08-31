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
          <h3 class="box-title">MASUKAN DAFTAR CEKAL</h3>
        </div><!-- /.box-header -->
        <!-- form start -->
        <div class="form">
	        <form id="add_data" method="post">
	        <input type="text" name="thn_akd" value="{{thn_akd}}" style="display:none;">
	        <input type="text" name="session_id" value="{{session_id}}" style="display:none;">
	          <div class="box-body">
	            <div class="row">
	              <div class="col-md-1"></div>
	              <div class="col-md-10">
	              	<div class="form-group">
	                  <label>Daftar mhs yang di cekal</label>
	                  <textarea class="form-control" name="mhs" rows="3" placeholder="Enter ..."></textarea>
                    </div>
                    <div class="form-group">
	                  <label>Alasan</label>
	                  <input name="alasan" type="text" class="form-control" placeholder="Enter ...">
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
          <h3 class="box-title">Daftar MHS Yg Di Cekal</h3>
        </div><!-- /.box-header -->
        <div class="box-body">
          <table id="" class="table table-bordered table-striped">
            <thead>
              <tr>
                <th style="width: 10px">No</th>
                <th>Nomhs</th>
                <th>PS</th>
                <th>Nama</th>
                <th>Alasan</th>
                <th>Delete</th>
              </tr>
            </thead>
            <tbody>
            
            {% set no=1 %}
            {% for v in daftar_cekal %}
            <tr>
              <td>{{no}}</td>
              <td>{{v.id_mhs}}</td>
              <td>{{v.id_ps}}</td>
              <td>{{v.nama}}</td>
              <td>{{v.alasan}}</td>
              <td><input name="delete_data" value="{{v.id}}" type="checkbox"></td>
            </tr>
            {% set no=no+1 %}
            {% endfor %}

            </tbody>            
          </table>
          <button type="button" onclick="delete_data()" class="btn bg-navy margin btn-flat pull-right">Hapus</button>
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
  var link = '{{ url("manajemensesi/daftarCekal/") }}';
  reload_page_data(link,datas);
}


function back(thn_akd,session_id) {
	var link = '{{ url("manajemensesi/viewSession/") }}';
    var datas = "thn_akd="+thn_akd+"&session_id="+session_id;
    go_page_data(link,datas);
}

function add_defujian() {
  var link = '{{ url("manajemensesi/addDaftarCekal/") }}';
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


  function delete_data(){
  	var id =[];
	$('input[type=checkbox]:checked').each(function(index){
	  id.push($(this).val());
	});
	var datas = "mhs="+id;
    var link = '{{ url("manajemensesi/deleteDaftarCekal") }}/';

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

	    if (id.length == 0) {
			new PNotify({
				title: 'Regular Notice',
				text: 'Pilih MHS yang akan di Hapus',
				type:'warning'
			});
	    }else{
		    $.ajax({
		         type: "POST",
		         url: link,
		         dataType : "json",
		         data : datas,
		    }).done(function( data ) {
		          new PNotify({
		             title: 'Regular Notice',
		             text: 'data telah Di Hapus',
		             type:'success'
		          });
		        reload();
		    });    	
	    }

    }).on('pnotify.cancel', function() {
       console.log('batal');
    });
  }

</script>