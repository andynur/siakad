<style>
    .bootstrap-filestyle label {
        width: 9.3em;
        font-size: 1.1em;
    }
</style>

<section class="content-header">
    <h1>
        <button type="button" onclick="back({{id}})" class="btn bg-navy btn-flat"><i class="fa fa-arrow-circle-left"></i> &nbsp; Kembali</button>
    </h1>
    {% for opt in rombel %}
        {% if (opt.rombongan_belajar_id == id) %}
            {% set data = [opt.nama_tingkat, opt.nama_rombel] %}
        {% endif %}
    {% endfor %}
    <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i>{{ data[0] }}</a></li>
        <li><a href="#">{{ data[1] }}</a></li>   
        <li><a href="#">Data Murid</a></li>
        <li class="active">Tambah</li>
    </ol>
</section>

<!-- Main content -->
<section class="content">
    <div class="row">
        <div class="col-md-offset-2 col-md-8">
            <div class="box box-info">
                <div class="box-header with-border">
                    <h3 class="box-title">Tambah Murid Baru</h3>
                </div>

                <form method="post" class="edit_form" id="form_add" action="{{ url('pesertadidik/newMurid') }}" >
                    <div class="box-body" style="height:auto;">
                        <div class="row">

                            <div class="col-lg-12">
                                <div class="callout callout-info custom">
                                    <h4><i class="fa fa-user"></i>&nbsp; Profil Murid</h4>
                                </div>

                                <div class="col-lg-9">
                                    <div class="row">
                                        <div class="col-lg-7">
                                            <div class="form-group">
                                                <label>Nama Lengkap<span style="color:red">*</span></label>
                                                <input value="" name="nama" type="text" id="nama" placeholder=" Nama" class="form-control">
                                            </div>
                                        </div>
                                        <div class="col-lg-5">
                                            <div class="form-group">
                                                <label>Agama</label>
                                                <input value="ISLAM" name="agama" type="text" class="form-control" readonly>
                                            </div>
                                        </div>
                                        <!-- /.col-lg-12 -->

                                        <div class="col-lg-7">
                                            <div class="form-group">
                                                <label>NISN</label>
                                                <input type="text" name="nisn" id="nisn" placeholder="Nomor Induk Siswa Nasional" class="form-control" maxlength="10">
                                            </div>
                                        </div>
                                        <div class="col-lg-5">
                                            <div class="form-group">
                                                <label>NIS</label>
                                                <input type="text" name="nis" id="nis" placeholder="Nomor Induk Murid" class="form-control" maxlength="10">
                                            </div>
                                        </div>
                                        <!-- /.col-lg-12 -->

                                        <div class="col-lg-7">
                                            <div class="form-group">
                                                <label>NIK</label>
                                                <input name="nik" type="text" id="nik" placeholder=" NIK" class="form-control">
                                            </div>
                                        </div>
                                        <div class="col-lg-5">
                                            <div class="form-group">
                                                <label>Tanggal Masuk / Diterima</label>
                                                <input name="tgl_masuk" type="text" id="tgl_masuk" placeholder=" Tanggal Masuk" class="form-control">
                                            </div>
                                        </div>

                                        <div class="col-lg-7">
                                            <div class="form-group">
                                                <label>Tempat Lahir <span style="color:red">*</span></label>
                                                <input name="tempat_lahir" type="text" id="tempat_lahir" placeholder=" Tempat Lahir" class="form-control">
                                            </div>
                                        </div>
                                        <div class="col-lg-5">
                                            <div class="form-group">
                                                <label>Tanggal Lahir <span style="color:red">*</span></label>
                                                <input name="tgl_lahir" type="text" id="tgl_lahir" placeholder=" Tanggal Lahir" class="form-control">
                                            </div>
                                        </div>

                                        <div class="col-lg-7">
                                            <div class="form-group">
                                                <label>Jenis Kelamin <span style="color:red">*</span></label>
                                                <div class="jk">
                                                    <input name="gender" type="radio" value="L" id="gender_l"> Laki-Laki &nbsp; &nbsp;
                                                    <input name="gender" type="radio" value="P" id="gender_p"> Perempuan
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-lg-5">
                                            <div class="form-group">
                                                <label>Golongan Darah </label>
                                                <div class="form-control" style="border:0">
                                                    <input name="gol_darah" type="radio" id="gol_darah_a" value="A"> A &nbsp;&nbsp;&nbsp;&nbsp;
                                                    <input name="gol_darah" type="radio" id="gol_darah_b" value="B"> B &nbsp;&nbsp;&nbsp;&nbsp;
                                                    <input name="gol_darah" type="radio" id="gol_darah_o" value="O"> O &nbsp;&nbsp;&nbsp;&nbsp;
                                                    <input name="gol_darah" type="radio" id="gol_darah_ab" value="AB"> AB
                                                    &nbsp;&nbsp;&nbsp;&nbsp;
                                                </div>
                                            </div>
                                        </div>
                                        <!-- /.col-lg-12 -->

                                    </div>
                                </div>

                                <div class="col-lg-3">
                                    <div class="form-group">
                                        <label>Foto</label>
                                        <div style="width:100%; align-text:center;">
                                            <img src="img/user.png" alt="foto murid" style="width: 100%; border-radius: 6px;" id="uploadPreview1" />
                                        </div>
                                    </div>
                                    <input type="file" name="foto" id="uploadImage1" onchange="PreviewImage(1)">
                                    <input type="hidden" name="foto_lama" value="woman-1.png">
                                </div>
                            </div>

                            <div class="col-lg-12">
                                <div class="col-lg-4">
                                    <div class="form-group">
                                        <label>Rombel<span style="color:red">*</span></label>
                                        <select class="form-control" name="rombel" id="rombel">
                                            <option value="">-- Pilih Rombel --</option>
                                            {% for opt in rombel %}
                                            <option value="{{ opt.rombongan_belajar_id }}">{{ opt.nama_tingkat }} - {{ opt.nama_rombel }}</option>
                                            {% endfor %}
                                        </select>
                                    </div>
                                </div>
                                <div class="col-lg-4">
                                    <div class="form-group">
                                        <label>Semester</label>
                                        <input type="text" class="form-control" id="semester" readonly>
                                    </div>
                                </div>
                                <div class="col-lg-4">
                                    <div class="form-group">
                                        <label>Kurikulum</label>
                                        <input type="text" class="form-control" id="kurikulum" readonly>
                                    </div>
                                </div>
                            </div>
                            <!-- /.col-lg-12 -->

                            <div class="col-lg-12">
                                <div class="callout callout-info custom">
                                    <h4><i class="fa fa-map-marker"></i>&nbsp; Alamat Sekarang</h4>
                                </div>

                                <div class="col-lg-4">
                                    <div class="form-group">
                                        <label>Alamat Jalan</label>
                                        <input name="alamat" type="text" id="alamat" placeholder="Alamat Jalan" class="form-control">
                                    </div>
                                </div>
                                <div class="col-lg-2">
                                    <div class="form-group">
                                        <label>RT</label>
                                        <input name="rt" type="number" maxlength=3"" placeholder="RT" class="form-control" id="rt">
                                    </div>
                                </div>
                                <div class="col-lg-2">
                                    <div class="form-group">
                                        <label>RW</label>
                                        <input name="rw" type="number" maxlength=3"" placeholder="RW" class="form-control" id="rw">
                                    </div>
                                </div>                                
                                <div class="col-lg-4">
                                    <div class="form-group">
                                        <label>Dusun</label>
                                        <input name="dusun" type="text" id="nama_dusun" placeholder="Dusun" class="form-control">
                                    </div>
                                </div>                                                            
                                <!-- /.col-lg-12 -->                                 

                                <div class="col-lg-6">
                                    <div class="form-group">
                                        <label>Provinsi</label>
                                        <select class="form-control" name="provinsi" id="provinsi">
                                            <option value="">-- Pilih Provinsi --</option>
                                            {% for a in provinsi %}
                                            <option value="{{ a.id }}">{{ a.name }}</option>
                                            {% endfor %}
                                        </select>
                                    </div>
                                </div>
                                <div class="col-lg-6">
                                    <div class="form-group">
                                        <label>Kabupaten / Kota</label>
                                        <select class="form-control" name="kota" id="kota">
                                            <option id="kota_now" value="">-- Pilih Kota --</option>
                                        </select>
                                    </div>
                                </div>
                                
                                <!-- /.col-lg-12 -->                                 

                                <div class="col-lg-4">
                                    <div class="form-group">
                                        <label>Kecamatan</label>
                                        <select class="form-control" name="kecamatan" id="kecamatan">
                                            <option value="">-- Pilih Kecamatan --</option>
                                        </select>
                                    </div>
                                </div>  
                                <div class="col-lg-4">
                                    <div class="form-group">
                                        <label>Kelurahan</label>
                                        <select class="form-control" name="kelurahan" id="kelurahan">
                                            <option value="">-- Pilih Kelurahan --</option>
                                        </select>
                                    </div>
                                </div>                                   
                                <div class="col-lg-4">
                                    <div class="form-group">
                                        <label>Kode Pos</label>
                                        <input name="kode_pos" type="text" id="kode_pos" placeholder="Kode Pos" class="form-control">
                                    </div>
                                </div>
                                <!-- /.col-lg-12 -->
                            </div>

                            <!-- <div class="col-lg-12">
                                <div class="callout callout-info custom">
                                    <h4><i class="fa fa-map-pin"></i>&nbsp; Alamat Asal</h4>
                                </div>

                                <div class="col-lg-12">
                                    <div class="form-group">
                                        <label>Alamat Asal</label>
                                        <input name="alamat2" type="text" id="alamat2" placeholder=" Alamat" class="form-control">
                                    </div>
                                </div>
                                /.col-lg-12

                                <div class="col-lg-6">
                                    <div class="form-group">
                                        <label>Kode Pos Asal</label>
                                        <input name="kode_pos2" type="text" id="kode_pos2" placeholder=" Kode Pos" class="form-control">
                                    </div>
                                </div>
                                /.col-lg-12

                                <div class="col-lg-6">
                                    <div class="form-group">
                                        <label>Provinsi Asal</label>
                                        <select class="form-control" name="provinsi2" id="provinsi2">
                                            <option id="provinsi_now2" value="">-- Pilih Provinsi --</option>
                                            {% for a in provinsi %}
                                            <option value="{{ a.id }}">{{ a.name }}</option>
                                            {% endfor %}
                                        </select>
                                    </div>
                                </div>
                                /.col-lg-12

                                <div class="col-lg-6">
                                    <div class="form-group">
                                        <label>Telepon Asal</label>
                                        <input name="telepon2" type="text" id="telepon2" placeholder=" Telepon" class="form-control">
                                    </div>
                                </div>
                                <!-- /.col-lg-12 -->

                                <!-- <div class="col-lg-6" id="kota_col2">
                                    <div class="form-group">
                                        <label>Kota Asal</label>
                                        <select class="form-control" name="kota2" id="kota2"></select>
                                    </div>
                                </div>
                                /.col-lg-12
                            </div> -->

                            <div class="col-lg-12">
                                <div class="callout callout-info custom">
                                    <h4><i class="fa fa-users"></i>&nbsp; Orangtua</h4>
                                </div>
                                
                                <div class="col-lg-6">
                                    <div class="form-group">
                                        <label>Nama Ayah</label>
                                        <input name="nama_ayah" type="text" id="nama_ayah" placeholder=" Nama Ayah" class="form-control">
                                    </div>
                                </div>
                                <!-- /.col-lg-12 -->

                                <div class="col-lg-6">
                                    <div class="form-group">
                                        <label>Nama Ibu</label>
                                        <input name="nama_ibu" type="text" id="nama_ibu" placeholder=" Nama Ibu" class="form-control">
                                    </div>
                                </div>
                                <!-- /.col-lg-12 -->

                                <div class="col-lg-6">
                                    <div class="form-group">
                                        <label>Agama Ayah</label>
                                        <select class="form-control" name="agama_ayah" id="agama_ayah">
                                            <option id="agama_now" value="">-- Pilih Agama --</option>
                                            {% for a in agama %}
                                            <option value="{{ a.agama_id }}">{{ a.nama }}</option>
                                            {% endfor %}
                                        </select>
                                    </div>
                                </div>
                                <!-- /.col-lg-12 -->

                                <div class="col-lg-6">
                                    <div class="form-group">
                                        <label>Agama Ibu</label>
                                        <select class="form-control" name="agama_ibu" id="agama_ibu">
                                            <option id="agama_now" value="">-- Pilih Agama --</option>
                                            {% for a in agama %}
                                            <option value="{{ a.agama_id }}">{{ a.nama }}</option>
                                            {% endfor %}
                                        </select>
                                    </div>
                                </div>
                                <!-- /.col-lg-12 -->

                                <div class="col-lg-6">
                                    <div class="form-group">
                                        <label>Pendidikan Ayah</label>
                                        <select class="form-control" name="pendidikan_ayah">
                                            <option id="pendidikan_now" value="">-- Pilih Pendidikan --</option>
                                            {% for a in pendidikan %}
                                            <option value="{{ a.jenjang_pendidikan_id }}">{{ a.nama }}</option>
                                            {% endfor %}
                                        </select>
                                    </div>
                                </div>
                                <!-- /.col-lg-12 -->

                                <div class="col-lg-6">
                                    <div class="form-group">
                                        <label>Pendidikan Ibu</label>
                                        <select class="form-control" name="pendidikan_ibu">
                                            <option id="pendidikan_now" value="">-- Pilih Pendidikan --</option>
                                            {% for a in pendidikan %}
                                            <option value="{{ a.jenjang_pendidikan_id }}">{{ a.nama }}</option>
                                            {% endfor %}
                                        </select>
                                    </div>
                                </div>
                                <!-- /.col-lg-12 -->

                                <div class="col-lg-6">
                                    <div class="form-group">
                                        <label>Pekerjaan Ayah</label>
                                        <select class="form-control" name="pekerjaan_ayah">
                                            <option id="pekerjaan_now" value="">-- Pilih Pekerjaan --</option>
                                            {% for a in pekerjaan %}
                                            <option value="{{ a.pekerjaan_id }}">{{ a.nama }}</option>
                                            {% endfor %}
                                        </select>
                                    </div>
                                </div>
                                <!-- /.col-lg-12 -->

                                <div class="col-lg-6">
                                    <div class="form-group">
                                        <label>Pekerjaan Ibu</label>
                                        <select class="form-control" name="pekerjaan_ibu">
                                            <option id="pekerjaan_now" value="">-- Pilih Pekerjaan --</option>
                                            {% for a in pekerjaan %}
                                            <option value="{{ a.pekerjaan_id }}">{{ a.nama }}</option>
                                            {% endfor %}
                                        </select>
                                    </div>
                                </div>
                                <!-- /.col-lg-12 -->

                                <div class="col-lg-6">
                                    <div class="form-group">
                                        <label>Penghasilan Ayah</label>
                                        <select class="form-control" name="penghasilan_ayah">
                                            <option value="">-- Pilih Penghasilan --</option>
                                            {% for a in penghasilan %}
                                            <option value="{{ a.penghasilan_orangtua_wali_id }}">{{ a.nama }}</option>
                                                {% endfor %}
                                        </select>                                        
                                    </div>
                                </div>
                                <div class="col-lg-6">
                                    <div class="form-group">
                                        <label>Penghasilan Ibu</label>
                                        <select class="form-control" name="penghasilan_ibu">
                                            <option value="">-- Pilih Penghasilan --</option>
                                            {% for a in penghasilan %}
                                            <option value="{{ a.penghasilan_orangtua_wali_id }}">{{ a.nama }}</option>
                                            {% endfor %}
                                        </select>
                                    </div>
                                </div>                                
                                    <!-- /.col-lg-12 -->
                                <div class="col-lg-6">
                                    <div class="form-group">
                                        <label>Email</label>
                                        <input name="email" type="text" id="email" placeholder=" Email Orangtua" class="form-control">
                                    </div>
                                </div>
                                <div class="col-lg-6">
                                    <div class="form-group">
                                        <label>No Telepon Rumah</label>
                                        <input name="telpon" type="text" id="telpon" placeholder="Telepon Rumah" class="form-control">
                                    </div>
                                </div>
                                <!-- /.col-lg-12 -->

                                <div class="col-lg-6">
                                    <div class="form-group">
                                        <label>No Hp Ayah</label>
                                        <input name="nomor_ayah" type="text" id="hp_ayah" placeholder="No Hp Ayah" class="form-control">
                                    </div>
                                </div>
                                <div class="col-lg-6">
                                    <div class="form-group">
                                        <label>No Hp Ibu</label>
                                        <input name="nomor_ibu" type="text" id="hp_ibu" placeholder="Np Hp Ibu " class="form-control">
                                    </div>
                                </div>                                
                                <!-- /.col-lg-12 -->                                

                                <div class="col-lg-12">
                                    <div class="form-group">
                                        <label>Alamat Orang Tua</label>
                                        <input name="alamat_ortu" type="text" id="alamat_ortu" placeholder=" Alamat Orang Tua" class="form-control">
                                    </div>
                                </div>
                                <!-- /.col-lg-12 -->
                            </div>

                        </div>
                        <!-- /.row -->
                    </div>
                    <!-- /.box-body -->

                    <div class="box-footer">
                        <div class="col-md-offset-3 col-md-3">
                            <label style="padding: 10px 0;">&nbsp; &nbsp; Tanda <span style="color:red">*</span> wajib diisi!</label>
                        </div>
                        <div class="col-md-3">
                            <button id="frm_data" type="submit" class="btn btn-lg btn-danger"><i class="fa fa-paper-plane"></i>&nbsp; Simpan Data</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</section>
