<section class="content-header">
  <h1>
    <button type="button" onclick="back()" class="btn bg-navy btn-flat margin"><i class="fa fa-fw fa-arrow-left"></i> Back</button>
  </h1>
  <ol class="breadcrumb">
    <li><a href="#"><i class="fa fa-dashboard"></i> Setup</a></li>
    <li class="active">Manajemen</li>
  </ol>
</section>

<!-- Main content -->
<section class="content">
  
<div class="row">
  <div class="col-md-8">
    <div class="box">
        <div class="box-header">
          <h3 class="box-title">Edit Session </h3>
        </div><!-- /.box-header -->

        <form method="post" id="edit_sesi">
        {% for v in session %}
        <input type="text" id="thn_akd" name="thn_akd" value="{{v.thn_akd}}" style="display:none;">
        <input type="text" id="session_id" name="session_id" value="{{v.session_id}}" style="display:none;">
        <div class="box-body">
            <table class="table">
              <tbody>
                <tr>
                  <td class="judul text-left"><b>Tgl Mulai Berlakunya Sesi :</b></td>
                  <td>
                  	<div class="input-group">
                      <div class="input-group-addon">
                        <i class="fa fa-calendar"></i>
                      </div>
                      <input name="begin_dt" type="text" class="form-control pull-right" id="tgl_picker">
                    </div><!-- /.input group -->
                   </td>
                  <td class="text-center"></td>
                </tr>
                <tr>
                  <td class="judul text-left"><b>Tgl Akhir Berlakunya Sesi :</b></td>
                  <td>
                  <div class="input-group">
                      <div class="input-group-addon">
                        <i class="fa fa-calendar"></i>
                      </div>
                      <input name="end_dt" type="text" class="form-control pull-right" id="tgl_picker2">
                    </div><!-- /.input group -->
                   </td>                
                  <td></td>
                </tr>
                <tr>
                  <td class="judul text-left"><b>Jadwal KRS Online :</b></td>
                  <td>
                  {%for value in krs_ol %}
                  	<a href="javascript:void(0)" onclick="krs_online('{{value.ol_id}}')">{{value.nama_ol}}</a>
                  	<p>{{value.start}}</p>
                  	<p>{{value.akhir}}</p>
                  	<hr>
                  {% endfor %}
                  </td>
                  <td>
                  	<a class="btn btn-app" onclick="add_krs_online()"> <i class="fa fa-edit"></i> Baru </a>
                  </td>                  
                </tr>
                <tr>
                  <td class="judul text-left"><b>Max IP wajib PIN KRS :</b></td>                  
                  <td><input id="range1" name="ip_pin_krs" type="text" class="form-control porm" value="{{v.ip_pin_krs}}"></td>
                  <td></td>                  
                </tr>
                <tr>
                  <td class="judul text-left"><b>PIN KRS oleh Dosen Wali :</b></td>                  
                  <td>
                  	<input name="pin_krs_wali" type="checkbox" {% if v.pin_krs_wali == 'Y' %} checked {% endif %}> Ya
                  </td>
                  <td></td>                  
                </tr>
                <tr>
                  <td class="judul text-left"><b>Jatah SKS oleh Dosen Wali :</b></td>                  
                  <td><input name="max_sks_wali" type="checkbox" {% if v.max_sks_wali == 'Y' %} checked {% endif %}> Ya</td>
                  <td></td>                  
                </tr>
                <tr>
                  <td class="judul text-left"><b>Jatah SKS berdasar IPS :</b></td>                  
                  <td>
                  	<div class="col-md-3" style="padding-left: 0px;">
                  		<input name="ips_check" type="checkbox" {% if v.ips_check == 'Y' %} checked {% endif %}> Aktif
                  	</div>
                  	<div class="col-md-9">
                  	<select name="p_session" id="angkatan" class="form-control">                  	
                  	{% for val in tahun_sesi %}
                        <option value="{{val.thn_akd}}-{{val.session_id}}" <?php if ($v->pthn_akd.'-'.$v->psession_id == $val->thn_akd.'-'.$val->session_id) {echo "selected";} ?> >{{val.nama}} {{ helper.format_thn_akd(val.thn_akd) }}</option>
                    {% endfor %}                    
                    </select>
                  	</div>
                  </td>
                  <td></td>                  
                </tr>
                <tr>
                  <td class="judul text-left"><b>Jatah SKS berdasar IPK :</b></td>                  
                  <td><input name="ipk_check" type="checkbox" {% if v.ipk_check == 'Y' %} checked {% endif %}> Aktif</td>
                  <td></td>
                </tr>
                <tr>
                  <td class="judul text-left"><b>Pengajuan KRS akan dicek terhadap Pembayaran SPP :</b></td>
                  <td><input name="spp_check" type="checkbox" {% if v.spp_check == 'Y' %} checked {% endif %}> Cek</td>
                  <td></td>
                </tr>
                <tr>
                  <td class="judul text-left"><b>Blokir Pengajuan KRS :</b></td>                  
                  <td><input name="blockkrs" type="checkbox" {% if v.blockkrs == 'Y' %} checked {% endif %}> Blokir</td>
                  <td></td>
                </tr>
                <tr>
                  <td class="judul text-left"><b>Cek Eval Dosen Sebelum Pengajuan KRS :</b></td>                  
                  <td>
                    <div class="col-md-3" style="padding-left: 0px;">
                      <input name="evaldosen_check" type="checkbox" {% if v.evaldosen_check == 'Y' %} checked {% endif %}> Aktif
                    </div>
                    <div class="col-md-9">
                    <select name="evaldosen_check_sesi" id="angkatan" class="form-control">                    
                    {% for val in tahun_sesi %}
                        <option value="{{val.thn_akd}}-{{val.session_id}}" <?php if ($v->evaldosen_thn_akd.'-'.$v->evaldosen_session_id == $val->thn_akd.'-'.$val->session_id) {echo "selected";} ?> >{{val.nama}} {{ helper.format_thn_akd(val.thn_akd) }}</option>
                    {% endfor %}                    
                    </select>
                    </div>
                  </td>
                  <td></td>                  
                </tr>
                <tr>
                  <td class="judul text-left"><b>Pengajuan KRS akan dicek terhadap Peminjaman Buku :</b></td>
                  <td>
                  	<input name="libcheck" type="checkbox" {% if v.libcheck == 'Y' %} checked {% endif %}> Cek
                  	<p class="text-info">Peminjaman Sebelum Tanggal :</p>
                  	<div class="input-group">
                      <div class="input-group-addon">
                        <i class="fa fa-calendar"></i>
                      </div>
                      <input name="libcheck_dt" type="text" class="form-control pull-right" id="tgl_picker3">
                    </div>
                  </td>
                  <td></td>
                </tr>
                <tr>
                  <td class="judul text-left"><b></b></td>
                  <td></td>
                  <td><button style="margin: 0;" type="button" onclick="edit_sesi()" class="btn bg-navy btn-flat margin pull-right"><i class="fa fa-fw fa-save"></i> Simpan</button></td>
                </tr>
              </tbody>
            </table>
            {% endfor %}
        </div>
        </form>

    </div>
  </div>
  <div class="col-md-4">
  	<div class="box box-info">
        <div class="box-header with-border">
          <h3 class="box-title">Sesi</h3>
        </div><!-- /.box-header -->
        <div class="box-body no-padding">
            <div class="col-md-12">
              <i class="fa fa-fw fa-caret-square-o-right"></i>&nbsp;&nbsp;
              <a href="javascript:void(0)" onclick="krs_lintas_program()">KRS Lintas Program</a>
            </div>
            <div class="col-md-12">
              <i class="fa fa-fw fa-caret-square-o-right"></i>&nbsp;&nbsp;
              <a href="javascript:void(0)" onclick="ruang_aktif()">Ruang Aktif</a>
            </div>
            <div class="col-md-12">
              <i class="fa fa-fw fa-caret-square-o-right"></i>&nbsp;&nbsp;
              <a href="javascript:void(0)" onclick="dosen_aktif()">Dosen Aktif</a>
            </div>
            
            <!-- <div class="col-md-12">
              <i class="fa fa-fw fa-caret-square-o-right"></i>&nbsp;&nbsp;
              <a href="javascript:void(0)" onclick="pilih_mk()">Pemilihan Mata Kuliah</a>
            </div> -->

            <div class="col-md-12">
              <i class="fa fa-fw fa-caret-square-o-right"></i>&nbsp;&nbsp;
              <a href="javascript:void(0)" onclick="kwjb_bayar()">Kewajiban Pembayaran</a>
            </div>
            <div class="col-md-12">
              <i class="fa fa-fw fa-caret-square-o-right"></i>&nbsp;&nbsp;
              <a href="javascript:void(0)" onclick="definisi_ujian()">Buat Definisi Ujian</a>
            </div>
            <div class="col-md-12">
              <i class="fa fa-fw fa-caret-square-o-right"></i>&nbsp;&nbsp;
              <a href="javascript:void(0)" onclick="rumus_sks()">Rumus Jatah SKS</a>
            </div>
            <div class="col-md-12">
              <i class="fa fa-fw fa-caret-square-o-right"></i>&nbsp;&nbsp;
              <a href="javascript:void(0)" onclick="daftar_cekal()">Daftar Cekal Mhs</a>
            </div>
        </div>
      </div>
      <div class="box box-info">
        <div class="box-header with-border">
          <h3 class="box-title">Mata Kuliah</h3>
        </div><!-- /.box-header -->
        <div class="box-body no-padding">
            <div class="col-md-12">
              <i class="fa fa-fw fa-caret-square-o-right"></i>&nbsp;&nbsp;
              <a href="javascript:void(0)" onclick="kelas_wizard()">Pilih MK dan Set Jumlah Kelas</a>
            </div>
        </div>
      </div>
      <div class="box box-info">
        <div class="box-header with-border">
          <h3 class="box-title">Kelas</h3>
        </div><!-- /.box-header -->
        <div class="box-body no-padding">
            <div class="col-md-12">
              <i class="fa fa-fw fa-caret-square-o-right"></i>&nbsp;&nbsp;
              <a  href="javascript:void(0)" onclick="set_kapasitas_kls()">Set Kapasitas Kelas</a>
            </div>
            <div class="col-md-12">
              <i class="fa fa-fw fa-caret-square-o-right"></i>&nbsp;&nbsp;
              <a href="javascript:void(0)" onclick="mhs_kelas()">Mhs Aktif-Nonaktif</a>
            </div>
            <div class="col-md-12">
              <i class="fa fa-fw fa-caret-square-o-right"></i>&nbsp;&nbsp;
              <a href="javascript:void(0)" onclick="dosen_kelas()">Pilih Dosen Pengajar</a>
            </div>
            <div class="col-md-12">
              <i class="fa fa-fw fa-caret-square-o-right"></i>&nbsp;&nbsp;
              <a href="javascript:void(0)" onclick="transfer_peserta_kelas()">Transfer Peserta-Kelas</a>
            </div>
            <div class="col-md-12">
              <i class="fa fa-fw fa-caret-square-o-right"></i>&nbsp;&nbsp;
              <a href="javascript:void(0)" onclick="jadwal_nilai()">Jadwal Input Nilai</a>
            </div>

        </div>
      </div>
      <div class="box box-info">
        <div class="box-header with-border">
          <h3 class="box-title">Menu</h3>
        </div><!-- /.box-header -->
        <div class="box-body no-padding">
            <div class="col-md-12">
              <i class="fa fa-navicon"></i>&nbsp;&nbsp;
              <a href="#">Transfer KRS ke KHS</a>
            </div>
            <div class="col-md-12">
              <i class="fa fa-navicon"></i>&nbsp;&nbsp;
              <a href="#">Hapus Sesi</a>
            </div>
        </div>
      </div>
  </div>
