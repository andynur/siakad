<section class="content-header">
    <h1>Guru <small>Pengelolaan data guru</small></h1>    
    <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i> Guru</a></li>
        <li class="active">Index</li>
    </ol>
</section>

<!-- Main content -->
<section class="content">
    <div class="row">
        <div class="col-md-12">
            <div class="box">
                <div class="box-header">
                    <h3 class="box-title">Data Guru</h3>
                </div>
                <div class="box-body">
                    <form class="form-horizontal">
                        <div class="form-group">
                            <div class="col-sm-4">
                                <a href="#" onclick="add_new()" class="btn btn-sm btn-success"><i class="fa fa-plus"></i>&nbsp; Tambah Data</a>
                            </div>
                        </div>
                    </form>
                                        
                    <table id="data_table" class="table table-bordered table-striped">
                        <thead>
                            <tr>
                                <th style="width: 10px">No</th>
                                <th>Foto</th>
                                <th>Profil Guru</th>
                                <th>Jenis Kelamin</th>
                                <th>Jenis Guru</th>
                                <th>Kepegawaian</th>
                                <th>Keaktifan</th>
                                <th>Aksi</th>
                            </tr>
                        </thead>
                        <tbody>
                            {% set no=1 %} {% for v in data %}
                            <tr id="data_{{v.ptk_id}}" class="middle-row">
                                <td align="center">{{no}}</td>
                                <td align="center"><img src="img/guru/{{v.foto}}" alt="{{v.nama}}" style="height: 3em"></td>
                                <td>
                                    <span style="font-weight: 600;">{{v.nama}}</span> <br/> 
                                    <span class="label label-default">NIP</span> 
                                    <span class="label label-primary">{{v.nip}}</span>
                                </td>
                                <td>{{v.jenis_kelamin}}</td>
                                <td>{{v.jenis_ptk}}</td>
                                <td>{{v.kepegawaian}}</td>
                                <td>{{v.keaktifan}}</td>
                                <td align="center">
                                    <a class="btn btn-primary btn-xs btn-flat" onclick="edit_data('{{v.ptk_id}}', '{{rombel_id}}')"><i class="glyphicon glyphicon-edit"></i> Ubah &nbsp;</a>

                                    <a onclick="delete_data('{{v.ptk_id}}')" class="btn btn-danger btn-xs btn-flat"><i class="glyphicon glyphicon-trash"></i> Hapus</a>
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

    function add_new() {        
        var url = '{{ url("guru/addGuru/") }}';
        var url_back = '{{ url("guru/index/") }}';
        var data = "url_back="+url_back;

        go_page_data(url, data);
    }

    function edit_data(id, rombel_id) {
        var url = '{{ url("guru/editGuru/") }}' + id;
        go_page(url);
    }

    function delete_data(id) {
        var url_target = '{{ url("guru/deleteGuru") }}/' + id;
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
                    reload_page2('guru/kelas/{{rombel_id}}');
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