<section class="content-header">
    <h1>
        Tes Get Data
        <small>Semua berawal dari negara api menyerang.</small>
    </h1>
    <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i> Tes</a></li>
        <li class="active">Index</li>
    </ol>
</section>

<!-- Main content -->
<section class="content">
    <div class="row">
        <!-- left column -->
        <div class="col-md-4">
            <div class="box box-primary">
                <div class="box-header">
                    <h3 class="box-title">Tes Get Data &nbsp;<small>Cuman tes doang bang</small></h3>
                    <!-- tools box -->
                    <div class="pull-right box-tools">
                        <button class="btn btn-primary btn-sm" data-widget="collapse" data-toggle="tooltip" title="Collapse">
                            <i class="fa fa-minus"></i>
                        </button>
                    </div>
                    <!-- /. tools -->
                </div>
                <!-- /.box-header -->
                <div class="box-body pad">
                    <form id="form_tes">
                        <div class="form-group">
                            <label for="nama">Nama</label>
                            <input type="text" class="form-control" id="nama" placeholder="Nama...">
                        </div>
                        <div class="form-group">
                            <label for="jumlah">Jumlah</label>
                            <input type="text" class="form-control" id="jumlah" placeholder="Jumlah...">
                        </div>
                        <div class="form-group">
                            <label for="tanggal">Tanggal</label>
                            <input type="date" class="form-control" id="tanggal" placeholder="Tanggal...">
                        </div>
                        <button style="margin-top: 5px;" type="button" onclick="add_tes()" class="btn btn-success pull-right">Tambah Data</button>
                    </form>
                </div>
            </div>
            <!-- /.box -->
        </div>


        <div class="col-md-8">
            <div class="box">
                <div class="box-header">
                    <h3 class="box-title">DataTable dengan fitur super kumplit!</h3>
                </div>
                <!-- /.box-header -->
                <div class="box-body">

                    <table id="example2" class="table table-bordered table-striped">
                        <thead>
                            <tr>
                                <th style="width: 10px">No</th>
                                <th>Nama</th>
                                <th>Jumlah</th>
                                <th>Tanggal</th>
                                <th>Aksi</th>
                            </tr>
                        </thead>
                        <tbody>

                            {% set no=1 %} {% for v in data %}
                            <tr>
                                <td>{{no}}</td>
                                <td>{{v.nama}}</td>
                                <td>{{v.jumlah}}</td>
                                <td>{{v.tanggal}}</td>
                                <td>
                                    <a id="edit" class="btn btn-primary btn-xs btn-flat" data-toggle="modal" data-target="#myModal{{v.id}}"><i class="glyphicon glyphicon-edit"></i> </a>                                
                                    <a id="delete" onclick="delete_tes('{{v.id}}')" class="btn btn-danger btn-xs btn-flat"><i class="glyphicon glyphicon-trash"></i></a>
                                </td>
                            </tr>

                            <!-- Modal -->
                            <div class="modal fade" id="myModal{{v.id}}" role="dialog">
                                <div class="modal-dialog modal-lg">

                                    <!-- Modal content-->
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <button type="button" class="close"data-dismiss="modal">&times;</button>
                                            <h4 class="modal-title">Edit Data</h4>
                                        </div>
                                        <div class="modal-body" style="border: 1px solid #eee;  width: 80%; margin: 0 auto;">
                                            <div class="form-group">
                                                <label for="nama">Nama</label>
                                                <input style="width:80%;" type="text" class="form-control" id="nama{{v.id}}" value="{{v.nama}}">
                                            </div>
                                            <div class="form-group">
                                                <label for="jumlah">Jumlah</label>
                                                <input style="width:80%;" type="text" class="form-control" id="jumlah{{v.id}}" value="{{v.jumlah}}">
                                            </div>
                                            <div class="form-group">
                                                <label for="tanggal">Tanggal</label>
                                                <input style="width:80%;" type="date" class="form-control" id="tanggal{{v.id}}" value="{{v.tanggal}}">
                                            </div>                                            
                                        </div>
                                        <div class="modal-footer">
                                            <button type="button" onclick="edit_tes('{{v.id}}')" class="btn btn-primary">Edit</button>
                                            <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                                        </div>
                                    </div>

                                </div>
                            </div>                            

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
        $('#example2').DataTable({
            "paging": true,
            "lengthChange": true,
            "searching": true,
            "ordering": true,
            "info": true,
            "autoWidth": true,
            "language": {
                "url": "js/Indonesian.json"
            }
        });

    });

    function delete_tes(id) {
        var urel = '{{ url("tescrud/delTes") }}/' + id;
        (new PNotify({
            title: 'Confirmation Needed',
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
                url: urel,
                success: function (data) {
                    reload_page2('tescrud/index');
                    new PNotify({
                        title: data.title,
                        text: data.text,
                        type: data.type
                    });
                }
            });
        }).on('pnotify.cancel', function () {
            console.log('batal');
        });
    }

    function edit_tes(id) {
        var nama = $("#nama" + id).val();
        var jumlah = $("#jumlah" + id).val();
        var tanggal = $("#tanggal" + id).val();

        var datas = "nama=" + nama + "&jumlah=" + jumlah + "&tanggal=" + tanggal;
        var urel = '{{ url("tescrud/editTes/") }}' + id;
        $.ajax({
            type: "POST",
            url: urel,
            dataType: "json",
            data: datas
        }).done(function (data) {
            $('#myModal' + id).modal('hide');
            $('body').removeClass('modal-open');
            $("body").css("padding-right", "0px");
            $('.modal-backdrop').remove();
            reload_page2('tescrud/index');
            new PNotify({
                title: data.title,
                text: data.text,
                type: data.type
            });
        });
    }

    function add_tes() {

        var nama = $("#nama").val();
        var jumlah = $("#jumlah").val();
        var tanggal = $("#tanggal").val();

        var datas = "nama=" + nama + "&jumlah=" + jumlah + "&tanggal=" + tanggal;
        var urel = '{{ url("tescrud/addTes") }}';
        $.ajax({
            type: "POST",
            url: urel,
            dataType: "json",
            data: datas
        }).done(function (data) {
            reload_page2('tescrud/index');
            new PNotify({
                title: data.title,
                text: data.text,
                type: data.type
            });
        });
    }
</script>