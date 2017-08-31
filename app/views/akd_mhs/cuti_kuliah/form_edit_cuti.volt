<?php date_default_timezone_set('Asia/Jakarta'); ?>
<section class="content-header">
    <h1><button type="button" onclick="back()" class="btn bg-navy btn-flat"><i class="fa fa-fw fa-arrow-left"></i> Back</button></h1>
    <ol class="breadcrumb">
        <li class="lead"><b>{{nama}}</b> - Nomhs : {{nomhs}} - Angkatan : {{angkatan}}</li>
    </ol>
</section>

<!-- Main content -->
<section class="content">

<?php foreach ($data_cuti as $key => $value): ?>
<?php 

$start = $value['tgl_start'];
$stop = $value['tgl_stop'];
$surat = $value['tgl_surat'];

$tgl_mulai = $newDate = date("d", strtotime($start));
$bln_mulai = $newDate = date("m", strtotime($start));
$thn_mulai = $newDate = date("Y", strtotime($start));

$tgl_akhir = $newDate = date("d", strtotime($stop));
$bln_akhir = $newDate = date("m", strtotime($stop));
$thn_akhir = $newDate = date("Y", strtotime($stop));


$tgl_surat = $newDate = date("d", strtotime($surat));
$bln_surat = $newDate = date("m", strtotime($surat));
$thn_surat = $newDate = date("Y", strtotime($surat));

?>
<form method="post">
    <div class="row">
        <div class="col-md-2"></div>
        <div class="col-md-8">
	      <div class="box">
	        <div class="box-header">
	          <h3 class="box-title">Edit Cuti Mahasiswa</h3>
	          <button type="button" class="btn bg-red btn-flat pull-right margin" onclick="del_data('<?= $value['cuti_id'] ?>')"><i class="fa fa-fw fa-trash"></i> Hapus</button>
	          <button type="button" class="btn bg-green btn-flat pull-right margin" onclick="edit_data()"><i class="fa fa-fw fa-plus"></i> Simpan</button>
	        </div><!-- /.box-header -->
	        <div class="box-body">

            <input name="id" type="hidden" id="id" value="<?= $value['cuti_id'] ?>" >
            <div class="col-lg-12">
                <div class="form-group">
                    <label>Keterangan <span style="color:red">*</span></label>
                    <input name="keterangan" type="text" value="<?= $value['keterangan'] ?>" class="form-control" >
                </div>
            </div><!-- /.col-lg-12 -->

            <div class="col-lg-3">
                <div class="form-group">
                    <label>Tanggal Mulai <span style="color:red">*</span></label>
                    <input name="tgl_mulai" type="text" value="<?= $tgl_mulai ?>" class="form-control" >
                </div>
            </div><!-- /.col-lg-12 -->
            <div class="col-lg-6">
                <div class="form-group">
                <label><span style="color:white">*</span></label>
                    <select class="form-control" name="bln_mulai">
                    	<?php foreach ($bulan as $k => $v): ?>
                    		<?php if ($bln_mulai == $k): ?>	
                        	<option value="<?= $k ?>" selected><?= $v ?></option>
                    		<?php else: ?>
                        	<option value="<?= $k ?>"><?= $v ?></option>
                    		<?php endif ?>
                    	<?php endforeach ?>
                    </select>
                </div>
            </div><!-- /.col-lg-12 -->
            <div class="col-lg-3">
                <div class="form-group">
                    <label><span style="color:white">*</span></label>
                    <input name="thn_mulai" type="text" value="<?= $thn_mulai ?>" class="form-control" >
                </div>
            </div><!-- /.col-lg-12 -->

            <div class="col-lg-3">
                <div class="form-group">
                    <label>Tanggal Akhir <span style="color:red">*</span></label>
                    <input name="tgl_akhir" type="text" id="tgl_akhir" value="<?= $tgl_akhir ?>" class="form-control" >
                </div>
            </div><!-- /.col-lg-12 -->
            <div class="col-lg-6">
                <div class="form-group">
                <label><span style="color:white">*</span></label>
                    <select class="form-control" name="bln_akhir">
                        <?php foreach ($bulan as $k => $v): ?>
                        	<?php if ($bln_akhir == $k): ?>	
                        	<option value="<?= $k ?>" selected><?= $v ?></option>
                    		<?php else: ?>
                        	<option value="<?= $k ?>"><?= $v ?></option>
                    		<?php endif ?>
                    	<?php endforeach ?>
                    </select>
                </div>
            </div><!-- /.col-lg-12 -->
            <div class="col-lg-3">
                <div class="form-group">
                    <label><span style="color:white">*</span></label>
                    <input name="thn_akhir" type="text" value="<?= $thn_akhir ?>" class="form-control" >
                </div>
            </div><!-- /.col-lg-12 -->

            <div class="col-lg-12">
                <div class="form-group">
                    <label>Nomor Surat <span style="color:red">*</span></label>
                    <input name="no_surat" type="text" value="<?= $value['no_surat'] ?>" class="form-control" >
                </div>
            </div><!-- /.col-lg-12 -->

            <div class="col-lg-3">
                <div class="form-group">
                    <label>Tanggal Surat <span style="color:red">*</span></label>
                    <input name="tgl_surat" type="text" id="tgl_mulai" value="<?= $tgl_surat ?>" class="form-control" >
                </div>
            </div><!-- /.col-lg-12 -->
            <div class="col-lg-6">
                <div class="form-group">
                <label><span style="color:white">*</span></label>
                    <select class="form-control" name="bln_surat">
                        <?php foreach ($bulan as $k => $v): ?>
                        	<?php if ($bln_surat == $k): ?>	
                        	<option value="<?= $k ?>" selected><?= $v ?></option>
                    		<?php else: ?>
                        	<option value="<?= $k ?>"><?= $v ?></option>
                    		<?php endif ?>
                    	<?php endforeach ?>
                    </select>
                </div>
            </div><!-- /.col-lg-12 -->
            <div class="col-lg-3">
                <div class="form-group">
                    <label><span style="color:white">*</span></label>
                    <input name="thn_surat" type="text" id="tgl_mulai" value="<?= $thn_surat ?>" class="form-control" >
                </div>
            </div><!-- /.col-lg-12 -->

        </div><!-- /.row -->

        </div>
      </div>
    </div>

