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
                            <div class="col-sm-5">
                                <div class="input-group">
                                    <a href="#" class="input-group-addon" style="background: #f9f9f9" onclick="change_date('-')">
                                        <i class="fa fa-arrow-circle-left"></i>
                                    </a>
                                    <a href="#" class="input-group-addon" style="background: #f9f9f9" onclick="change_date('+')">
                                            <i class="fa fa-arrow-circle-right"></i>
                                        </a>                                    
                                    <div class="date" id="datetimepicker1" style="display: inherit;">
                                        <input name="tanggal_pilih" type="text" id="tanggal_pilih" class="form-control" value="<?= $this->helper->dateBahasaIndo($tanggal); ?>" style="font-weight: 600;">
                                        <span class="input-group-addon">
                                            <i class="fa fa-calendar"></i>
                                        </span>
                                    </div>
                                </div>
                            </div>                            
                            <div class="col-sm-5 pull-right">
                                <p style="text-align: right; font-size: 12px;">
                                    <i class="fa fa-calendar-o"></i>&nbsp; <?= $this->helper->dateBahasaIndo(date('Y-m-d')); ?><br/>
                                    <i class="fa fa-clock-o"></i>&nbsp; <span id="waktu" style="font-weight:bold;">00:00:00</span>
                            </div>
                        </div>
                    </form>

                    <table id="data_table" class="table table-bordered table-striped">
                        <thead>
                            <tr>
                                <th style="width: 5px"><input type="checkbox" id="select_all" style="margin: 0;"></th> 
                                <th style="width: 5px">No</th>
                                <!-- <th style="width: 80px">Tanggal</th> -->
                                <th style="width: 200px">Murid</th>
                                <th style="width: 120px">Masuk</th>
                                <th style="width: 120px">Keluar</th>
                                <th style="width: 60px">Email Orangtua</th>
                                <th style="width: 60px">Aksi</th>
                            </tr>
                        </thead>
                        <tbody>
                            <?php
                            $no = 1;
                            foreach($data as $a => $v) {                                
                            ?>
                            <tr id="data_{{v.murid_id}}" class="middle-row">
                                <td><input type="checkbox" class="check" data-id="{{v.murid_id}}"></td>
                                <td align="center">{{no}}</td>
                                <!-- <td><?= $this->helper->dateBahasaIndo(date('Y-m-d')) ?></td> -->
                                <!-- <td>{{ hadir[v.murid_id]['masuk']['tanggal'] != '' ? hadir[v.murid_id]['masuk']['tanggal'] : '' }}</td> -->
                                <td>
                                    <img src="img/mhs/{{v.foto}}" alt="{{v.nama_murid}}" style="height: 3em; float: left; margin-right: 10px; border-radius: 50px">
                                    <a href="#" style="font-weight: 600;" onclick="edit_murid('{{v.murid_id}}', '{{rombel_id}}')" id="nama_murid">{{v.nama_murid}}</a> <br/> 
                                    <span class="label label-default">NIS</span> 
                                    <span class="label label-primary">{{v.nis}}</span>
                                </td>  
                                
                                {% set masuk = hadir[v.murid_id]['masuk']['presensi'] %}
                                {% if (masuk == 'hadir') %}
                                    {% set masuk_tipe = 'success' %}
                                    {% set masuk_icon = 'fa-check' %}
                                {% elseif (masuk == 'absen') %}
                                    {% set masuk_tipe = 'danger' %}
                                    {% set masuk_icon = 'fa-times' %}
                                {% elseif (masuk == 'sakit') %}
                                    {% set masuk_tipe = 'primary' %}
                                    {% set masuk_icon = 'fa-medkit' %}    
                                {% elseif (masuk == 'izin') %}
                                    {% set masuk_tipe = 'warning' %}
                                    {% set masuk_icon = 'fa-question' %}
                                {% endif %}     

                                {% set masuk_email = hadir[v.murid_id]['masuk']['status_email'] %}  
                                {% if (masuk_email == 'T') %}
                                    {% set masuk_status = 'Belum Dikirim' %}
                                {% elseif (masuk_email == 'Y') %}
                                    {% set masuk_status = 'Berhasil Dikirim' %}
                                {% elseif (masuk_email == 'P') %}
                                    {% set masuk_status = 'Proses Dikirim' %}                        
                                {% endif %}

                                <td style="text-transform: uppercase">
                                    {% if (masuk != '') %}
                                    <span class="label label-{{masuk_tipe}}">
                                        <i class="fa {{masuk_icon}}"></i>&nbsp; {{masuk}}
                                    </span>
                                    {% endif %}
                                
                                    {% set masuk_waktu = hadir[v.murid_id]['masuk']['waktu'] %}
                                    {% if (masuk_waktu != '') %}               
                                        <span class="label label-default"><i class="fa fa-clock-o"></i>&nbsp; {{masuk_waktu}}</span>            
                                    {% endif %}
                                    
                                    {% set masuk_ket = hadir[v.murid_id]['masuk']['keterangan'] %} 
                                    {% if (masuk_ket != '') %}
                                        <span class="label label-default" data-toggle="tooltip" title="{{masuk_ket}}"><i class="fa fa-info-circle"></i></span>
                                    {% endif %}
                                    <br/>
                                    {% if (masuk_email != '') %}
                                        <span class="label label-default"><i class="fa fa-envelope"></i>&nbsp; {{masuk_status}}</span>           
                                    {% endif %}
                                </td>                                                                
                                {% set keluar = hadir[v.murid_id]['keluar']['presensi'] %}
                                {% if (keluar == 'hadir') %}
                                    {% set keluar_tipe = 'success' %}
                                    {% set keluar_icon = 'fa-check' %}
                                {% elseif (keluar == 'absen') %}
                                    {% set keluar_tipe = 'danger' %}
                                    {% set keluar_icon = 'fa-times' %}
                                {% elseif (keluar == 'sakit') %}
                                    {% set keluar_tipe = 'primary' %}
                                    {% set keluar_icon = 'fa-medkit' %}    
                                {% elseif (keluar == 'izin') %}
                                    {% set keluar_tipe = 'warning' %}
                                    {% set keluar_icon = 'fa-question' %}
                                {% endif %}     

                                {% set keluar_email = hadir[v.murid_id]['keluar']['status_email'] %}
                                {% if (keluar_email == 'T') %}
                                    {% set keluar_status = 'Belum Dikirim' %}
                                {% elseif (keluar_email == 'Y') %}
                                    {% set keluar_status = 'Berhasil Dikirim' %}
                                {% elseif (keluar_email == 'P') %}
                                    {% set keluar_status = 'Proses Dikirim' %}                        
                                {% endif %}

                                <td style="text-transform: uppercase">
                                    {% if (keluar != '') %}
                                    <span class="label label-{{keluar_tipe}}">
                                        <i class="fa {{keluar_icon}}"></i>&nbsp; {{keluar}}
                                    </span>
                                    {% endif %}
                                
                                    {% set keluar_waktu = hadir[v.murid_id]['keluar']['waktu'] %}
                                    {% if (keluar_waktu != '') %}             
                                        <span class="label label-default"><i class="fa fa-clock-o"></i>&nbsp; {{keluar_waktu}}</span>            
                                    {% endif %}
                                    
                                    {% set keluar_ket = hadir[v.murid_id]['keluar']['keterangan'] %}
                                    {% if (keluar_ket != '') %}
                                        <span class="label label-default" data-toggle="tooltip" title="{{keluar_ket}}"><i class="fa fa-info"></i></span>
                                    {% endif %}
                                    <br/>
                                    {% if (keluar_email != '') %}
                                        <span class="label label-default"><i class="fa fa-envelope"></i>&nbsp; {{keluar_status}}</span>           
                                    {% endif %}
                                </td>                             
                                <td>
                                    {% if (masuk_email != '' OR keluar_email != '') %}
                                    <div class="dropdown">
                                        <button class="btn btn-default btn-xs dropdown-toggle" type="button" data-toggle="dropdown"><i class="fa fa-envelope-o"></i>&nbsp; Kirim Email
                                        <span class="caret"></span></button>
                                        
                                        <ul class="dropdown-menu">
                                            {% if (masuk_email != 'Y') %}
                                            <li><a href="#" onclick="send_mail('masuk', this)">&raquo; Email Masuk</a></li>
                                            {% endif %}
                                            {% if (keluar_email != 'Y' AND keluar != '') %}
                                            <li><a href="#" onclick="send_mail('keluar', this)">&raquo; Email Keluar</a></li>
                                            {% endif %}
                                        </ul>
                                    </div>      
                                    {% endif %}                               
                                    <span class="label label-default" id="email_wali">{{v.email}}</span>
                                </td>
                                <td>                        
                                    {% if (masuk == '' OR keluar == '') %}        
                                    <div class="dropdown">
                                        <button class="btn btn-default dropdown-toggle" type="button" data-toggle="dropdown"><i class="fa fa-sign-in"></i>&nbsp; Presensi: &nbsp; 
                                        <span class="caret"></span></button>
                                        <ul class="dropdown-menu">
                                            <li><a href="#" onclick="presensi_modal('hadir', this)">&raquo; Hadir</a></li>
                                            <li><a href="#" onclick="presensi_modal('absen', this)">&raquo; Absen</a></li>                  
                                            <li><a href="#" onclick="presensi_modal('sakit', this)">&raquo; Sakit</a></li>
                                            <li><a href="#" onclick="presensi_modal('izin', this)">&raquo; Izin</a></li>
                                        </ul>
                                    </div>
                                    {% endif %}
                                </td>                                
                            </tr>
                            <?php
                            $no++;
                            }
                            ?>
                        </tbody>
                        <tfoot>
                            <tr>
                                <td colspan="5" style="padding-top: 1em; vertical-align: middle;">
                                    <p style="display: inline-block; margin-top: 7px;">
                                        <i class="fa fa-hand-pointer-o"></i>&nbsp;
                                        <span class="rows_selected" id="select_count">0</span> Data Terpilih
                                    </p>
                                    <div class="pull-right">
                                        <div class="form-group dropdown" style="margin-right: 10px">
                                            <button class="btn btn-default dropdown-toggle" type="button" data-toggle="dropdown"><i class="fa fa-sign-in"></i>&nbsp; Presensi: &nbsp; 
                                            <span class="caret"></span></button>

                                            <ul class="dropdown-menu">
                                                <li><a href="#" onclick="presensi_modal('hadir')">&raquo; Hadir</a></li>
                                                <li><a href="#" onclick="presensi_modal('absen')">&raquo; Absen</a></li>              
                                                <li><a href="#" onclick="presensi_modal('sakit')">&raquo; Sakit</a></li>
                                                <li><a href="#" onclick="presensi_modal('izin')">&raquo; Izin</a></li>
                                            </ul>
                                        </div>                                        
                                        <div class="form-group dropdown" style="margin-right: 10px">
                                            <button class="btn btn-default dropdown-toggle" type="button" data-toggle="dropdown"><i class="fa fa-envelope-o"></i>&nbsp; Kirim Email:
                                            <span class="caret"></span></button>
                                            
                                            <ul class="dropdown-menu">
                                                <li><a href="#" onclick="send_mail('masuk')">&raquo; Email Masuk</a></li>
                                                <li><a href="#" onclick="send_mail('keluar')">&raquo; Email Keluar</a></li>
                                            </ul>
                                        </div>
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

    <!-- presensi modal -->
    <div class="modal fade" id="presensiModal" tabindex="-1" role="dialog" aria-labelledby="presensiModalLabel">
        <div class="modal-dialog modal-sm" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="loadingLabel">Form Presensi</h4>
                </div>
                <div class="modal-body">
                    <div class="form-group">
                        <label for="presensi_nama"><i class="fa fa-user"></i>&nbsp; Nama</label>
                        <input type="text" id="presensi_nama" class="form-control" readonly>
                    </div>               
                    <div class="col-md-6" style="padding-left: 0;">
                        <div class="form-group">
                            <label for="presensi_waktu"><i class="fa fa-clock-o"></i>&nbsp; Waktu</label>
                            <div class="bootstrap-timepicker">
                                <div class="input-group">
                                    <input id="presensi_waktu" type="text" class="form-control timepicker" style="width: 100px">
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">                                
                            <label for="presensi_tipe"><i class="fa fa-tasks"></i>&nbsp; Tipe</label>
                            <select id="presensi_tipe" class="form-control">
                                <option value="masuk">Masuk</option>
                                <option value="keluar">Keluar</option>
                            </select>    
                        </div>                        
                    </div>
                    <div class="form-group">
                        <label for="presensi_keterangan"><i class="fa fa-edit"></i>&nbsp; Keterangan (<span style="color: red;" id="presensi_jenis">sakit</span>)</label>
                        <textarea id="presensi_keterangan" class="form-control" placeholder="opsional"></textarea>
                    </div>
                    <button type="submit" class="btn btn-primary" id="presensi_simpan"><i class="fa fa-send"></i>&nbsp; Simpan</button>
                </div>               
            </div>
        </div>
    </div>

    <!-- loading modal -->
    <div class="modal fade" id="loadingModal" tabindex="-1" role="dialog" aria-labelledby="LoadingModalLabel">
        <div class="modal-dialog modal-sm" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="myModalLabel">Proses</h4>
                </div>
                <div class="modal-body text-center">
                    <img src="{{ url('public/img/loader.gif') }}">   
                    <h4>Tunggu hingga proses selesai...</h4>             
                </div>               
            </div>
        </div>
    </div>

