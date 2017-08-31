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
                <th>Sem</th>
                <th>SKS</th>
                <th>Kelas</th>
                <th>Dosen</th>
                <th>Jml Mhs</th>
              </tr>
            </thead>
            <tbody>            
            {% set no=1 %}
            {% for v in mk %}
            <tr class="<?= $class ?>">
              <td>{{no}}</td>
              <td>{{v.thn_kur}}</td>
              <td>{{v.kode_mk}}</td>
              <td><a href="javascript:void(0)" onclick="">{{v.nama}}</a></td>
              <td>{{v.semester}}</td>
              <td>{{v.sks}}</td>
              <td>{{v.nama_kelas}}</td>
              <td>{{v.dosen}}</td>
              <td>{{v.jml_mhs}}</td>
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
  var link = '{{ url("manajemensesi/setKapasitasKelas/") }}';
  reload_page_data(link,datas);
}

function back(thn_akd,session_id,thn_kur) {
  var datas = "thn_akd="+thn_akd+"&session_id="+session_id;
  var link = '{{ url("manajemensesi/viewSession/") }}';
  go_page_data(link,datas);
}

function function_name(argument) {
	// body...
}

  function edit_kapasitas(id) {
      var kap = $("#kap"+id).val();
      var jml_mhs = $("#jml_mhs"+id).val();

      var datas = "kap="+kap+"&jml_mhs="+jml_mhs;
      var urel = '{{ url("manajemensesi/submitKapasitas/") }}'+id;
      
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