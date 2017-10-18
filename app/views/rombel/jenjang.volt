{# Define variables #}
{% set tanggalIndo = helper.dateBahasaIndo(date('Y-m-d')) %}
{% set urlPost = url('jenjangpendidikan/addJenjang') %}

{# Global css #}
<style>{% include "include/view.css" %}</style>

<!-- Header content -->
<section class="content-header">
    <h1>
        Jenjang Pendidikan
        <small>
            <i class="fa fa-calendar-o"></i> {{ tanggalIndo }} 
            <i class="fa fa-clock-o"></i> <span id="waktu">00:00:00</span>
        </small> 
    </h1>
    <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i> Rombongan Belajar</a></li>
        <li class="active">Jenjang Pendidikan</li>
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
                            <label for="nama">Jenjang Nama</label>
                            <input type="text" class="form-control" name="nama" placeholder="Jenjang nama">
                        </div>
                        <div class="form-group">
                            <label for="jenjang_lembaga">Jenjang Lembaga</label>
                            <input type="number" class="form-control" name="jenjang_lembaga" placeholder="Jenjang lembaga">
                        </div>
                        <div class="form-group">
                            <label for="jenjang_orang">Jenjang Orang</label>
                            <input type="number" class="form-control" name="jenjang_orang" placeholder="Jenjang orang">
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
                    <h3 class="box-title">Data Jenjang Pendidikan</h3>
                </div>
                <!-- /.box-header -->                
                <div class="box-body">
                    <table id="data_table" class="table table-bordered table-striped">
                        <thead>
                            <tr>
                                <th class="width-10">No</th>
                                <th>Jenjang Nama</th>
                                <th>Jenjang Lembaga</th>
                                <th>Jenjang Orang</th>
                                <th>Aksi</th>
                            </tr>
                        </thead>
                        <tbody>
                        {% set no = 1 %} 
                        {% for row in data %}                                                     
                            {% set id = row.jenjang_pendidikan_id %} 
                            {% set nama = row.nama %} 
                            {% set lembaga = row.jenjang_lembaga %} 
                            {% set orang = row.jenjang_orang %} 

                            <tr id="data_{{ id }}">
                                <td>{{ no }}</td>
                                <td>{{ nama }}</td>
                                <td>{{ lembaga }}</td>
                                <td>{{ orang }}</td>
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
<script>{% include "rombel/assets/jenjang.js" %}</script>