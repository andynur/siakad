<section class="content-header">
    <h1>
        Rombel Anggota
        <small>Pengelolaan data rombel anggota</small>
    </h1>
    <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i> Rombongan Belajar</a></li>
        <li class="active">Rombel Anggota</li>
    </ol>
</section>

<!-- Main content -->
<section class="content">
    <div class="row">
        <!-- left column -->
        <div class="col-md-offset-3 col-md-6">
            <div class="box box-primary">
                <div class="box-header">
                    <h3 class="box-title">Tambah Data</h3>
                    <div class="pull-right box-tools">
                        <button class="btn btn-primary btn-sm" data-widget="collapse" data-toggle="tooltip">
                            <i class="fa fa-minus"></i>
                        </button>
                    </div>
                </div>
                <!-- /.box-header -->
                <div class="box-body pad">
                    <form id="form_add">         
                        <div class="form-group">
                            <label for="rombongan_belajar_id">Rombel</label>
                            <select class="form-control" name="rombongan_belajar_id" id="rombel">
                                <option value="">-- Pilih Rombel --</option>
                                {% for opt in rombel %}
                                <option value="{{ opt.rombongan_belajar_id }}">{{ opt.nama_tingkat }} - {{ opt.nama_rombel }} ({{ opt.nama_semester }})</option>
                                {% endfor %}
                            </select>
                        </div>
                        <div class="form-group">
                            <label for="siswa_id">Siswa</label>
                            <select class="form-control select2" multiple="multiple" name="siswa_id" style="width: 100%" id="siswa">
                                {% for opt in siswa %}
                                <option value="{{ opt.siswa_id }}">{{ opt.nama }} ({{ opt.nis }})</option>
                                {% endfor %}
                            </select>
                        </div>                        
                        <div class="form-group">
                            <label for="jenis_pendaftaran_id">Jenis Pendaftaran</label>
                            <select class="form-control" name="jenis_pendaftaran_id" id="jenis">
                                <option value="">-- Pilih Jenis --</option>
                                {% for opt in jenis %}
                                <option value="{{ opt.jenis_pendaftaran_id }}">{{ opt.nama }}</option>
                                {% endfor %}
                            </select>
                        </div>

                        <button type="button" onclick="save_data('#form_add', 'addRombelAnggota')" class="btn btn-primary pull-right">Tambah</button>
                    </form>
                </div>
            </div>
            <!-- /.box -->
        </div>
        <!-- right column -->
        <div class="col-md-12">
            <div class="box">
                <div class="box-header">
                    <h3 class="box-title">Data Rombel Anggota</h3>
                </div>
                <div class="box-body">
                    <table id="data_table" class="table table-bordered table-striped">
                        <thead>
                            <tr>
                                <th style="width: 10px">No</th>
                                <th>Rombel</th>
                                <th>Semester</th>
                                <th>Siswa</th>
                                <th>NIS</th>
                                <th>Jenis Pendaftaran</th>
                                <th>Aksi</th>
                            </tr>
                        </thead>
                        <tbody>
                            {% set no=1 %} {% for v in data %}
                            <tr id="data_{{v.anggota_rombel_id}}">
                                <td>{{no}}</td>
                                <td>{{v.nama_tingkat}} - {{v.nama_rombel}}</td>
                                <td>{{v.nama_semester}}</td>
                                <td>
                                    <span class="siswa_nama_{{v.anggota_rombel_id}}">{{v.nama_siswa}}</span>
                                    <span style="display: none" class="siswa_id_{{v.anggota_rombel_id}}">{{v.siswa_id}}</span>
                                </td>
                                <td>{{v.nis}}</td>
                                <td>{{v.nama_jenis}}</td>
                                <td>
                                    <a class="btn btn-primary btn-xs btn-flat" data-toggle="modal" data-target="#myModal" onclick="show_modal('{{ v.anggota_rombel_id }}')"><i class="glyphicon glyphicon-edit"></i> </a>

                                    <a class="btn btn-danger btn-xs btn-flat" onclick="delete_data('{{v.anggota_rombel_id}}')"><i class="glyphicon glyphicon-trash"></i></a>
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
                                            <label for="rombongan_belajar_id">Rombel</label>
                                            <select class="form-control" name="rombongan_belajar_id" id="edit_rombel">
                                                <option value="">-- Pilih Rombel --</option>
                                                {% for opt in rombel %}
                                                <option value="{{ opt.rombongan_belajar_id }}">{{ opt.nama_tingkat }} - {{ opt.nama_rombel }} ({{ opt.nama_semester }})</option>
                                                {% endfor %}
                                            </select>
                                        </div>
                                        <div class="form-group">
                                            <label for="siswa_id">Siswa</label>
                                            <select class="form-control select2-edit" multiple="multiple" name="siswa_id" data-placeholder="-- Pilih Siswa --" style="width: 100%" id="edit_siswa">
                                                {% for opt in siswa %}
                                                <option value="{{ opt.siswa_id }}">{{ opt.nama }} ({{ opt.nis }})</option>
                                                {% endfor %}
                                            </select>
                                        </div>                                                 
                                        <div class="form-group">
                                            <label for="jenis_pendaftaran_id">Jenis Pendaftaran</label>
                                            <select class="form-control" name="jenis_pendaftaran_id" id="edit_jenis">
                                                <option value="">-- Pilih Jenis --</option>
                                                {% for opt in jenis %}
                                                <option value="{{ opt.jenis_pendaftaran_id }}">{{ opt.nama }}</option>
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
                [10, 25, 50, -1],
                [10, 25, 50, "Semua"]
            ],
            "iDisplayLength": 10,
            "language": {
                "url": "js/Indonesian.json"
            }
        });

        // select2 config
        $('.select2').select2({
            placeholder: '-- Pilih Siswa --',
            minimumInputLength: 3
        })
        $('.select2-edit').select2({
            placeholder: '-- Pilih Siswa --',
            minimumInputLength: 3,
            maximumSelectionLength: 1
        })        
    });

    function show_modal(id) {
        var get_rombel = $('#data_' + id + ' > td').eq(1).html();
        var get_semester = $('#data_' + id + ' > td').eq(2).html();
        var get_nis = $('#data_' + id + ' > td').eq(4).html();
        var get_jenis = $('#data_' + id + ' > td').eq(5).html();
        var get_siswa_nama = $('.siswa_nama_'+id).html();
        var get_siswa_id = $('.siswa_id_'+id).html();
        var get_rombel_mix = get_rombel + ' (' + get_semester + ')';
        var get_siswa_mix = get_siswa_nama + ' (' + get_nis + ')';

        var selected_jenis = $('#edit_jenis option:contains("' + get_jenis + '")').attr('value');
        var selected_rombel = $('#edit_rombel option:contains("' + get_rombel_mix + '")').attr('value');        
        var selected_siswa = '<option value="'+get_siswa_id+'" selected="selected">'+get_siswa_mix+'</option>';

        $('#edit_rombel').val(selected_rombel);
        $('#edit_jenis').val(selected_jenis);
        $("#edit_siswa").val('').trigger('change');
        $("#edit_siswa").append(selected_siswa);
        $("#edit_siswa").trigger('change');

        $('#btn_edit').removeAttr('onclick');
        $('#btn_edit').attr('onclick', "return save_data('#form_edit', 'editRombelAnggota/" + id + "')");
    }

    function save_data(target, action) {
        var tipe = ((target == '#form_edit') ? 'edit_' : '');
        var rombel = $("#"+tipe+"rombel").val();
        var siswa = $("#"+tipe+"siswa").val();
        var jenis = $("#"+tipe+"jenis").val();
        
        var data_target = "rombel="+rombel+"&siswa="+siswa+"&jenis="+jenis;        
        $.ajax({
            method: "POST",
            dataType: "json",
            url: '{{ url("rombelanggota/' + action + '") }}',
            data: data_target
        }).done(function (data) {
            reload_page2('rombelanggota/index');
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
        var url_target = '{{ url("rombelanggota/deleteRombelAnggota") }}/' + id;
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
                    reload_page2('rombelanggota/index');
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