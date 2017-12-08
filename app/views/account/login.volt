<!DOCTYPE html>
<html>

<head>
  <meta charset="utf-8">
  <meta http-equiv='Content-Type' content='text/html; charset=iso-8859-1' />
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>SISKO SMP Al Azhar 29 BSB City Semarang</title>
  <!-- favicon  -->
  <link rel="icon" href="../img/favicon.png" sizes="32x32" />
  <link rel="icon" href="../img/favicon.png" sizes="192x192" />
  <link rel="apple-touch-icon-precomposed" href="../img/favicon.png" />
  <meta name="msapplication-TileImage" content="../img/favicon.png" /> 
  <link href="https://fonts.googleapis.com/css?family=Montserrat:400,500" rel="stylesheet">
  {{ stylesheet_link("font-awesome/css/font-awesome.min.css") }} 
  {{ stylesheet_link("bootstrap/css/bootstrap.min.css") }}
  {{ stylesheet_link("css/style2.css") }} 
  {{ stylesheet_link("css/login.css") }} 
  {{ javascript_include("jquery/dist/jquery.min.js") }} 
  {{ javascript_include("bootstrap/dist/js/bootstrap.min.js") }} 
  {{ javascript_include("http://richhollis.github.io/vticker/downloads/jquery.vticker.min.js") }}
</head>

<body>
  <div class="container">
    <!-- Header  -->
    <div class="col-md-12">
      <div class="header">
        <img src="../img/logo.png" class="logo">
        <img src="../img/logo-himsya.png" class="logo">

        <div class="info">
          <h1>SISKO SMP Al Azhar 29 BSB City Semarang</h1>
          <p>Jalan RM. Hadisoebeno Sosro Wardoyo, Mijen, Kedungpane, Jawa Tengah, <br> Kode Pos. 50211, Telepon. 08112799510</p>
        </div>
      </div>
    </div><!-- ./Header  -->
    <div class="col-md-12">
      <!-- Navigation  -->
      <nav class="navbar navbar-inverse">
        <div class="navbar-header">
          <span class="title">Menu</span>
          <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
        </div>
        <div id="navbar" class="collapse navbar-collapse">
          <ul class="nav navbar-nav">
            <li><a href="http://portal.al-azharbsbcity.or.id/">Beranda</a></li>
            <li class="active"><a href="#">SISKO SMP</a></li>
            <li><a href="http://pmb.al-azharbsbcity.or.id/" target="_blank">PMB</a></li>
            <li><a href="http://tkialazhar29.sch.id/" target="_blank">KB-TK</a></li>
            <li><a href="http://sd-alazhar29.sch.id/" target="_blank">SD</a></li>
            <li><a href="http://smpialazhar29.sch.id/" target="_blank">SMP</a></li>
            <li><a href="http://smaialazhar16.sch.id/" target="_blank">SMA</a></li>
          </ul>
          <ul class="nav navbar-nav navbar-right">
            <li><a href="http://portal.al-azharbsbcity.or.id/DownloadApk" target="_blank">Download Apk</a></li>     
          </ul>
        </div><!--/.nav-collapse -->
      </nav><!-- ./Navigation  -->
      <!-- Pengumuman  -->
      <div class="pengumuman">
        <div class="breaking-news">
          <div class="title">
            <h2>Pengumuman</h2>
            <span></span>
          </div>
          <ul>
            {% set teks_berjalan = helper.getBerita('teks_berjalan') %} 
            {% for v in teks_berjalan %}
              <li>
                <?php $teks = strip_tags($v->berita, '<a><strong><em>'); ?>            
                {{ teks }}
              </li>
            {% endfor %}
          </ul>
        </div>

      </div><!-- ./Pengumuman  -->
    </div>
    <!-- Slider  -->
    <div class="col-md-8">
      <div id="slider-container">
        <div id="slider" class="carousel slide">
          <ol class="carousel-indicators">
            {% set slider = helper.getSlider() %} {% set no = 1 %} {% for v in slider %} {% if (no == 1) %}
            <li data-target="#slider" data-slide-to="{{ no }}" class="active"></li>
            {% else %}
            <li data-target="#slider" data-slide-to="{{ no }}"></li>
            {% endif %} {% set no += 1 %} {% endfor %}
          </ol>
          <div class="carousel-inner">
            {% set no = 1 %} {% for v in slider %} {% if (no == 1) %}
            <div class="item active">
              {% else %}
              <div class="item">
                {% endif %}
                <img src="../img/galeri/{{ v.nama }}" class="img-responsive">
                <div class="container">
                  <div class="carousel-caption">
                    <h2>{{ v.judul }}</h2>
                    <p>{{ v.deskripsi }}</p>
                  </div>
                </div>
              </div>
              {% set no += 1 %} {% endfor %}
            </div>
            <!-- Controls -->
            <a class="left carousel-control" href="#slider" data-slide="prev">
              <span class="icon-prev"></span>
            </a>
            <a class="right carousel-control" href="#slider" data-slide="next">
              <span class="icon-next"></span>
            </a>
          </div>
        </div> 
      </div>           
      <!-- ./Slider  -->
      <!-- Form  -->
      <div class="col-md-4">
        <div class="form card card-container">
          <h3>AKUN SISKO SMP</h3>
          <form class="form-signin" action="{{ url('account/loginProses') }}" method="post">
            <div class="form-group">
              <label for="uid">Username</label>
              <input name="uid" type="text" class="form-control" id="uid" placeholder="username">
            </div>
            <div class="form-group">
              <label for="password">Password</label>
              <input name="passwd" type="password" class="form-control" id="password" placeholder="password">
            </div>
            <div class="captcha">
              <label for="captcha">Captcha</label>
              <div class="row">
                <div class="col-md-5">
                  <img src="http://kuliahdaring.stiesemarang.ac.id/capcay.php" />
                </div>
                <div class="col-md-7">
                  <input type="text" name="ccek" placeholder="verifikasi captcha" class="form-control" id="captcha"  />
                </div>
              </div>
            </div>
            <button class="btn btn-lg btn-primary btn-block btn-signin" type="submit" value="Login">Login</button>
          </form>
          <!-- /form -->
          <a href="#" class="forgot-password" onclick="alert('Silahkan kontak admin untuk mereset password.')">Lupa Password? </a>

        </div>
        <!-- /card-container -->
      </div>
      <!-- ./Form  -->

      <div class="col-md-12">
        <footer>
          <p>Sistem Informasi Sekolah</p>
          <p class="link">
            <a href="http://sd-alazhar29.sch.id/" target="_blank">SISKO SMP Al Azhar 29 BSB City Semarang</a>
          </p>
          <p>Copyright © 2017</p>
        </footer>      
      </div>
    </div>
    <!-- /container -->
</body>

</html>

<script type="text/javascript">
  $(document).ready(function () {
    $('.breaking-news').vTicker();

    $('#slider').carousel({
      interval: 4000
    });

    var clickEvent = false;
    $('#slider').on('click', '.nav a', function () {
      clickEvent = true;
      $('#slider .nav li').removeClass('active');
      $(this).parent().addClass('active');
    }).on('slid.bs.carousel', function (e) {
      if (!clickEvent) {
        var count = $('#slider .nav').children().length - 1;
        var current = $('#slider .nav li.active');
        current.removeClass('active').next().addClass('active');
        var id = parseInt(current.data('slide-to'));
        if (count == id) {
          $('#slider .nav li').first().addClass('active');
        }
      }
      clickEvent = false;
    });
  });
</script>