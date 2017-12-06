{# Define variables #}
{% set tanggalIndo = helper.dateBahasaIndo(date('Y-m-d')) %}

{# Global css #}
<style>{% include "include/view.css" %}</style>

<!-- Header content -->
<section class="content-header">
    <h1>
        Ubah Akun
        <small>
            <i class="fa fa-calendar-o"></i> {{ tanggalIndo }} 
            <i class="fa fa-clock-o"></i> <span id="waktu">00:00:00</span>
        </small> 
    </h1>
    <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i> User</a></li>
        <li class="active">Ubah Akun</li>
    </ol>   
</section>

<!-- Main content -->
<section class="content">
    <div class="row">
        <!-- Table column -->
        <div class="col-md-offset-3 col-md-6">
            <div class="box box-primary">
                <div class="box-header">
                    <h3 class="box-title">Ubah Akun Pengguna</h3>
                </div>
                <div class="box-body">
                    <div class="form-group">
                        <label>Username <span class="text-red">(*tidak boleh diubah)</span></label>
                        <input type="text" class="form-control" id="username" value="<?= $this->session->get('uid'); ?>" disabled>
                    </div>
                    <div class="form-group">
                        <label>Password Lama</label>
                        <input type="password" id="pass" class="form-control">
                    </div>                        
                    <div class="form-group">
                        <label>Password Baru</label>
                        <input type="password" id="pass_baru" class="form-control">
                    </div>
                    <div class="form-group">
                        <label>Ulangi Password Baru</label>
                        <input type="password" onChange="checkPasswordMatch();" id="ulangi" class="form-control ul2">

                        <p class="notip" style="color:#dd4b39; display:none;">Password tidak sama!</p>
                    </div>  
                    <div class="form-group">           
                        <input class="btn btn-xs btn-success btn-flat" id="show" type="checkbox" style="margin: 0">  
                        <label for="show" style="font-weight: normal">Tampilkan Password</label>
                    </div>                                                 

                    <div class="pull-right">
                        <button onclick="ganti_login()" class="pull-right btn bg-navy btn-flat margin">Simpan</button>
                    </div>
                </div>
                <!-- /.box-body -->
            </div>
            <!-- /.box -->
        </div>
    </div>

</section>
<!-- /.content -->

<!-- global script -->
<script>{% include "include/view.js" %}</script>

<script type="text/javascript">

function checkPasswordMatch() {
    var pass_baru = $("#pass_baru").val();
    var ulangi = $("#ulangi").val();

    if (pass_baru != ulangi){
        $(".ul").css("color", "#dd4b39");
        $(".ul2").css("border-color", "#dd4b39");
        $(".notip").css("display", "block");
        // $(".notip").html("Passwords tidak sama.");
    }else{
        $(".ul").css("color", "#444");
        $(".ul2").css("border-color", "#d2d6de");
        $(".notip").css("display", "none");
    }
}

$(document).ready(function () {
   $("#ulangi").keyup(checkPasswordMatch);
   $("#pass_baru").keyup(checkPasswordMatch);
});

  function ganti_login() {
    var pass_lama = $("#pass").val();
    var pass_baru = $("#pass_baru").val();
    var ulangi = $("#ulangi").val();

    var datas = "pass_lama="+pass_lama+"&pass_baru="+pass_baru;

    var urel = '{{ url("user/resetMhs/") }}';

    (new PNotify({
        title: 'Confirmation Needed',
        text: 'Apakah Anda Yakin meRESET Password?',
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
    })).get().on('pnotify.confirm', function() {

        $.ajax({
            type: "POST",
            dataType: "JSON",
            url: urel,
            data: datas,
            success: function(data){ 
              if (data.status == true) {
                  (new PNotify({
                      title: 'Confirmation Needed',
                      text: 'Silahkan login kembali dengan Akun baru!',
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
                      },
                      addclass: 'stack-modal',
                      stack: {
                          'dir1': 'down',
                          'dir2': 'right',
                          'modal': true
                      }
                  })).get().on('pnotify.confirm', function() {
                      var login = "{{url('account/logout')}}";
                      window.location.replace(login);
                  }).on('pnotify.cancel', function() {
                      var login = "{{url('account/logout')}}";
                      window.location.replace(login);
                  });
              }else{
                new PNotify({
                  title: data.title,
                  text: data.text,
                  type: data.type
                });
              }
            }
        });
    }).on('pnotify.cancel', function() {
       console.log('batal');
    });

  }

  // Show Password
  $(document).on('click','#show',function() {
    $('#pass_baru').removeAttr('type').attr({type:'text'});
    $('#ulangi').removeAttr('type').attr({type:'text'});
    $('#show').removeAttr('id').attr({id:'hide'});
  });

  $(document).on('click','#hide',function() {
    $('#pass_baru').removeAttr('type').attr({type:'password'});
    $('#ulangi').removeAttr('type').attr({type:'password'});
    $('#hide').removeAttr('id').attr({id:'show'});
  });

  $(document).on('click','#profil_img',function() {
    $('#up_img').css({display:'block'});
  });

</script>
