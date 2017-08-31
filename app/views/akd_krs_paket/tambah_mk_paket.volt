<section class="content-header">
  <h1><button type="button" onclick="back()" class="btn bg-navy btn-flat margin"><i class="fa fa-fw fa-arrow-left"></i> Back</button></h1>
  <ol class="breadcrumb">
    <li><a href="#"><i class="fa fa-dashboard"></i> KRS</a></li>
    <li class="active">Paket</li>
  </ol>
</section>

<!-- Main content -->
<section class="content">
	<div class="row">
<div class="col-md-12">
  <div class="box">
    <div class="box-header" style="text-align: center;">
      <h2 class="box-title text-blue">Tahun Kurikulum</h2>
    </div>
    <div class="box-body">
    	<div class="col-md-5"></div>
    	<div class="col-md-2">    		
    	{% for v in tahun %}
			<button class="btn bg-navy btn-flat margin btn-block" onclick="list_kur('{{v.thn_kur}}')">{{v.thn_kur}}</button>
        {% endfor %}
    	</div>
    	<div class="col-md-5"></div>      
    </div>
  </div>
</div>
	</div>

  <div class="row">
    <div class="col-md-12">
      <div class="box">
        <div class="box-header with-border">
          <h3 class="box-title">DAFTAR MATA KULIAH</h3>
        </div><!-- /.box-header -->
        <div class="box-body data_mk">
          
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


function back() {
	var id = "{{id}}";
	var paket_id = "{{paket_id}}";
	var link = '{{ url("akdkrspaket/listMkPaket/") }}';
	var datas = 'id='+id+'&paket_id='+paket_id;
    go_page_data(link,datas);
}

function list_kur(thn) {
	var paket_id = "{{paket_id}}";
	var datas = "paket_id="+paket_id;
    var link = '{{ url("akdkrspaket/listMK/") }}'+thn;
    $.ajax({
		type: "POST",
		url: link,
		dataType : "html",
		data : datas
	}).done(function( data ) {
		$('.data_mk').html(data);
	}); 
}





</script>