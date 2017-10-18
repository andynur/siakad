{# Define variables #}
{% set tanggalIndo = helper.dateBahasaIndo(date('Y-m-d')) %}
{% set urlPost = url('sysinformasi/addSlider') %}

{# Global css #}
<style>{% include "include/view.css" %}</style>
{# Custom css #}
<style>{% include "informasi/assets/slider.css" %}</style>

<!-- Header content -->
<section class="content-header">
    <h1>
        Galeri Slider
        <small>
            <i class="fa fa-calendar-o"></i> {{ tanggalIndo }} 
            <i class="fa fa-clock-o"></i> <span id="waktu">00:00:00</span>
        </small> 
    </h1>
    <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i> Informasi</a></li>
        <li class="active">Galeri Slider</li>
    </ol>
</section>

<!-- Main content -->
<section class="content">
    <div class="row">
        <!-- Form column -->
        {% include "informasi/slider_form.volt" %}

        <!-- Table column -->
        <div class="col-md-8">
            <div class="box">
                <div class="box-header">
                    <h3 class="box-title">Data Galeri Foto</h3>
                </div>
                <!-- /.box-header -->                
                <div class="box-body">
                    <table id="data_table" class="table table-bordered table-striped">
                        <thead>
                            <tr>
                                <th class="width-10">No</th>
                                <th>Foto</th>
                                <th>Judul</th>
                                <th>Deskripsi</th>
                                <th>Aktif</th>
                                <th class="width-30">Aksi</th>
                            </tr>
                        </thead>
                        <tbody>
                        {% set no = 1 %} 
                        {% for row in data %}                                                     
                            {% set id = row.id %} 
                            {% set nama = row.nama %} 
                            {% set judul = row.judul %} 
                            {% set deskripsi = row.deskripsi %} 
                            {% set aktif = row.aktif %} 

                            {% if (aktif == 'Y') %}
                                {% set color = 'green' %}
                            {% else %}
                                {% set color = 'red' %}
                            {% endif %}

                            <tr id="data_{{ id }}">
                                <td>{{ no }}</td>
                                <td>
                                  <a href="#" class="show_image">
                                    <img src="img/galeri/thumb/{{ nama }}" alt="foto {{ judul }}" class="img-show">
                                  </a>
                                </td>
                                <td>{{ judul }}</td>
                                <td>{{ deskripsi }}</td>
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

    <!-- Image Modal -->
    {% include "include/image_modal.volt" %}

</section>
<!-- /.content -->

<!-- Bootstrap Filestyle -->
<script src="js/bootstrap-filestyle.min.js"></script>
{# Global script #}
<script>{% include "include/view.js" %}</script>
{# Custom script #}
<script>{% include "informasi/assets/slider.js" %}</script>