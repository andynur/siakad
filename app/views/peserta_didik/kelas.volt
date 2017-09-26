<section class="content-header">
    <h1>
        {{data[0].nama_tingkat}} - {{data[0].nama_rombel}}
        <small>Pengelolaan data kelas</small>
    </h1>    
    <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i> {{data[0].nama_tingkat}}</a></li>
        <li><a href="#">{{data[0].nama_rombel}}</a></li>
        <li class="active">Data Murid</li>
    </ol>
</section>

<!-- Main content -->
<section class="content">
    <div class="row">
        <div class="col-md-12">
            <div class="box">
                <div class="box-header">
                    <h3 class="box-title">Data Murid Per-Kelas </h3>
                </div>
                <div class="box-body">
                    <form class="form-horizontal">
                        <div class="form-group">
                            <div class="col-sm-4">
                                <a href="#" onclick="go_page('pesertadidik/addMurid/{{rombel_id}}')" class="btn btn-sm btn-success"><i class="fa fa-plus"></i>&nbsp; Tambah Data</a>
                            </div>

                            <label for="semester" class="col-sm-2 control-label"><i class="fa fa-arrow-circle-o-right"></i> &nbsp; Semester/Kurikulum</label>
                            <div class="col-sm-3">
                                <select class="form-control" id="semester">
                                    <option value="">-- Pilih Semester --</option>
                                    {% for opt in semester %}
                                    {% if (opt.semester_id == data[0].semester_id) %}
                                    <option value="{{ opt.semester_id }}" selected="selected">{{ opt.nama }}</option>
                                    {% else %}
                                    <option value="{{ opt.semester_id }}">{{ opt.nama }}</option>
                                    {% endif %}
                                    {% endfor %}
                                </select>
                            </div>
                            <div class="col-sm-3">
                                <select class="form-control" id="kurikulum">
                                    <option value="">-- Pilih kurikulum --</option>
                                    {% for opt in kurikulum %}
                                        {% if (opt.kurikulum_id == data[0].kurikulum_id) %}
                                            <option value="{{ opt.kurikulum_id }}" selected="selected">{{ opt.nama_kurikulum }}</option>
                                        {% else %}
                                            <option value="{{ opt.kurikulum_id }}">{{ opt.nama_kurikulum }}</option>
                                        {% endif %}
                                    {% endfor %}
                                </select>
                            </div>
                        </div>
                    </form>
                                        
                    <table id="data_table" class="table table-bordered table-striped">
                        <thead>
                            <tr>
                                <th style="width: 10px">No</th>
                                <th>Foto</th>
                                <th style="width: 12em">Murid</th>
                                <th style="width: 14em">Orang Tua</th>
                                <th style="width: 10em">Kontak</th>
                                <th>Alamat</th>
                                <th>Aksi</th>
                            </tr>
                        </thead>
                        <tbody>
                            {% set no=1 %} {% for v in data %}
                            <tr id="data_{{v.murid_id}}" class="middle-row">
                                <td align="center">{{no}}</td>
                                <td align="center"><img src="img/mhs/{{v.foto}}" alt="{{v.nama_murid}}" style="height: 3em; border-radius: 100%;"></td>
                                <td>
                                    <span style="font-weight: 600;">{{v.nama_murid}}</span> <br/> 
                                    <span class="label label-default">NIS</span> 
                                    <span class="label label-primary">{{v.nis}}</span>
                                    <span class="label label-default">NISN</span> 
                                    <span class="label label-primary">{{v.nisn != '' ? v.nisn : 'kosong'}}</span>
                                </td>
                                <td>
                                    <span class="label label-default"><i class="fa fa-user"></i>&nbsp; Ayah</span>
                                    {{v.nama_ayah}} <br/>
                                    <span class="label label-primary"><i class="fa fa-user"></i>&nbsp; Ibu &nbsp;&nbsp;</span>
                                    {{v.nama_ibu}}
                                </td>
                                <td>
                                    <span class="label label-default"><i class="fa fa-phone"></i>&nbsp; No Ayah</span>
                                    {{v.nomor_ayah}}<br/>
                                    <span class="label label-primary"><i class="fa fa-phone"></i>&nbsp; No Ibu &nbsp;&nbsp;</span>
                                    {{v.nomor_ibu}}<br/>
                                </td>
                                <td>{{v.alamat}}</td>
                                <td align="center">
                                    <a class="btn btn-primary btn-xs btn-flat" onclick="edit_data('{{v.murid_id}}', '{{rombel_id}}')"><i class="glyphicon glyphicon-edit"></i> Ubah &nbsp;</a>

                                    <a onclick="delete_data('{{v.murid_id}}')" class="btn btn-danger btn-xs btn-flat"><i class="glyphicon glyphicon-trash"></i> Hapus</a>
                                </td>
                            </tr>
                            {% set no=no+1 %} {% endfor %}
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

    function add_new(id) {
        var nama_tingkat = '{{data[0].nama_tingkat}}';
        var nama_rombel = '{{data[0].nama_rombel}}';
        var kurikulum_id = '{{data[0].kurikulum_id}}';
        var semester_id = '{{data[0].semester_id}}';
        
        var data_target = "";

        var urel = '{{ url("pesertadidik/addMurid/") }}' + id;
        go_page_data(urel, data_target);          
    }

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

    function edit_data(id, rombel_id) {
        var url = '{{ url("pesertadidik/editMurid/") }}' + id + '/' + rombel_id;
        var back_link = '{{ url("pesertadidik/kelas/") }}' + id;
        var data = 'back_link='+back_link;

        go_page_data(url, data);         
    }

    function delete_data(id) {
        var url_target = '{{ url("pesertadidik/deleteMurid") }}/' + id;
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
                    reload_page2('pesertadidik/kelas/{{rombel_id}}');
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