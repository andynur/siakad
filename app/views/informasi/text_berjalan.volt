{# Define variables #} 
{% set tanggalIndo = helper.dateBahasaIndo(date('Y-m-d')) %} 
{% set urlPost = url('sysinformasi/addBerita') %} 
{# Global css #}
<style>{% include "include/view.css" %}</style>

<!-- Header content -->
<section class="content-header">
    <h1>
        Teks Berjalan
        <small>
            <i class="fa fa-calendar-o"></i> {{ tanggalIndo }} 
            <i class="fa fa-clock-o"></i> <span id="waktu">00:00:00</span>
        </small>
    </h1>
    <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i> Informasi</a></li>
        <li class="active">Teks Berjalan</li>
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
                    <form id="form_input" method="POST" action="{{ urlPost }}/{{ jenis }}">
                        <div class="form-group">
                            <label>Isi Teks Berjalan</label>                        
                            <textarea id="editor"></textarea>
                        </div>
                        <div class="form-group">
                            <label>Aktif</label>
                            <select name="aktif" class="form-control">
                                <option value="Y">Ya</option>
                                <option value="N">Tidak</option>
                            </select>
                        </div>

                        <div class="form-group">
                            <div class="pull-right">
                                <button type="reset" class="btn btn-default" id="reset"><i class="fa fa-refresh"></i> Reset</button>
                                <button type="submit" class="btn btn-primary" id="submit"><i class="fa fa-send"></i> Simpan</button>
                            </div>
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
                    <h3 class="box-title">Data Teks Berjalan</h3>
                </div>
                <!-- /.box-header -->
                <div class="box-body">
                    <table id="data_table" class="table table-bordered table-striped">
                        <thead>
                            <tr>
                                <th class="width-10">No</th>
                                <th>Teks Berjalan</th>
                                <th>Tanggal Dibuat</th>
                                <th>Aktif</th>
                                <th>Aksi</th>
                            </tr>
                        </thead>
                        <tbody>
                        {% set no = 1 %} 
                        {% for row in data %} 
                            {% set id = row.id %} 
                            {% set berita = row.berita %} 
                            {% set tanggal = row.created %} 
                            {% set aktif = row.tampil %} 
                            
                            {% if (aktif == 'Y') %} 
                                {% set color = 'green' %} 
                            {% else %} 
                                {% set color = 'red' %} 
                            {% endif %}



                            <tr id="data_{{ id }}">
                                <td>{{ no }}</td>
                                <td>{{ berita }}</td>
                                <td>{{ helper.dateBahasaIndo(tanggal) }}</td>
                                <td><span class="badge bg-{{ color }}">{{ aktif }}</span></td>
                                <td>
                                    <a data-id="{{ id }}" class="btn btn-primary btn-xs btn-flat edit"><i class="glyphicon glyphicon-edit"></i> </a>

                                    <a data-id="{{ id }}" data-img="{{ nama }}" class="btn btn-danger btn-xs btn-flat delete"><i class="glyphicon glyphicon-trash"></i></a>
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
<script>{% include "informasi/assets/text_berjalan.js" %}</script>