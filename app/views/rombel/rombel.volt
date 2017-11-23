{# Define variables #}
{% set tanggalIndo = helper.dateBahasaIndo(date('Y-m-d')) %}
{% set urlPost = url('rombonganbelajar/addRombel') %}

{# Global css #}
<style>{% include "include/view.css" %}</style>

<!-- Header content -->
<section class="content-header">
    <h1>
        Rombel
        <small>
            <i class="fa fa-calendar-o"></i> {{ tanggalIndo }} 
            <i class="fa fa-clock-o"></i> <span id="waktu">00:00:00</span>
        </small> 
    </h1>
    <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i> Rombongan Belajar</a></li>
        <li class="active">Rombel</li>
    </ol>   
</section>

<!-- Main content -->
<section class="content">
    <div class="row">
        <!-- Form column -->
        <div class="col-md-3">
            <div class="box box-primary">
                <div class="box-header">
                    <h3 class="box-title" id="form_title">Tambah Data</h3>
                    <div class="pull-right box-tools">
                      <button class="btn btn-primary btn-sm" data-widget="collapse" data-toggle="tooltip" title="" data-original-title="Collapse"><i class="fa fa-minus" style="padding:0"></i></button>
                    </div>
                </div>
                <!-- /.box-header -->
                <div class="box-body pad">
                    <form id="form_input" method="POST" action="{{ urlPost }}">
                        <div class="form-group">
                            <label for="nama">Nama Rombel</label>
                            <input type="text" class="form-control" name="nama" placeholder="Nama rombel">
                        </div>
                        <div class="form-group">
                            <label for="nama">Tipe</label>
                            <div class="radio">
                                <label><input type="radio" name="tipe" value="umum">Umum</label> &nbsp; &nbsp;
                                <label><input type="radio" name="tipe" value="ekskul"> Ekskul</label>
                            </div>
                        </div>                        
                        <div class="form-group">
                            <label for="tingkat_pendidikan_id">Tingkat Pendidikan</label>
                            <select class="form-control" name="tingkat_pendidikan_id">
                                <option value="">-- Pilih Tingkat --</option>
                                {% for opt in tingkat %}
                                <option value="{{ opt.tingkat_pendidikan_id }}">{{ opt.nama }}</option>
                                {% endfor %}
                            </select>
                        </div>  
                        <div class="form-group">
                            <label for="semester_id">Tahun Ajaran</label>
                            <select class="form-control" name="semester_id">
                                <option value="">-- Pilih Tahun Ajaran --</option>
                                {% for opt in tahun %}
                                <option value="{{ opt.tahun_ajaran_id }}0">{{ opt.nama }}</option>
                                {% endfor %}
                            </select>
                        </div>  
                        <div class="form-group">
                            <label for="kurikulum_id">Kurikulum</label>
                            <select class="form-control" name="kurikulum_id">
                                <option value="">-- Pilih kurikulum --</option>
                                {% for opt in kurikulum %}
                                <option value="{{ opt.kurikulum_id }}">{{ opt.nama_kurikulum }}</option>
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
        <div class="col-md-9">
            <div class="box">
                <div class="box-header">
                    <h3 class="box-title">Data Rombel</h3>
                </div>
                <div class="box-body">
                    <table id="data_table" class="table table-bordered table-striped">
                        <thead>
                            <tr>
                                <th class="width-10">No</th>
                                <th>Nama Rombel</th>
                                <th>Tingkat</th>
                                <th>Tipe</th>
                                <th>Tahun Ajaran</th>
                                <th>Kurikulum</th>
                                <th>Aksi</th>
                            </tr>
                        </thead>
                        <tbody>
                        {% set no = 1 %} 
                        {% for row in data %}                                                     
                            {% set id = row.rombongan_belajar_id %} 
                            {% set rombel = row.nama_rombel %} 
                            {% set tipe = row.tipe %} 
                            {% set tingkat = row.nama_tingkat %} 
                            {% set semester = row.nama_semester|right_trim(' -') %} 
                            {% set kurikulum = row.nama_kurikulum %}                             

                            <tr id="data_{{ id }}">
                                <td>{{ no }}</td>
                                <td>{{ rombel }}</td>
                                <td>{{ tingkat }}</td>
                                <td>{{ tipe }}</td>
                                <td>{{ semester }}</td>
                                <td>{{ kurikulum }}</td>
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
<script>{% include "rombel/assets/rombel.js" %}</script>