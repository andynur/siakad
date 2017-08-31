<section class="content-header">
	<h1>
    <button type="button" onclick="back('{{sesi}}','{{id}}','{{ujian_id}}','{{thn_kur}}','{{kode_mk}}','{{nama_kelas}}')" class="btn bg-navy btn-flat margin"><i class="fa fa-fw fa-arrow-left"></i> Back</button>
  </h1>
  <ol class="breadcrumb">
    <li><a href="#"><i class="fa fa-dashboard"></i> Setup</a></li>
    <li class="">Jadwal</li>
    <li class="active">Ujian</li>
  </ol>
</section>

<!-- Main content -->
<section class="content">
<div class="row">
    <div class="col-md-1"></div>
    <div class="col-md-10">
    <p>Jumlah Mahasiswa Total : {{jml_mhs}}</p>
      <div class="box">
        <div class="box-header with-border">
          <h3 class="box-title">JADWAL UJIAN</h3>
        </div><!-- /.box-header -->
        <div class="box-body">
          <table id="asd" class="table table-bordered table-striped">
            <thead>
              <tr>
                <th style="width: 10px">No</th>
                <th>Ruang</th>
                <th>Max Ruang</th>
                <th>Jml Mhs</th>
                <th>Mulai</th>
                <th>Selesai</th>
                <th>Gabung</th>
              </tr>
            </thead>
            <tbody>

            <?php $no=1; foreach ($dt_list_jad2 as $key => $value): ?>
            <?php 
                $id = $value['id'];
                $awal = $value['awal'];
                $akhir = $value['akhir'];
            ?>
            <tr>
              <td><?= $no ?></td>
              <td><?= $value['nama_ruang'] ?></td>
              <td><?= $value['volume'] ?></td>
              <td><?= $value['kapasitas'] ?></td>
              <td> <?= $awal ?></td>
              <td> <?= $akhir ?></td>        
              <td>
                <?php foreach ($value['st_gabung'] as $k => $v): ?>
                  <?php  echo $v['thn_kur'].' '.$v['kode_mk']." kelas ".$v['nama_kelas'].' : '.$v['kapasitas']. '<br>' ?>
                <?php endforeach ?>
              </td>
              </tr>

            <?php $no++; endforeach ?>

            </tbody>            
          </table>
        </div><!-- /.box-body -->
      </div><!-- /.box -->
    </div>

  </div>

