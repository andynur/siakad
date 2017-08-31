<section class="content-header">
  <h1>
    <button type="button" onclick="back()" class="btn bg-navy btn-flat margin"><i class="fa fa-fw fa-arrow-left"></i> Back</button>
  </h1>
  <ol class="breadcrumb">
    <li><a href="#"><i class="fa fa-dashboard"></i> Setup</a></li>
    <li class="">KRS</li>
    <li class="active">Online</li>
  </ol>
</section>

<!-- Main content -->
<section class="content">
  
<div class="row">
<div class="col-md-2"></div>
  <div class="col-md-8">
    <div class="box">
        <div class="box-header">
          <h3 class="box-title">Edit Session </h3>
        </div><!-- /.box-header -->

        <form method="post" id="edit_krs_ol">
        {% for v in krs_ol %}
        <input type="text" id="thn_akd" name="thn_akd" value="{{v.thn_akd}}" style="display:none;">
        <input type="text" id="session_id" name="session_id" value="{{v.session_id}}" style="display:none;">
        <input type="text" id="ol_id" name="ol_id" value="{{v.ol_id}}" style="display:none;">
        <input type="text" id="id" name="id" value="{{v.id}}" style="display:none;">
        <div class="box-body">
            <table class="table">
              <tbody>
              	<tr>
                  <td></td>                
                  <td class="text-aqua text-left"><b>STATUS</b></td>
                  <td></td>
                </tr>
                <tr>
                  <td class="judul text-left"><b>Status Aktif :</b></td>
                  <td><input name="aktif" type="checkbox" {% if v.aktif == 'Y' %} checked {% endif %}> Ya
                   </td>
                  <td class="text-center"></td>
                </tr>
                <tr>
                  <td class="judul text-left"><b>Nama Online :</b></td>
                  <td>
                  	<div class="input-group">
                      <input name="nama_ol" type="text" class="form-control pull-right porm" value="{{v.nama_ol}}">
                    </div><!-- /.input group -->
                   </td>                
                  <td></td>
                </tr>
                <tr>
                  <td></td>                
                  <td class="text-aqua text-left"><b>WAKTU</b></td>
                  <td></td>
                </tr>
                <tr>
                  <td class="judul text-left"><b>Waktu Mulai :</b></td>
                  <td>
                  	<div class="input-group">
                      <div class="input-group-addon">
                        <i class="fa fa-calendar"></i>
                      </div>
                      <input name="start" type="text" class="form-control pull-right" id="tgl_picker">
                    </div><!-- /.input group -->
                   </td>   
                   <td>
	                	<div class="bootstrap-timepicker">
		                  	<div class="input-group">
		                      <div class="input-group-addon">
		                        <i class="fa fa-clock-o"></i>
		                      </div>
		                      <input name="start_time" type="text" class="form-control pull-right timepicker">
		                    </div
	                    </div>
                   </td>                
                </tr>
                <tr>
                  <td class="judul text-left"><b>Waktu Akhir :</b></td>
                  	<td>
	                  	<div class="input-group">
	                      <div class="input-group-addon">
	                        <i class="fa fa-calendar"></i>
	                      </div>
	                      <input name="end" type="text" class="form-control pull-right" id="tgl_picker2">
	                    </div><!-- /.input group -->
                   	</td>                
                  	<td>
	                	<div class="bootstrap-timepicker">
		                  	<div class="input-group">
		                      <div class="input-group-addon">
		                        <i class="fa fa-clock-o"></i>
		                      </div>
		                      <input name="end_time" type="text" class="form-control pull-right timepicker2">
		                    </div
	                    </div>
                   	</td>        
                </tr>
                <tr>
                  <td></td>                
                  <td class="text-aqua text-left"><b>Jatah Maximum Pengambilan MK/SKS</b></td>
                  <td></td>
                </tr>

                <tr>
                  <td class="judul text-left"><b>Max Pengambilan MK :</b></td>
                  <td>
                  	<div class="input-group">
                      <input name="mkmax" type="text" class="form-control pull-right porm" value="{{v.mkmax}}">
                    </div><!-- /.input group -->
                   </td>                
                  <td></td>
                </tr>
                <tr>
                  <td class="judul text-left"><b>Max Pengambilan MK baru :</b></td>
                  <td>
                  	<div class="input-group">
                      <input name="mkbarumax" type="text" class="form-control pull-right porm" value="{{v.mkbarumax}}">
                    </div><!-- /.input group -->
                   </td>                
                  <td></td>
                </tr>
                <tr>
                  <td class="judul text-left"><b>Max Pengambilan MK ulang :</b></td>
                  <td>
                  	<div class="input-group">
                      <input name="mkulangmax" type="text" class="form-control pull-right porm" value="{{v.mkulangmax}}">
                    </div><!-- /.input group -->
                   </td>                
                  <td></td>
                </tr>
                <tr>
                  <td class="judul text-left"><b>Max Pengambilan SKS :</b></td>
                  <td>
                  	<div class="input-group">
                      <input name="sksmax" type="text" class="form-control pull-right porm" value="{{v.sksmax}}">
                    </div><!-- /.input group -->
                   </td>                
                  <td></td>
                </tr>
                <tr>
                  <td class="judul text-left"><b>Max Pengambilan SKS baru :</b></td>
                  <td>
                  	<div class="input-group">
                      <input name="sksbarumax" type="text" class="form-control pull-right porm" value="{{v.sksbarumax}}">
                    </div><!-- /.input group -->
                   </td>                
                  <td></td>
                </tr>
                <tr>
                  <td class="judul text-left"><b>Max Pengambilan SKS ulang :</b></td>
                  <td>
                  	<div class="input-group">
                      <input name="sksulangmax" type="text" class="form-control pull-right porm" value="{{v.sksulangmax}}">
                    </div><!-- /.input group -->
                   </td>                
                  <td></td>
                </tr>

                <tr>
                  <td></td>                
                  <td class="text-aqua text-left"><b>Penalti Terlambat</b></td>
                  <td></td>
                </tr>
                <tr>
                  <td class="judul text-left"><b>Max adalah penalti :</b></td>                  
                  <td>
                  	<input name="jatahfix" type="checkbox" {% if v.jatahfix == 'Y' %} checked {% endif %} > Ya
                  </td>
                  <td></td>                  
                </tr>
                <tr>
                  <td class="judul text-left"><b>MK penalti :</b></td>
                  <td>
                  	<div class="input-group">
                      <input name="mkpenalti" type="text" class="form-control pull-right porm" value="{{v.mkpenalti}}">
                    </div><!-- /.input group -->
                   </td>                
                  <td></td>
                </tr>
                <tr>
                  <td class="judul text-left"><b>SKS penalti :</b></td>
                  <td>
                  	<div class="input-group">
                      <input name="skspenalti" type="text" class="form-control pull-right porm" value="{{v.skspenalti}}">
                    </div><!-- /.input group -->
                   </td>                
                  <td></td>
                </tr>

                <tr>
                  <td></td>                
                  <td class="text-aqua text-left"><b>Perbaikan</b></td>
                  <td></td>
                </tr>



                <tr>
                  <td class="judul text-left"><b>Boleh Batal MK :</b></td>                  
                  <td><input name="batalmk" type="checkbox" {% if v.batalmk == 'Y' %} checked {% endif %}> Ya</td>
                  <td></td>                  
                </tr>

                <tr>
                  <td class="judul text-left"><b>Boleh Pindah Kelas :</b></td>                  
                  <td><input name="pindahkls" type="checkbox" {% if v.pindahkls == 'Y' %} checked {% endif %}> Ya</td>
                  <td></td>
                </tr>
                <tr>
                  <td class="judul text-left"><b>Boleh Ganti MK :</b></td>
                  <td><input name="gantimk" type="checkbox" {% if v.gantimk == 'Y' %} checked {% endif %}> Ya</td>
                  <td></td>
                </tr>
                <tr>
                  <td class="judul text-left"><b>Nilai Kosong Dipinjami :</b></td>
                  <td>
                  	<input name="pinjaman" type="checkbox" {% if v.pinjaman == 'Y' %} checked {% endif %}> Ya
                  	<p class="text-info"> Nilai Pinjaman :</p>
                  	<div class="input-group">
                      <input name="npinjaman" type="text" class="form-control pull-right" value="{{v.npinjaman}}">
                    </div>
                  </td>
                  <td></td>
                </tr>
                <tr>
                  <td class="judul text-left"><b></b></td>
                  <td></td>
                  <td>
                  <button style="margin: 0;" type="button" onclick="hapus_krs_ol('{{v.id}}')" class="btn bg-navy btn-flat margin "><i class="fa fa-fw fa-trash"></i> Hapus</button>
                  <button style="margin: 0;" type="button" onclick="edit_krs_ol()" class="btn bg-navy btn-flat margin pull-right"><i class="fa fa-fw fa-save"></i> Simpan</button>
                  </td>
                </tr>
              </tbody>
            </table>
            {% endfor %}
        </div>
        </form>

    </div>
  </div>
  <div class="col-md-2"></div>