</div>
      
</section><!-- /.content -->

<style type="text/css">

.judul{
	background: #eee;
	width: 200px;
    padding: 7px 5px;
}
.porm{
	height: 30px;
}

</style>


<script type="text/javascript">

$(function () {
	$('[data-toggle="tooltip"]').tooltip()
	$(".select2").select2();
	$("#tgl_picker").datepicker();
	$("#tgl_picker2").datepicker();
	$("#tgl_picker3").datepicker();

	$('#example2').DataTable({
	  "paging": true,
	  "lengthChange": true,
	  "searching": true,
	  "ordering": true,
	  "info": false,
	  "autoWidth": true
	});

	$("#tgl_picker").datepicker( "setDate" , "{{begin_dt}}" );
	$("#tgl_picker2").datepicker( "setDate" , "{{end_dt}}" );
	$("#tgl_picker3").datepicker( "setDate" , "{{libcheck_dt}}" );
});

function reload(thn_akd,session_id) {
	var link = '{{ url("manajemensesi/viewSession/") }}';
    var datas = "thn_akd="+thn_akd+"&session_id="+session_id;
    reload_page_data(link,datas);
}

function edit_sesi(argument) {
	var thn_akd = $('#thn_akd').val();
	var session_id = $('#session_id').val();
	var datas = $('form').serialize();

	var link = '{{ url("manajemensesi/UpdateSession/") }}';
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
    	reload(thn_akd,session_id);
    });
}

