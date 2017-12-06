{% set urlPost = url('sdm/editSdm') %}

{# Global css #}
<style>{% include "include/view.css" %}</style>
{# Custom css #}
<style>{% include "sdm/assets/form.css" %}</style>

<section class="content-header">
    <h1>
        <button type="button" class="btn bg-navy btn-flat" id="back"><i class="fa fa-arrow-circle-left"></i> &nbsp; Kembali</button>
    </h1>
    <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i>SDM</a></li>
        <li class="active">Ubah</li>
    </ol>
</section>

<!-- Main content -->
<section class="content">
    <div class="row">
        <div class="col-md-offset-2 col-md-8">
            <div class="box box-info">
                <div class="box-header with-border">
                    <h3 class="box-title">Edit SDM #{{ data.id_sdm }}</h3>
                </div>

                <form method="post" id="form_input" action="{{ urlPost }}/{{ data.id_sdm }}" >
                    <div class="box-body" style="height:auto;">
                        <div class="row">
                            <!-- Profil SDM -->
                            <div class="col-lg-12">
                                <div class="callout callout-info custom">
                                    <h4><i class="fa fa-user"></i>&nbsp; Profil SDM</h4>
                                </div>

                                <div class="col-lg-9">
                                    <div class="row">
                                        <div class="col-lg-7">
                                            <div class="form-group">
                                                <label>Nama Lengkap <span class="red">*</span></label>
                                                <input name="nama" type="text" placeholder="Nama" class="form-control" value="{{ data.nama }}">
                                            </div>
                                        </div>
                                        <div class="col-lg-5">
                                            <div class="form-group">
                                                <label>Email</label>
                                                <input name="email" type="text" placeholder="Email" class="form-control" value="{{ data.e_mail }}">
                                            </div>                                            
                                        </div>
                                        <!-- /.col-lg-12 -->

                                        <div class="col-lg-7">
                                            <div class="form-group">
                                                <label>NIP <span class="red">*</span></label>
                                                <input type="text" name="nip" placeholder="Nomor Induk Pegawai" class="form-control" maxlength="18" value="{{ data.nip }}">
                                            </div>
                                        </div>
                                        <div class="col-lg-5">
                                            <div class="form-group">
                                                <label>NUPTK</label>
                                                <input type="text" name="nuptk" placeholder="NUPTK" class="form-control" maxlength="10" value="{{ data.nuptk }}">
                                            </div>
                                        </div>
                                        <!-- /.col-lg-12 -->

                                        <div class="col-lg-7">
                                            <div class="form-group">
                                                <label>NIK</label>
                                                <input type="text" name="nik" placeholder="Nomor Induk Kewarganegaraan" class="form-control" maxlength="16" value="{{ data.nik }}">
                                            </div>
                                        </div>
                                        <div class="col-lg-5">
                                            <div class="form-group">
                                                <label>NIY NIGK</label>
                                                <input name="niy_nigk" type="text" placeholder="NIY NIGK" class="form-control" value="{{ data.niy_nigk }}">
                                            </div>
                                        </div>

                                        <div class="col-lg-7">
                                            <div class="form-group">
                                                <label>Tempat Lahir  <span class="red">*</span></label>
                                                <input name="tempat_lahir" type="text" placeholder="Tempat Lahir" class="form-control" value="{{ data.tmp_lahir }}">
                                            </div>
                                        </div>
                                        <div class="col-lg-5">
                                            <div class="form-group">
                                                <label>Tanggal Lahir  <span class="red">*</span></label>
                                                <input name="tanggal_lahir" type="text" placeholder="Tanggal Lahir" class="form-control" value="{{ helper.dateBahasaIndo(data.tgl_lahir) }}">
                                                <input type="hidden" name="tanggal_kirim" value="{{ data.tgl_lahir }}">
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="col-lg-3">
                                    <div class="form-group">
                                        <label>Foto</label>
                                        <div>
                                            <img src="img/sdm/{{ data.foto }}" alt="foto sdm" class="preview" id="uploadPreview" />
                                        </div>
                                    </div>
                                    <input type="file" name="foto" id="uploadImage" accept="image/*">
                                    <input type="hidden" name="foto_lama" value="{{ data.foto }}">
                                </div>

                                <div class="col-lg-4">
                                    <div class="form-group">
                                        <label>Jenjang <span class="red">*</span></label>
                                        <select class="form-control" name="jenjang">
                                            <option value="0">-- Pilih Jenjang --</option>
                                            <option value="KB-TK" {{ (data.jenjang == 'KB-TK') ? 'selected' : '' }}>KB-TK</option>
                                            <option value="SD" {{ (data.jenjang == 'SD') ? 'selected' : '' }}>SD</option>
                                            <option value="SMP" {{ (data.jenjang == 'SMP') ? 'selected' : '' }}>SMP</option>
                                            <option value="SMA" {{ (data.jenjang == 'SMA') ? 'selected' : '' }}>SMA</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="col-lg-4">
                                    <div class="form-group">
                                        <label>Agama </label>
                                        <select class="form-control" name="agama">
                                            <option value="0">-- Pilih Agama --</option>
                                            {% for a in agama %}
                                            {% if (a.agama_id == data.kode_agama) %}
                                            <option value="{{ a.agama_id }}" selected="selected">{{ a.nama }}</option>
                                            {% else %}
                                            <option value="{{ a.agama_id }}">{{ a.nama }}</option>
                                            {% endif %}
                                            {% endfor %}
                                        </select>
                                    </div>
                                </div>
                                <div class="col-lg-4">
                                    <div class="form-group">
                                        <label>Jenis Kelamin <span class="red">*</span></label>
                                        <div class="jk">
                                            <input name="jenis_kelamin" type="radio" id="jkl" value="l" {{ (data.kelamin == 'l') ? 'checked' : '' }}>
                                            <label for="jkl" style="font-weight: normal;"> Laki-Laki</label>  &nbsp; &nbsp;
                                            <input name="jenis_kelamin" type="radio" id="jkp" value="p" {{ (data.kelamin == 'p') ? 'checked' : '' }}>
                                            <label for="jkp" style="font-weight: normal;"> Perempuan</label>  
                                        </div>
                                    </div>
                                </div>                                        
                                <!-- /.col-lg-12 -->                                
                            </div>
                            <!-- Alamat & Kontak -->
                            <div class="col-lg-12">
                                <div class="callout callout-info custom">
                                    <h4><i class="fa fa-map-marker"></i>&nbsp; Alamat &amp; Kontak</h4>
                                </div>

                                <div class="col-lg-4">
                                    <div class="form-group">
                                        <label>Alamat Jalan</label>
                                        <input name="alamat" type="text" placeholder="Alamat Jalan" class="form-control" value="{{ data.alamat }}">
                                    </div>
                                </div>
                                <div class="col-lg-2">
                                    <div class="form-group">
                                        <label>RT</label>
                                        <input name="rt" type="number" maxlength=3"" placeholder="RT" class="form-control" value="{{ data.rt }}">
                                    </div>
                                </div>
                                <div class="col-lg-2">
                                    <div class="form-group">
                                        <label>RW</label>
                                        <input name="rw" type="number" maxlength=3"" placeholder="RW" class="form-control" value="{{ data.rw }}">
                                    </div>
                                </div>                                
                                <div class="col-lg-4">
                                    <div class="form-group">
                                        <label>Dusun</label>
                                        <input name="dusun" type="text" placeholder="Dusun" class="form-control" value="{{ data.nama_dusun }}">
                                    </div>
                                </div>                                                            
                                <!-- /.col-lg-12 -->                                 

                                <div class="col-lg-6">
                                    <div class="form-group">
                                        <label>Provinsi</label>
                                        <select class="form-control" name="provinsi">
                                            <option value="0">-- Pilih provinsi --</option>
                                            {% for a in provinsi_list %}
                                            {% if (a.kode_wilayah == provinsi.id) %}
                                            <option value="{{ a.kode_wilayah }}" selected>{{ a.nama }}</option>
                                            {% else %}
                                            <option value="{{ a.kode_wilayah }}">{{ a.nama }}</option>
                                            {% endif %}
                                            {% endfor %}
                                        </select>
                                    </div>
                                </div>
                                <div class="col-lg-6">
                                    <div class="form-group">
                                        <label>Kabupaten / Kota</label>
                                        <select class="form-control" name="kabupaten" readonly>
                                            <option value="{{ kabupaten.id }}" selected>{{ kabupaten.nama }}</option>
                                        </select>
                                    </div>
                                </div>                            
                                <!-- /.col-lg-12 -->                                 

                                <div class="col-lg-6">
                                    <div class="form-group">
                                        <label>Kecamatan</label>
                                        <select class="form-control" name="kecamatan" readonly>
                                            <option value="{{ kecamatan.id }}" selected>{{ kecamatan.nama }}</option>
                                        </select>
                                    </div>
                                </div>  
                                <div class="col-lg-6">
                                    <div class="form-group">
                                        <label>Kelurahan</label>
                                        <select class="form-control" name="kelurahan" readonly>
                                            <option value="{{ data.kode_wilayah }}" selected>{{ data.desa_kelurahan }}</option>
                                        </select>
                                        <input type="hidden" name="kode_wilayah" value="{{ data.kode_wilayah }}">
                                        <input type="hidden" name="desa_kelurahan" value="{{ data.desa_kelurahan }}">
                                    </div>
                                </div>    
                                <!-- /.col-lg-12 -->                                 
                                                               
                                <div class="col-lg-4">
                                    <div class="form-group">
                                        <label>Kode Pos</label>
                                        <input name="kode_pos" type="text" placeholder="Kode Pos" class="form-control" value="{{ data.kodepos }}">
                                    </div>
                                </div>                                
                                <div class="col-lg-4">
                                    <div class="form-group">
                                        <label>No Telepon Rumah</label>
                                        <input name="no_telepon_rumah" type="text" placeholder="No Telepon Rumah" class="form-control" value="{{ data.telpon }}">
                                    </div>
                                </div>  
                                <div class="col-lg-4">
                                    <div class="form-group">
                                        <label>No Handphone</label>
                                        <input name="no_hp" type="text" placeholder="No Handphone" class="form-control" value="{{ data.no_hp }}">
                                    </div>
                                </div>                                   
                                <!-- /.col-lg-12 -->                                
                            </div>
                            <!-- Informasi Lain -->
                            <div class="col-lg-12">
                                <div class="callout callout-info custom">
                                    <h4><i class="fa fa-info-circle"></i>&nbsp; Informasi Lain</h4>
                                </div>
                                
                                <div class="col-lg-6">
                                    <div class="form-group">
                                        <label>Status Kepegawaian</label>
                                        <select class="form-control" name="status_kepegawaian_id">
                                            <option value="0">-- Pilih Status Pegawai --</option>
                                            {% for a in status_kepegawaian %}
                                            {% if (a.status_kepegawaian_id == data.status_kepegawaian_id)%}
                                            <option value="{{ a.status_kepegawaian_id }}" selected>{{ a.nama }}</option>
                                            {% else %}
                                            <option value="{{ a.status_kepegawaian_id }}">{{ a.nama }}</option>
                                            {% endif %}
                                            {% endfor %}
                                        </select>
                                    </div>
                                </div>
                                <!-- /.col-lg-12 -->

                                <div class="col-lg-6">
                                    <div class="form-group">
                                        <label>Jenis SDM</label>
                                        <select class="form-control" name="jenis_ptk_id">
                                            <option value="0">-- Pilih Jenis SDM --</option>
                                            {% for a in jenis_ptk %}
                                            {% if (a.jenis_ptk_id == data.jenis_ptk_id)%}
                                            <option value="{{ a.jenis_ptk_id }}" selected>{{ a.jenis_ptk }}</option>
                                            {% else %}
                                            <option value="{{ a.jenis_ptk_id }}">{{ a.jenis_ptk }}</option>
                                            {% endif %}
                                            {% endfor %}
                                        </select>
                                    </div>
                                </div>
                                <!-- /.col-lg-12 -->

                                <div class="col-lg-6">
                                    <div class="form-group">
                                        <label>Status Keaktifan</label>
                                        <select class="form-control" name="status_keaktifan_id">
                                            <option value="1" {{ (data.status_keaktifan_id == '1') ? 'selected' : '' }}>Aktif</option>
                                            <option value="2" {{ (data.status_keaktifan_id == '2') ? 'selected' : '' }}>Tidak AKitf</option>
                                        </select>
                                    </div>
                                </div>

                                <div class="col-lg-6">
                                    <div class="form-group">
                                        <label>Lembaga Pengangkat</label>
                                        <select class="form-control" name="lembaga_pengangkat_id">
                                            <option value="0">-- Pilih Lembaga Pengangkat --</option>
                                            {% for a in lembaga_pengangkat %}
                                            {% if (a.lembaga_pengangkat_id == data.lembaga_pengangkat_id)%}
                                            <option value="{{ a.lembaga_pengangkat_id }}" selected>{{ a.nama }}</option>
                                            {% else %}                                            
                                            <option value="{{ a.lembaga_pengangkat_id }}">{{ a.nama }}</option>
                                            {% endif %}
                                            {% endfor %}
                                        </select>
                                    </div>
                                </div>

                                <div class="col-lg-6">
                                    <div class="form-group">
                                        <label>Pangkat Golongan</label>
                                        <select class="form-control" name="pangkat_golongan_id">
                                            <option value="0">-- Pilih Pangkat Golongan --</option>
                                            {% for a in pangkat_golongan %}
                                            {% if (a.pangkat_golongan_id == data.pangkat_golongan_id)%}
                                            <option value="{{ a.pangkat_golongan_id }}" selected>{{ a.nama }}</option>
                                            {% else %}                                            
                                            <option value="{{ a.pangkat_golongan_id }}">{{ a.nama }}</option>
                                            {% endif %}                                            
                                            {% endfor %}
                                        </select>
                                    </div>
                                </div>                  
                                
                                <div class="col-lg-6">
                                    <div class="form-group">
                                        <label>Keahlian Laboratorium</label>
                                        <select class="form-control" name="keahlian_laboratorium_id">
                                            <option value="0">-- Pilih Keahlian --</option>
                                            {% for a in keahlian_laboratorium %}
                                            {% if (a.keahlian_laboratorium_id == data.keahlian_laboratorium_id)%}
                                            <option value="{{ a.keahlian_laboratorium_id }}" selected>{{ a.nama }}</option>
                                            {% else %}                                            
                                            <option value="{{ a.keahlian_laboratorium_id }}">{{ a.nama }}</option>
                                            {% endif %}                                             
                                            {% endfor %}
                                        </select>
                                    </div>
                                </div>                                
                                
                                <div class="col-lg-6">
                                    <div class="form-group">
                                        <label>Sumber Gaji</label>
                                        <select class="form-control" name="sumber_gaji_id">
                                            <option value="0">-- Pilih Sumber Gaji --</option>
                                            {% for a in sumber_gaji %}
                                            {% if (a.sumber_gaji_id == data.sumber_gaji_id)%}
                                            <option value="{{ a.sumber_gaji_id }}" selected>{{ a.nama }}</option>
                                            {% else %}                                            
                                            <option value="{{ a.sumber_gaji_id }}">{{ a.nama }}</option>
                                            {% endif %}
                                            {% endfor %}
                                        </select>
                                    </div>
                                </div>                          
                            </div>

                        </div>
                        <!-- /.row -->
                    </div>
                    <!-- /.box-body -->

                    <div class="box-footer">
                        <div class="col-md-6">
                            <label style="padding: 10px 0;">&nbsp; &nbsp; Tanda <span style="color:red">*</span> wajib diisi!</label>
                        </div>                      
                        <div class="col-md-6">
                            <button type="submit" class="btn btn-lg btn-danger pull-right" id="submit"><i class="fa fa-paper-plane"></i> Simpan Data</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</section>
<!-- /.content -->

<!-- bootstrap filestyle -->
<script src="js/bootstrap-filestyle.min.js"></script>
<!-- global script -->
<script>{% include "include/view.js" %}</script>
<!-- custom script -->
<script>{% include "sdm/assets/form.js" %}</script>