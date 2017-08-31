<section class="content-header">
  <h1>
    Informasi
    <small>it all inform here</small>
  </h1>
  <ol class="breadcrumb">
    <li><a href="#"><i class="fa fa-dashboard"></i> Informasi</a></li>
    <li class="active">Text Berjalan</li>
  </ol>
</section>

<!-- Main content -->
<section class="content">
  <div class="row">
    <!-- left column -->
    <div class="col-md-5">
      <div class="box box-info">
        <div class="box-header">
          <h3 class="box-title">Inform <small>text berjalan</small></h3>
          <!-- tools box -->
          <div class="pull-right box-tools">
            <button class="btn btn-info btn-sm" data-widget="collapse" data-toggle="tooltip" title="Collapse"><i class="fa fa-minus"></i></button>
          </div><!-- /. tools -->
        </div><!-- /.box-header -->
        <div class="box-body pad">
          <form id="form_berita">
            <textarea id="editor" rows="10" cols="80"></textarea>
            <button style="margin-top: 5px;" type="button" onclick="add_berita()" class="btn btn-info pull-right">Tambah</button>
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
                <th>Berita</th>
                <th>Aktif</th>
                <th>Aksi</th>
              </tr>
            </thead>
            <tbody>
            
            {% set no=1 %}
            {% for v in berita %}
            <tr>
              <td>{{no}}</td>
              <td>{{v.berita}}</td>
              <td>
                {% if v.tampil === "Y" %}
                  <span class="badge bg-green">{{v.tampil}}</span>
                {% else %}
                  <span class="badge bg-red">{{v.tampil}}</span>
                {% endif %}
              </td>
              <td>
                <a id="edit" class="btn btn-primary btn-xs btn-flat" onclick="text_editor('{{v.id}}')" data-toggle="modal" data-target="#myModal{{v.id}}"><i class="glyphicon glyphicon-edit"></i> </a>
                  <!-- Modal -->
                  <div class="modal fade" id="myModal{{v.id}}" role="dialog">
                    <div class="modal-dialog modal-lg">
                    
                      <!-- Modal content-->
                      <div class="modal-content">
                        <div class="modal-header">
                          <button type="button" class="close" data-dismiss="modal">&times;</button>
                          <h4 class="modal-title">Edit Data</h4>
                        </div>
                        <div class="modal-body" style="  border: 1px solid #eee;  width: 80%; margin: 0 auto;">
                          	<div class="col-md-12">
			                  <label>Aktif</label>
			                  <select class="form-control" id="tampil{{v.id}}">
			                    <option value="Y">Ya</option>
			                    <option value="N">Tidak</option>
			                  </select>
			              	</div><!-- /.col-lg-6 --><br><br><br>
	                          <form id="form_berita">
							    <textarea id="editor2{{v.id}}" rows="10" cols="80">{{v.berita}}</textarea>
							  </form>
                        </div>
                        <div class="modal-footer">
                          <button type="button" onclick="edit_berita('{{v.id}}')" class="btn btn-info">Edit</button>
                          <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                        </div>
                      </div>
                      
                    </div>
                  </div>
                <a id="delete" onclick="delete_berita('{{v.id}}')" class="btn btn-danger btn-xs btn-flat"><i class="glyphicon glyphicon-trash"></i></a> 
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
		CKEDITOR.replace( 'editor' );

		$(".select2").select2();

    	$('#example2').DataTable({
			"paging": true,
			"lengthChange": true,
			"searching": true,
			"ordering": true,
			"info": true,
			"autoWidth": true
		});

	});

function text_editor(id) {
	CKEDITOR.replace( 'editor2'+id);
}

  function delete_berita(id){
    var urel = '{{ url("sysinformasi/delBeritaBerjalan") }}/'+id;
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
                reload_page2('sysinformasi/textBerjalan');
                new PNotify({
                     title: 'Regular Notice',
                     text: 'data telah dihapus',
                     type:'success'
                 });
            }
        });
    }).on('pnotify.cancel', function() {
       console.log('batal');
    });
  }

  function edit_berita(id) {
    var berita = CKEDITOR.instances['editor2'+id].getData();
    var tampil = $("#tampil"+id).val();

    var datas = "berita="+berita+"&tampil="+tampil;
    var urel = '{{ url("sysinformasi/editBeritaBerjalan/") }}'+id;
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
		reload_page2('sysinformasi/textBerjalan');
		new PNotify({
			title: data.title,
			text: data.text,
			type: data.type
		});
    });
  }

  function add_berita() {

    var berita = CKEDITOR.instances['editor'].getData();

	    var datas = "berita="+berita;
	    var urel = '{{ url("sysinformasi/addBeritaBerjalan") }}';
	    $.ajax({
	       type: "POST",
	       url: urel,
	       dataType : "json",
	       data: datas
	    }).done(function( data ) {
        	reload_page2('sysinformasi/textBerjalan');
        	new PNotify({
			   title: data.title,
			   text: data.text,
			   type: data.type
			});
	    });
  }
</script>