</div>
      
</section><!-- /.content -->

<style type="text/css">

.judul{
	background: #eee;
	width: 200px;
    padding: 7px 5px;
}
.porm{
	height: 25px;
}

</style>


<script type="text/javascript">

$(function () {
	$('[data-toggle="tooltip"]').tooltip()
	$(".select2").select2();
	$("#tgl_picker").datepicker();
	$("#tgl_picker2").datepicker();

	$("#tgl_picker").datepicker( "setDate" , "{{start}}" );
	$("#tgl_picker2").datepicker( "setDate" , "{{end}}" );
	// $('.timepicker').timepicker({defaultTime: '{{start_time}}'});
	// $('.timepicker2').timepicker({defaultTime: '{{end_time}}'});


	$(".timepicker").timepicker({
		showInputs: false,
		defaultTime: '{{start_time}}'
	});
	$(".timepicker2").timepicker({
		showInputs: false,
		defaultTime: '{{end_time}}'
	});


});

function back() {
	var thn_akd = $('#thn_akd').val();
	var session_id = $('#session_id').val();
	var link = '{{ url("manajemensesi/viewSession/") }}';
    var datas = "thn_akd="+thn_akd+"&session_id="+session_id;
    go_page_data(link,datas);
}


function reload() {
	var thn_akd = $('#thn_akd').val();
	var session_id = $('#session_id').val();
	var id_ol = $('#ol_id').val();
    var data = "thn_akd="+thn_akd+"&session_id="+session_id+"&id="+id_ol;
    var link = '{{ url("manajemensesi/krsOnline/") }}';
    reload_page_data(link,data);
}

function hapus_krs_ol(id) {
	var link = '{{ url("manajemensesi/delKrs/") }}'+id;
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
         type: "GET",
         url: link,
         dataType : "json",
      }).done(function( data ) {
          new PNotify({
             title: 'Regular Notice',
             text: 'data telah dihapus',
             type:'success'
          });
          back();
      });
    }).on('pnotify.cancel', function() {
       console.log('batal');
    });
}

function edit_krs_ol() {
	var datas = $('form').serialize();
	var link = '{{ url("manajemensesi/editKrs/") }}';
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
    	reload();
    });
}
  
</script>