function back() {
    var link = '{{ url("manajemensesi/manSesi/") }}';
    go_page(link);
}

function krs_online(id) {
	var thn_akd = $('#thn_akd').val();
	var session_id = $('#session_id').val();
    var data = "thn_akd="+thn_akd+"&session_id="+session_id+"&id="+id;
    var link = '{{ url("manajemensesi/krsOnline/") }}';
    go_page_data(link,data);
}

function add_krs_online() {
	var thn_akd = $('#thn_akd').val();
	var session_id = $('#session_id').val();
    var datas = "thn_akd="+thn_akd+"&session_id="+session_id;
    var link = '{{ url("manajemensesi/addKrsOnline/") }}';
    $.ajax({
       type: "POST",
       url: link,
       dataType : "json",
       data: datas
    }).done(function( data ) {
      	if (data.status == true) {
    		krs_online(data.id);
      	}else{
      		new PNotify({
             title: 'Regular Notice',
             text: 'data telah dihapus',
             type:'success'
          });
      	}
    });
}

///////////////////////////////////////
//////////// MENU ////////////////////
///////////////////////////////////////
function menu_sesi(link) {
  var thn_akd = $('#thn_akd').val();
  var session_id = $('#session_id').val();
  var datas = "thn_akd="+thn_akd+"&session_id="+session_id;
  go_page_data(link,datas);
}

