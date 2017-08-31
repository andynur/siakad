<section class="content-header">
	<h1>
    <button type="button" onclick="back('{{sesi}}','{{id}}','{{ujian_id}}')" class="btn bg-navy btn-flat margin"><i class="fa fa-fw fa-arrow-left"></i> Back</button>
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
                <th>Hapus</th>
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
<td> <a href="javascript:void(0)" onclick="edit_jadwal('{{sesi}}','{{id}}','{{ujian_id}}','{{thn_kur}}','{{kode_mk}}','{{nama_kelas}}','<?= $id ?>')"> <?= $awal ?> </a></td>
<td> <a href="javascript:void(0)" onclick="edit_jadwal('{{sesi}}','{{id}}','{{ujian_id}}','{{thn_kur}}','{{kode_mk}}','{{nama_kelas}}','<?= $id ?>')"> <?= $akhir ?> </a></td>        
              <td>
                <?php foreach ($value['st_gabung'] as $k => $v): ?>
                  <?php  echo $v['thn_kur'].' '.$v['kode_mk']." kelas ".$v['nama_kelas'].' : '.$v['kapasitas']. '<br>' ?>
                <?php endforeach ?>
              </td>
              <td>
                <a id="delete" onclick="del('<?= $id ?>')" class="btn btn-danger btn-xs btn-flat">
                  <i class="glyphicon glyphicon-trash"></i>
                </a>
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
          <h3 class="box-title">TAMBAH JADWAL UJIAN</h3>
        </div><!-- /.box-header -->
        <div class="box-body">
        <form method="post">
        <input  type="text" name="jml_mhs" id="jml_mhs" style="display: none;" value="{{jml_mhs}}">
            <table class="table table-condensed">
              <tbody>
                <tr>
					<td style="padding: 11px 6px;width: 130px; background: #eee" class="text-left"><b>Awal :</b></td>
					<td>Tgl : <input  type="text" name="dd1" size="2" maxlength="2" value="<?= date('d') ?>">                 
					
						<select  name="mm1">
							<option value="1" selected="">Januari</option>
							<option value="2">Februari</option>
							<option value="3">Maret</option>
							<option value="4">April</option>
							<option value="5">Mei</option>
							<option value="6">Juni</option>
							<option value="7">Juli</option>
							<option value="8">Agustus</option>
							<option value="9">September</option>
							<option value="10">Oktober</option>
							<option value="11">November</option>
							<option value="12">Desember</option>
						</select>
					                
					<input  type="text" maxlength="4" name="yyyy1" size="4" value="<?= date('Y') ?>" >            
					 Jam : <input  type="text" name="t1" id="t1" size="5" maxlength="5" value=""></td>                  
                </tr>
                <tr>
					<td style="padding: 11px 6px;width: 130px; background: #eee" class="text-left"><b>Akhir :</b></td>
					<td>Tgl : <input  type="text" name="dd2" size="2" maxlength="2" value="<?= date('d') ?>">                 
					
						<select  name="mm2">
							<option value="1" selected="">Januari</option>
							<option value="2">Februari</option>
							<option value="3">Maret</option>
							<option value="4">April</option>
							<option value="5">Mei</option>
							<option value="6">Juni</option>
							<option value="7">Juli</option>
							<option value="8">Agustus</option>
							<option value="9">September</option>
							<option value="10">Oktober</option>
							<option value="11">November</option>
							<option value="12">Desember</option>
						</select>
					                
					<input  type="text" maxlength="4" name="yyyy2" size="4" value="<?= date('Y') ?>" >            
					 Jam : <input  type="text" name="t2" id="t2" size="5" maxlength="5" value=""></td>                  
                </tr>
                <tr>
                  <td style="padding: 11px 6px;width: 130px; background: #eee" class="text-left"><b>Ruang :</b></td>
                  	<td>
	                  	<div class="input-group">
	                      <select class="form-control" name="ruang_id" id="ruang_ujian" onchange="ruang(this);">
		                        <option value="" > </option>
	                       	{% for val in ruang %}
		                        <option value="{{val.ruang_id}}" >{{val.nama_ruang}} </option>
		                    {% endfor %}   
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
	                  	<div class="input-group" id="kap">
	                    </div><!-- /.input group -->
                   	</td>                  
                </tr>
              </tbody>
            </table>
            <input type="text" name="thn_kur" value="{{thn_kur}}" style="display: none;">
            <input type="text" name="kode_mk" value="{{kode_mk}}" style="display: none;">
            <input type="text" name="nama_kelas" value="{{nama_kelas}}" style="display: none;">
            <input type="text" name="ujian_id" value="{{ujian_id}}" style="display: none;">
            <input type="text" name="sesi" value="{{sesi}}" style="display: none;">
            <button style="margin: 0;" type="button" onclick="tambah()" class="btn bg-navy btn-flat pull-right"><i class="fa fa-fw fa-edit"></i> Tambah</button>
            </form>
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

function del(id) {
	var urel = '{{ url("akdjadwalujian/delJadwal") }}/'+id;
    (new PNotify({
        title: 'Confirmation Needed',
        text: 'Apakah Anda Yakin menghapus data ini?',
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
        }
    })).get().on('pnotify.confirm', function() {
        $.ajax({
            type: "POST",
            dataType: "JSON",
            url: urel,
            success: function(data){ 
                reload();
                new PNotify({
                     title: 'Regular Notice',
                     text: 'data telah dihapus',
                     type:'success'
                 });
            }
        });
    }).on('pnotify.cancel', function() {
       console.log('batal');
    });
}

function edit_jadwal(sesi,id,ujian_id,thn_kur,kode_mk,nama_kelas,id_jadwal_ujian) {
  var link = '{{ url("akdjadwalujian/formEdit/") }}'+id_jadwal_ujian;
  var datas = "sesi="+sesi+"&id="+id+"&ujian_id="+ujian_id+"&thn_kur="+thn_kur+"&kode_mk="+kode_mk+"&nama_kelas="+nama_kelas;
  go_page_data(link,datas);
}

function tambah() {

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
	var link = '{{ url("akdjadwalujian/tambahJadwal/") }}';
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
            var datas2 = "mhs_nya="+data.mhs_nya+"&id_yg_akan_digabungkan="+data.id_yg_akan_digabungkan+'&'+$("form").serialize();
            var link2 = '{{ url("akdjadwalujian/digabung/") }}';
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

function back(sesi,id,ujian_id) {
	var link = '{{ url("akdjadwalujian/listmk/") }}';
    var datas = "id="+id+"&ujian_id="+ujian_id+"&sesi="+sesi;
    go_page_data(link,datas);
}


</script>