<section class="content-header">
  <h1>
    <button type="button" onclick="back('{{thn_akd}}','{{session_id}}')" class="btn bg-navy btn-flat margin"><i class="fa fa-fw fa-arrow-left"></i> Back</button>
  </h1>
  <ol class="breadcrumb">
    <li><a href="#"><i class="fa fa-dashboard"></i> Setup</a></li>
    <li class="">Mata</li>
    <li class="active">Kuliah</li>
  </ol>
</section>

<!-- Main content -->
<section class="content">
  <div class="row">
  	<div class="col-md-4"></div>
  	<div class="col-md-4">
	  <div class="box">
	    <div class="box-header" style="text-align: center;">
	      <h2 class="box-title text-navy">Pilih Kurikulum Yang Ditawarkan:</h2>
	    </div>
	    <div class="box-body">
	    	<div class="col-md-12">    		
				<select name="thn_kur" id="thn_kur" class="form-control">
					{% for v in thn %}
					<option value="{{v.thn_kur}}">{{v.thn_kur}}</option>
					{% endfor %}
				</select>
				<button class="btn bg-navy margin btn-flat pull-right" onclick="cari_mk()"><i class="fa fa-fw fa-search"></i> Cari</button>
	    	</div>
	    </div>
	  </div>
	</div>
	<div class="col-md-4"></div>
  </div>
  <div class="row">

    <div class="col-md-1"></div>
    <div class="col-md-10">
      <div class="box">
        <div class="box-header with-border">
          <h3 class="box-title">Data Matakuliah</h3>
        </div><!-- /.box-header -->
        <div class="box-body">
        <form method="post">
         	<input type="text" id="thn_akd" name="thn_akd" value="{{thn_akd}}" style="display: none;">
        	<input type="text" id="session_id" name="session_id" value="{{session_id}}" style="display: none;">
        	<input type="text" id="thn_kur_aktif" name="thn_kur_aktif" value="{{thn_kur}}" style="display: none;">
          <table id="" class="table table-bordered table-striped">
            <thead>
              <tr>
                <th style="width: 10px">No</th>
                <th>Kode MK</th>
                <th>Nama</th>
                <th>Sem</th>
                <th>SKS</th>
                <th>Aktif</th>
              </tr>
            </thead>
            <tbody>

            
            {% set no=1 %}
            {% for v in mk %}

            <?php 
            // if ( in_array($v->nip, $s_aktif)) { $cek = "checked";}else{$cek = '';}; 
            ?>
            <tr>
              <td>{{no}}</td>
              <td>{{v.kode_mk}}</td>
              <td>{{v.nama}}</td>
              <td>{{v.semester}}</td>         
              <td>{{v.sks}}</td>         
              <td>
              	<input name="dosen_{{v.kode_mk}}" type="checkbox" style="float: left;width: 20%; margin-top: 10px;">
              </td>             
            {% set no=no+1 %}
            {% endfor %}

            </tbody>            
          </table>
        </form>
          <button type="button" onclick="aktifkan('{{thn_akd}}','{{session_id}}')" class="btn bg-navy btn-flat margin pull-right"><i class="fa fa-fw fa-save"></i> Simpan</button>
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
  var thn_akd = $('#thn_akd').val();
  var session_id = $('#session_id').val();
  var thn_kur = $('#thn_kur_aktif').val();
  var datas = "thn_akd="+thn_akd+"&session_id="+session_id+"&thn_kur="+thn_kur;
  var link = '{{ url("manajemensesi/pilihMk/") }}';
  reload_page_data(link,datas);
}

function back(thn_akd,session_id) {
	var link = '{{ url("manajemensesi/viewSession/") }}';
    var datas = "thn_akd="+thn_akd+"&session_id="+session_id;
    go_page_data(link,datas);
}

function cari_mk() {
  var thn_akd = $('#thn_akd').val();
  var session_id = $('#session_id').val();
  var thn_kur = $('#thn_kur').val();
  var datas = "thn_akd="+thn_akd+"&session_id="+session_id+"&thn_kur="+thn_kur;
  var link = '{{ url("manajemensesi/pilihMk/") }}';
  reload_page_data(link,datas);
}

function aktifkan(thn_akd,session_id) {
	var sdm =[];
	$('input[type=checkbox]:checked').each(function(index){
	  sdm.push($(this).val());
	});

	var datas = $('form').serialize();
	var link = '{{ url("manajemensesi/addSdmAktif/") }}';
	console.log(datas);
    // go_page_data(link,datas);
	
	if (sdm.length == 0) {
		new PNotify({
			title: 'Regular Notice',
			text: 'Pilih Ruang yang akan di Aktifkan',
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
	             text: 'data telah Di Simpan',
	             type:'success'
	          });
	        reload();
	    });    	
    }

}
</script>