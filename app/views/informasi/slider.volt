<section class="content-header">
  <h1>
    Slider <?= $this->session->get('ps_id') ?>
    <small>it all inform here</small>
  </h1>
  <ol class="breadcrumb">
    <li><a href="#"><i class="fa fa-dashboard"></i> Slider</a></li>
    <li class="active">Image</li>
  </ol>
</section>

<!-- Main content -->
<section class="content">
  <div class="row">
    <!-- left column -->
    <div class="col-md-12">
      <div class="box box-info">
        <div class="box-body">
    		<div class="col-md-3"></div>
    		<div class="col-md-6">
	    		<div class="col-md-8">
		    		<div class="form-group">
	                  <span for="exampleInputFile">File input :</span>
	                  <input style="border: 1px solid;" type="file" id="slider">
	                  <p class="help-block">File type : jpg, jpeg, gif, png</p>	                  
	                </div>
                </div>
	    		<div class="col-md-4">
	    		<button onclick="upload()" class="pull-left btn bg-navy btn-flat margin">Upload</button>
	    		</div>    			
    		</div>
    		<div class="col-md-3"></div>

    	<table id="example2" class="table table-bordered table-striped">
            <thead>
              <tr>
                <th style="width: 10px">No</th>
                <th>Gambar</th>
                <th>Nama File</th>
                <th>Aktif</th>
                <th>Aksi</th>
              </tr>
            </thead>
            <tbody>
            
            {% set no=1 %}
            {% for v in slider %}
            <tr>
              <td>{{no}}</td>
              <td><a target="blank" href="<?= BASE_URL.'public/slider/' ?>{{v.nama}}"><img width="90px" src="<?= BASE_URL.'public/slider/' ?>{{v.nama}}"></a></td>
              <td>{{v.nama}}</td>
              <td>
                {% if v.aktif === "Y" %}
                	<a data-toggle="modal" data-target="#myModal{{v.id}}" class="btn btn-info btn-xs btn-flat">{{v.aktif}}</a> 
                {% else %}
                	<a data-toggle="modal" data-target="#myModal{{v.id}}" class="btn btn-danger btn-xs btn-flat">{{v.aktif}}</a> 
                {% endif %}
                <div class="modal fade" id="myModal{{v.id}}" role="dialog">
                    <div class="modal-dialog">
                    
                      <!-- Modal content-->
                      <div class="modal-content">
                        <div class="modal-header">
                          <button type="button" class="close" data-dismiss="modal">&times;</button>
                          <h4 class="modal-title">Edit aksi file {{v.nama}}</h4>
                        </div>
                        <div class="modal-body" style="  border: 1px solid #eee;  width: 100%; margin: 0 auto;">
                          <div class="form">
                            <div class="box-body">
                              <div class="row">
                                <div class="col-lg-4"> </div>
                                <div class="col-lg-4">
                                    <label>Aktif</label>
                                    <select class="form-control" id="aktif{{v.id}}">
                                      <option value="Y">Ya</option>
                                      <option value="N">Tidak</option>
                                    </select>
                                </div>
                                <div class="col-lg-4"></div>
                              </div>
                            </div><!-- /.box-body -->
                          </div>
                        </div>
                        <div class="modal-footer">
                          <button type="button" onclick="edit_image('{{v.id}}')" class="btn btn-info">Edit</button>
                          <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                        </div>
                      </div>
                      
                    </div>
                  </div>
              </td>
              <td>                
                <a id="delete" onclick="delete_image('{{v.id}}','{{v.nama}}')" class="btn btn-danger btn-xs btn-flat"><i class="glyphicon glyphicon-trash"></i></a> 
              </td>
            </tr>
            {% set no=no+1 %}
            {% endfor %}

            </tbody>            
          </table>
        </div>
      </div><!-- /.box -->
    </div>

  </div>
      
</section><!-- /.content -->

<script type="text/javascript">

	$(function () {

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

function upload(){
	var urel = '{{ url("sysinformasi/uploadSlider") }}';
    var file_data = $('#slider').prop('files')[0];   
    var form_data = new FormData();                  
    form_data.append('file', file_data);
    if (file_data == '' || file_data == null) {
		new PNotify({
		   title: 'Regular Notice',
		   text: 'File tidak boleh kosong.',
		   type:'warning'
		});
	}
    // alert(form_data);                             
    $.ajax({
            url: urel, // point to server-side PHP script 
            dataType: 'json',  // what to expect back from the PHP script, if anything
            cache: false,
            contentType: false,
            processData: false,
            data: form_data,                         
            type: 'post',
            success: function(data){
                // console.log(data.title);
                var urel2 = '{{ url("sysinformasi/slider") }}';
                reload_page2(urel2);
                new PNotify({
                    title: data.title,
          					text: data.text,
          					type: data.type
                });
            }
     });
}



  function delete_image(id, nama){
    var urel = '{{ url("sysinformasi/delSliderImage") }}/'+id;
    var datas = "id="+id+"&nama="+nama;
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
            data: datas,
            success: function(data){ 
                reload_page2('sysinformasi/slider');
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

  function edit_image(id) {
    var aktif = $("#aktif"+id).val();

    var datas = "aktif="+aktif;
    var urel = '{{ url("sysinformasi/editSlider/") }}'+id;
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
		reload_page2('sysinformasi/slider');
		new PNotify({
			title: data.title,
			text: data.text,
			type: data.type
		});
    });
  }


</script>