<div class="row">
  <div class="col-md-2"></div>
  <div class="col-md-8">
    <div class="box">
        <div class="box-header">
          <h3 class="box-title">EDIT JADWAL UJIAN</h3>
        </div><!-- /.box-header -->
        <div class="box-body">

  		<?php foreach ($dt_list_jad2 as $key => $value): ?>
        <?php 

        	$awal = $value['awal'];
			$akhir = $value['akhir'];

			$tgl_awal = $newDate = date("d", strtotime($awal));
			$bln_awal = $newDate = date("m", strtotime($awal));
			$tahun_awal = $newDate = date("Y", strtotime($awal));
			$jam_awal = $newDate = date("H:i", strtotime($awal));

			$tgl_akhir = $newDate = date("d", strtotime($akhir));
			$bln_akhir = $newDate = date("m", strtotime($akhir));
			$tahun_akhir = $newDate = date("Y", strtotime($akhir));
			$jam_akhir = $newDate = date("H:i", strtotime($akhir));

			$mhs_campur = ($value['mhs_campur'] == 'Y') ? 'checked' : '';
			$gabung_st = ($value['gabung_st'] == 'Y') ? 'checked' : '';


        ?>
        <form method="post">
            <table class="table table-condensed">
              <tbody>
                <tr>
					<td style="padding: 11px 6px;width: 130px; background: #eee" class="text-left"><b>Awal :</b></td>
					<td>Tgl : <input  type="text" name="dd1" size="2" maxlength="2" value="<?= $tgl_awal ?>">                 
					
						<select  name="mm1">
							<?php foreach ($bulan as $a => $b): ?>
								<?php if ($bln_awal == $a): ?>
								<option value="<?= $a ?>" selected=""><?= $b ?></option>
								<?php endif ?>
								<option value="<?= $a ?>"><?= $b ?></option>
							<?php endforeach ?>
						</select>
					                
					<input  type="text" maxlength="4" name="yyyy1" size="4" value="<?= $tahun_awal ?>" >            
					 Jam : <input  type="text" name="t1" id="t1" size="5" maxlength="5" value="<?= $jam_awal ?>"></td>                  
                </tr>
                <tr>
					<td style="padding: 11px 6px;width: 130px; background: #eee" class="text-left"><b>Akhir :</b></td>
					<td>Tgl : <input  type="text" name="dd2" size="2" maxlength="2" value="<?= $tgl_akhir ?>">                 
					
						<select  name="mm2">
							<?php foreach ($bulan as $a => $b): ?>
								<?php if ($bln_akhir == $a): ?>
								<option value="<?= $a ?>" selected=""><?= $b ?></option>
								<?php else: ?>
								<option value="<?= $a ?>"><?= $b ?></option>
								<?php endif ?>
							<?php endforeach ?>
						</select>
					                
					<input  type="text" maxlength="4" name="yyyy2" size="4" value="<?= $tahun_akhir ?>" >            
					 Jam : <input  type="text" name="t2" id="t2" size="5" maxlength="5" value="<?= $jam_akhir ?>"></td>                  
                </tr>
                <tr>
                  <td style="padding: 11px 6px;width: 130px; background: #eee" class="text-left"><b>Ruang :</b></td>
                  	<td>
	                  	<div class="input-group">
	                      <select class="form-control" name="ruang_id" id="ruang_ujian" onchange="ruang(this);">
		                        <option value="" > </option>
		                    <?php foreach ($ruang as $a => $b): ?>
		                    	<?php if ($value['ruang_id'] == $b['ruang_id']): ?>
								<option value="<?= $b['ruang_id'] ?>" selected=""><?= $b['nama_ruang'] ?></option>
								<?php else: ?>
		                        <option value="<?= $b['ruang_id'] ?>" ><?= $b['nama_ruang'] ?> </option>
								<?php endif ?>
	                       	<?php endforeach ?>
	                      </select>
	                    </div><!-- /.input group -->
                   	</td>                  
                </tr>
                <tr>
                  <td style="padding: 11px 6px;width: 130px; background: #eee" class="text-left"><b>Konfigurasi :</b></td>
                  	<td>
	                  	<div class="input-group">
	                      <select id="konfigurasi" name="conf_id" class="form-control" onchange="kapasitas(this);" >
		                        <option value="" > </option>
	                      </select>
	                    </div><!-- /.input group -->
                   	</td>                  
                </tr>
                <tr>
                  <td style="padding: 11px 6px;width: 130px; background: #eee" class="text-left"><b>Kapasitas Ruang :</b></td>
                  	<td>
	                  	<div class="input-group" id="kap_ruang">
	                    </div><!-- /.input group -->
                   	</td>                  
                </tr>
                <tr>
                  <td style="padding: 11px 6px;width: 130px; background: #eee" class="text-left"><b>Jumlah MHS :</b></td>
                  	<td>
	                  	<div class="input-group" id="kap">
	                  		<input  type="text" maxlength="4" name="jml_mhs" size="4" value="<?= $value['kapasitas'] ?>" >
	                    </div><!-- /.input group -->
                   	</td>                  
                </tr>
                <tr>
                  <td style="padding: 11px 6px;width: 130px; background: #eee" class="text-left"><b>Mhs Campur :</b></td>
                  	<td>
	                  	<div class="input-group" id="kap">
	                  		<input type="checkbox" name="mhs_campur" value="Y" <?= $mhs_campur ?> >
	                    </div><!-- /.input group -->
                   	</td>                  
                </tr>
                <tr>
                  <td style="padding: 11px 6px;width: 130px; background: #eee" class="text-left"><b>St Gabung :</b></td>
                  	<td>
	                  	<div class="input-group" id="kap">
	                  		<input type="checkbox" name="st_gabung" value="Y" <?= $gabung_st ?> >
	                    </div><!-- /.input group -->
                   	</td>                  
                </tr>
              </tbody>
            </table>
            <input type="text" name="id_jadwal" value="<?= $value['id'] ?>" style="display: none;">
            <input type="text" name="ruang_id_sebelumnya" value="<?= $value['ruang_id'] ?>" style="display: none;">
            <input type="text" name="thn_kur" value="{{thn_kur}}" style="display: none;">
            <input type="text" name="kode_mk" value="{{kode_mk}}" style="display: none;">
            <input type="text" name="nama_kelas" value="{{nama_kelas}}" style="display: none;">
            <input type="text" name="ujian_id" value="{{ujian_id}}" style="display: none;">
            <input type="text" name="sesi" value="{{sesi}}" style="display: none;">
            <button style="margin: 0;" type="button" onclick="edit()" class="btn bg-navy btn-flat pull-right"><i class="fa fa-fw fa-edit"></i> Edit</button>
            </form>
        
        <?php endforeach ?>
        
        </div>
    </div>
  </div>
  <div class="col-md-3"></div>
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
	var id = "{{id}}";
	var ujian_id = "{{ujian_id}}";
	var sesi = "{{sesi}}";
	var thn_kur = "{{thn_kur}}";
	var kode_mk = "{{kode_mk}}";
	var nama_kelas = "{{nama_kelas}}";
	var link = '{{ url("akdjadwalujian/addJadwalForm/") }}';
    var datas = "id="+id+"&ujian_id="+ujian_id+"&sesi="+sesi+"&thn_kur="+thn_kur+"&kode_mk="+kode_mk+"&nama_kelas="+nama_kelas;
    reload_page_data(link,datas);
}