</form>
<?php endforeach ?>

</section><!-- /.content -->

<script type="text/javascript">


function back() {
    var nama = "{{nama}}";
    var nomhs = "{{nomhs}}";
    var angkatan = "{{angkatan}}";
    var link = '{{ url("akdmhscuti/dataCutiMhs/") }}';
    var datas = 'nomhs='+nomhs+'&angkatan='+angkatan+'&nama='+nama;
    go_page_data(link,datas);
}

function reload() {
    var id = "{{id}}";
    var nama = "{{nama}}";
    var nomhs = "{{nomhs}}";
    var angkatan = "{{angkatan}}";
    var link = '{{ url("akdmhscuti/formEdit/") }}';
    var datas = 'id='+id+'&nomhs='+nomhs+'&angkatan='+angkatan+'&nama='+nama;
    go_page_data(link,datas);
}

function edit_data() {
    var link = '{{ url("akdmhscuti/updateCuti/") }}';
    var datas = $('form').serialize();
    $.ajax({
      type: "POST",
      url: link,
      dataType : "json",
      data: datas
    }).done(function( data ) {    
        new PNotify({
            title: data.title,
            text: data.text,
            type: data.type
        });
        back();
    });
}

function del_data(id) {
	var link = '{{ url("akdmhscuti/deleteCuti/") }}'+id;
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
	      url: link,
	      dataType : "json"
	    }).done(function( data ) {    
	        new PNotify({
	            title: data.title,
	            text: data.text,
	            type: data.type
	        });
	        back();
	    });
    }).on('pnotify.cancel', function() {
       console.log('batal');
    });
}

</script>
