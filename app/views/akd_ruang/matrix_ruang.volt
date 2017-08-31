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
    <li class="">Konfigurasi</li>
    <li class="active">Matrix</li>
  </ol>
</section>

<section class="content-header">
  <h1>
    Matrix Ruang  <a href="#"><?= $nama_conf ?></a>
  </h1>
</section>


<!-- Main content -->
<section class="content">
  <div class="row">
    <!-- left column -->
    <div class="col-md-5">
      <div class="box">
        <div class="box-header with-border">
          <h3 class="box-title">UBAH MATRIKS KURSI</h3>
        </div><!-- /.box-header -->
        <!-- form start -->
        <div class="form">
          <div class="box-body">
            <div class="row">
              <div class="col-lg-6">
                  <label>Kolom</label>
                  <input type="text" id="kolom" placeholder="kolom" class="form-control">
                  <input type="text" id="ruang_id" value="<?= $id_ruang ?>" style="display:none;" class="form-control">
              </div><!-- /.col-lg-6 -->
              <div class="col-lg-6">
                  <label>Baris</label>
                  <input type="text" id="baris" placeholder="baris" class="form-control">
              </div><!-- /.col-lg-6 -->
				<br><br><br><br>
	            <div class="box-header with-border">
		          <h3 class="box-title">Urutan :</h3>
		        </div><!-- /.box-header -->

               <div class="col-lg-4">
                  <label>Kolom</label>
                  <input type="radio" name="optionsRadios" id="optionsRadios1" value="urut_kolom" checked="">
              </div><!-- /.col-lg-6 -->
              <div class="col-lg-4">
                  <label>Baris</label>
                  <input type="radio" name="optionsRadios" id="optionsRadios1" value="urut_baris">
              </div><!-- /.col-lg-6 -->
            </div><br>

          </div><!-- /.box-body -->
          <div class="box-footer">
            <button type="submit" onclick="add_matrix('<?= $id_ruang ?>','<?= $nama_ruang ?>')" class="btn btn-info pull-right">Tambah</button>
          </div><!-- /.box-footer -->
        </div>
      </div><!-- /.box -->
    </div>


    <div class="col-md-7">
      <div class="box">
        <div class="box-header with-border">
          <h3 class="box-title">Bordered Table</h3>
        </div><!-- /.box-header -->
        <div class="box-body">
          <table id="example2" class="table table-bordered">
            <thead>
              <tr>
                <th style="padding: 1px;">No</th>
                <th style="padding: 1px;">Kursi</th>
                <th style="padding: 1px;">X, Y</th>
                <th style="padding: 1px;">Nama</th>
                <th style="padding: 1px;">Edit</th>
                <th style="padding: 1px;">Hapus</th>
              </tr>
            </thead>
            <tbody>
            
            {% set no=1 %}
            {% for v in mtrx %}
            <tr>
              <td style="padding: 1px;">{{no}}</td>
              <td style="padding: 1px;"><span class="badge bg-green">{{v.no_kursi}}</span></td>
              <td style="padding: 1px;">{{v.x}}, {{v.y}}</td>
              <td style="padding: 1px;">{{v.nama_kursi}}</td>
              <td style="padding: 1px;">
              <a id="edit" class="btn btn-primary btn-xs btn-flat" data-toggle="modal" data-target="#myModal{{v.no_kursi}}"><i class="glyphicon glyphicon-edit"></i> </a>
                  <!-- Modal -->
                  <div class="modal fade" id="myModal{{v.no_kursi}}" role="dialog">
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
					                  <label>Nama</label>
					                  <input type="text" value="{{v.nama_kursi}}" id="nama{{v.no_kursi}}" class="form-control">
					              </div>
                                </div><br>
                              </div><!-- /.box-body -->
                            </div>
                        </div>
                        <div class="modal-footer">
                          <button type="button" onclick="edit_matrix('{{v.conf_id}}','<?= $id_ruang ?>','{{v.no_kursi}}')" class="btn btn-info">Edit</button>
                          <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                        </div>
                      </div>
                      
                    </div>
                  </div>

              </td>
              <td>
                <input type="checkbox" id="ch" value="{{v.no_kursi}}">
              </td>
            </tr>
            {% set no=no+1 %}
            {% endfor %}

            </tbody>            
          </table>
          <button type="submit" onclick="del_matrix()" class="btn btn-info pull-right">Hapus</button>

        </div><!-- /.box-body -->
      </div><!-- /.box -->
    </div>

  </div>

      
</section><!-- /.content -->



<script type="text/javascript">
$(function () {
    // $('#example2').DataTable({
    //     "paging": true,
    //     "lengthChange": true,
    //     "searching": true,
    //     "ordering": false,
    //     "info": true,
    //     "autoWidth": true,
    //     "iDisplayLength": 25
    //   });
  });


function back() {
    var id_ruang = "<?= $id_ruang ?>";
    var nama_ruang = "<?= $nama_ruang ?>";

    var back = '{{ url("akdruang/konfigurasiRuang?id=") }}'+id_ruang+"&nama="+nama_ruang;
	go_page(back);
	
}

function reload() {
    var conf_id = "<?= $conf_id ?>";
    var nama_conf = "<?= $nama_conf ?>";
	var id_ruang = "<?= $id_ruang ?>";
	var nama_ruang = "<?= $nama_ruang ?>";

	var link = '{{ url("akdruang/matrixRuang/") }}';
    var datas = "conf_id="+conf_id+"&nama_conf="+nama_conf+"&nama_ruang="+nama_ruang+"&id_ruang="+id_ruang;
    reload_page_data(link,datas);  
}

function edit_matrix(conf_id,id_ruang,no_kursi) {
	var nama = $("#nama"+no_kursi).val();

	var datas = "conf_id="+conf_id+"&id_ruang="+id_ruang+"&no_kursi="+no_kursi+"&nama="+nama;
	var urel = '{{ url("akdruang/editMatrix/") }}';

	$.ajax({
	   type: "POST",
	   url: urel,
	   dataType : "json",
	   data: datas
	}).done(function( data ) {
		$('#myModal'+no_kursi).modal('hide');
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


function add_matrix() {
	var radio = $('input[name=optionsRadios]:checked').val();
	var kolom = $('#kolom').val();
	var ruang_id = $('#ruang_id').val();
	var baris = $('#baris').val();
	var conf_id = "<?= $conf_id ?>";

    var datas = "radio="+radio+"&kolom="+kolom+"&ruang_id="+ruang_id+"&baris="+baris+"&conf_id="+conf_id;
	var urel = '{{ url("akdruang/addMatrix") }}';
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
       	reload();
	});
	
}

function del_matrix(id,id_ruang,nama_ruang) {

	var no_kursi =[];
	$('input[type=checkbox]:checked').each(function(index){
	  no_kursi.push($(this).val());
	});
	no_kursi.toString();
	// console.log(no_kursi.length);
	var conf_id = "<?= $conf_id ?>";
	var id_ruang = "<?= $id_ruang ?>";

	var link = '{{ url("akdruang/delMatrix/") }}';
	var datas = "conf_id="+conf_id+"&id_ruang="+id_ruang+"&no_kursi="+no_kursi;
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

    if (no_kursi.length == 0) {
		new PNotify({
			title: 'Regular Notice',
			text: 'Pilih Ruang yang akan di hapus',
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
	             text: 'data telah dihapus',
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