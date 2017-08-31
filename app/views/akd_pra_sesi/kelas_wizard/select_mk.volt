<section class="content-header">
  <h1>
    <button type="button" onclick="back('{{thn_akd}}','{{session_id}}','{{thn_kur}}')" class="btn bg-navy btn-flat margin"><i class="fa fa-fw fa-arrow-left"></i> Back</button>
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
          <h3 class="box-title">Bordered Table</h3>
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
                <th>Kode</th>
                <th>Nama</th>
                <th>Sem</th>
                <th>SKS</th>
                <th>Kelas <span class="text-red">*Pisah dg koma(,)</span></th>
                <th>Aktif</th>
              </tr>
            </thead>
            <tbody>

            
            {% set no=1 %}
            {% for v in mk_select %}
<?php 
  if ( array_key_exists($v->kode_mk, $cek_mkkpkl)) { 
    $kls = implode(',',$cek_mkkpkl[$v->kode_mk]); 
  }else{
    $kls = '';
  }; 

  $check = ($v->thn_akd != '' && $v->session_id != '' ? "checked": "");
?>
            <tr>
              <td>{{no}}</td>
              <td>{{v.kode_mk}}</td>
              <td><a href="#">{{v.nama}}</a></td>
              <td>{{v.semester}}</td>
              <td>{{v.sks}}</td>
              <td><input type="text" name="nama_{{v.kode_mk}}" value="<?= $kls ?>"> </td>
              <td><input type="checkbox" value="{{v.kode_mk}}" <?= $check ?>></td>
            </tr>                   
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


<style type="text/css">
	.aktip{
		background: aliceblue;
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
  var thn_kur = "{{thn_kur}}";
  var thn_akd = $('#thn_akd').val();
  var session_id = $('#session_id').val();
  var datas = "thn_akd="+thn_akd+"&session_id="+session_id+"&thn_kur="+thn_kur;
  var link = '{{ url("manajemensesi/selectKur/") }}';
  reload_page_data(link,datas);
}

function back(thn_akd,session_id,thn_kur) {
  var datas = "thn_akd="+thn_akd+"&session_id="+session_id+"&thn_kur="+thn_kur;
  var link = '{{ url("manajemensesi/kelasWizard/") }}';
  go_page_data(link,datas);
}

function aktifkan(thn_akd,session_id) {
	var mk =[];
	$('input[type=checkbox]:checked').each(function(index){
	  mk.push($(this).val());
	});
  var thn_kur = "{{thn_kur}}";

  var form = $('form').serialize();
  var datas = form+"&mk="+mk+"&thn_kur="+thn_kur;

  var link = '{{ url("manajemensesi/simpanMk/") }}';
  // go_page_data(link,datas);
	
	if (mk.length == 0) {
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