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
            [50, 25, 10, 5, -1],
            [50, 25, 10, 5, "Semua"]
        ],
        "iDisplayLength": 50,
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
    }).on('changeDate', function (ev) {
        var selected_date = ev.format(0, "yyyy-mm-dd");
        var url = '{{ url("presensi/index/") }}{{rombel_id}}/' + selected_date;
        go_page(url);
    });

    // pilih semua checkbox
    $('#select_all').on('change', function (e) {
        if ($(this).is(':checked', true)) {
            $(".check").prop('checked', true);
            $('.check').map(function () {
                var id = $(this).data('id');
                checked_murid.push({
                    murid_id: id,
                    nama: $('#data_' + id + ' #nama_murid').html(),
                    email: $('#data_' + id + ' #email_wali').html()
                });
            });
        } else {
            $(".check").prop('checked', false);
            // hapus semua uncheckedbox array
            $('.check').map(function () {
                var id = $(this).data('id');
                checked_murid = $.grep(checked_murid, function (e) {
                    return e.murid_id != id;
                });
            });
        }

        $("#select_count").html(checked_murid.length);
        console.log(checked_murid);
    });

    // pilih checkbox satuan
    $(".check").on('change', function (e) {
        var id = $(this).data('id');
        if ($(this).is(':checked', true)) {
            checked_murid.push({
                murid_id: id,
                nama: $('#data_' + id + ' #nama_murid').html(),
                email: $('#data_' + id + ' #email_wali').html()
            });
            $("#select_count").html(checked_murid.length);
        } else {
            // hapus uncheckedbox array
            checked_murid = $.grep(checked_murid, function (e) {
                return e.murid_id != id;
            });
        }

        console.log(checked_murid);
    });
});

// jam digital
window.setTimeout("waktu()", 1000);

function waktu() {
    var tanggal = new Date();
    setTimeout("waktu()", 1000);
    $('#waktu').html(
        tanggal.getHours() + ':' + 
        tanggal.getMinutes() + ':' + 
        tanggal.getSeconds()
    );
}

// ganti tanggal kemarin / besok
function change_date(type = '-') {
    var current_date = new Date('{{tanggal}}');
    var new_date = new Date(current_date);
    new_date.setDate(current_date.getDate() - 1);

    if (type == '+') {
        new_date.setDate(current_date.getDate() + 1);
    }

    var dd = new_date.getDate();
    var mm = new_date.getMonth() + 1;
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

function presensi_modal(jenis, single = '') {
    $('#presensiModal').modal('show');
    $('#presensi_nama').closest('.form-group').show();
    $('#presensi_jenis').html(jenis);

    if (single !== '') {
        var data_id = $(single).closest('tr').attr('id');
        var id = data_id.split('_')[1];
        var nama = $('#' + data_id + ' #nama_murid').html();
        var email = $('#' + data_id + ' #email_wali').html();

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

    $('#presensi_simpan').attr('onclick', 'save_data(\'' + jenis + '\')');
}


function edit_data(id, rombel_id) {
    var link = '{{ url("presensi/editMurid/") }}' + id + '/' + rombel_id;
    go_page(link);
}

function save_data(presensi) {
    if (checked_murid.length <= 0) {
        alert("Silahkan pilih data.");
    } else {
        var data_murid = JSON.stringify(checked_murid);
        var url_target = '{{ url("presensi/status") }}';
        var rombel_id = '{{rombel_id}}';
        var semester_id = '{{semester_id}}';
        var tanggal = '{{tanggal}}';
        var tipe = $('#presensi_tipe').val();
        var waktu = $('#presensi_waktu').val();
        var keterangan = $('#presensi_keterangan').val();

        var data_send = 'rombel_id=' + rombel_id + '&tanggal=' + tanggal + '&waktu=' + waktu + '&data_murid=' + data_murid + '&presensi=' + presensi + '&tipe=' + tipe + '&keterangan=' + keterangan + '&semester_id=' + semester_id;

        $.ajax({
            method: "POST",
            dataType: "json",
            url: url_target,
            cache: false,
            data: data_send,
            complete: function () {
                $('#presensiModal').modal('hide');
                $('body').removeClass('modal-open');
                $("body").css("padding-right", "0px");
                $('.modal-backdrop').remove();
            },
            success: function (res) {
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
    var data = 'back_link=' + back_link;

    go_page_data(url, data);
}

function send_mail(tipe, single = '') {
    if (single !== '') {
        var data_id = $(single).closest('tr').attr('id');
        var id = data_id.split('_')[1];
        var nama = $('#' + data_id + ' #nama_murid').html();
        var email = $('#' + data_id + ' #email_wali').html();

        checked_murid = [];
        checked_murid.push({
            murid_id: id,
            nama: nama,
            email: email
        });
    } else {
        if (checked_murid.length <= 0) {
            alert("Silahkan pilih data.");
        }
    }

    var data_murid = JSON.stringify(checked_murid);
    var url_target = '{{ url("presensi/mail") }}';
    var tanggal = '{{tanggal}}';

    var data_send = 'data_murid=' + data_murid + '&tanggal=' + tanggal + '&tipe=' + tipe;

    $.ajax({
        method: "POST",
        dataType: "json",
        url: url_target,
        cache: false,
        data: data_send,
        beforeSend: function () {
            $('#loadingModal').modal('show');
        },
        complete: function () {
            $('#loadingModal').modal('hide');
            $('body').removeClass('modal-open');
            $("body").css("padding-right", "0px");
            $('.modal-backdrop').remove();
        },
        success: function (res) {
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