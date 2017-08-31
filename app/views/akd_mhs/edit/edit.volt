<section class="content-header">
  <h1>
    Edit MHS
    <small>it all starts here</small>
  </h1>
  <ol class="breadcrumb">
    <li><a href="#"><i class="fa fa-dashboard"></i> MHS</a></li>
    <li class="active">Edit MHS</li>
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
          <h3 class="box-title">Edit Mahasiswa</h3>
        </div>
        <!-- /.box-header -->
        <!-- form start -->

        <form method="post" class="edit_form" id="form_edit">
          {% for data in edit %}
          <div class="box-body" style="height:auto;">
            <!-- Modal -->
            <div class="row">

              <div class="col-lg-12">

                <div class="col-lg-12" style="background: #ddd; text-align:center;">
                  <label ></label>
                </div><!-- /.col-lg-12 -->

                <div class="col-lg-9">
                  <div class="row">

                    <div class="col-lg-7">
                      <div class="form-group">
                        <label>No Mahasiswa <span style="color:red">*</span></label>
                        <p id="label_id" style="background: #fff; padding:7px;border:solid #fff 1px;"><span> {{ data.id_mhs }}</span></p>
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
                        <input value="{{ data.nama }}" name="nama" type="text" id="nama" placeholder=" Nama" class="form-control" >
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
                        <input name="nik" type="text" id="nik" placeholder=" NIK" class="form-control" value="{{ data.nik }}">
                      </div>
                    </div><!-- /.col-lg-12 -->

                  </div>
                </div>

                <div class="col-lg-3" >
                  <div class="row">
                    <div class="form-group">
                      <label>Foto</label>
                      <div style="background: #ddd; width:100%; height:185px; align-text:center;">
                        <img src="img/mhs/{{ data.foto }}" alt="foto" style="align: center" width="100%" height="100%">
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
                    <input value="{{ data.alamat_yk }}" name="alamat1" type="text" id="alamat1" placeholder=" Alamat" class="form-control">
                  </div>
                </div><!-- /.col-lg-12 -->

                <div class="col-lg-6">
                  <div class="form-group">
                    <label>Telepon</label>
                    <input value="{{ data.telpon }}" name="telepon1" type="text" id="telepon1" placeholder=" Telepon" class="form-control" >
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
                    <input value="{{ data.kode_posyk }}" name="kode_pos1" type="text" id="kode_pos1" placeholder=" Kode Pos" class="form-control" >
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
                    <input value="{{ data.alamat_asal }}" name="alamat2" type="text" id="alamat2" placeholder=" Alamat" class="form-control">
                  </div>
                </div><!-- /.col-lg-12 -->

                <div class="col-lg-6">
                  <div class="form-group">
                    <label>Kode Pos</label>
                    <input value="{{ data.kdpos_asal }}" name="kode_pos2" type="text" id="kode_pos2" placeholder=" Kode Pos" class="form-control" >
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
                    <input value="{{ data.telpon_asal }}" name="telepon2" type="text" id="telepon2" placeholder=" Telepon" class="form-control" >
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

                <div class="col-lg-12" style="background: #ddd; text-align:center;">
                  <label ></label>
                </div><!-- /.col-lg-12 -->

                <div class="col-lg-6">
                  <div class="form-group">
                    <label>Tempat Lahir <span style="color:red">*</span></label>
                    <input value="{{ data.tempat_lahir }}" name="tempat_lahir" type="text" id="tempat_lahir" placeholder=" Tempat Lahir" class="form-control">
                  </div>
                </div><!-- /.col-lg-12 -->

                <div class="col-lg-6">
                  <div class="form-group">
                    <label>Tanggal Lahir <span style="color:red">*</span></label>
                    <input value="{{ data.tgl_lahir }}" name="tgl_lahir" type="date" id="tgl_lahir" placeholder=" Tanggal Lahir" class="form-control">
                  </div>
                </div><!-- /.col-lg-12 -->

                <div class="col-lg-6">
                  <div class="form-group">
                    <label>Tanggal Masuk / Diterima</label>
                    <input value="{{ data.tgl_masuk }}" name="tgl_masuk" type="text" id="tgl_masuk" placeholder=" Tanggal Masuk" class="form-control">
                  </div>
                </div><!-- /.col-lg-12 -->

                <div class="col-lg-6">
                  <div class="form-group">
                    <label>Tanggal Lulus</label>
                    <input value="{{ data.tgl_lulus }}" name="tgl_lulus" type="text" id="tgl_lulus" placeholder=" Tanggal Lulus" class="form-control">
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
                    <input value="{{ data.nama_ayah }}" name="nama_ayah" type="text" id="nama_ayah" placeholder=" Nama Ayah" class="form-control" >
                  </div>
                </div><!-- /.col-lg-12 -->

                <div class="col-lg-6">
                  <div class="form-group">
                    <label>Nama Ibu</label>
                    <input value="{{ data.nama_ibu }}" name="nama_ibu" type="text" id="nama_ibu" placeholder=" Nama Ibu" class="form-control" >
                  </div>
                </div><!-- /.col-lg-12 -->

                <div class="col-lg-12">
                  <div class="form-group">
                    <label>Alamat Orang Tua</label>
                    <input value="{{ data.alamat_ortu }}" name="alamat_ortu" type="text" id="alamat_ortu" placeholder=" Alamat Orang Tua" class="form-control" >
                  </div>
                </div><!-- /.col-lg-12 -->

                <div class="col-lg-6">
                  <div class="form-group">
                    <label>Kota</label>
                    <input value="{{ data.kota_ortu }}" name="kota_ortu" type="text" id="kota_ortu" placeholder=" Kota Orang Tua" class="form-control" >
                  </div>
                </div><!-- /.col-lg-12 -->

                <div class="col-lg-6">
                  <div class="form-group">
                    <label>Kode Pos</label>
                    <input value="{{ data.kode_pos_ortu }}" name="kode_pos_ortu" type="text" id="kode_pos_ortu" placeholder=" Kode Pos" class="form-control" >
                  </div>
                </div><!-- /.col-lg-12 -->

                <div class="col-lg-12" style="background: #ddd; text-align:center;">
                  <label >Asal Sekolah</label>
                </div><!-- /.col-lg-12 -->

                <div class="col-lg-6">
                  <div class="form-group">
                    <label>Nama Asal Sekolah</label>
                    <input value="{{ data.asal_smu }}" name="asal_sekolah" type="text" id="asal_sekolah" placeholder=" Nama Asal Sekolah" class="form-control" >
                  </div>
                </div><!-- /.col-lg-12 -->

                <div class="col-lg-6">
                  <div class="form-group">
                    <label>NISN (No Induk Siswa Nasional)</label>
                    <input value="{{ data.nisn }}" name="nisn" type="text" id="nisn" placeholder=" NISN" class="form-control" >
                  </div>
                </div><!-- /.col-lg-12 -->

                <div class="col-lg-12">
                  <div class="form-group">
                    <label>Alamat Sekolah </label>
                    <input value="{{ data.alamat_sekolah }}" name="alamat_sekolah" type="text" id="alamat_sekolah" placeholder=" Alamat Sekolah" class="form-control" >
                  </div>
                </div><!-- /.col-lg-12 -->

                <div class="col-lg-12">
                  <div class="form-group">
                    <label>Judul Skripsi</label>
                    <input value="{{ data.judul_skripsi }}" name="judul_skripsi" type="text" id="judul_skripsi" placeholder=" Judul Skripsi" class="form-control" >
                  </div>
                </div><!-- /.col-lg-12 -->

              </div><!-- /.col-lg-6 -->

              <script type="text/javascript">
                $('#angkatan').val({{ data.angkatan }});

                $('#agama').val({{ data.id_agama }});

                if('{{ data.gender }}' === 'L') {
                  $('#jeniskelamin_l').prop({checked:true});
                } else if ('{{ data.gender }}' === 'P') {
                  $('#jeniskelamin_p').prop({checked:true});
                } else {
                  $('#jeniskelamin_l').prop({checked:false});
                  $('#jeniskelamin_p').prop({checked:false});
                }

                ///////////////////////
                // PROVINSI SEKARANG //
                ///////////////////////
                $("#provinsi1").val({{data.kode_prop}});
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

                provinsi1 = $("#provinsi1").val();
                if (provinsi1) {
                  $('#provinsi_now1').css({display: 'block'});
                  $('#kota_col1').css({display: 'block'});
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

                        $('#kota1').find('option').remove().end().append('<option id="kota_now1" value="">-- Pilih Kota --</option>'+buatOption).val({{ data.kode_kab }});
                      }
                    });// /.ajax membuat option kabupaten

                } else if (provinsi1 == null){
                  console.log("kosong");
                  $('#provinsi_now1').css({display: 'none'});
                }

                ///////////////////
                // PROVINSI ASAL //
                ///////////////////
                $("#provinsi2").val({{data.kdprop_asal}});
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

                provinsi2 = $("#provinsi2").val();
                if (provinsi2) {
                  $('#provinsi_now2').css({display: 'block'});
                  $('#kota_col2').css({display: 'block'});
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

                        $('#kota2').find('option').remove().end().append('<option id="kota_now2" value="">-- Pilih Kota --</option>'+buatOption).val({{ data.kdkab_asal }});
                      }
                    });// /.ajax membuat option kabupaten

                } else if (provinsi2 == null){
                  console.log("kosong");
                  $('#provinsi_now2').css({display: 'none'});
                }

                var gol_darah = '{{ data.gol_darah }}';
                if(gol_darah=='A'){
                  $('#gol_darah_a').prop({checked: true});
                } else if(gol_darah=='B'){
                  $('#gol_darah_b').prop({checked: true});
                } else if(gol_darah=='O'){
                  $('#gol_darah_o').prop({checked: true});
                } else if(gol_darah=='AB'){
                  $('#gol_darah_ab').prop({checked: true});
                } else if(gol_darah =! 'A'||'B'||'O'||'AB' ){
                  $('#gol_darah_a').prop({checked: false});
                  $('#gol_darah_b').prop({checked: false});
                  $('#gol_darah_o').prop({checked: false});
                  $('#gol_darah_ab').prop({checked: false});
                };

                $('#tgl_lahir').datepicker({
                  format:'yyyy-mm-dd',
                  startDate: `-50y`,
                  endDate: '+1d',});
                $('#tgl_masuk').datepicker({
                  format:'yyyy-mm-dd',
                  startDate: '-8y',
                  endDate: '+1d',});
                $('#tgl_lulus').datepicker({
                  format:'yyyy-mm-dd',
                  startDate: '-8y',
                  endDate: '+5y',});

                $('#kurikulum').val({{data.id_kur}});
              </script>

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
            <button id="frm_data" type="button" class="btn btn-primary" onclick="update_data({{data.id_mhs}})">Save changes</button>
          </div>
        {% endfor %}
        </form>
      </div><!-- /.box -->
    </div><!-- /.col-lg -->

    <div class="col-lg-2">
    </div>

  </div><!-- /.row -->
</section><!-- /.content -->

<script type="text/javascript" id="tambahan">

</script>
<script type="text/javascript">
  function update_data(id) {
    var data = $('#form_edit').serialize();
    $.ajax({
      type: "POST",
      url: '{{ url('akdMhs/updateAkdMhs/') }}'+id,
      dataType : "json",
      data: data
    }).done(function( data ) {
      console.log(data);
      // $('#table').load();
      new PNotify({
        title: data.title,
        text: data.text,
        type: data.type
      });

      if (data) {
        if (data.type == 'success') {
          return load_page('akdMhs/editMhs/','page_akdMhs/editMhs/');
        } else {
        }
      }
    });
  }
</script>