function edit() {

	var jam1 = $("#t1").val();
	var jam2 = $("#t2").val();
	var ruang_ujian = $("#ruang_ujian").val();
	if (jam1 == '' || jam2 == '' ) {
		new PNotify({
		   title: "warning",
		   text: "jam tidak boleh kosong",
		   type: "warning"
		});
	}

	if (ruang_ujian == '') {
		new PNotify({
		   title: "warning",
		   text: "Ruang boleh kosong",
		   type: "warning"
		});
	}

	var datas = $("form").serialize();
	var link = '{{ url("akdjadwalujian/editJadwal/") }}';
	// go_page_data(link,datas);
    $.ajax({
       type: "POST",
       url: link,
       dataType : "json",
       data: datas
    }).done(function( data ) {

      if (data.type == 'warning') {
        (new PNotify({
            title: 'Confirmation Needed',
            text: data.text,
            icon: 'glyphicon glyphicon-question-sign',
            after_init: function(notice) {
              notice.attention('swing');
            },
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
            },
            addclass: 'stack-modal',
            stack: {
                'dir1': 'down',
                'dir2': 'right',
                'modal': true
            }
        })).get().on('pnotify.confirm', function() {
            var datas2 = "gabung_action=gabung_action"+"mhs_nya="+data.mhs_nya+"&id_yg_akan_digabungkan="+data.id_yg_akan_digabungkan+'&'+$("form").serialize();
            var link2 = '{{ url("akdjadwalujian/editJadwal/") }}';
            // go_page_data(link2,datas2);
            // console.log(datas2);
            $.ajax({
               type: "POST",
               url: link2,
               dataType : "json",
               data: datas2
            }).done(function( data ) {
              reload();
              new PNotify({
                title: data.title,
                text: data.text,
                after_init: function(notice) {
                  notice.attention('swing');
                },
                type: data.type
              });
            });
        }).on('pnotify.cancel', function() {
            console.log('perbaiki');
        });
      }else{  
        reload();
      	new PNotify({
    		   title: data.title,
    		   text: data.text,
    		   type: data.type
    		});
      }
    });
}

function ruang(sel)
{
  kapasitas(0);
    var datas = "ruang_id="+sel.value;
	var link = '{{ url("akdjadwalujian/konfigurasiOption/") }}';
    $.ajax({
        method: "POST",
        dataType: "html",
        url: link,
        data: datas,
        success: function(res){
            $('#konfigurasi').html(res);
        }
    });
}

function kapasitas(conf_id)
{
    var datas = "conf_id="+conf_id.value;
	var link = '{{ url("akdjadwalujian/konfigurasiKapasitas/") }}';
    $.ajax({
        method: "POST",
        dataType: "html",
        url: link,
        data: datas,
        success: function(res){
            $('#kap').html(res);
        }
    });
}


function back(sesi,id,ujian_id,thn_kur,kode_mk ,nama_kelas) {
	var link = '{{ url("akdjadwalujian/addJadwalForm/") }}';
    var datas = "id="+id+"&ujian_id="+ujian_id+"&sesi="+sesi+"&thn_kur="+thn_kur+"&kode_mk="+kode_mk+"&nama_kelas="+nama_kelas;
    go_page_data(link,datas);
}


</script>