<section class="content-header">
    <h1>
        Rombel
        <small>Pengelolaan data rombel</small>
    </h1>
    <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i> Rombongan Belajar</a></li>
        <li class="active">Rombel</li>
    </ol>   
</section>

<!-- Main content -->
<section class="content">
    <div class="row">
        <!-- left column -->
        <div class="col-md-4">
            <div class="box box-primary">
                <div class="box-header">
                    <h3 class="box-title">Tambah Data</h3>
                </div>
                <!-- /.box-header -->
                <div class="box-body pad">
                    <form id="form_add">
                        <div class="form-group">
                            <label for="nama">Nama Rombel</label>
                            <input type="text" class="form-control" name="nama" placeholder="Nama rombel">
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
                            <label for="semester_id">Semester</label>
                            <select class="form-control" name="semester_id">
                                <option value="">-- Pilih Semester --</option>
                                {% for opt in semester %}
                                <option value="{{ opt.semester_id }}">{{ opt.nama }}</option>
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

                        <button type="button" onclick="save_data('#form_add', 'addRombel')" class="btn btn-primary pull-right">Tambah</button>
                    </form>
                </div>
            </div>
            <!-- /.box -->
        </div>
        <!-- right column -->
        <div class="col-md-8">
            <div class="box">
                <div class="box-header">
                    <h3 class="box-title">Data Rombel</h3>
                </div>
                <div class="box-body">
                    <table id="data_table" class="table table-bordered table-striped">
                        <thead>
                            <tr>
                                <th style="width: 10px">No</th>
                                <th>Nama Rombel</th>
                                <th>Tingkat Pendidikan</th>
                                <th>Semester</th>
                                <th>Kurikulum</th>
                                <th>Aksi</th>
                            </tr>
                        </thead>
                        <tbody>
                            {% set no=1 %} {% for v in data %}
                            <tr id="data_{{v.rombongan_belajar_id}}">
                                <td>{{no}}</td>
                                <td>{{v.nama_rombel}}</td>
                                <td>{{v.nama_tingkat}}</td>
                                <td>{{v.nama_semester}}</td>
                                <td>{{v.nama_kurikulum}}</td>
                                <td>
                                    <a class="btn btn-primary btn-xs btn-flat" data-toggle="modal" data-target="#myModal" onclick="show_modal('{{ v.rombongan_belajar_id }}')"><i class="glyphicon glyphicon-edit"></i> </a>

                                    <a class="btn btn-danger btn-xs btn-flat" onclick="delete_data('{{v.rombongan_belajar_id}}')"><i class="glyphicon glyphicon-trash"></i></a>
                                </td>
                            </tr>
                            {% set no=no+1 %} {% endfor %}
                        </tbody>
                    </table>

                    <!-- Modal -->
                    <div class="modal fade" id="myModal" role="dialog">
                        <div class="modal-dialog">
                            <!-- Modal content-->
                            <div class="modal-content">
                                <div class="modal-header">
                                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                                    <h4 class="modal-title">Ubah Data</h4>
                                </div>
                                <div class="modal-body">
                                    <form id="form_edit">
                                        <div class="form-group">
                                            <label for="nama">Nama Rombel</label>
                                            <input type="text" class="form-control" name="nama" placeholder="Nama rombel" id="edit_nama">
                                        </div>
                                        <div class="form-group">
                                            <label for="tingkat_pendidikan_id">Tingkat Pendidikan</label>
                                            <select class="form-control" name="tingkat_pendidikan_id" id="edit_tingkat">
                                                <option value="">-- Pilih Tingkat --</option>
                                                {% for opt in tingkat %}
                                                <option value="{{ opt.tingkat_pendidikan_id }}">{{ opt.nama }}</option>
                                                {% endfor %}
                                            </select>
                                        </div>  
                                        <div class="form-group">
                                            <label for="semester_id">Semester</label>
                                            <select class="form-control" name="semester_id" id="edit_semester">
                                                <option value="">-- Pilih Semester --</option>
                                                {% for opt in semester %}
                                                <option value="{{ opt.semester_id }}">{{ opt.nama }}</option>
                                                {% endfor %}
                                            </select>
                                        </div>  
                                        <div class="form-group">
                                            <label for="kurikulum_id">Kurikulum</label>
                                            <select class="form-control" name="kurikulum_id" id="edit_kurikulum">
                                                <option value="">-- Pilih kurikulum --</option>
                                                {% for opt in kurikulum %}
                                                <option value="{{ opt.kurikulum_id }}">{{ opt.nama_kurikulum }}</option>
                                                {% endfor %}
                                            </select>
                                        </div> 
                                    </form>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-default" data-dismiss="modal">Batal</button>
                                    <button type="button" class="btn btn-primary" id="btn_edit">Simpan</button>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- /.Modal -->
                </div>
                <!-- /.box-body -->
            </div>
            <!-- /.box -->
        </div>
    </div>

