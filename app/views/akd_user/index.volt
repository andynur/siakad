{# Define variables #}
{% set tanggalIndo = helper.dateBahasaIndo(date('Y-m-d')) %}
{% set urlPost = url('user/addUser') %}

{# Global css #}
<style>{% include "include/view.css" %}</style>

{# Custom css #}
<style>{% include "rombel/assets/anggota.css" %}</style>

<!-- Header content -->
<section class="content-header">
    <h1>
        User Pengguna
        <small>
            <i class="fa fa-calendar-o"></i> {{ tanggalIndo }} 
            <i class="fa fa-clock-o"></i> <span id="waktu">00:00:00</span>
        </small> 
    </h1>
    <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i> Setup Admin</a></li>
        <li class="active">User</li>
    </ol>   
</section>

<!-- Main content -->
<section class="content">
    <div class="row">
        <!-- left column -->
        <div class="col-md-4">
            <div class="box box-primary">
                <div class="box-header">
                    <h3 class="box-title" id="form_title">Tambah User</h3>
                </div>
                <!-- /.box-header -->
                <div class="box-body pad">
                    <div class="row">
                        <form id="form_input" method="POST" action="{{ urlPost }}">
                            <div class="form-group col-md-12 text-center">
                                <img src="img/user.png" alt="Foto User" height="85px" class="img-circle text-center" id="foto">
                            </div>
                            <div class="form-group col-md-5">
                                <label for="id_jenis">Jenis User</label>
                                <select class="form-control" name="id_jenis" onchange="changeJenis(this)" id="jenis">
                                    <option value="">Pilih:</option>
                                    {% for opt in jenis %}
                                        {% if (opt.nama == 'SDM') %}
                                            {% set jenis_nama = 'GURU/SDM' %}
                                        {% else %}
                                            {% set jenis_nama = 'MURID' %}
                                        {% endif %}
                                    <option value="{{ opt.id_jenis }}">{{ jenis_nama }}</option>
                                    {% endfor %}
                                </select>
                            </div>                                   
                            <div class="form-group col-md-7">
                                <label for="nama">Nama Lengkap</label>
                                <select id="nama" class="form-control select2" data-placeholder="Cari nama..." style="width: 100%;">
                                    <option value=""></option>
                                </select>
                            </div>                                               
                            <div class="form-group col-md-5">
                                <label for="uid">UID</label>
                                <input type="text" class="form-control" name="uid" placeholder="UID" id="uid">
                                <input type="hidden" name="nip" id="nip">
                            </div>
                            <div class="form-group col-md-7">
                                <label for="password">Password</label>
                                <div class="input-group">
                                    <input type="password" class="form-control active" name="password" placeholder="Password" id="pass">
                                    <a class="input-group-addon" href="#" id="showPassword"><i class="fa fa-eye-slash"></i></a>
                                </div>                                
                            </div>                                                        
                            <div class="form-group col-md-12">
                                <label for="area">Area Akses Menu</label>
                                <select name="area" id="area" class="form-control select2" multiple="multiple" data-placeholder="Pilih area akses:" style="width: 100%;">
                                    {% for opt in area %}
                                    <option value="{{opt.id}}">{{opt.label_menu}}</option>
                                    {% endfor %}
                                </select>
                            </div>
                            <div class="form-group col-md-12">
                                <label for="usergroup">Usergroup</label>
                                <select name="usergroup" id="usergroup" class="form-control select2" multiple="multiple" data-placeholder="Pilih usergroup:" style="width: 100%;">
                                    {% for opt in usergroup %}
                                    <option value="{{opt.id}}">{{opt.nama}}</option>
                                    {% endfor %}
                                </select>
                            </div>                                     

                            <div class="col-md-12">
                                <div class="pull-right">
                                    <button type="reset" class="btn btn-default" id="reset"><i class="fa fa-refresh"></i>&nbsp; Reset</button>
                                    <button type="button" onclick="save_data('addUser')" class="btn btn-primary" id="submit"><i class="fa fa-send"></i>&nbsp; Simpan</button>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
            <!-- /.box -->
        </div>
        <!-- right column -->
        <div class="col-md-8">
            <div class="box">
                <div class="box-header">
                    <h3 class="box-title">Data User</h3>
                </div>
                <div class="box-body">
                    <!-- Filter section -->
                    <form class="form-horizontal" id="form_filter">
                        <div class="row form-group">
                            <div class="col-sm-2">
                                <label for="filter_jenis" class="control-label">
                                    <i class="fa fa-arrow-circle-o-right"></i> Filter Data:
                                </label>
                            </div>
                            <div class="col-sm-3">
                                <select class="form-control" id="filter_jenis">
                                    <option value="">-- Pilih Jenis --</option>
                                    {% if (set_jenis == '1') %}
                                        {% set selected_guru = 'selected="selected"' %}
                                        {% set disable = 'disabled' %}
                                    {% endif %}
                                    {% if (set_jenis == '2') %}
                                        {% set selected_murid = 'selected="selected"' %}
                                    {% endif %}                                    
                                    <option value="1" {{ selected_guru }}>Guru/Sdm</option>
                                    <option value="2" {{ selected_murid }}>Murid</option>
                                </select>
                            </div>
                            <div class="col-sm-3">
                                <select class="form-control" id="filter_tingkat" {{ disable }}>
                                    <option value="0">-- Pilih Tingkat --</option>
                                    {% for opt in tingkat %}
                                        {% if (opt.id == set_tingkat) %}
                                        <option value="{{ opt.id }}" selected="selected">{{ opt.nama }}</option>
                                        {% elseif (opt.id == '7') %}
                                            
                                        {% else %}
                                        <option value="{{ opt.id }}">{{ opt.nama }}</option>
                                        {% endif %}
                                    {% endfor %}
                                </select>
                            </div>
                            <div class="col-sm-2">
                                <button type="button" class="btn btn-success btn-flat" id="proses"><i class="fa fa-send"></i> Proses</button>
                            </div>
                        </div>
                    </form>
                    <!-- ./Filter section -->

                    <table id="data_table" class="table table-bordered table-striped">
                        <thead>
                            <tr>
                                <th style="width: 10px">No</th>
                                <th>UID</th>
                                <th>Nama / No Identitas</th>
                                <th>Jenis</th>
                                <th>Aktif</th>
                                <th>Aksi</th>
                            </tr>
                        </thead>
                        <tbody>
                            {% set no=1 %} {% for v in data %}
                            
                            {% if (v.id_jenis == 1) %}
                                {% set folder = 'sdm' %}
                                {% set nama_jenis = 'Guru/Sdm' %}
                            {% else %}
                                {% set folder = 'mhs' %}
                                {% set nama_jenis = 'Murid' %}                                
                            {% endif %}

                            {% if (v.id_status == 'A') %}
                                {% set color = 'green' %}
                            {% else %}
                                {% set color = 'red' %}
                            {% endif %}

                            <tr id="data_{{v.login}}" class="middle-row">
                                <td>{{no}}</td>
                                <td><span class="badge bg-dark">{{v.login}}</span></td>
                                <td>
                                    <img src="img/{{folder}}/{{v.foto}}" alt="{{v.nama}}" style="height: 3em; float: left; margin-right: 10px; border-radius: 50px">
                                    <span style="font-weight: 600">{{v.nama}}</span> <br/> 
                                    {% if (v.nip != '') %}
                                        {% if (v.id_jenis == 1) %}
                                            {% set identitas = 'NIP' %}
                                        {% else %}
                                            {% set identitas = 'NIS' %}
                                        {% endif %}                                      
                                    <span class="label label-default">{{identitas}}</span> 
                                    <span class="label label-primary">{{v.nip}}</span>
                                    {% endif %}  
                                </td> 
                                <td>{{nama_jenis}}</td>
                                <td><span class="badge bg-{{color}}">{{v.id_status}}</span></td>
                                <td>
                                    <a class="btn btn-primary btn-xs btn-flat" onclick="edit_data('{{ v.login }}')"><i class="glyphicon glyphicon-edit"></i> </a>

                                    <a class="btn btn-danger btn-xs btn-flat" onclick="delete_data('{{v.login}}')"><i class="glyphicon glyphicon-trash"></i></a>
                                </td>
                            </tr>
                            {% set no=no+1 %} {% endfor %}
                        </tbody>
                    </table>
                </div>
                <!-- /.box-body -->
            </div>
            <!-- /.box -->
        </div>
    </div>

</section>
<!-- /.content -->

<script>{% include "akd_user/assets/user.js" %}</script>