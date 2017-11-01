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

    $(".select2").select2();

    $("img").on("error", function() {
        $(this).attr('src', 'img/user.png');
    });

    $('#showPassword').on("click", function(e) {
        if ($('#pass').hasClass('active')) {
            $('#pass').attr('type', 'text');
            $('#pass').removeClass('active');
            $('#showPassword > i').attr('class', 'fa fa-eye');
        } else {
            $('#pass').attr('type', 'password');
            $('#pass').addClass('active');
            $('#showPassword > i').attr('class', 'fa fa-eye-slash');
        }

        e.preventDefault();        
    });

    $("#reset").on("click", function() {
        $("#form_title").text('Tambah User');
        $("#foto").attr('src', 'img/user.png');
        $("#jenis").removeAttr('disabled');
        $("#nama").removeAttr('disabled');
        $("#nama").empty().trigger("change");
        $("#uid").removeAttr('readonly');
        $("#area").val(null).trigger("change");
        $("#usergroup").val(null).trigger("change");
        $("#reset").attr('class', 'btn btn-default');
        $("#reset").html('<i class="fa fa-refresh"></i>&nbsp; Reset');
        $("#submit").attr('onclick', 'save_data(\'addUser\')');
    });

    $('#filter_jenis').on("change", function() {
        if (this.value == '2') {
            $('#filter_tingkat').removeAttr('disabled');
        } else {
            $('#filter_tingkat').attr('disabled', 'disabled');
        }
    });

    $('#proses').on("click", function() {
        var jenis = $('#filter_jenis').val();
            tingkat = $('#filter_tingkat').val();
            url = "{{ url('user/index') }}";

        if (jenis == '2') {
            url = "{{ url('user/index/') }}" + jenis + '/' + tingkat;
        }

        go_page(url);
    });
});

function changeJenis(element) {
    var id = element.value;    
    var img_folder = 'sdm';
    // reset uid dan nama
    $('#uid').removeAttr('readonly');
    $("#nama").empty().trigger("change");
    // jika jenisnya murid maka gk boleh ganti uid
    if (id == 2) {
        $('#uid').attr('readonly', 'readonly');
        img_folder = 'mhs';
    }    

    $.ajax({
        url       : "{{ url('user/searchNama/') }}"+id,
        type      : "POST",
        dataType  : "json",
        data      : {'name' : 'value'},
        cache     : false,
        success   : function(response){            
            $("#nama").select2({
                placeholder: 'Cari nama...',
                data: response
            }).on("select2:selecting", function(evt) {                
                var img_name = evt.params.args.data.foto;                
                var getValue = evt.params.args.data.id;                
                $('#uid').val(getValue);
                $('#nip').val(getValue);
                $('#foto').attr('src', 'img/'+img_folder+'/'+img_name);
            });
        }
    });
}

function save_data(action) {
    var jenis = $("#jenis").val();
    var uid = $("#uid").val();
    var nip = $("#nip").val();
    var password = $("#pass").val();
    var area = $("#area").val();
    var usergroup = $("#usergroup").val();
    var aktif = $("#aktif").val();
    
    if (area == '' || area == null) {
        new PNotify({
            title: 'Gagal',
            text: '<b>&raquo; Area akses menu</b> tidak boleh kosong',
            type:'warning'
        });
    } else if (usergroup == '' || usergroup == null) {
        new PNotify({
             title: 'Gagal',
             text: '<b>&raquo; Usergroup</b> tidak boleh kosong',
             type:'warning'
        });
    } else {
        if (action == 'addUser') {
            var data_send = "jenis="+jenis+"&uid="+uid+"&nip="+nip+"&password="+password+"&area="+area+"&usergroup="+usergroup;
        } else {
            var data_send = "uid="+uid+"&password="+password+"&area="+area+"&usergroup="+usergroup;
        }

        $.ajax({
            method: "POST",
            dataType: "json",
            url: '{{ url("user/' + action + '") }}',
            data: data_send
        }).done(function (data) {
            reload_page2('user/index');
            new PNotify({
                title: data.title,
                text: data.text,
                type: data.type
            });
        });
    }

    return false;
}

function edit_data(uid) {
    $.ajax({
        url       : "{{ url('user/get/') }}"+uid,
        type      : "POST",
        dataType  : "json",
        data      : {'name' : 'value'},
        cache     : false,
        success   : function(row){  
            $("#jenis").attr('disabled', 'disabled');
            $("#nama").attr('disabled', 'disabled');
            $("#uid").removeAttr('readonly');

            var img_folder = 'sdm'
            if (row.id_jenis == 2) {
                img_folder = 'mhs'
                $("#uid").attr('readonly', 'readonly');
            }

            $('#form_title').text('Ubah User');
            $('#reset').html('<i class="fa fa-times"></i>&nbsp; Batal');
            $('#reset').attr('class', 'btn btn-danger');            
            $('#submit').attr('onclick', 'save_data(\'editUser/'+uid+'\')');
            $('#foto').attr('src', 'img/'+img_folder+'/'+row.foto);

            $('#jenis').val(row.id_jenis);
            $('#uid').val(row.login);
            $('#nip').val(row.nip);
            
            var setNama = $("<option value='"+row.nip+"' selected>"+row.nama+"</option>");
            $("#nama").empty().trigger("change");
            $("#nama").append(setNama);
            $("#nama").trigger("change");         
            
            var setArea = (row.area).slice(1, -1).split(',');
            var setUsergroup = (row.usergroup).slice(1, -1).split(',');
            $('#area').select2().val(setArea).trigger("change");
            $('#usergroup').select2().val(setUsergroup).trigger("change");            
        }
    });
}

function delete_data(uid) {
    var url_target = '{{ url("user/deleteUser") }}/' + uid;
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
                reload_page2('user/index');
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