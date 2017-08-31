<section class="content-header">
  <h1>
		<button type="button" onclick="back()" class="btn bg-navy btn-flat"><i class="fa fa-fw fa-arrow-left"></i> Back</button>
  </h1>
  <ol class="breadcrumb">
    <li><a href="#"><i class="fa fa-dashboard"></i> Akses</a></li>
    <li class="active">Sdm</li>
  </ol>
</section>

<!-- Main content -->
<section class="content">
  <div class="row">
    <!-- left column -->
    <div class="col-md-4">
    	<div class="box box-info">
        <div class="box-body">
    		<table id="" class="table table-bordered table-striped">
	    		<thead>
	              <tr>
	                <th>nip</th>
	                <th>Nama</th>
	              </tr>
	            </thead>
	            <tbody>    	
		            <tr>
						<td>{{nip}}</td>
						<td>{{nama}}</td>
		            </tr>
	            </tbody>            
          	</table>
        </div>
      </div><!-- /.box -->
    </div>

    <div class="col-md-5">
      <div class="box box-info">
        <div class="box-body">
		<form method="post">
    	<table id="" class="table table-bordered table-striped">
            <thead>
              <tr>
                <th class="text-center" style="padding: 0px; width: 10px">Select</th>
                <th class="text-center" style="padding: 0px;">Area</th>
              </tr>
            </thead>
            <tbody>
            
<?php $no=1; foreach ($list_area as $key => $value): ?>
<?php $att = (in_array($value['id'], $data_area)) ? "checked" : ""; ?>
	
            <tr>
				<td style="padding: 0px;"><input selecte type="checkbox" name="area_<?= $value['id'] ?>" value="<?= $value['id'] ?>" <?= $att ?>></td>
				<td style="padding: 0px;"><?= $value['label_menu'] ?></td>
            </tr>

<?php $no++; endforeach ?>

            </tbody>            
          </table><br>
          </form>
          <button onclick="pilih_area()" class="btn btn-block btn-success">Simpan</button>
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

function back() {
	var back = '{{ url("adminsetup/hakAksesSdm") }}';
	go_page(back);
}

function reload() {
	var nip = "{{nip}}";
	var nama = "{{nama}}";
	var datas = "nip="+nip+"&nama="+nama;
	var link = '{{ url("adminsetup/listAreaAkses/") }}';
	reload_page_data(link,datas);
}

function pilih_area() {
	var area =[];
	$('input[type=checkbox]:checked').each(function(index){
	  area.push($(this).val());
	});

	var datas = $('form').serialize();
	var link = '{{ url("adminsetup/addSdmArea/") }}';
	// console.log(datas);
    // go_page_data(link,datas);
	
	if (area.length == 0) {
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