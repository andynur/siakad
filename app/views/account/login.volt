<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="utf-8">
  <meta http-equiv='Content-Type' content='text/html; charset=iso-8859-1' />
  <title>SISKO SD Islam Al-Azhar BSB 29 Semarang</title>
  <!-- favicon  -->
  <link rel="icon" href="../img/favicon.png" sizes="32x32" />
  <link rel="icon" href="../img/favicon.png" sizes="192x192" />
  <link rel="apple-touch-icon-precomposed" href="../img/favicon.png" />
  <meta name="msapplication-TileImage" content="../img/favicon.png" /> 

  {{ stylesheet_link("font-awesome/css/font-awesome.min.css") }} 
  {{ stylesheet_link("bootstrap/css/bootstrap.min.css") }}
  {{ stylesheet_link("css/style2.css") }} 

  {{ javascript_include("jquery/dist/jquery.min.js") }} 
  {{ javascript_include("bootstrap/dist/js/bootstrap.min.js") }}
</head>

<body>
  <div class="container">
    <!-- Header  -->
    <div class="row" style="padding: 1em;">
      <div class="col-md-12">
        <div style="margin: 0 auto; ">
          <img src="../img/logo.png" style="height: 6em;float: left; padding: 0 0.5em 0 1em;">
          <div style="float: left;padding: 1.5em 0 0 1em;">
            <h1 style="text-transform: uppercase;margin: 0;font-size: 2em;color: #0282c6;">
              <b>SISKO SD Islam Al Azhar BSB 29</b>
            </h1>
            <p style="color: #333;">Jl. RM. Hadisoebeno Sosro Wardoyo, Mijen, Kedungpane, Jawa Tengah, Kode Pos. 50211, Telp. 08112799510</p>
          </div>
        </div>
      </div>
    </div>

    <!-- Pengumuman  -->
    <div class="col-md-12" style="width: 100%;min-height: 20px;margin-bottom: 1em;">
      <div class="top"></div>
      <div class="pull-left tab-selected">Pengumuman</div>
      <div class="pull-left cells">
        <p style="color: #555;text-align: center;margin-top: 0.7em;">
          <marquee>Aplikasi SISKO SD Islam Al Azhar BSB 29 Semarang telah diluncurkan.</marquee>
        </p>
      </div>
    </div>

    <div class="col-md-8">
      <div id="myCarousel" class="carousel slide">
        <ol class="carousel-indicators">
          <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
          <li data-target="#myCarousel" data-slide-to="1"></li>
          <li data-target="#myCarousel" data-slide-to="2"></li>
          <li data-target="#myCarousel" data-slide-to="3"></li>
          <li data-target="#myCarousel" data-slide-to="4"></li>
        </ol>
        <div class="carousel-inner">
          <div class="item active">
            <img src="../img/galeri/staff.jpg" class="img-responsive">
            <div class="container">
              <div class="carousel-caption">
                <h1>Staff Beserta Jajaran</h1> 
                <p>SD Islam Al Azhar BSB 29 Semarang</p>
              </div>
            </div>
          </div>
          <div class="item">
            <img src="../img/galeri/depan.jpg" class="img-responsive">
            <div class="container">
              <div class="carousel-caption">
                <h1>Bangunan Depan</h1>                
                <p>SD Islam Al Azhar BSB 29 Semarang</p>                
              </div>
            </div>
          </div>  
          <div class="item">
            <img src="../img/galeri/halaman.jpg" class="img-responsive">
            <div class="container">
              <div class="carousel-caption">
                <h1>Halaman Sekolah</h1>
                <p>SD Islam Al Azhar BSB 29 Semarang</p> 
              </div>
            </div>
          </div>                  
          <div class="item">
            <img src="../img/galeri/khotmil.jpg" class="img-responsive">
            <div class="container">
              <div class="carousel-caption">
                <h1>Kegiatan Khotmil Quran</h1>
                <p>SD Islam Al Azhar BSB 29 Semarang</p> 
              </div>
            </div>
          </div>                  
          <div class="item">
            <img src="../img/galeri/adiwiyata.jpg" class="img-responsive">
            <div class="container">
              <div class="carousel-caption">
                <h1>Adiwiyata</h1>
                <p>SD Islam Al Azhar BSB 29 Semarang</p> 
              </div>
            </div>
          </div>                  
        </div>
        <!-- Controls -->
        <a class="left carousel-control" href="#myCarousel" data-slide="prev">
          <span class="icon-prev"></span>
        </a>
        <a class="right carousel-control" href="#myCarousel" data-slide="next">
          <span class="icon-next"></span>
        </a>
      </div>
    </div>

    <div class="col-md-4">
      <div class="card card-container" style="margin-top: 0px">
        <label style="width: 100%;text-align: left; color: #0282c6; border-bottom: solid;">
        <h3>AKUN SISKO</h3></label>
        <form class="form-signin" action="{{ url('account/loginProses') }}" method="post">
          <span id="reauth-email" class="reauth-email"></span>
          <label>Login</label>
          <input name="uid" type="text" class="form-control" placeholder="Login">
          <label>Password</label>
          <input name="passwd" type="password" class="form-control" placeholder="Password">
          <p style="color: #999"> Captcha</p>
          <img src="http://kuliahdaring.stiesemarang.ac.id/capcay.php" />
          <input style="    width: 160px;    float: right;" name="ccek" placeholder="Verifikasi" class="form-control" type="text"
          />
          <div id="remember" class="checkbox">
          </div>
          <button class="btn btn-lg btn-primary btn-block btn-signin" type="submit" value="Login">Login</button>
        </form>
        <!-- /form -->
        <a href="#" class="forgot-password">Lupa Password? </a>

      </div>
      <!-- /card-container -->
    </div>
  </div>
  <!-- /container -->
  
  <footer>
    <div class="text-center" style="color: #333;">
      <p>Sistem Informasi Akademik</p>
      <p style="font-weight:bold;color: #0282c6;"><a href="http://sd-alazhar29.sch.id/" target="_blank">SD Islam Al Azhar BSB 29  Semarang</a></p>
      <p>Copyright © 2017</p>
    </div>
  </footer>

</body>

</html>

<script type="text/javascript">
  $(document).ready(function () {
    $('#myCarousel').carousel({
      interval: 4000
    });

    var clickEvent = false;
    $('#myCarousel').on('click', '.nav a', function () {
      clickEvent = true;
      $('.nav li').removeClass('active');
      $(this).parent().addClass('active');
    }).on('slid.bs.carousel', function (e) {
      if (!clickEvent) {
        var count = $('.nav').children().length - 1;
        var current = $('.nav li.active');
        current.removeClass('active').next().addClass('active');
        var id = parseInt(current.data('slide-to'));
        if (count == id) {
          $('.nav li').first().addClass('active');
        }
      }
      clickEvent = false;
    });
  });
</script>