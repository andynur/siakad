{# Define variables #}
{% set tanggalIndo = helper.dateBahasaIndo(date('Y-m-d')) %}
{% set urlPost = url('sdm/addSdm') %}

{# Global css #}
<style>{% include "include/view.css" %}</style>

<!-- Header content -->
<section class="content-header">
    <h1>
        SDM
        <small>
            <i class="fa fa-calendar-o"></i> {{ tanggalIndo }} 
            <i class="fa fa-clock-o"></i> <span id="waktu">00:00:00</span>
        </small> 
    </h1>
    <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i> SDM</a></li>
        <li class="active">Index</li>
    </ol>   
</section>

<!-- Main content -->
<section class="content">
    <div class="row">
        <!-- Table column -->
        <div class="col-md-12">
            <div class="box box-primary">
                <div class="box-header">
                    <h3 class="box-title">Data SDM</h3>
                </div>
                <div class="box-body">
                    <div class="form-group">
                        <a href="#" onclick="go_page('sdm/formSdm')" class="btn btn-sm btn-success"><i class="fa fa-plus"></i>&nbsp; Tambah Data</a>
                    </div>

                    <table id="data_table" class="table table-bordered table-striped">
                        <thead>
                            <tr>
                                <th class="width-10">No</th>
                                <th>SDM</th>
                                <th>NUPTK</th>
                                <th>Jenjang</th>
                                <th>Jenis Kelamin</th>
                                <th>Aktif</th>
                                <th>Aksi</th>
                            </tr>
                        </thead>
                        <tbody>
                        {% set no = 1 %} 
                        {% for row in data %}                                                     
                            {% set id = row.id_sdm %} 
                            {% set nip = row.nip %} 
                            {% set nama = row.nama %} 
                            {% set nuptk = row.nuptk %} 
                            {% set jenjang = row.jenjang %} 
                            {% set foto = row.foto %}
                            
                            {% if (row.status_keaktifan_id == 1) %}
                                {% set status = 'Y' %}
                                {% set color = 'green' %}
                            {% else %}
                                {% set status = 'T' %}
                                {% set color = 'red' %}
                            {% endif %}

                            {% if (row.kelamin == 'l') %}
                                {% set kelamin = 'Laki-laki' %}
                            {% elseif (row.kelamin == 'p') %}
                                {% set kelamin = 'Perempuan' %}
                            {% endif %}                            

                            <tr id="data_{{ id }}" class="middle-row">
                                <td>{{ no }}</td>
                                <td>
                                    <img src="img/sdm/{{ foto }}" alt="{{ nama }}" title="perbesar foto" class="img-murid" data-toggle="tooltip">
                                    <span class="nama weight-600">{{ nama }}</span> <br/> 
                                    <span class="label label-default">NIP</span> 
                                    <span class="label label-primary">{{ nip }}</span>
                                </td>
                                <td>{{ nuptk }}</td>
                                <td>{{ jenjang }}</td>
                                <td>{{ kelamin }}</td>
                                <td><span class="badge bg-{{ color }}">{{ status }}</span></td>
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

        <!-- Image Modal -->
        {% include "include/image_modal.volt" %}
    </div>

</section>
<!-- /.content -->

<!-- global script -->
<script>{% include "include/view.js" %}</script>
<!-- custom script -->
<script>{% include "sdm/assets/sdm.js" %}</script>