</section>
<!-- /.content -->

<script type="text/javascript">
    var checked_murid = [];

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

        // timepicker config
        $(".timepicker").timepicker({
            showInputs: false,
            showSeconds: false,
            showMeridian: false,
            maxHours: 24
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
        }).on('changeDate', function(ev){ 
            var selected_date = ev.format(0,"yyyy-mm-dd");
            var url = '{{ url("presensi/index/") }}{{rombel_id}}/' + selected_date;
            go_page(url);
        });

        // pilih semua checkbox
        $('#select_all').on('change', function(e) {
            if ($(this).is(':checked', true)) {
                $(".check").prop('checked', true);  
                $('.check').map(function() {
                    var id = $(this).data('id');
                    checked_murid.push({
                        murid_id: id, 
                        nama: $('#data_'+id+' #nama_murid').html(),
                        email: $('#data_'+id+' #email_wali').html()
                    });
                });
            }  
            else {  
                $(".check").prop('checked',false);  
                // hapus semua uncheckedbox array
                $('.check').map(function() {
                    var id = $(this).data('id');
                    checked_murid = $.grep(checked_murid, function(e){ 
                        return e.murid_id != id; 
                    });
                });
            }		
            
            $("#select_count").html(checked_murid.length);
            console.log(checked_murid);
        });
        
        // pilih checkbox satuan
        $(".check").on('change', function(e) {
            var id = $(this).data('id');
            if ($(this).is(':checked', true)) {
                checked_murid.push({
                    murid_id: id, 
                    nama: $('#data_'+id+' #nama_murid').html(),
                    email: $('#data_'+id+' #email_wali').html()
                });
                $("#select_count").html(checked_murid.length);
            } else {
                // hapus uncheckedbox array
                checked_murid = $.grep(checked_murid, function(e){ 
                    return e.murid_id != id; 
                });
            }

            console.log(checked_murid);
        });	    
    });

    // jam digital
    window.setTimeout("waktu()",1000);
    function waktu() {
        var tanggal = new Date();
        setTimeout("waktu()",1000);
        $('#waktu').html(tanggal.getHours()+':'+tanggal.getMinutes()+':'+tanggal.getSeconds());
    }

    // ganti tanggal kemarin / besok
    function change_date(type='-') {
        var current_date = new Date('{{tanggal}}');
        var new_date = new Date(current_date);
        new_date.setDate(current_date.getDate() - 1);
       
        if (type == '+') {
            new_date.setDate(current_date.getDate() + 1);
        }

        var dd = new_date.getDate();
        var mm = new_date.getMonth()+1;
        var yyyy = new_date.getFullYear();

        if (dd < 10) {
            dd = '0' + dd
        } 
        if (mm < 10) {
            mm = '0' + mm
        } 
        
        new_date = yyyy + '-' + mm + '-' + dd;
        var url = '{{ url("presensi/index/") }}{{rombel_id}}/' + new_date;
        go_page(url);

        return false;
    }

    function add_new(id) {
        var nama_tingkat = '{{data[0].nama_tingkat}}';
        var nama_rombel = '{{data[0].nama_rombel}}';
        var kurikulum_id = '{{data[0].kurikulum_id}}';
        var semester_id = '{{data[0].semester_id}}';
        
        var data_target = "";

        var urel = '{{ url("presensi/addPresensi/") }}' + id;
        go_page_data(urel, data_target);          
    }

    function presensi_modal(jenis, single='') {
        $('#presensiModal').modal('show');
        $('#presensi_nama').closest('.form-group').show();
        $('#presensi_jenis').html(jenis);

        if (single !== '') {
            var data_id = $(single).closest('tr').attr('id');
            var id = data_id.split('_')[1];
            var nama = $('#'+data_id+' #nama_murid').html();
            var email = $('#'+data_id+' #email_wali').html();

            $('#presensi_nama').val(nama);            

            checked_murid = [];
            checked_murid.push({
                murid_id: id, 
                nama: nama,
                email: email
            });
        } else {
            $('#presensi_nama').closest('.form-group').hide();
        }

        $('#presensi_simpan').attr('onclick', 'save_data(\''+jenis+'\')');
    }


    function edit_data(id, rombel_id) {
        var link = '{{ url("presensi/editMurid/") }}' + id + '/' + rombel_id;
        go_page(link);
    }

    function save_data(presensi) {
		if (checked_murid.length <=0) {  
			alert("Silahkan pilih data.");
		} else { 				
            var data_murid = JSON.stringify(checked_murid);
            var url_target = '{{ url("presensi/status") }}';
            var rombel_id = '{{rombel_id}}';
            var tanggal = '{{tanggal}}';
            var tipe = $('#presensi_tipe').val();
            var waktu = $('#presensi_waktu').val();
            var keterangan = $('#presensi_keterangan').val();

            var data_send = 'rombel_id='+rombel_id+'&tanggal='+tanggal+'&waktu='+waktu+'&data_murid='+data_murid+'&presensi='+presensi+'&tipe='+tipe+'&keterangan='+keterangan;

            $.ajax({ 
                method: "POST",
                dataType: "json",
                url: url_target,
                cache: false,
                data: data_send,
                complete: function() {
                    $('#presensiModal').modal('hide');
                    $('body').removeClass('modal-open');
                    $("body").css("padding-right", "0px");
                    $('.modal-backdrop').remove();
                },
                success: function(res){
                    new PNotify({
                        title: res.title,
                        text: res.text,
                        type: res.type
                    });
                    reload_page2('presensi/index/{{rombel_id}}/{{tanggal}}');
                }                
            });
		}      

        return false;
    }

    function edit_murid(id, rombel_id) {
        var url = '{{ url("pesertadidik/editMurid/") }}' + id + '/' + rombel_id;
        var back_link = '{{ url("presensi/index/") }}' + rombel_id + '/{{tanggal}}';
        var data = 'back_link='+back_link;

        go_page_data(url, data);                 
    }

    function send_mail(tipe, single='') {        
        if (single !== '') {
            var data_id = $(single).closest('tr').attr('id');
            var id = data_id.split('_')[1];
            var nama = $('#'+data_id+' #nama_murid').html();
            var email = $('#'+data_id+' #email_wali').html();
            
            checked_murid = [];
            checked_murid.push({
                murid_id: id, 
                nama: nama,
                email: email
            });
        } else {
            if (checked_murid.length <=0) {  
                alert("Silahkan pilih data.");
            }
        }

        var data_murid = JSON.stringify(checked_murid);
        var url_target = '{{ url("presensi/mail") }}';  
        var tanggal = '{{tanggal}}';

        var data_send = 'data_murid='+data_murid+'&tanggal='+tanggal+'&tipe='+tipe;

        $.ajax({ 
            method: "POST",
            dataType: "json",
            url: url_target,  
            cache: false,  
            data: data_send,   
            beforeSend: function() {
                $('#loadingModal').modal('show');
            },
            complete: function() {
                $('#loadingModal').modal('hide');
                $('body').removeClass('modal-open');
                $("body").css("padding-right", "0px");
                $('.modal-backdrop').remove();
            },
            success: function(res){
                new PNotify({
                    title: res.title,
                    text: res.text,
                    type: res.type
                });
                reload_page2('presensi/index/{{rombel_id}}/{{tanggal}}');
            }
        });     
        
        return false;
    }

</script>