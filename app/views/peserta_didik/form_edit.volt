<style>
    .bootstrap-filestyle label {
        width: 9.3em;
        font-size: 1.1em;
    }
</style>
<section class="content-header">
    <h1>
        <button type="button" onclick="back({{rombel_id}})" class="btn bg-navy btn-flat"><i class="fa fa-arrow-circle-left"></i> &nbsp; Kembali</button>
    </h1>
    <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i>Kelas</a></li>
        <li><a href="#">Ubah Data</a></li>   
        <li class="active">{{ data[0].nama }}</li>
    </ol>
</section>

<!-- Main content -->
<section class="content">
    <div class="row">
        <div class="col-md-offset-2 col-md-8">
            <div class="box box-info">
                <div class="box-header with-border">
                    <h3 class="box-title">Ubah Data Murid #{{ data[0].id_mhs }}</h3>
                </div>

                <form method="post" class="edit_form" id="form_edit" action="{{ url('pesertadidik/updateMurid') }}/{{ data[0].id_mhs }}" >
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
                                                <input name="nama" type="text" id="nama" placeholder="Nama murid" value="{{ data[0].nama }}" class="form-control">
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
                                                <input type="text" name="nisn" id="nisn" placeholder="Nomor Induk Siswa Nasional"  value="{{ data[0].nisn }}"class="form-control" maxlength="10">
                                            </div>
                                        </div>
                                        <div class="col-lg-5">
                                            <div class="form-group">
                                                <label>NIS <span style="color:red">*</span></label>
                                                <input type="text" name="nis" id="nis" placeholder="Nomor Induk Murid" value="{{ data[0].nis }}" class="form-control" maxlength="10">
                                            </div>
                                        </div>
                                        <!-- /.col-lg-12 -->

                                        <div class="col-lg-7">
                                            <div class="form-group">
                                                <label>NIK</label>
                                                <input name="nik" type="text" id="nik" placeholder="NIK" value="{{ data[0].nik }}" class="form-control">
                                            </div>
                                        </div>
                                        <div class="col-lg-5">
                                            <div class="form-group">
                                                <label>Tanggal Masuk / Diterima</label>
                                                <input type="text" id="tgl_masuk_input" placeholder="Tanggal Masuk" value="{{ helper.dateBahasaIndo(data[0].tgl_masuk) }}" class="form-control">
                                                <input type="hidden" name="tgl_masuk" value="{{ data[0].tgl_masuk }}" id="tgl_masuk">
                                            </div>
                                        </div>

                                        <div class="col-lg-7">
                                            <div class="form-group">
                                                <label>Tanggal Lahir <span style="color:red">*</span></label>
                                                <div class="input-group"> 
                                                    <input type="text" id="tgl_lahir_input" placeholder="Tanggal Lahir" value="{{ helper.dateBahasaIndo(data[0].tgl_lahir) }}" class="form-control">
                                                    <div class="input-group-btn"> 
                                                        <button type="button" class="btn btn-primary btn-flat" id="reset_pass">
                                                            <i class="fa fa-refresh"></i>&nbsp; Ubah Password
                                                        </button>
                                                    </div> 
                                                    <input type="hidden" name="tgl_lahir" id="tgl_lahir" value="{{ data[0].tgl_lahir }}">
                                                </div>                                                
                                            </div>
                                        </div>
                                        <div class="col-lg-5">
                                            <div class="form-group">
                                                <label>Tempat Lahir <span style="color:red">*</span></label>
                                                <input name="tempat_lahir" type="text" id="tempat_lahir" placeholder="Tempat Lahir" value="{{ data[0].tempat_lahir }}" class="form-control">
                                            </div>
                                        </div>                                        

                                        <div class="col-lg-7">
                                            <div class="form-group">
                                                <label>Golongan Darah </label>
                                                <div class="gol">
                                                    <label class="radio-inline">
                                                        <input name="gol_darah" type="radio" id="gol_darah_a" value="A" {{data[0].gol_darah == 'A' ? 'checked="checked"' : ''}}> A &nbsp;&nbsp;&nbsp;&nbsp;
                                                    </label>
                                                    <label class="radio-inline">
                                                        <input name="gol_darah" type="radio" id="gol_darah_b" value="B" {{data[0].gol_darah == 'B' ? 'checked="checked"' : ''}}> B &nbsp;&nbsp;&nbsp;&nbsp;
                                                    </label>
                                                    <label class="radio-inline">
                                                        <input name="gol_darah" type="radio" id="gol_darah_o" value="O" {{data[0].gol_darah == 'O' ? 'checked="checked"' : ''}}> O &nbsp;&nbsp;&nbsp;&nbsp;
                                                    </label>
                                                    <label class="radio-inline">
                                                        <input name="gol_darah" type="radio" id="gol_darah_ab" value="AB" {{data[0].gol_darah == 'AB' ? 'checked="checked"' : ''}}> AB
                                                    </label>                                                    
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-lg-5">
                                            <div class="form-group">
                                                <label>Jenis Kelamin <span style="color:red">*</span></label>
                                                <div class="jk">
                                                    <label class="radio-inline">
                                                        <input name="gender" type="radio" value="L" {{data[0].gender == 'L' ? 'checked="checked"' : ''}} id="gender_l"> Laki-Laki &nbsp; &nbsp;
                                                    </label>
                                                    <label class="radio-inline">
                                                        <input name="gender" type="radio" value="P" {{data[0].gender == 'P' ? 'checked="checked"' : ''}} id="gender_p"> Perempuan
                                                    </label>
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
                                            <img src="img/mhs/{{data[0].foto}}" alt="foto murid" style="width: 100%; border-radius: 6px;" id="uploadPreview1" />
                                        </div>
                                    </div>
                                    <input type="file" name="foto" id="uploadImage1" onchange="PreviewImage(1)">
                                    <input type="hidden" name="foto_lama" value="{{data[0].foto}}">
                                </div>
                            </div>

                            <div class="col-lg-12">
                                <div class="col-lg-4">
                                    <div class="form-group">
                                        <label>Rombel<span style="color:red">*</span></label>
                                        <select class="form-control" name="rombel" id="rombel">
                                            <option value="0">-- Pilih Rombel --</option>
                                            {% for opt in rombel %}
                                                {% if (opt.rombongan_belajar_id == rombel_id) %}
                                                <option value="{{ opt.rombongan_belajar_id }}" selected="selected">{{ opt.nama_tingkat }} - {{ opt.nama_rombel }}</option>
                                                {% else %}
                                                <option value="{{ opt.rombongan_belajar_id }}">{{ opt.nama_tingkat }} - {{ opt.nama_rombel }}</option>
                                                {% endif%}
                                            {% endfor %}
                                        </select>
                                    </div>
                                </div>
                                <div class="col-lg-4">
                                    <div class="form-group">
                                        <label>Tahun Ajaran</label>
                                        <input type="text" class="form-control" id="semester" value="{{data[0].semester|right_trim()}}" readonly>
                                        <input type="hidden" name="semester_id" id="semester_id" value="{{data[0].semester_id}}">
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
                                        <input name="alamat" type="text" id="alamat" placeholder="Alamat Jalan" value="{{data[0].alamat}}" class="form-control">
                                    </div>
                                </div>
                                <div class="col-lg-2">
                                    <div class="form-group">
                                        <label>RT</label>
                                        <input name="rt" type="number" maxlength=3"" placeholder="RT" value="{{data[0].rt}}" class="form-control" id="rt">
                                    </div>
                                </div>
                                <div class="col-lg-2">
                                    <div class="form-group">
                                        <label>RW</label>
                                        <input name="rw" type="number" maxlength=3"" placeholder="RW" value="{{data[0].rw}}" class="form-control" id="rw">
                                    </div>
                                </div>                                
                                <div class="col-lg-4">
                                    <div class="form-group">
                                        <label>Dusun</label>
                                        <input name="dusun" type="text" id="nama_dusun" placeholder="Dusun" value="{{data[0].nama_dusun}}" class="form-control">
                                    </div>
                                </div>                                                            
                                <!-- /.col-lg-12 -->                                 

                                <div class="col-lg-6">
                                    <div class="form-group">
                                        <label>Provinsi</label>
                                        <select class="form-control" name="provinsi" id="provinsi">
                                            <option value="0">-- Pilih Provinsi --</option>
                                            {% for a in provinsi %}
                                                {% if (a.id == data[0].kode_prop) %}
                                                <option value="{{ a.id }}" selected="selected">{{ a.name }}</option>
                                                {% else %}
                                                <option value="{{ a.id }}">{{ a.name }}</option>
                                                {% endif %}   
                                            {% endfor %}
                                        </select>
                                    </div>
                                </div>
                                <div class="col-lg-6">
                                    <div class="form-group">
                                        <label>Kabupaten / Kota</label>
                                        <select class="form-control" id="kota" name="kota" readonly>
                                            <option value="{{data[0].kode_kab}}" selected="selected">{{data[0].nama_kabupaten}}</option>
                                        </select>
                                    </div>
                                </div>
                                
                                <!-- /.col-lg-12 -->                                 

                                <div class="col-lg-4">
                                    <div class="form-group">
                                        <label>Kecamatan</label>
                                        <select class="form-control" id="kecamatan" name="kecamatan" readonly>
                                            <option value="{{data[0].kode_kec}}" selected="selected">{{data[0].nama_kecamatan}}</option>
                                        </select>
                                    </div>
                                </div>  
                                <div class="col-lg-4">
                                    <div class="form-group">
                                        <label>Kelurahan</label>
                                        <select class="form-control" id="kelurahan" name="kelurahan" readonly>
                                            <option value="{{data[0].desa_kelurahan}}" selected="selected">{{data[0].nama_kelurahan}}</option>
                                        </select>
                                    </div>
                                </div>                                   
                                <div class="col-lg-4">
                                    <div class="form-group">
                                        <label>Kode Pos</label>
                                        <input name="kode_pos" type="text" id="kode_pos" placeholder="Kode Pos" value="{{data[0].kode_pos}}" class="form-control">
                                    </div>
                                </div>
                                <!-- /.col-lg-12 -->
                            </div>

                            <div class="col-lg-12">
                                <div class="callout callout-info custom">
                                    <h4><i class="fa fa-users"></i>&nbsp; Orangtua</h4>
                                </div>
                                
                                <div class="col-lg-6">
                                    <div class="form-group">
                                        <label>Nama Ayah</label>
                                        <input name="nama_ayah" type="text" id="nama_ayah" placeholder="Nama Ayah" value="{{data[0].nama_ayah}}" class="form-control">
                                    </div>
                                </div>
                                <!-- /.col-lg-12 -->

                                <div class="col-lg-6">
                                    <div class="form-group">
                                        <label>Nama Ibu</label>
                                        <input name="nama_ibu" type="text" id="nama_ibu" placeholder="Nama Ibu" value="{{data[0].nama_ibu}}"class="form-control">
                                    </div>
                                </div>
                                <!-- /.col-lg-12 -->

                                <div class="col-lg-6">
                                    <div class="form-group">
                                        <label>Agama Ayah</label>
                                        <select class="form-control" name="agama_ayah" id="agama_ayah">
                                            <option id="agama_now" value="">-- Pilih Agama --</option>
                                            {% for a in agama %}
                                                {% if (a.agama_id == data[0].agama_ayah) %}
                                                    <option value="{{ a.agama_id }}" selected="selected">{{ a.nama }}</option>
                                                {% else %}
                                                    <option value="{{ a.agama_id }}">{{ a.nama }}</option>
                                                {% endif %}                                            
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
                                                {% if (a.agama_id == data[0].agama_ibu) %}
                                                    <option value="{{ a.agama_id }}" selected="selected">{{ a.nama }}</option>
                                                {% else %}
                                                    <option value="{{ a.agama_id }}">{{ a.nama }}</option>
                                                {% endif %}                                            
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
                                                {% if (a.jenjang_pendidikan_id == data[0].edu_ayah) %}
                                                    <option value="{{ a.jenjang_pendidikan_id }}" selected="selected">{{ a.nama }}</option>
                                                {% else %}
                                                    <option value="{{ a.jenjang_pendidikan_id }}">{{ a.nama }}</option>
                                                {% endif %}                                               
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
                                                {% if (a.jenjang_pendidikan_id == data[0].edu_ibu) %}
                                                    <option value="{{ a.jenjang_pendidikan_id }}" selected="selected">{{ a.nama }}</option>
                                                {% else %}
                                                    <option value="{{ a.jenjang_pendidikan_id }}">{{ a.nama }}</option>
                                                {% endif %}                                               
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
                                                {% if (a.pekerjaan_id == data[0].job_ayah) %}
                                                    <option value="{{ a.pekerjaan_id }}" selected="selected">{{ a.nama }}</option>
                                                {% else %}
                                                    <option value="{{ a.pekerjaan_id }}">{{ a.nama }}</option>
                                                {% endif %}                                               
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
                                                {% if (a.pekerjaan_id == data[0].job_ibu) %}
                                                    <option value="{{ a.pekerjaan_id }}" selected="selected">{{ a.nama }}</option>
                                                {% else %}
                                                    <option value="{{ a.pekerjaan_id }}">{{ a.nama }}</option>
                                            {% endif %}                                               
                                        {% endfor %}  
                                        </select>
                                    </div>
                                </div>
                                <!-- /.col-lg-12 -->

                                <div class="col-lg-6">
                                    <div class="form-group">
                                        <label>Penghasilan Ayah</label>
                                        <select class="form-control" name="penghasilan_ayah">
                                            <option value="0">-- Pilih Penghasilan --</option>
                                            {% for a in penghasilan %}
                                                {% if (a.penghasilan_orangtua_wali_id == data[0].penghasilan_ortu) %}
                                                    <option value="{{ a.penghasilan_orangtua_wali_id }}" selected="selected">{{ a.nama }}</option>
                                                {% else %}
                                                    <option value="{{ a.penghasilan_orangtua_wali_id }}">{{ a.nama }}</option>
                                                {% endif %}                                               
                                            {% endfor %}
                                        </select>                                        
                                    </div>
                                </div>
                                <div class="col-lg-6">
                                    <div class="form-group">
                                        <label>Penghasilan Ibu</label>
                                        <select class="form-control" name="penghasilan_ibu">
                                            <option value="0">-- Pilih Penghasilan --</option>
                                            {% for a in penghasilan %}
                                                {% if (a.penghasilan_orangtua_wali_id == data[0].penghasilan_id_ibu) %}
                                                    <option value="{{ a.penghasilan_orangtua_wali_id }}" selected="selected">{{ a.nama }}</option>
                                                {% else %}
                                                    <option value="{{ a.penghasilan_orangtua_wali_id }}">{{ a.nama }}</option>
                                                {% endif %}                                               
                                            {% endfor %}
                                        </select>
                                    </div>
                                </div>                                
                                    <!-- /.col-lg-12 -->
                                <div class="col-lg-6">
                                    <div class="form-group">
                                        <label>Email</label>
                                        <input name="email" type="text" id="email" placeholder="Email Orangtua" value="{{data[0].email}}" class="form-control">
                                    </div>
                                </div>
                                <div class="col-lg-6">
                                    <div class="form-group">
                                        <label>No Telepon Rumah</label>
                                        <input name="telpon" type="text" id="telpon" placeholder="Telepon Rumah" value="{{data[0].telpon}}" class="form-control">
                                    </div>
                                </div>
                                <!-- /.col-lg-12 -->

                                <div class="col-lg-6">
                                    <div class="form-group">
                                        <label>No Hp Ayah</label>
                                        <input name="nomor_ayah" type="text" id="hp_ayah" placeholder="No Hp Ayah" value="{{data[0].nomor_telepon_seluler}}" class="form-control">
                                    </div>
                                </div>
                                <div class="col-lg-6">
                                    <div class="form-group">
                                        <label>No Hp Ibu</label>
                                        <input name="nomor_ibu" type="text" id="hp_ibu" placeholder="Np Hp Ibu" value="{{data[0].nomor_telepon_seluler_2}}" class="form-control">
                                    </div>
                                </div>                                
                                <!-- /.col-lg-12 -->                                

                                <div class="col-lg-12">
                                    <div class="form-group">
                                        <label>Alamat Orang Tua</label>
                                        <input name="alamat_ortu" type="text" id="alamat_ortu" placeholder="Alamat Orang Tua" value="{{data[0].alamat_ortu}}" class="form-control">
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
                            <button id="frm_data" type="submit" class="btn btn-lg btn-danger"><i class="fa fa-paper-plane"></i>&nbsp; Ubah Data</button>
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
        $('#tgl_lahir_input').datepicker({
            language: 'id',
            format: 'dd-MM-yyyy',
            autoclose: true,
            startDate: `-50y`,
            endDate: '+1d',
            todayBtn: true,
            todayHighlight: true,
            title: "Pilih Tanggal"
        }).on('changeDate', function (ev) {
            var selectedDate = ev.format(0, "yyyy-mm-dd");
            $('#tgl_lahir').val(selectedDate);
            $("#reset_pass").attr("onclick", "reset_password('"+selectedDate+"')");
        });        
        
        $('#tgl_masuk_input').datepicker({
            language: 'id',
            format: 'dd-MM-yyyy',
            autoclose: true,
            startDate: `-8y`,
            endDate: '+1d',
            todayBtn: true,
            todayHighlight: true,
            title: "Pilih Tanggal"
        }).on('changeDate', function (ev) {
            var selectedDate = ev.format(0, "yyyy-mm-dd");
            $('#tgl_masuk').val(selectedDate);
        });        

        // filestyle config
        $(":file").filestyle({
            input: false,
            buttonText: "Upload",
            buttonName: "btn-danger",            
            iconName: "fa fa-cloud-upload"
        });

        // replace image when error
        $('#uploadPreview1').on("error", function() {
            $(this).attr('src', 'img/user.png');
        });

    });

    (function() {
        $('#form_edit').on('submit', function(e) {
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
                success: function(res){
                    reload_page2('pesertadidik/editMurid/{{ data[0].id_mhs }}/{{rombel_id}}');
                    new PNotify({
                        title: res.title,
                        text: res.text,
                        type: res.type
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
                $('#semester').val(data[0]["nama_semester"]);
                $('#semester_id').val(data[0]["semester_id"]);
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
            success   : function(res){                      
                count = res.length;
                buatOption = "";
                for(a = 0; a < count; a++){
                    buatOption += '<option value='+res[a]["id"]+'>'+res[a]["name"]+'</option>';
                }

                $('#kota').removeAttr('readonly');
                $('#kota').find('option').remove().end().append('<option value="0">-- Pilih Kota --</option>' + buatOption);
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
            success   : function(res){            
                count = res.length;
                buatOption = "";
                for(a = 0; a < count; a++){
                    buatOption += '<option value='+res[a]["id"]+'>'+res[a]["name"]+'</option>';
                }

                $('#kecamatan').removeAttr('readonly');
                $('#kecamatan').find('option').remove().end().append('<option value="0">-- Pilih Kecamatan --</option>' + buatOption);
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
            success   : function(res){            
                count = res.length;
                buatOption = "";
                for(a = 0; a < count; a++){
                    buatOption += '<option value='+res[a]["id"]+'>'+res[a]["name"]+'</option>';
                }

                $('#kelurahan').removeAttr('readonly');
                $('#kelurahan').find('option').remove().end().append('<option value="0">-- Pilih Kelurahan --</option>' + buatOption);
            }
        });
    });

    function PreviewImage(id) {
        var oFReader = new FileReader();
        oFReader.readAsDataURL(document.getElementById("uploadImage"+id).files[0]);

        oFReader.onload = function (oFREvent) {
            document.getElementById("uploadPreview"+id).src = oFREvent.target.result;
        };
    };

    function reset_password(date) {
        var nis = '{{ data[0].nis }}';
        var dataStore = "nis="+nis+"&tgl_lahir="+date;

        $.ajax({
            type     : 'POST',
            url      : "{{ url('pesertadidik/resetPassword') }}",
            data     : dataStore,
            dataType : 'json',
            success  : function(res){            
                new PNotify({
                    title: 'Berhasil',
                    text: res.status,
                    type: 'success'
                });
            }
        });        
    }

</script>