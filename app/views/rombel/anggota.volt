{# Define variables #}
{% set tanggalIndo = helper.dateBahasaIndo(date('Y-m-d')) %}
{% set urlPost = url('rombelanggota/addRombelAnggota') %}

{# Global css #}
<style>{% include "include/view.css" %}</style>

{# Custom css #}
<style>{% include "rombel/assets/anggota.css" %}</style>

<!-- Header content -->
<section class="content-header">
    <h1>
        Rombel Anggota
        <small>
            <i class="fa fa-calendar-o"></i> {{ tanggalIndo }} 
            <i class="fa fa-clock-o"></i> <span id="waktu">00:00:00</span>
        </small> 
    </h1>
    <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i> Rombongan Belajar</a></li>
        <li class="active">Rombel Anggota</li>
    </ol>
</section>

<!-- Main content -->
<section class="content">
    <div class="row">
        <!-- Form column -->
        <div class="col-md-4">
            <div class="box box-primary">
                <div class="box-header">
                    <h3 class="box-title" id="form_title">Tambah Anggota</h3>
                    <div class="pull-right box-tools">                    
                      <button class="btn btn-primary btn-sm" data-widget="collapse" data-toggle="tooltip" title="" data-original-title="Collapse"><i class="fa fa-minus" style="padding:0"></i></button>
                    </div>                    
                </div>
                <!-- /.box-header -->
                <div class="box-body pad">
                    <form id="form_input" method="POST" action="{{ urlPost }}">
                        <div class="form-group">
                            <label for="rombongan_belajar_id">Rombel</label>
                            <select class="form-control" name="rombongan_belajar_id">
                                <option value="">-- Pilih Rombel --</option>
                                {% for opt in rombel %}
                                <option value="{{ opt.rombongan_belajar_id }}">{{ opt.nama_tingkat }} - {{ opt.nama_rombel }}</option>
                                {% endfor %}
                            </select>
                        </div>
                        <div class="form-group">
                            <label for="semester_id">Semester</label>
                            <select class="form-control" name="semester_id">
                                <option value="">-- Pilih Semester --</option>
                                {% for opt in semester %}
                                <option value="{{ opt.semester_id }}">{{ opt.nama }}</option>
                                {% endfor %}
                            </select>
                        </div>                        
                        <div class="form-group">
                            <label for="siswa_id">Murid</label>
                            <select class="form-control select2" multiple="multiple" name="siswa_id" style="width: 100%">
                                {% for opt in siswa %}
                                <option value="{{ opt.siswa_id }}">{{ opt.nama }} ({{ opt.nis }})</option>
                                {% endfor %}
                            </select>
                            <input type="hidden" name="siswa_id_hidden">
                        </div>                        
                        <div class="form-group">
                            <label for="jenis_pendaftaran_id">Jenis Pendaftaran</label>
                            <select class="form-control" name="jenis_pendaftaran_id">
                                <option value="">-- Pilih Jenis --</option>
                                {% for opt in jenis %}
                                <option value="{{ opt.jenis_pendaftaran_id }}">{{ opt.nama }}</option>
                                {% endfor %}
                            </select>
                        </div>

                        <div class="pull-right">
                            <button type="reset" class="btn btn-default" id="reset"><i class="fa fa-refresh"></i> Reset</button>
                            <button type="submit" class="btn btn-primary" id="submit"><i class="fa fa-send"></i> Simpan</button>
                        </div>
                    </form>
                </div>
                <!-- /.box-body -->                
            </div>
            <!-- /.box -->
        </div>

        <!-- Table column -->
        <div class="col-md-8">
            <div class="box">
                <div class="box-header">
                    <h3 class="box-title">Data Rombel Anggota</h3>
                    <button class="btn btn-xs btn-flat bg-orange" id="siswa_add" style="    margin-left: 0.5em;"><i class="fa fa-plus"></i> Murid</button>
                </div>
                <div class="box-body">
                    <!-- Filter section -->
                    <form class="form-horizontal" id="form_filter">
                        <div class="form-group">
                            <div class="col-sm-2">
                                <label for="filter_rombel" class="control-label">
                                    <i class="fa fa-arrow-circle-o-right"></i> Filter Data:
                                </label>
                            </div>
                            <div class="col-sm-4">
                                <select class="form-control" id="filter_rombel">
                                    <option value="">-- Pilih Rombel --</option>
                                    {% for opt in rombel %}
                                        {% if (opt.rombongan_belajar_id == rombel_id) %}
                                        <option value="{{ opt.rombongan_belajar_id }}" selected="selected">{{ opt.nama_tingkat }} - {{ opt.nama_rombel }}</option>
                                        {% else %}
                                        <option value="{{ opt.rombongan_belajar_id }}">{{ opt.nama_tingkat }} - {{ opt.nama_rombel }}</option>
                                        {% endif %}
                                    {% endfor %}
                                </select>
                            </div>
                            <div class="col-sm-4">
                                <select class="form-control" id="filter_semester">
                                    <option value="">-- Pilih Semester --</option>
                                    {% for opt in semester %}
                                        {% if (opt.semester_id == semester_id) %}
                                        <option value="{{ opt.semester_id }}" selected="selected">{{ opt.nama }}</option>
                                        {% else %}
                                        <option value="{{ opt.semester_id }}">{{ opt.nama }}</option>
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
                                <th class="width-10">No</th>
                                <th class="min-260">Murid</th>
                                <th>Jenis Pendaftaran</th>
                                <th>Aksi</th>
                            </tr>
                        </thead>
                        <tbody>
                        {% set no = 1 %} 
                        {% for row in data %}                                                     
                            {% set id = row.anggota_rombel_id %} 
                            {% set foto = row.foto %} 
                            {% set rombel = row.nama_rombel %} 
                            {% set jenis = row.nama_jenis %} 
                            {% set nis = row.nis %} 
                            {% set siswa = row.nama_siswa %} 
                            {% set siswa_id = row.siswa_id %} 

                            <tr id="data_{{ id }}" class="middle-row">
                                <td>{{ no }}</td>
                                <td>
                                    <img src="img/mhs/{{ foto }}" alt="{{ siswa }}" class="img-murid">
                                    <a href="#" data-siswa="{{ siswa_id }}" data-rombel="{{ rombel_id }}" id="siswa">{{ siswa }}</a> <br/> 
                                    <span class="label label-default">NIS</span> 
                                    <span class="label label-primary" id="nis">{{ nis }}</span>
                                    <span class="hide" id="siswa_id">{{ siswa_id }}</span>
                                </td>
                                <td>{{ jenis }}</td>
                                <td>
                                    <a data-id="{{ id }}" class="btn btn-primary btn-xs btn-flat edit"><i class="glyphicon glyphicon-edit"></i> </a>

                                    <a data-id="{{ id }}" class="btn btn-danger btn-xs btn-flat delete"><i class="glyphicon glyphicon-trash"></i></a>
                                </td>
                            </tr>
                        {% set no += 1 %} 
                        {% endfor %}
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

{# Global script #}
<script>{% include "include/view.js" %}</script>
{# Custom script #}
<script>{% include "rombel/assets/anggota.js" %}</script>