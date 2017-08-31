<section class="content-header">
  <h1>
    User Profil
    <small>it all starts here</small>
  </h1>
  <ol class="breadcrumb">
    <li><a href="#"><i class="fa fa-dashboard"></i> User</a></li>
    <li class="active">Profil</li>
  </ol>
</section>

<!-- Main content -->
<section class="content">
  <!-- row -->
  <div class="row">
      <div class="box box-primary">
        <div class="box-header with-border">
          <h3 class="box-title">Ubah Account</h3>
        </div>

        <div class="box-body">
        <div class="col-md-2"></div>        
        <div class="col-md-8">

          <table class="table">
            <tbody>
              <tr>
                <td><b>Password Lama :</b></td>
                <td><input type="password" id="pass" class="form-control" placeholder="Enter..."></td>
                <td></td>
                <td></td>
              </tr>
              <tr class="form-horizontal">
                <td><b>Login baru :</b></td>
                <td><input type="text" class="form-control" id="username" placeholder="Enter..."><p class="text-aqua">*tanpa spasi</p></td>
                <td><label for="inputEmail3" class="col-sm-2 control-label">Password</label></td>
                <td><input type="password" id="pass_baru" class="form-control" placeholder="Enter..."></td>
              </tr>
              <tr>
                <td><b class="ul">Ulangi Password baru :</b></td>
                <td><input type="password" onChange="checkPasswordMatch();" id="ulangi" class="form-control ul2" placeholder="Enter...">
                <p class="notip" style="color:#dd4b39; display:none;">Passwords tidak sama.</p>
                </td>
                <td></td>
                <td></td>
              </tr>
             
              <tr>
                <td></td>
                <td><input class="btn btn-xs btn-success btn-flat" id="show" type="checkbox"> Tampilkan Password</td>
                <td></td>
                <td><button onclick="ganti_login()" class="pull-right btn bg-navy btn-flat margin">Ganti</button></td>
              </tr>
            </tbody>
          </table>

<!-- <button style="margin-bottom:20px;" type="submit" id="frm_data" class="btn btn-primary btn-block pull-right" onclick="reset_data('<?= $this->session->get('id'); ?>')">Ubah</button> -->

        </div>
        <div class="col-md-2"></div>

        </div>

      </div><!-- /.box -->
  </div><!-- /.row -->
</section><!-- /.content -->
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
    var username = $("#username").val();
    var pass_baru = $("#pass_baru").val();
    var ulangi = $("#ulangi").val();

    var datas = "pass_lama="+pass_lama+"&username="+username+"&pass_baru="+pass_baru;

    var urel = '{{ url("user/resetSdm/") }}';

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
    $('#pass').removeAttr('type').attr({type:'text'});
    $('#pass_baru').removeAttr('type').attr({type:'text'});
    $('#ulangi').removeAttr('type').attr({type:'text'});
    $('#show').removeAttr('id').attr({id:'hide'});

  });

  $(document).on('click','#hide',function() {
    $('#pass').removeAttr('type').attr({type:'password'});
    $('#pass_baru').removeAttr('type').attr({type:'password'});
    $('#ulangi').removeAttr('type').attr({type:'password'});
    $('#hide').removeAttr('id').attr({id:'show'});
  });

  $(document).on('click','#profil_img',function() {
    $('#up_img').css({display:'block'});
  });

</script>
