{# Define variables #}
{% set tanggalIndo = helper.dateBahasaIndo(date('Y-m-d')) %}
{% set urlPost = url('pengumuman/addPengumuman') %}

{# Global css #}
<style>{% include "include/view.css" %}</style>
{# Custom css #}
<style>{% include "pengumuman/assets/pengumuman.css" %}</style>

<!-- Header content -->
<section class="content-header">
    <h1>
        Pengumuman Kelas
        <small>
            <i class="fa fa-calendar-o"></i> {{ tanggalIndo }} 
            <i class="fa fa-clock-o"></i> <span id="waktu">00:00:00</span>
        </small> 
    </h1>
    <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i> Rombongan Belajar</a></li>
        <li class="active">Pengumuman Kelas</li>
    </ol>   
</section>

<!-- Main content -->
<section class="content">
    <div class="row">
        <!-- Table column -->
        <div class="col-md-12">
            <div class="box box-primary">
                <div class="box-header">
                    <h3 class="box-title">Data Pengumuman Kelas</h3>
                    <div class="pull-right box-tools">
                      <button class="btn btn-primary btn-sm" data-widget="collapse" data-toggle="tooltip" title="" data-original-title="Collapse"><i class="fa fa-minus" style="padding:0"></i></button>
                    </div>                    
                </div>
                <div class="box-body">
                    <table id="data_table" class="table table-bordered table-striped">
                        <thead>
                            <tr>
                                <th class="width-10">No</th>
                                <th class="min-260">Judul</th>
                                <th>Tanggal Kirim</th>
                                <th>Kelas Tujuan</th>
                                <th>Pengirim</th>
                                <th>Status</th>
                                <th>Lampiran</th>
                                <th>Aksi</th>
                            </tr>
                        </thead>
                        <tbody>
                        {% set no = 1 %} 
                        {% for row in data %}                                                     
                            {% set id = row.pengumuman_id %} 
                            {% set judul = row.judul %} 
                            {% set tanggal = row.tanggal %} 
                            {% set uid = row.login %}
                            {% set pengirim = row.nama %}
                            {% set tujuan = list_tujuan[id] %}
                            {% set lampiran = row.lampiran %}
                            {% set status = row.status %}
                            {% set nama_tingkat = row.nama_tingkat %}
                            {% set nama_rombel = row.nama_rombel %}

                            {% if (lampiran == 'publish') %} 
                                {% set color = 'success' %} 
                            {% else %} 
                                {% set color = 'default' %} 
                            {% endif %}

                            {% if (status == 'publish') %} 
                                {% set color = 'success' %} 
                            {% else %} 
                                {% set color = 'default' %} 
                            {% endif %}
                                    
                            <tr id="data_{{ id }}">
                                <td>{{ no }}</td>
                                <td>{{ judul }}</td>
                                <td>{{ helper.dateBahasaIndo(tanggal) }}</td>
                                <td>
                                    <div class="dropdown">
                                        <button class="btn btn-flat btn-default btn-xs dropdown-toggle" type="button" data-toggle="dropdown"><i class="fa fa-list-ul"></i>&nbsp; Lihat Tujuan &nbsp; 
                                        <span class="caret"></span></button>
                                        
                                        <ul class="dropdown-menu">
                                            {% for list in tujuan %}
                                                <li>&nbsp; &raquo; {{ list }}</li>
                                            {% endfor %}
                                        </ul>
                                    </div>
                                </td>
                                <td>{{ pengirim }}</td>
                                <td><span class="label label-{{ color }}">{{ status }}</span></td>
                                <td>
                                    {% if (lampiran != '') %} 
                                        <button class="btn btn-xs btn-dark btn-flat show_image" data-image="{{ lampiran }}"><i class="fa fa-eye"></i> Lihat</button>
                                    {% endif %}                                
                                </td>
                                <td>
                                    {% for val in usergroup %}
                                        {% if (val == '1' OR val == '4') %}
                                            {% set check = true %}
                                        {% else %}
                                            {% set check = false %}
                                        {% endif %}
                                    {% endfor %}

                                    {% if (this.session.get('uid') == uid OR check == true) %}
                                    <a data-id="{{ id }}" class="btn btn-primary btn-xs btn-flat edit"><i class="glyphicon glyphicon-edit"></i> </a>

                                    <a data-id="{{ id }}" class="btn btn-danger btn-xs btn-flat delete"><i class="glyphicon glyphicon-trash"></i></a>
                                    {% endif %}
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

        <!-- Form column -->
        {% include "pengumuman/form.volt" %}
    </div>

</section>
<!-- /.content -->

<!-- bootstrap filestyle -->
<script src="js/bootstrap-filestyle.min.js"></script>
<!-- global script -->
<script>{% include "include/view.js" %}</script>
<!-- custom script -->
<script>{% include "pengumuman/assets/pengumuman.js" %}</script>