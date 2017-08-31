<section class="content-header">
    <h1><button type="button" onclick="back()" class="btn bg-navy btn-flat margin"><i class="fa fa-fw fa-arrow-left"></i> Back</button></h1>
    <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i> Mahasiswa</a></li>
        <li class="active">Skripsi</li>
    </ol>
</section>

<!-- Main content -->
<section class="content">

<div class="row">
    <div class="col-md-12">
        <div class="box">
            <div class="box-header">
              <h3 class="box-title">Mahasiswa Mengajukan Skripsi Baru TA  <span class="text-blue">{{sesi_nama}}</span></h3>
            </div><!-- /.box-header -->

            <div class="box-body">
            <form method="post">
                <input type="text" id="sesi" name="sesi" value="{{sesi}}" style="display: none;">
                <table class="table table-bordered" id="table" style="padding-right:0; margin-right:0;">
                    <thead>
                        <tr>
                            <td width="50">NO</td>
                            <td width="200">MHS</td>
                            <td>Skripsi</td>
                            <td width="200">Action</td>
                        </tr>
                    </thead>
                    <tbody>
                        <?php $no = 1 ?>
                        <?php foreach ($pengajuan as $key => $v): ?>
                        <?php 
                        if ($v['status'] == 'P') {
                        	$class = 'text-aqua';
                        }elseif ($v['status'] == 'Y') {
                        	$class = 'text-green';
                        }elseif ($v['status'] == 'N') {
                        	$class = 'text-red';
                        }

                        ?>
                            
                        <tr>
                            <td><?= $no ?></td>
                        	<td>
			                    <p>Nomhs : <?= $v['nomhs'] ?></p>
			                    <p>Nama : <?= $v['nama'] ?></p>
			                </td>
			                <td>
			                    <p>Judul Skripsi : <span class="<?= $class ?>"><?= $v['judul_skripsi'] ?></span></p>
			                    <p>Bidang Penelitian : <?= $v['bidang_penelitian'] ?></p>
			                    <p>Perusahaan : <?= $v['perusahaan'] ?></p>
			                    <p>Kota Perusahaan : <?= $v['kota_perusahaan'] ?></p>
			                    <p>Status : 
			                    	<?php if ($v['status'] == 'P'): ?>
	                            		<span class="text-aqua">Pengajuan</span>
	                            	<?php elseif($v['status'] == 'Y'): ?>
	                            		<span class="text-green">Diterima</span>
	                            	<?php elseif($v['status'] == 'N'): ?>
	                            		<span class="text-red">Ditolak</span>
	                            	<?php endif ?>
			                    </p>
			                </td>
                            <td>
	                            <button type="button" onclick="terima('<?= $v['id'] ?>')" class="btn bg-green btn-flat"><i class="fa fa-fw fa-pencil"></i> Terima</button>
	                            <button type="button" onclick="tolak('<?= $v['id'] ?>')" class="btn bg-red btn-flat"><i class="fa fa-fw fa-trash"></i> Tolak</button>
                            </td>
                        </tr>
                        <?php $no++; endforeach ?>
                    </tbody>
                </table>
                </form>
            </div>
        </div>
    </div>
</div>

</section><!-- /.content -->

<style type="text/css">
    .peringatan{
        background-color: #FFDDDD;
    }
</style>
<script type="text/javascript">

function reload() {
	var sesi = "{{sesi}}";
	var datas = 'sesi='+sesi;
	var link = '{{ url("akdskripsi/mhsPengajuan/") }}';
    reload_page_data(link,datas);
}

function back() {
    var link = '{{ url("akdskripsi/selectSesiAcc/") }}';
    go_page(link);
}

function terima(id) {
    var urel = '{{ url("akdskripsi/terimaSkripsi") }}/'+id;
    (new PNotify({
        title: 'Confirmation Needed',
        text: 'Apakah Anda Yakin Menerima Skripsi ini?',
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
            dataType: "JSON",
            url: urel,
            success: function(data){ 
                reload();
                new PNotify({
					title: data.title,
					text: data.text,
					type: data.type
				});
            }
        });
    }).on('pnotify.cancel', function() {
       console.log('batal');
    });
}

function tolak(id) {
    var urel = '{{ url("akdskripsi/tolakSkripsi") }}/'+id;
    (new PNotify({
        title: 'Confirmation Needed',
        text: 'Apakah Anda Yakin Menolak Skripsi ini?',
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
            dataType: "JSON",
            url: urel,
            success: function(data){ 
                reload();
                new PNotify({
					title: data.title,
					text: data.text,
					type: data.type
				});
            }
        });
    }).on('pnotify.cancel', function() {
       console.log('batal');
    });
}


</script>
