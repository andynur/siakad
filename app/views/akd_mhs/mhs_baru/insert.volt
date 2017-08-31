<section class="content-header">
  <h1>
    Add MHS
    <small>it all starts here</small>
  </h1>
  <ol class="breadcrumb">
    <li><a href="#"><i class="fa fa-dashboard"></i> MHS</a></li>
    <li class="active">Add MHS</li>
  </ol>
</section>

<!-- Main content -->
<section class="content">
  {#buat input no mhs & nama mhs#}
  <div class="row">
    <div class="col-lg-2">
    </div>

    <div class="col-lg-8">
      <!-- general form elements -->
      <div class="box box-info">
        <div class="box-header with-border">
          <h3 class="box-title">Add Mahasiswa</h3>
        </div>
        <!-- /.box-header -->
        <!-- form start -->

        <form method="post" class="edit_form" id="form_edit">
          <div class="box-body" style="height:auto;">
            <!-- Modal -->
            <div class="row">

              <div class="col-lg-12">

                <div class="col-lg-12" style="background: #ddd; text-align:center; height:25px">
                  <label ></label>
                </div><!-- /.col-lg-12 -->

                <div class="col-lg-9">
                  <div class="row">
                    <div class="col-lg-7">
                      <div class="form-group">
                        <label>No Mahasiswa <span style="color:red">*</span></label>
                        <input value="" name="id_mhs" type="text" id="id_mhs" placeholder=" No Mhahasiswa" class="form-control" >
                      </div>
                    </div><!-- /.col-lg-12 -->

                    <div class="col-lg-5">
                      <div class="form-group">
                        <label>Angkatan<span style="color:red">*</span></label>
                        <select class="form-control" name="angkatan" id="angkatan">
                          {% set thn = 2000 %}
                          {% set thn_now = date('Y') %}
                          {% for a in thn_now..thn %}
                          <option value="{{a}}">{{a}}</option>
                          {% endfor %}
                        </select>
                      </div>
                    </div><!-- /.col-lg-12 -->

                    <div class="col-lg-7">
                      <div class="form-group">
                        <label>Nama <span style="color:red">*</span></label>
                        <input value="" name="nama" type="text" id="nama" placeholder=" Nama" class="form-control" >
                      </div>
                    </div><!-- /.col-lg-12 -->

                    <div class="col-lg-5">
                      <div class="form-group">
                        <label>Agama <span style="color:red">*</span></label>
                        <select class="form-control" name="agama" id="agama">
                        <option id="agama_now" value="">-- Pilih Agama --</option>
                          {% for a in agama %}
                          <option value="{{ a.id_agama }}">{{ a.nama }}</option>
                          {% endfor %}
                        </select>
                      </div>
                    </div><!-- /.col-lg-12 -->

                    <div class="col-lg-7">
                      <div class="form-group">
                        <label>Jenis Kelamin <span style="color:red">*</span></label>
                        <div class="jk">
                          <input name="jeniskelamin" type="radio" value="l" id="jeniskelamin_l"> Laki-Laki
                          <input name="jeniskelamin" type="radio" value="p" id="jeniskelamin_p"> Perempuan
                        </div>
                      </div>
                    </div><!-- /.col-lg-12 -->

                    <div class="col-lg-5">
                      <div class="form-group">
                        <label>NIK</label>
                        <input name="nik" type="text" id="nik" placeholder=" NIK" class="form-control">
                      </div>
                    </div><!-- /.col-lg-12 -->

                  </div>
                </div>

                <div class="col-lg-3" >
                  <div class="row">
                    <div class="form-group">
                      <label>Foto</label>
                      <div style="background: #ddd; width:100%; height:185px; align-text:center;">
                        <img src="" alt="foto" style="align: center">
                      </div><!-- /.col-lg-12 -->
                    </div>
                  </div>
                </div>

                <div class="col-lg-12" style="background: #ddd; text-align:center;">
                  <label >Alamat Sekarang</label>
                </div><!-- /.col-lg-12 -->

                <div class="col-lg-12">
                  <div class="form-group">
                    <label>Alamat</label>
                    <input  name="alamat1" type="text" id="alamat1" placeholder=" Alamat" class="form-control">
                  </div>
                </div><!-- /.col-lg-12 -->

                <div class="col-lg-6">
                  <div class="form-group">
                    <label>Telepon</label>
                    <input  name="telepon1" type="text" id="telepon1" placeholder=" Telepon" class="form-control" >
                  </div>
                </div><!-- /.col-lg-12 -->

                <div class="col-lg-6">
                  <div class="form-group">
                    <label>Provinsi</label>
                    <select class="form-control" name="provinsi1" id="provinsi1">
                      <option id="provinsi_now1" value="">-- Pilih Provinsi --</option>
                      {% for a in provinsi %}
                      <option value="{{ a.id }}">{{ a.name }}</option>
                      {% endfor %}
                    </select>
                  </div>
                </div><!-- /.col-lg-12 -->

                <div class="col-lg-6">
                  <div class="form-group">
                    <label>Kode Pos</label>
                    <input  name="kode_pos1" type="text" id="kode_pos1" placeholder=" Kode Pos" class="form-control" >
                  </div>
                </div><!-- /.col-lg-12 -->

                <div class="col-lg-6" id="kota_col1" style="display:none;">
                  <div class="form-group">
                    <label>Kota</label>
                    <select class="form-control" name="kota1" id="kota1">
                    </select>
                  </div>
                </div><!-- /.col-lg-12 -->

                <div class="col-lg-12" style="background: #ddd; text-align:center;">
                  <label >Alamat Asal</label>
                </div><!-- /.col-lg-12 -->

                <div class="col-lg-12">
                  <div class="form-group">
                    <label>Alamat</label>
                    <input name="alamat2" type="text" id="alamat2" placeholder=" Alamat" class="form-control">
                  </div>
                </div><!-- /.col-lg-12 -->

                <div class="col-lg-6">
                  <div class="form-group">
                    <label>Kode Pos</label>
                    <input name="kode_pos2" type="text" id="kode_pos2" placeholder=" Kode Pos" class="form-control" >
                  </div>
                </div><!-- /.col-lg-12 -->

                <div class="col-lg-6">
                  <div class="form-group">
                    <label>Provinsi</label>
                    <select class="form-control" name="provinsi2" id="provinsi2">
                      <option id="provinsi_now2" value="">-- Pilih Provinsi --</option>
                      {% for a in provinsi %}
                      <option value="{{ a.id }}">{{ a.name }}</option>
                      {% endfor %}
                    </select>
                  </div>
                </div><!-- /.col-lg-12 -->

                <div class="col-lg-6">
                  <div class="form-group">
                    <label>Telepon</label>
                    <input name="telepon2" type="text" id="telepon2" placeholder=" Telepon" class="form-control" >
                  </div>
                </div><!-- /.col-lg-12 -->

                <div class="col-lg-6" id="kota_col2" style="display:none;">
                  <div class="form-group">
                    <label>Kota</label>
                    <select class="form-control" name="kota2" id="kota2">
                    </select>
                  </div>
                </div><!-- /.col-lg-12 -->

              </div><!-- /.col-lg-6 -->

              <div class="col-lg-12">

                <div class="col-lg-12" style="background: #ddd; text-align:center; height:25px;">
                  <label ></label>
                </div><!-- /.col-lg-12 -->

                <div class="col-lg-6">
                  <div class="form-group">
                    <label>Tempat Lahir <span style="color:red">*</span></label>
                    <input name="tempat_lahir" type="text" id="tempat_lahir" placeholder=" Tempat Lahir" class="form-control">
                  </div>
                </div><!-- /.col-lg-12 -->

                <div class="col-lg-6">
                  <div class="form-group">
                    <label>Tanggal Lahir <span style="color:red">*</span></label>
                    <input name="tgl_lahir" type="date" id="tgl_lahir" placeholder=" Tanggal Lahir" class="form-control">
                  </div>
                </div><!-- /.col-lg-12 -->

                <div class="col-lg-6">
                  <div class="form-group">
                    <label>Tanggal Masuk / Diterima</label>
                    <input name="tgl_masuk" type="text" id="tgl_masuk" placeholder=" Tanggal Masuk" class="form-control">
                  </div>
                </div><!-- /.col-lg-12 -->


                <div class="col-lg-6">
                  <div class="form-group">
                    <label>Golongan Darah </label>
                    <div class="form-control" style="border:0">
                      <input name="gol_darah" type="radio" id="gol_darah_a" value="A"> A &nbsp;&nbsp;&nbsp;&nbsp;
                      <input name="gol_darah" type="radio" id="gol_darah_b" value="B"> B &nbsp;&nbsp;&nbsp;&nbsp;
                      <input name="gol_darah" type="radio" id="gol_darah_o" value="O"> O &nbsp;&nbsp;&nbsp;&nbsp;
                      <input name="gol_darah" type="radio" id="gol_darah_ab" value="AB"> AB &nbsp;&nbsp;&nbsp;&nbsp;
                    </div>
                  </div>
                </div><!-- /.col-lg-12 -->

                <div class="col-lg-6">
                  <div class="form-group">
                    <label>Kurikulum </label>
                    <select class="form-control" name="kurikulum" id="kurikulum">
                      {% for a in thn_kur %}
                      <option value="{{ a.thn_kur }}">{{ a.thn_kur }}</option>
                      {% endfor %}
                    </select>
                  </div>
                </div><!-- /.col-lg-12 -->

                <div class="col-lg-12" style="background: #ddd; text-align:center;">
                  <label >Orang Tua</label>
                </div><!-- /.col-lg-12 -->

                <div class="col-lg-6">
                  <div class="form-group">
                    <label>Nama Ayah</label>
                    <input name="nama_ayah" type="text" id="nama_ayah" placeholder=" Nama Ayah" class="form-control" >
                  </div>
                </div><!-- /.col-lg-12 -->

                <div class="col-lg-6">
                  <div class="form-group">
                    <label>Nama Ibu</label>
                    <input name="nama_ibu" type="text" id="nama_ibu" placeholder=" Nama Ibu" class="form-control" >
                  </div>
                </div><!-- /.col-lg-12 -->

                <div class="col-lg-6">
                  <div class="form-group">
                    <label>NIK Ayah</label>
                    <input name="nik_ayah" type="text" id="nik_ayah" placeholder=" Nama Ayah" class="form-control" >
                  </div>
                </div><!-- /.col-lg-12 -->

                <div class="col-lg-6">
                  <div class="form-group">
                    <label>NIK Ibu</label>
                    <input name="nik_ibu" type="text" id="nik_ibu" placeholder=" Nama Ibu" class="form-control" >
                  </div>
                </div><!-- /.col-lg-12 -->

                <div class="col-lg-6">
                  <div class="form-group">
                    <label>Agama Ayah</label>
                    <select class="form-control" name="agama_ayah" id="agama_ayah">
                      <option id="agama_now" value="">-- Pilih Agama --</option>
                      {% for a in agama %}
                      <option value="{{ a.id_agama }}">{{ a.nama }}</option>
                      {% endfor %}
                    </select>
                  </div>
                </div><!-- /.col-lg-12 -->

                <div class="col-lg-6">
                  <div class="form-group">
                    <label>Agama Ibu</label>
                    <select class="form-control" name="agama_ibu" id="agama_ibu">
                      <option id="agama_now" value="">-- Pilih Agama --</option>
                      {% for a in agama %}
                      <option value="{{ a.id_agama }}">{{ a.nama }}</option>
                      {% endfor %}
                    </select>
                  </div>
                </div><!-- /.col-lg-12 -->

                <div class="col-lg-6">
                  <div class="form-group">
                    <label>Pendidikan Ayah</label>
                    <select class="form-control" name="pendidikan_ayah">
                      <option value="" >-- PILIH --</option>
                      <option value="Tidak Tamat SD">Tidak Tamat SD</option>
                      <option value="Tamat SD">Tamat SD</option>
                      <option value="Tamat SMTP">Tamat SMTP</option>
                      <option value="Tamat SMTA">Tamat SMTA</option>
                      <option value="Diploma">Diploma</option>
                      <option value="Sarjana Muda">Sarjana Muda</option>
                      <option value="Sarjana">Sarjana</option>
                      <option value="Pasca Sarjana">Pasca Sarjana</option>
                      <option value="Doktor">Doktor</option>
                    </select>
                  </div>
                </div><!-- /.col-lg-12 -->

                <div class="col-lg-6">
                  <div class="form-group">
                    <label>Pendidikan Ibu</label>
                    <select class="form-control" name="pendidikan_ibu">
                      <option value="" >-- PILIH --</option>
                      <option value="Tidak Tamat SD">Tidak Tamat SD</option>
                      <option value="Tamat SD">Tamat SD</option>
                      <option value="Tamat SMTP">Tamat SMTP</option>
                      <option value="Tamat SMTA">Tamat SMTA</option>
                      <option value="Diploma">Diploma</option>
                      <option value="Sarjana Muda">Sarjana Muda</option>
                      <option value="Sarjana">Sarjana</option>
                      <option value="Pasca Sarjana">Pasca Sarjana</option>
                      <option value="Doktor">Doktor</option>
                    </select>
                  </div>
                </div><!-- /.col-lg-12 -->

                <div class="col-lg-6">
                  <div class="form-group">
                    <label>Pekerjaan Ayah</label>
                    <select class="form-control" name="pekerjaan_ayah">
                      <option value="" $="">-- PILIH --</option>
                      <option value="Peg. Neg. Sipil">Peg. Neg. Sipil</option>
                      <option value="ABRI">ABRI</option>
                      <option value="Petani">Petani</option>
                      <option value="Peg. Swasta">Peg. Swasta</option>
                      <option value="Usaha Sendiri">Usaha Sendiri</option>
                      <option value="Tidak Bekerja">Tidak Bekerja</option>
                      <option value="Pensiun">Pensiun</option>
                      <option value="Lain-lain">Lain-lain</option>
                    </select>
                  </div>
                </div><!-- /.col-lg-12 -->

                <div class="col-lg-6">
                  <div class="form-group">
                    <label>Pekerjaan Ibu</label>
                    <select class="form-control" name="pekerjaan_ibu">
                      <option value="" $="">-- PILIH --</option>
                      <option value="Peg. Neg. Sipil">Peg. Neg. Sipil</option>
                      <option value="ABRI">ABRI</option>
                      <option value="Petani">Petani</option>
                      <option value="Peg. Swasta">Peg. Swasta</option>
                      <option value="Usaha Sendiri">Usaha Sendiri</option>
                      <option value="Tidak Bekerja">Tidak Bekerja</option>
                      <option value="Pensiun">Pensiun</option>
                      <option value="Lain-lain">Lain-lain</option>
                    </select>
                  </div>
                </div><!-- /.col-lg-12 -->

                <div class="col-lg-6">
                  <div class="form-group">
                    <label>Penghasilan Ortu</label>
                    <select class="form-control" name="penghasilan_ortu">
                      <option value="" $="">-- PILIH --</option>
                      <option value="< 1.000.000">< 1.000.000</option>
                      <option value=">= 1.000.000 - 2.000.000">>= 1.000.000 - 2.000.000</option>
                      <option value=">= 2.000.000 - 3.000.000">>= 2.000.000 - 3.000.000</option>
                      <option value="> 3.000.000">> 3.000.000</option>
                    </select>
                  </div>
                </div><!-- /.col-lg-12 -->


                <div class="col-lg-6">
                  <div class="form-group">
                    <label>Kota Orang tua</label>
                    <input name="kota_ortu" type="text" placeholder=" Kota Orang Tua" class="form-control" >
                  </div>
                </div><!-- /.col-lg-12 -->

                <div class="col-lg-12">
                  <div class="form-group">
                    <label>Alamat Orang Tua</label>
                    <input name="alamat_ortu" type="text" id="alamat_ortu" placeholder=" Alamat Orang Tua" class="form-control" >
                  </div>
                </div><!-- /.col-lg-12 -->

                <!-- <div class="col-lg-12" style="background: #ddd; text-align:center;">
                  <label >Dikti</label>
                </div>

                <div class="col-lg-6">
                  <div class="form-group">
                    <label>Reguler / Kerjasama</label>
                    <select class="form-control" name="shift">
                      <option value=""></option>
                      <option value="R">Reguler</option>
                      <option value="K">Kerja Sama</option>
                    </select>
                  </div>
                </div>

                <div class="col-lg-6">
                  <div class="form-group">
                    <label>Baru / Pindahan</label>
                    <select class="form-control" name="stmhs">
                    <option value=""></option><option value="A">Aktif</option><option value="C">Cuti</option><option value="D">Drop Out</option><option value="K">Keluar</option><option value="L">Lulus</option><option value="N">Non Aktif</option>
                    </select>
                  </div>
                </div>

                <div class="col-lg-6">
                  <div class="form-group">
                    <label>Status Mahasiswa</label>
                    <select class="form-control" name="stmhs">
                    <option value=""></option><option value="A">Aktif</option><option value="C">Cuti</option><option value="D">Drop Out</option><option value="K">Keluar</option><option value="L">Lulus</option><option value="N">Non Aktif</option>
                    </select>
                  </div>
                </div>

                <div class="col-lg-6">
                  <div class="form-group">
                    <label>Asal Perguruan tinggi</label>
                    <input name="asal_sekolah" type="text" id="asal_sekolah" placeholder=" Nama Asal Sekolah" class="form-control" >
                  </div>
                </div>
                
                <div class="col-lg-6">
                  <div class="form-group">
                    <label>Semester Awal</label>
                    <input name="asal_sekolah" type="text" id="asal_sekolah" placeholder=" Nama Asal Sekolah" class="form-control" >
                  </div>
                </div>


                <div class="col-lg-6">
                  <div class="form-group">
                    <label>Batas Studi</label>
                    <input name="asal_sekolah" type="text" id="asal_sekolah" placeholder=" Nama Asal Sekolah" class="form-control" >
                  </div>
                </div>

                <div class="col-lg-6">
                  <div class="form-group">
                    <label>SKS Diakui</label>
                    <input name="asal_sekolah" type="text" id="asal_sekolah" placeholder=" Nama Asal Sekolah" class="form-control" >
                  </div>
                </div>

                <div class="col-lg-6">
                  <div class="form-group">
                    <label>Asal NIM</label>
                    <input name="asal_sekolah" type="text" id="asal_sekolah" placeholder=" Nama Asal Sekolah" class="form-control" >
                  </div>
                </div>

                <div class="col-lg-12">
                  <div class="form-group">
                    <label>Judul Skripsi</label>
                    <input name="judul_skripsi" type="text" id="judul_skripsi" placeholder=" Judul Skripsi" class="form-control" >
                  </div>
                </div> -->

                <div class="col-lg-12" style="background: #ddd; text-align:center;">
                  <label >Asal Sekolah/Perguruan tinggi</label>
                </div><!-- /.col-lg-12 -->

                <!-- <div class="col-lg-6">
                  <div class="form-group">
                    <label>Asal Jenjang</label>
                    <select class="form-control" name="asjen">
                      <option value=""></option><option value="A">S3</option><option value="B">S2</option><option value="C">S1</option><option value="D">D4</option><option value="E">D3</option><option value="F">D2</option><option value="G">D1</option><option value="H">Sp-1</option><option value="I">Sp-2</option><option value="J">Profesi</option>
                    </select>
                  </div>
                </div> -->

                <div class="col-lg-6">
                  <div class="form-group">
                    <label>Nama SMA/SMK</label>
                    <input name="nama_smu" type="text" id="nisn" placeholder="Nama sekolah" class="form-control" >
                  </div>
                </div><!-- /.col-lg-12 -->
                
                <div class="col-lg-6">
                  <div class="form-group">
                    <label>Jurusan SMU</label>
                    <input name="jurusan" type="text" placeholder="Jurusan" class="form-control" >
                  </div>
                </div><!-- /.col-lg-12 -->

                <div class="col-lg-6">
                  <div class="form-group">
                    <label>Provinsi</label>
                    <select class="form-control" name="provinsi3" id="provinsi3">
                      <option id="provinsi_now1" value="">-- Pilih Provinsi --</option>
                      {% for a in provinsi %}
                      <option value="{{ a.id }}">{{ a.name }}</option>
                      {% endfor %}
                    </select>
                  </div>
                </div><!-- /.col-lg-12 -->

                <div class="col-lg-6" id="kota_col3" style="display:none;">
                  <div class="form-group">
                    <label>Kota</label>
                    <select class="form-control" name="kota3" id="kota3">
                    </select>
                  </div>
                </div><!-- /.col-lg-12 -->


                <div class="col-lg-12">
                  <div class="form-group">
                    <label>Alamat Sekolah SMA/SMK</label>
                    <input name="alamat_sekolah" type="text" id="alamat_sekolah" placeholder=" Alamat Sekolah" class="form-control" >
                  </div>
                </div><!-- /.col-lg-12 -->  

                <div class="col-lg-6">
                  <div class="form-group">
                    <label>NISN (No Induk Siswa Nasional)</label>
                    <input name="nisn" type="text" id="nisn" placeholder=" NISN" class="form-control" >
                  </div>
                </div><!-- /.col-lg-12 -->


              </div><!-- /.col-lg-6 -->

              <div class="col-md-12">
                <div class="col-lg-12">
                  <div class="form-group">
                    <label> <span style="color:red">*</span> Wajib di isi</label>
                  </div>
                </div>
              </div>

            </div><!-- /.row -->
          </div><!-- /.box-body -->

          <div class="box-footer">
            <button id="frm_data" type="button" class="btn btn-primary" onclick="insert_data()">Save changes</button>
          </div>
        </form>
      </div><!-- /.box -->
    </div><!-- /.col-lg -->

    <div class="col-lg-2">
    </div>

  </div><!-- /.row -->
</section><!-- /.content -->

<script type="text/javascript">

$(document).ready(function(){
        $(".content-wrapper").css("height", "2200px");
});
  ///////////////////////
  // PROVINSI SMU //
  ///////////////////////
  $("#provinsi3").change(function(){
    provinsi3 = $("#provinsi3").val();
    $("#kota_col3").css({display:'block'});

    // ajax membuat option kabupaten
    $.ajax({
      url       : "{{ url('akdmhs/editKab/') }}"+provinsi3,
      type      : "POST",
      dataType  : "json",
      data      : {'name' : 'value'},
      cache     : false,
      success   : function(data){
        jmlData = data.length;
        buatOption = "";
        for(a = 0; a < jmlData; a++){
          buatOption += '<option value='+data[a]["id"]+'>'+data[a]["name"]+'</option>';
        }

        $('#kota3').find('option').remove().end().append('<option id="kota_now3" value="">-- Pilih Kota --</option>'+buatOption);
      }
    });// /.ajax membuat option kabupaten

    if(!provinsi3 == false) {
      $('#kota_col3').css({display: 'block'});
    }
    if(provinsi3 == ''){
      $('#kota_col3').css({display: 'none'});
    }

  });

  ///////////////////////
  // PROVINSI SEKARANG //
  ///////////////////////
  $("#provinsi1").change(function(){
    provinsi1 = $("#provinsi1").val();
    $("#kota_col1").css({display:'block'});

    // ajax membuat option kabupaten
    $.ajax({
      url       : "{{ url('akdmhs/editKab/') }}"+provinsi1,
      type      : "POST",
      dataType  : "json",
      data      : {'name' : 'value'},
      cache     : false,
      success   : function(data){
        jmlData = data.length;
        buatOption = "";
        for(a = 0; a < jmlData; a++){
          buatOption += '<option value='+data[a]["id"]+'>'+data[a]["name"]+'</option>';
        }

        $('#kota1').find('option').remove().end().append('<option id="kota_now1" value="">-- Pilih Kota --</option>'+buatOption);
      }
    });// /.ajax membuat option kabupaten

    if(!provinsi1 == false) {
      $('#kota_col1').css({display: 'block'});
    }
    if(provinsi1 == ''){
      $('#kota_col1').css({display: 'none'});
    }

  });

  ///////////////////
  // PROVINSI ASAL //
  ///////////////////
  $("#provinsi2").change(function(){
    provinsi2 = $("#provinsi2").val();
    $("#kota_col2").css({display:'block'});

    // ajax membuat option kabupaten
    $.ajax({
      url       : "{{ url('akdmhs/editKab/') }}"+provinsi2,
      type      : "POST",
      dataType  : "json",
      data      : {'name' : 'value'},
      cache     : false,
      success   : function(data){
        jmlData = data.length;
        buatOption = "";
        for(a = 0; a < jmlData; a++){
          buatOption += '<option value='+data[a]["id"]+'>'+data[a]["name"]+'</option>';
        }

        $('#kota2').find('option').remove().end().append('<option id="kota_now2" value="">-- Pilih Kota --</option>'+buatOption);
      }
    });// /.ajax membuat option kabupaten

    if(!provinsi2 == false) {
      $('#kota_col2').css({display: 'block'});
    }
    if(provinsi2 == ''){
      $('#kota_col2').css({display: 'none'});
    }

  });

  $('#tgl_lahir').datepicker({
    format:'yyyy-mm-dd',
    startDate: `-50y`,
    endDate: '+1d',});
  $('#tgl_masuk').datepicker({
    format:'yyyy-mm-dd',
    startDate: '-8y',
    endDate: '+1d',});


  /////////////////
  // Insert Data //
  /////////////////
  function insert_data() {
    nomhs = $('#id_mhs').val();
    huruf = /[0-9]/;
    if (!nomhs.match(huruf)) {
      new PNotify({
        title: 'Warning Notice',
        text: 'Id Mahasiswa harus angka',
        type:'warning'
      });
    } else {

      var data = $('#form_edit').serialize();
      $.ajax({
        type      : "POST",
        url       : "{{ url('akdMhsBaru/insertAkdMhs/') }}",
        dataType  : "json",
        data      : data
      }).done(function( data ) {
        console.log(data);
        // $('#table').load();
        new PNotify({
          title : data.title,
          text  : data.text,
          type  : data.type
        });

        if (data) {
          if (data.type == 'success') {
            return load_page('akdMhsBaru/mhsBaru/','page_akdMhsBaru/mhsBaru/');
          } else {
          }
        }
      });
    }
  }
</script>
