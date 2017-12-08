<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <title>SISKO SMA Al Azhar 16 BSB City Semarang</title>
  <!-- favicon  -->
  <link rel="icon" href="img/favicon.png" sizes="32x32" />
  <link rel="icon" href="img/favicon.png" sizes="192x192" />
  <link rel="apple-touch-icon-precomposed" href="img/favicon.png" />
  <meta name="msapplication-TileImage" content="img/favicon.png" />
  <!-- Tell the browser to be responsive to screen width -->
  <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
  <!-- Bootstrap 3.3.6 -->
  <link rel="stylesheet" href="bootstrap/css/bootstrap.min.css">
  <!-- Font Awesome -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.5.0/css/font-awesome.min.css">
  <!-- Ionicons -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/ionicons/2.0.1/css/ionicons.min.css">
  <!-- DataTables -->
  <link rel="stylesheet" href="plugins/datatables/dataTables.bootstrap.css">
  <link rel="stylesheet" href="https://cdn.datatables.net/buttons/1.2.4/css/buttons.bootstrap.min.css">
  
   <!-- bootstrap datepicker -->
  <link rel="stylesheet" href="plugins/datepicker/datepicker3.css">
  <link rel="stylesheet" href="plugins/timepicker/bootstrap-timepicker.min.css">
  <!-- Theme style -->
  <link rel="stylesheet" href="plugins/select2/select2.min.css">
  <!-- AdminLTE Skins. Choose a skin from the css/skins
       folder instead of downloading all of them to reduce the load. -->
  <link rel="stylesheet" href="css/skins/_all-skins.min.css">
  <!-- <link rel="stylesheet" href="https://cdn.datatables.net/buttons/1.2.4/css/buttons.dataTables.min.css"> -->
  <link rel="stylesheet" href="css/asilah.css">
  <link rel="stylesheet" href="css/AdminLTE.css">
  <style type="text/css">
    /*.modal-backdrop {
      z-index: -1 !important;
      }*/
  </style>
  <link rel="stylesheet" href="plugins/notify/pnotify.custom.min.css">
  <link rel="stylesheet" href="plugins/notify/animate.css">

  {{ javascript_include("plugins/jQuery/jquery-2.2.4.min.js") }}
  {{ javascript_include("js/asilah.js") }}

  </head>
  <!-- <body onload="StartTimers();" onmousemove="ResetTimers();" class=" skin-purple hold-transition skin-blue sidebar-mini"> -->
  <body class=" skin-yellow hold-transition fixed sidebar-mini">

    <!-- Site wrapper -->
    <div class="wrapper">

      <header class="main-header">
        <!-- Logo -->
        <a class="logo">
          <!-- mini logo for sidebar mini 50x50 pixels -->
          <span class="logo-mini"><b>SI</b>A</span>
          <!-- logo for regular state and mobile devices -->
          <span class="logo-lg"><b>SISKO SMA</b> Al Azhar</span>
        </a>
        <!-- Header Navbar: style can be found in header.less -->
        <nav class="navbar navbar-static-top" role="navigation">
          <!-- Sidebar toggle button-->
          <a href="#" class="sidebar-toggle" data-toggle="offcanvas" role="button">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </a>
          <div class="navbar-custom-menu">
            <ul class="nav navbar-nav">
              <!-- User Account: style can be found in dropdown.less -->
              <li class="dropdown user user-menu">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                  <?php if ($this->session->get('id_jenis') == 1): ?>
                  <img class="user-image" src="<?= PUBLIC_URL ?>img/sdm/<?= $this->session->get('foto'); ?>" alt="User Avatar" onerror="imageError(this)">
                  <?php else: ?>
                  <img class="user-image" src="<?= PUBLIC_URL ?>img/mhs/<?= $this->session->get('foto'); ?>" alt="User Avatar" onerror="imageError(this)">
                  <?php endif ?>
                  <span class="hidden-xs"><?= $this->session->get('nama'); ?></span>
                </a>
                <ul class="dropdown-menu">
                  <!-- User image -->
                  <li class="user-header">
                    <?php if ($this->session->get('id_jenis') == 1): ?>
                    <img class="img-circle" src="<?= PUBLIC_URL ?>img/sdm/<?= $this->session->get('foto'); ?>" alt="User Avatar" onerror="imageError(this)">
                    <?php else: ?>
                    <img class="img-circle" src="<?= PUBLIC_URL ?>img/mhs/<?= $this->session->get('foto'); ?>" alt="User Avatar" onerror="imageError(this)">
                    <?php endif ?>
                    <p>
                      <?= $this->session->get('nama'); ?> - <?php if ($this->session->get('id_jenis') == 1): ?>
                      SDM
                      <?php else: ?>
                      Mahasiswa
                      <?php endif ?>

                      <small><?=$this->session->get('nip') ?></small>
                    </p>
                  </li>
                  <!-- Menu Body -->
                  <li class="user-body">

                    <div class="col-xs-12 text-center">
                      <!-- <a href="#" onclick="return load_page2('user/gantiLogin')">Ubah Akun Login</a> -->
                      Selamat Datang di Web SISKO <br/> SMA Al Azhar 16 BSB City Semarang
                    </div>

                  </li>
                  <!-- Menu Footer-->
                  <li class="user-footer">
                    <div class="pull-left">
                      <!-- <a href="#" onclick="return load_page2('user/profil')" class="btn 
                      btn-default btn-flat">Ubah Profil</a> -->
                      <a href="#" onclick="return load_page2('user/gantiLogin')" class="btn btn-default btn-flat"><i class="fa fa-refresh"></i> Ubah Akun</a>
                    </div>
                    <div class="pull-right">
                      <a href="account/logout" class="btn btn-default btn-flat"><i class="fa fa-sign-out"></i> Keluar</a>
                    </div>
                  </li>
                </ul>
              </li>
              <!-- Control Sidebar Toggle Button -->
              <li>
                <a href="{{ baseUri }}" data-toggle="tooltip" data-placement="bottom" title="muat ulang halaman"><i class="fa fa-refresh"></i></a>
              </li>
              <li>
                <a href="account/logout" data-toggle="tooltip" data-placement="bottom" title="keluar aplikasi"><i class="fa fa-sign-out"></i></a>
              </li>
            </ul>
          </div>
        </nav>
      </header>

      <!-- =============================================== -->

      <!-- Left side column. contains the sidebar -->
      <aside class="main-sidebar">
        <!-- sidebar: style can be found in sidebar.less -->
        <section class="sidebar">
          <!-- Sidebar user panel -->
          <div class="user-panel">
            <div class="pull-left image">
              <?php if ($this->session->get('id_jenis') == 1): ?>
              <img class="img-circle" src="<?= PUBLIC_URL ?>img/sdm/<?= $this->session->get('foto'); ?>" alt="User Avatar" onerror="imageError(this)">
              <?php else: ?>
              <img class="img-circle" src="<?= PUBLIC_URL ?>img/mhs/<?= $this->session->get('foto'); ?>" alt="User Avatar" onerror="imageError(this)">
              <?php endif ?>
            </div>
            <div class="pull-left info">
              <p class="user-overflow" title="<?= $this->session->get('nama'); ?>"><?= $this->session->get('nama'); ?></p>
              <a href="#"><i class="fa fa-circle text-success"></i> Online</a>
            </div>
          </div>
          <div id="manu">
          
          </div>
        </section>
        <!-- /.sidebar -->
      </aside>

