<section class="content-header">
  <h1>
    <button type="button" onclick="back('{{thn_akd}}','{{session_id}}')" class="btn bg-navy btn-flat margin"><i class="fa fa-fw fa-arrow-left"></i> Back</button>
  </h1>
  <ol class="breadcrumb">
    <li><a href="#"><i class="fa fa-dashboard"></i> Setup</a></li>
    <li class="">Ruang</li>
    <li class="active">Aktif</li>
  </ol>
</section>

<!-- Main content -->
<section class="content">
  <div class="row">

    <div class="col-md-1"></div>
    <div class="col-md-10">
      <div class="box">
        <div class="box-header with-border">
          <h3 class="box-title">SET Kapasitas Kelas</h3>
        </div><!-- /.box-header -->
        <div class="box-body">
        <?php //echo "<pre>".print_r($cek_mkkpkl,1)."</pre>"; ?>
        <form method="post">
         	<input type="text" id="thn_akd" name="thn_akd" value="{{thn_akd}}" style="display: none;">
        	<input type="text" id="session_id" name="session_id" value="{{session_id}}" style="display: none;">
          <table id="" class="table table-bordered">
            <thead>
              <tr>
                <th style="width: 10px">No</th>
                <th>Thn Kur</th>
                <th>Kode</th>
                <th>Nama</th>
                <th>Kelas</th>
                <th>Prasyt Mhs</th>
                <th>Edit</th>
              </tr>
            </thead>
            <tbody>            
            {% set no=1 %}
            {% for v in mk %}

            <tr>
              <td>{{no}}</td>
              <td>{{v.thn_kur}}</td>
              <td>{{v.kode_mk}}</td>
              <td>{{v.nama}}</td>
              <td>{{v.nama_kelas}}</td>
              <td>{{v.prasyt_ang}}</td>
              <td>
              	<a id="edit" class="btn btn-primary btn-xs btn-flat" data-toggle="modal" data-target="#myModal{{v.id}}"><i class="glyphicon glyphicon-edit"></i> </a>
              	<div class="modal fade" id="myModal{{v.id}}" role="dialog">
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
 
                                  <div class="col-lg-7">
                                      <label>	Prasyt Mhs</label>
                                      <input type="text" value="{{v.prasyt_ang}}" id="prasyt{{v.id}}" class="form-control">
                                  </div>
                                </div>
                              </div><!-- /.box-body -->
                            </div>
                        </div>
                        <div class="modal-footer">
                          <button type="button" onclick="edit_kapasitas('{{v.id}}')" class="btn btn-info">Edit</button>
                          <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                        </div>
                      </div>
                      
                    </div>
                  </div>
              </td>

            </tr>                   
            {% set no=no+1 %}
            {% endfor %}

            </tbody>            
          </table>
        </form>

        </div><!-- /.box-body -->
      </div><!-- /.box -->
    </div>

  </div>
      
</section><!-- /.content -->


<style type="text/css">
	.over{
		/*background: crimson;*/
    	color: crimson;
	}
</style>

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
  var thn_akd = $('#thn_akd').val();
  var session_id = $('#session_id').val();
  var datas = "thn_akd="+thn_akd+"&session_id="+session_id;
  var link = '{{ url("manajemensesi/setAktifMhs/") }}';
  reload_page_data(link,datas);
}

function back(thn_akd,session_id,thn_kur) {
  var datas = "thn_akd="+thn_akd+"&session_id="+session_id;
  var link = '{{ url("manajemensesi/viewSession/") }}';
  go_page_data(link,datas);
}

  function edit_kapasitas(id) {
      var prasyt = $("#prasyt"+id).val();

      var datas = "prasyt="+prasyt;
      var urel = '{{ url("manajemensesi/submitAktifMhs/") }}'+id;
      
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
          
			reload();
			new PNotify({
				title: data.title,
				text: data.text,
				type: data.type
			});

        });
  }


</script>