<!-- /.content -->

<script src="js/bootstrap-filestyle.min.js"></script>

<script type="text/javascript">
    $(function () {
        // datepicker config
        $('#tgl_lahir').datepicker({
            format: 'yyyy-mm-dd',
            startDate: `-50y`,
            endDate: '+1d',
        });
        $('#tgl_masuk').datepicker({
            format: 'yyyy-mm-dd',
            startDate: '-8y',
            endDate: '+1d',
        });    

        // filestyle config
        $(":file").filestyle({
            input: false,
            buttonText: "Upload",
            buttonName: "btn-danger",            
            iconName: "fa fa-cloud-upload"
        });

    });

    (function() {

        $('#form_add').on('submit', function(e) {
            var form = $(this);
            var url = form.prop('action');

            $.ajax({
                type: 'POST',
                url: url,
                dataType:'json',
                data: new FormData(this),
                contentType: false,
                cache: false,
                processData: false,
                success: function(data){
                    reload_page2('pesertadidik/addMurid/{{id}}');
                    new PNotify({
                        title: data.title,
                        text: data.text,
                        type: data.type
                    });
                }
            });

            e.preventDefault();
        });
    })();

    // set back button
    function back(id) {
        var url_target = '{{ url("pesertadidik/kelas/") }}' + id;
        go_page(url_target);
    }
    // autochange class
    $("#rombel").change(function(){
        rombel = $("#rombel").val();

        $.ajax({
            url       : "{{ url('pesertadidik/searchRombel/') }}"+rombel,
            type      : "POST",
            dataType  : "json",
            data      : {'name' : 'value'},
            cache     : false,
            success   : function(data){    
                console.log(data);
                $('#semester').val(data[0]["nama_semester"]);
                $('#kurikulum').val(data[0]["nama_kurikulum"]);
            }
        });
    });

    // autochange address
    $("#provinsi").change(function(){
        provinsi = $("#provinsi").val();

        $.ajax({
            url       : "{{ url('pesertadidik/searchKabupaten/') }}"+provinsi,
            type      : "POST",
            dataType  : "json",
            data      : {'name' : 'value'},
            cache     : false,
            success   : function(data){      
                console.log(data);
                jmlData = data.length;
                buatOption = "";
                for(a = 0; a < jmlData; a++){
                    buatOption += '<option value='+data[a]["id"]+'>'+data[a]["name"]+'</option>';
                }

                $('#kota').find('option').remove().end().append('<option value="">-- Pilih Kota --</option>' + buatOption);
            }
        });
    });

    $("#kota").change(function(){
        kota = $("#kota").val();

        $.ajax({
            url       : "{{ url('pesertadidik/searchKecamatan/') }}"+kota,
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

                $('#kecamatan').find('option').remove().end().append('<option value="">-- Pilih Kecamatan --</option>' + buatOption);
            }
        });
    });

    $("#kecamatan").change(function(){
        kecamatan = $("#kecamatan").val();

        $.ajax({
            url       : "{{ url('pesertadidik/searchKelurahan/') }}"+kecamatan,
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

                $('#kelurahan').find('option').remove().end().append('<option value="">-- Pilih Kelurahan --</option>' + buatOption);
            }
        });
    });

    // function save_data(target, action) {
    //     $.ajax({
    //         method: "POST",
    //         dataType: "json",
    //         url: '{{ url("pesertadidik/' + action + '") }}',
    //         data: $('#form_add').serialize()
    //     }).done(function (data) {
    //         reload_page2('pesertadidik/addMurid/{{id}}');
    //         new PNotify({
    //             title: data.title,
    //             text: data.text,
    //             type: data.type
    //         });
    //     });

    //     return false;
    // }

    function PreviewImage(id) {
        var oFReader = new FileReader();
        oFReader.readAsDataURL(document.getElementById("uploadImage"+id).files[0]);

        oFReader.onload = function (oFREvent) {
            document.getElementById("uploadPreview"+id).src = oFREvent.target.result;
        };
    };

</script>