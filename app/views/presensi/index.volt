<section class="content-header">
    <h1>
        Presensi {{data[0].nama_tingkat}} - {{data[0].nama_rombel}}
        <small>Pengelolaan data presensi</small>
    </h1>    
    <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i>{{data[0].nama_tingkat}}</a></li>
        <li><a href="#">{{data[0].nama_rombel}}</a></li>
        <li class="active">Presensi</li>
    </ol>
</section>
<!-- Main content -->
<section class="content">
    <div class="row">
        <div class="col-md-12">
            <div class="box">
                <div class="box-header">
                    <h3 class="box-title">Data Presensi Murid</h3>
                </div>
                <div class="box-body">
                    <form class="form-horizontal">
                        <div class="form-group">                            
                            <div class="col-sm-1" style="width: 140px">
                                <label for="semester" class="control-label"><i class="fa fa-arrow-circle-o-right"></i> &nbsp; Filter Tanggal: </label>
                            </div>
                            <div class="col-sm-3">
                                <div class='input-group date' id='datetimepicker1'>
                                    <input name="tanggal_pilih" type="text" id="tanggal_pilih" class="form-control" value="<?= $this->helper->dateBahasaIndo(date('Y-m-d')); ?>">
                                    <span class="input-group-addon">
                                        <span class="glyphicon glyphicon-calendar"></span>
                                    </span>
                                </div>
                            </div>
                            <div class="col-sm-2">
                                <select class="form-control" name="tipe">
                                    <option value="masuk">Masuk</option>
                                    <option value="keluar">Keluar</option>
                                    <option value="semua">Semua</option>
                                </select>
                            </div>
                        </div>
                    </form>
                                        
                    <table id="data_table" class="table table-bordered table-striped">
                        <thead>
                            <tr>
                                <th style="width: 5px"><input type="checkbox" id="select_all"></th> 
                                <th style="width: 5px">No</th>
                                <th style="width: 80px">Tanggal</th>
                                <th style="width: 5px">Waktu</th>
                                <th style="width: 190px">Murid</th>
                                <th style="width: 10px">Tipe</th>
                                <th style="width: 10px">Presensi</th>
                                <th style="width: 60px">Status Email</th>
                                <th style="width: 10px">Aksi</th>
                            </tr>
                        </thead>
                        <tbody>
                            <?php
                            $no = 1;
                            foreach($anggota as $a => $v) {                                
                            ?>
                            <tr id="data_{{v.murid_id}}" class="middle-row">
                                <td><input type="checkbox" class="check"></td>
                                <td align="center">{{no}}</td>
                                <!-- <td><?= $this->helper->dateBahasaIndo(date('Y-m-d')) ?></td> -->
                                <td><?= $hadir[$v->murid_id]->tanggal; ?></td>
                                <td>{{ v.waktu != '' ? v.waktu : 'asem' }}</td>
                                <td>
                                    <img src="img/mhs/{{v.foto}}" alt="{{v.nama_murid}}" style="height: 3em; float: left; margin-right: 10px; border-radius: 50px">
                                    <span style="font-weight: 600;">{{v.nama_murid}}</span> <br/> 
                                    <span class="label label-default">NIS</span> 
                                    <span class="label label-primary">{{v.nis}}</span>
                                    <span class="label label-default">NISN</span> 
                                    <span class="label label-primary">{{v.nisn != '' ? v.nisn : 'kosong'}}</span>
                                </td>
                                {% if (v.tipe == 'masuk') %}
                                    {% set tipe = '<span class="label label-success">masuk</span>' %}
                                {% else %}
                                    {% set tipe = '<span class="label label-primary">keluar</span>' %}
                                {% endif %}
                                <td style="text-transform: uppercase">{{tipe}}</td>
                                {% if (v.status_email == 'T') %}
                                    {% set status = '<span class="label label-warning">Belum Terkirim</span></a>' 
                                    %}
                                    {% set aksi = '<a class="btn btn-sm btn-default"><i class="fa fa-send"></i>&nbsp; Kirim Email</span></a>' 
                                    %}
                                {% elseif (v.status_email == 'Y') %}
                                    {% set status = '<span class="btn btn-sm  btn-default">Sudah Terkirim</span>' %}   
                                    {% set aksi = '' %}
                                {% else %}
                                    {% set status = '<span class="label label-danger">Gagal Terkirim</span>' %}
                                    {% set aksi = '<a class="btn btn-sm btn-default"><i class="fa fa-refresh"></i>&nbsp; Kirim Ulang</span></a>' 
                                        %}
                                {% endif %}

                                {% if (v.presensi == 'hadir') %}
                                    {% set presensi = '<span class="label label-success"><i class="fa fa-check"></i>&nbsp; Hadir</span>' %}
                                {% elseif (v.presensi == 'absen') %}
                                    {% set presensi = '<span class="label label-danger"><i class="fa fa-times"></i>&nbsp; Absen</span>' %} 
                                {% elseif (v.presensi == 'sakit') %}
                                    {% set presensi = '<span class="label label-primary"><i class="fa fa-medkit"></i>&nbsp; Sakit</span>' %} 
                                {% else %}
                                    {% set presensi = '<span class="label label-warning"><i class="fa fa-question"></i>&nbsp; Izin</span>' %} 
                                {% endif %}                                
                                <td style="text-transform: uppercase">{{presensi}}</td>
                                <td style="text-transform: uppercase">{{status}}</td>
                                <td>{{aksi}}</td>
                            </tr>
                            <?php
                            $no++
                            }
                            ?>
                        </tbody>
                        <tfoot>
                            <tr>
                                <td colspan="5" style="padding-top: 1em; vertical-align: middle;">
                                    <span class="rows_selected" id="select_count">0 Data Terpilih</span>
                                    <div class="pull-right">
                                        <a class="btn btn-sm btn-success" id="hadir_all"><i class="fa fa-check"></i>&nbsp; Hadir</a> &nbsp;
                                        <a class="btn btn-sm btn-danger" id="absen_all"><i class="fa fa-times"></i>&nbsp; Absen</a> &nbsp;
                                        <a class="btn btn-sm btn-primary" id="sakit_all"><i class="fa fa-medkit"></i>&nbsp; Sakit</a> &nbsp;
                                        <a class="btn btn-sm btn-warning" id="izin_all"><i class="fa fa-info-circle"></i>&nbsp; Izin</a> &nbsp;
                                        <a class="btn btn-sm btn-default" id="kirim_all"><i class="fa fa-send"></i>&nbsp; Kirim Email</span></a> &nbsp;
                                        <a class="btn btn-sm btn-default" id="ulang_all"><i class="fa fa-refresh"></i>&nbsp; Kirim Ulang</span></a>
                                    </div>
                                </td>
                            </tr>
                        </tfoot>
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
        // datepicker config
        $('.date').datepicker({
            language: 'id',            
            format: 'dd-MM-yyyy',
            autoclose: true,
            startDate: `-1y`,
            endDate: '0d',
            todayBtn: true,
            todayHighlight: true,
            title: "Filter Tanggal"            
        });
    });

	// select all checkbox	
	$('#select_all').on('click', function(e) {
		if($(this).is(':checked',true)) {
			$(".check").prop('checked', true);  
		}  
		else {  
			$(".check").prop('checked',false);  
		}		
		// set all checked checkbox count
		$("#select_count").html($("input.check:checked").length+" Data Terpilih");
	});
	// set particular checked checkbox count
	$(".check").on('click', function(e) {
		$("#select_count").html($("input.check:checked").length+" Data Terpilih");
	});	

    function add_new(id) {
        var nama_tingkat = '{{data[0].nama_tingkat}}';
        var nama_rombel = '{{data[0].nama_rombel}}';
        var kurikulum_id = '{{data[0].kurikulum_id}}';
        var semester_id = '{{data[0].semester_id}}';
        
        var data_target = "";

        var urel = '{{ url("presensi/addPresensi/") }}' + id;
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
        var link = '{{ url("presensi/editMurid/") }}' + id + '/' + rombel_id;
        go_page(link);
    }

    function delete_data(id) {
        var url_target = '{{ url("presensi/deleteMurid") }}/' + id;
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
                    reload_page2('presensi/kelas/{{rombel_id}}');
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