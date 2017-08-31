<section class="content-header">
    <h1>
        Tingkat Pendidikan
        <small>Pengelolaan data tingkat pendidikan</small>
    </h1>
    <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i> Rombongan Belajar</a></li>
        <li class="active">Tingkat Pendidikan</li>
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

                        <button type="button" onclick="save_data('#form_add', 'addTingkat')" class="btn btn-primary pull-right">Tambah</button>
                    </form>
                </div>
            </div>
            <!-- /.box -->
        </div>
        <!-- right column -->
        <div class="col-md-8">
            <div class="box">
                <div class="box-header">
                    <h3 class="box-title">Data Tingkat Pendidikan</h3>
                </div>
                <div class="box-body">
                    <table id="data_table" class="table table-bordered table-striped">
                        <thead>
                            <tr>
                                <th style="width: 10px">No</th>
                                <th>Tingkat Pendidikan</th>
                                <th>Jenjang Pendidikan</th>
                                <th>Kode</th>
                                <th>Aksi</th>
                            </tr>
                        </thead>
                        <tbody>
                            {% set no=1 %} {% for v in data %}
                            <tr id="data_{{v.tingkat_pendidikan_id}}">
                                <td>{{no}}</td>
                                <td>{{v.nama}}</td>
                                <td>{{v.nama_jenjang}}</td>
                                <td>{{v.kode}}</td>
                                <td>
                                    <a class="btn btn-primary btn-xs btn-flat" data-toggle="modal" data-target="#myModal" onclick="show_modal('{{ v.tingkat_pendidikan_id }}')"><i class="glyphicon glyphicon-edit"></i> </a>

                                    <a class="btn btn-danger btn-xs btn-flat" onclick="delete_data('{{v.tingkat_pendidikan_id}}')"><i class="glyphicon glyphicon-trash"></i></a>
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
                                            <label for="nama">Tingkat Pendidikan</label>
                                            <input type="text" class="form-control" name="nama" placeholder="Tingkat pendidikan" id="edit_nama">
                                        </div>
                                        <div class="form-group">
                                            <label for="jenjang_pendidikan_id">Jenjang</label>
                                            <select class="form-control" name="jenjang_pendidikan_id" id="edit_jenjang">
                                            <option value="">-- Pilih Jenjang --</option>
                                              {% for opt in jenjang %}
                                              <option value="{{ opt.jenjang_pendidikan_id }}">{{ opt.nama }}</option>
                                              {% endfor %}
                                            </select>
                                          </div>     
                                        <div class="form-group">
                                            <label for="kode">Kode</label>
                                            <input type="text" class="form-control" name="kode" maxlength="5" placeholder="Kode" id="edit_kode">
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
        var get_jenjang = $('#data_' + id + ' > td').eq(2).html();
        var selected_jenjang = $('#edit_jenjang option:contains("'+get_jenjang+'")').attr('value');

        $('#edit_jenjang').val(selected_jenjang);
        $('#edit_nama').val($('#data_' + id + ' > td').eq(1).html());
        $('#edit_kode').val($('#data_' + id + ' > td').eq(3).html());

        $('#btn_edit').removeAttr('onclick');
        $('#btn_edit').attr('onclick', "return save_data('#form_edit', 'editTingkat/" + id + "')");
    }

    function save_data(target, action) {
        $.ajax({
            method: "POST",
            dataType: "json",
            url: '{{ url("tingkatpendidikan/' + action + '") }}',
            data: $(target).serialize()
        }).done(function (data) {
            reload_page2('tingkatpendidikan/index');
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
        var url_target = '{{ url("tingkatpendidikan/deleteTingkat") }}/' + id;
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
                    reload_page2('tingkatpendidikan/index');
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