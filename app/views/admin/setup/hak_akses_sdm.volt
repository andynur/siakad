<section class="content-header">
  <h1>
    Hak Akses SDM
    <small>it all inform here</small>
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
    <div class="col-md-12">
      <div class="box box-info">
        <div class="box-body">

    	<table id="example2" class="table table-bordered table-striped">
            <thead>
              <tr>
                <th style="width: 10px">No</th>
                <th>nip</th>
                <th>Nama</th>
                <th>Akses Area</th>
              </tr>
            </thead>
            <tbody>
            
<?php $no=1; foreach ($sdm as $key => $value): ?>
	
            <tr>
				<td><?= $no ?></td>
				<td><?= $value['nip'] ?></td>
				<td><a href="javascript:void(0)" onclick="pilih_area('<?= $value['nip'] ?>','<?= $value['nama'] ?>')"><?= $value['nama'] ?></a></td>
				<td>
				<?php 
					$area_arr=explode(",",$value['area']);
					foreach ($area_arr as $k => $v) {
						if ($v != '') {
							echo $data_area[$v]."<br>";
						}
					}
				?>
				</td>
            </tr>

<?php $no++; endforeach ?>

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



function pilih_area(nip,nama) {

    var datas = "nip="+nip+"&nama="+nama;
    var link = '{{ url("adminsetup/listAreaAkses/") }}';
    go_page_data(link,datas);
}


</script>