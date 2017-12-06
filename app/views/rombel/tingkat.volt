{# Define variables #}
{% set tanggalIndo = helper.dateBahasaIndo(date('Y-m-d')) %}
{% set urlPost = url('tingkatpendidikan/addTingkat') %}

{# Global css #}
<style>{% include "include/view.css" %}</style>

<!-- Header content -->
<section class="content-header">
    <h1>
        Tingkat Pendidikan
        <small>
            <i class="fa fa-calendar-o"></i> {{ tanggalIndo }} 
            <i class="fa fa-clock-o"></i> <span id="waktu">00:00:00</span>
        </small> 
    </h1>
    <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i> Rombongan Belajar</a></li>
        <li class="active">Tingkat Pendidikan</li>
    </ol>   
</section>

<!-- Main content -->
<section class="content">
    <div class="row">
        <!-- Form column -->
        <div class="col-md-4">
            <div class="box box-primary">
                <div class="box-header">
                    <h3 class="box-title" id="form_title">Tambah Data</h3>
                </div>
                <!-- /.box-header -->
                <div class="box-body pad">
                    <form id="form_input" method="POST" action="{{ urlPost }}">
                        <div class="form-group">
                            <label for="nama">Tingkat Pendidikan</label>
                            <input type="text" class="form-control" name="nama" placeholder="Tingkat pendidikan">
                        </div>
                        <div class="form-group">
                            <label for="jenjang_pendidikan_id">Jenjang</label>
                            <select class="form-control" name="jenjang_pendidikan_id" id="jenjang">
                                <option value="">-- Pilih Jenjang --</option>
                                {% for opt in jenjang %}
                                <option value="{{ opt.jenjang_pendidikan_id }}">{{ opt.nama }}</option>
                                {% endfor %}
                            </select>
                          </div>     
                        <div class="form-group">
                            <label for="kode">Kode</label>
                            <input type="text" class="form-control" name="kode" maxlength="5" placeholder="Kode">
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
                    <h3 class="box-title">Data Tingkat Pendidikan</h3>
                </div>
                <div class="box-body">
                    <table id="data_table" class="table table-bordered table-striped">
                        <thead>
                            <tr>
                                <th class="width-10">No</th>
                                <th>Tingkat Pendidikan</th>
                                <th>Jenjang Pendidikan</th>
                                <th>Kode</th>
                                <th>Aksi</th>
                            </tr>
                        </thead>
                        <tbody>
                        {% set no = 1 %} 
                        {% for row in data %}                                                     
                            {% set id = row.tingkat_pendidikan_id %} 
                            {% set nama = row.nama %} 
                            {% set jenjang = row.nama_jenjang %} 
                            {% set kode = row.kode %}

                            <tr id="data_{{ id }}">
                                <td>{{ no }}</td>
                                <td>{{ nama }}</td>
                                <td>{{ jenjang }}</td>
                                <td>{{ kode }}</td>
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

<!-- global script -->
<script>{% include "include/view.js" %}</script>
<!-- custom script -->
<script>{% include "rombel/assets/tingkat.js" %}</script>