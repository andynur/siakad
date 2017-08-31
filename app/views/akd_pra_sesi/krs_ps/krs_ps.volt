<section class="content-header">
  <h1><button type="button" onclick="back('{{thn_akd}}','{{session_id}}')" class="btn bg-navy btn-flat margin"><i class="fa fa-fw fa-arrow-left"></i> Back</button></h1>
  <ol class="breadcrumb">
    <li><a href="#"><i class="fa fa-dashboard"></i> KRS</a></li>
    <li class="active">Program Studi</li>
  </ol>
</section>

<!-- Main content -->
<section class="content">
  <div class="row">

    <div class="col-md-7">
      <div class="box">
        <div class="box-header">
          <h3 class="box-title">PILIH PROGRAM STUDI YANG DIIJINKAN KRS DI SINI :</h3>
        </div><!-- /.box-header -->
        <div class="box-body">
        <form method="post">
        <input type="text" id="thn_akd" name="thn_akd" value="{{thn_akd}}" style="display: none;">
        <input type="text" id="session_id" name="session_id" value="{{session_id}}" style="display: none;">
        <input type="text" name="jml_krs_ol" value="<?= count($krs_ol) ?>" style="display: none;">
          <table id="" class="table table-bordered table-striped">
            <thead>
              <tr>
                <th style="width: 10px">No</th>
                <th style="width: 70px;">Id PS</th>
                <th>Nama</th>
                <?php foreach ($krs_ol as $key): ?>
                	<th><?= $key ?></th>
                <?php endforeach ?>
              </tr>
            </thead>
            <tbody>
            <?php 
            $check_ps = [];
      			$mhsol_ps = [];
            foreach ($cross as $key => $value) {
              $ps_ol = $value['ps_allow']."-".$value['ol_id'];
              $check_ps[] = $ps_ol;
              $mhsol_ps[$ps_ol] = $value['mhsprasyt'];
            }

             ?>
            <?php $no=1; foreach ($ps as $key => $value): ?>
            	
            <tr>
              <td><?= $no ?></td>
              <td><span class="label label-success"><?= $value['id_ps'] ?></span></td>
              <td>
              	<p><?= $value['fak'] ?> <span style="text-info"><?= $value['nama'] ?></span><span style="text-green"><?= $value['jenjang'] ?></span></p>
              </td>
              <?php foreach ($krs_ol as $k => $v): ?>
              <?php 
	              $ps_online = $value['id_ps']."-".$k;  
	              if ( in_array($ps_online, $check_ps)) { $cek = "checked";}else{$cek = '';}; 
	              if ( array_key_exists($ps_online, $mhsol_ps)) { $mhsprasyt = $mhsol_ps[$ps_online];}else{$mhsprasyt = '';}; 
              ?>
              <td>
              	<input name="cek_<?= $ps_online ?>" type="checkbox" style="float: left;width: 20%; margin-top: 10px;" <?= $cek ?> > 
              	<input name="mhsprasyt_<?= $ps_online ?>" type="text" style="width:80%" class="form-control" placeholder="Enter ..." value="<?= $mhsprasyt ?>">
              </td>
                <?php endforeach ?>
            </tr>
            <?php $no++; endforeach ?>


            </tbody>            
          </table>
          </form>
          <button type="button" onclick="simpan('{{thn_akd}}','{{session_id}}')" class="btn bg-navy btn-flat margin pull-right"><i class="fa fa-fw fa-save"></i> Simpan</button>
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
  var datas = "thn_akd="+thn_akd+"&session_id="+session_id;
  var link = '{{ url("manajemensesi/aktifKrs/") }}';
  reload_page_data(link,datas);
}

function back(thn_akd,session_id) {
	var link = '{{ url("manajemensesi/viewSession/") }}';
    var datas = "thn_akd="+thn_akd+"&session_id="+session_id;
    go_page_data(link,datas);
}

function simpan(thn_akd,session_id) {
	var datas = $('form').serialize();
	// console.log(datas);
	var link = '{{ url("manajemensesi/simpanKrsPs/") }}';
	// go_page_data(link,datas);
    $.ajax({
       type: "POST",
       url: link,
       dataType : "json",
       data: datas
    }).done(function( data ) {
  		new PNotify({
			title: 'Regular Notice',
			text: 'data telah di Rubah',
			type:'success'
		});
		reload();
    });
}

</script>