function kwjb_bayar() {
  var link = '{{ url("keupembayaran/kewajibanPembayaran/") }}';
  menu_sesi(link);
}
function krs_lintas_program() {
  var link = '{{ url("manajemensesi/aktifKrs/") }}';
  menu_sesi(link);
}
function ruang_aktif() {
  var link = '{{ url("manajemensesi/ruangAktif/") }}';
  menu_sesi(link);
}
function dosen_aktif() {
  var link = '{{ url("manajemensesi/dosenAktif/") }}';
  menu_sesi(link);
}
function kelas_wizard() {
  var link = '{{ url("manajemensesi/kelasWizard/") }}';
  menu_sesi(link);
}
function pilih_mk() {
  var link = '{{ url("manajemensesi/pilihMk/") }}';
  menu_sesi(link);
}
function set_kapasitas_kls() {
  var link = '{{ url("manajemensesi/setKapasitasKelas/") }}';
  menu_sesi(link);
}
function mhs_kelas() {
  var link = '{{ url("manajemensesi/setAktifMhs/") }}';
  menu_sesi(link);
}
function dosen_kelas() {
  var link = '{{ url("manajemensesi/setDosen/") }}';
  menu_sesi(link);
}
function transfer_peserta_kelas() {
  var link = '{{ url("manajemensesi/transferPesertaKelas/") }}';
  menu_sesi(link);
}
function jadwal_nilai() {
  var link = '{{ url("manajemensesi/jadwalInputNilai/") }}';
  menu_sesi(link);
}
function definisi_ujian() {
  var link = '{{ url("manajemensesi/definisiUjian/") }}';
  menu_sesi(link);
}
function rumus_sks() {
  var link = '{{ url("manajemensesi/rumusSks/") }}';
  menu_sesi(link);
}

function daftar_cekal() {
  var link = '{{ url("manajemensesi/daftarCekal/") }}';
  menu_sesi(link);
}

</script>