</section>
<!-- /.content -->

<script type="text/javascript">
    $(function () {
        $('#data_table').DataTable({
            "paging": true,
            "lengthChange": true,
            "searching": true,
            "ordering": true,
            "info": true,
            "autoWidth": true,
            "lengthMenu": [
                [5, 10, 25, 50, -1],
                [5, 10, 25, 50, "Semua"]
            ],
            "iDisplayLength": 5,
            "language": {
                "url": "js/Indonesian.json"
            }
        });
    });

    function show_modal(id) {
        var get_tingkat = $('#data_' + id + ' > td').eq(2).html();
        var get_semester = $('#data_' + id + ' > td').eq(3).html();
        var get_kurikulum = $('#data_' + id + ' > td').eq(4).html();
        var selected_tingkat = $('#edit_tingkat option:contains("'+get_tingkat+'")').attr('value');
        var selected_semester = $('#edit_semester option:contains("'+get_semester+'")').attr('value');
        var selected_kurikulum = $('#edit_kurikulum option:contains("'+get_kurikulum+'")').attr('value');

        $('#edit_nama').val($('#data_' + id + ' > td').eq(1).html());        
        $('#edit_tingkat').val(selected_tingkat);
        $('#edit_semester').val(selected_semester);
        $('#edit_kurikulum').val(selected_kurikulum);

        $('#btn_edit').removeAttr('onclick');
        $('#btn_edit').attr('onclick', "return save_data('#form_edit', 'editRombel/" + id + "')");
    }

    function save_data(target, action) {
        $.ajax({
            method: "POST",
            dataType: "json",
            url: '{{ url("rombonganbelajar/' + action + '") }}',
            data: $(target).serialize()
        }).done(function (data) {
            reload_page2('rombonganbelajar/index');
            new PNotify({
                title: data.title,
                text: data.text,
                type: data.type
            });

            if (target == '#form_edit') {
                $('#myModal').modal('hide');
                $('body').removeClass('modal-open');
                $("body").css("padding-right", "0px");
                $('.modal-backdrop').remove();                
            }
        });

        return false;
    }

    function delete_data(id) {
        var url_target = '{{ url("rombonganbelajar/deleteRombel") }}/' + id;
        (new PNotify({
            title: 'Pesan Konfirmasi',
            text: 'Apakah Anda Yakin menghapus data ini?',
            icon: 'glyphicon glyphicon-question-sign',
            hide: false,
            confirm: {
                confirm: true
            },
            buttons: {
                closer: false,
                sticker: false
            },
            history: {
                history: false
            }
        })).get().on('pnotify.confirm', function () {
            $.ajax({
                type: "POST",
                dataType: "JSON",
                url: url_target,
                success: function (data) {
                    reload_page2('rombonganbelajar/index');
                    new PNotify({
                        title: 'Sukses',
                        text: 'Data berhasil dihapus',
                        type: 'success'
                    });
                }
            });
        }).on('pnotify.cancel', function () {
            console.log('batal');
        });
    }
</script>