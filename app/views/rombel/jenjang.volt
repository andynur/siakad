<section class="content-header">
    <h1>
        Jenjang Pendidikan
        <small>Pengelolaan data jenjang pendidikan</small>
    </h1>
    <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i> Rombongan Belajar</a></li>
        <li class="active">Jenjang Pendidikan</li>
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

                        <button type="button" onclick="save_data('#form_add', 'addJenjang')" class="btn btn-primary pull-right">Tambah</button>
                    </form>
                </div>
            </div>
            <!-- /.box -->
        </div>
        <!-- right column -->
        <div class="col-md-8">
            <div class="box">
                <div class="box-header">
                    <h3 class="box-title">Data Jenjang Pendidikan</h3>
                </div>
                <div class="box-body">
                    <table id="data_table" class="table table-bordered table-striped">
                        <thead>
                            <tr>
                                <th style="width: 10px">No</th>
                                <th>Jenjang Nama</th>
                                <th>Jenjang Lembaga</th>
                                <th>Jenjang Orang</th>
                                <th>Aksi</th>
                            </tr>
                        </thead>
                        <tbody>
                            {% set no=1 %} {% for v in data %}
                            <tr id="data_{{v.jenjang_pendidikan_id}}">
                                <td>{{no}}</td>
                                <td>{{v.nama}}</td>
                                <td>{{v.jenjang_lembaga}}</td>
                                <td>{{v.jenjang_orang}}</td>
                                <td>
                                    <a class="btn btn-primary btn-xs btn-flat" data-toggle="modal" data-target="#myModal" onclick="show_modal('{{ v.jenjang_pendidikan_id }}')"><i class="glyphicon glyphicon-edit"></i> </a>

                                    <a onclick="delete_data('{{v.jenjang_pendidikan_id}}')" class="btn btn-danger btn-xs btn-flat"><i class="glyphicon glyphicon-trash"></i></a>
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
                                            <label for="nama">Nama</label>
                                            <input type="text" class="form-control" name="nama" id="edit_nama">
                                        </div>
                                        <div class="form-group">
                                            <label for="jenjang_lembaga">Jenjang Lembaga</label>
                                            <input type="text" class="form-control" name="jenjang_lembaga" id="edit_jenjang_lembaga">
                                        </div>
                                        <div class="form-group">
                                            <label for="jenjang_orang">Jenjang Orang</label>
                                            <input type="text" class="form-control" name="jenjang_orang" id="edit_jenjang_orang">
                                        </div>
                                    </form>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-default" data-dismiss="modal" id="btn_batal">Batal</button>
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
        $('#edit_nama').val($('#data_' + id + ' > td').eq(1).html());
        $('#edit_jenjang_lembaga').val($('#data_' + id + ' > td').eq(2).html());
        $('#edit_jenjang_orang').val($('#data_' + id + ' > td').eq(3).html());

        $('#btn_edit').removeAttr('onclick');
        $('#btn_edit').attr('onclick', "return save_data('#form_edit', 'editJenjang/" + id + "')");
    }

    function save_data(target, action) {
        $.ajax({
            method: "POST",
            dataType: "json",
            url: '{{ url("jenjangpendidikan/' + action + '") }}',
            data: $(target).serialize()
        }).done(function (data) {
            reload_page2('jenjangpendidikan/index');
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
        var url_target = '{{ url("jenjangpendidikan/deleteJenjang") }}/' + id;
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
                    reload_page2('jenjangpendidikan/index');
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