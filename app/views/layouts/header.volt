<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <title>SIAKAD SD Islam Al-Azhar 29 Semarang</title>
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
  <body class=" skin-red hold-transition sidebar-mini">

    <!-- Site wrapper -->
    <div class="wrapper">

      <header class="main-header">
        <!-- Logo -->
        <a href="{{ baseUri }}" class="logo">
          <!-- mini logo for sidebar mini 50x50 pixels -->
          <span class="logo-mini"><b>SD</b>A</span>
          <!-- logo for regular state and mobile devices -->
          <span class="logo-lg"><b>SIAKAD</b> SD Al Azhar</span>
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
              <!-- Messages: style can be found in dropdown.less-->
              <li class="dropdown messages-menu">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                  <i class="fa fa-envelope-o"></i>
                  <span class="label label-success">1</span>
                </a>
                <ul class="dropdown-menu">
                  <li class="header">Anda memiliki 1 pesan</li>
                  <li>
                    <!-- inner menu: contains the actual data -->
                    <ul class="menu">
                      <li><!-- start message -->
                        <a href="#">
                          <div class="pull-left">
                            <?php if ($this->session->get('id_jenis') == 1): ?>
                            <img class="img-circle" src="<?= PUBLIC_URL ?>img/sdm/<?= $this->session->get('foto'); ?>" alt="User Avatar">
                            <?php else: ?>
                            <img class="img-circle" src="<?= PUBLIC_URL ?>img/mhs/<?= $this->session->get('foto'); ?>" alt="User Avatar">
                            <?php endif ?>
                          </div>
                          <h4>
                            Tim Support
                            <small><i class="fa fa-clock-o"></i> 5 menit</small>
                          </h4>
                          <p>Apa ada masalah direkap data?</p>
                        </a>
                      </li><!-- end message -->
                    </ul>
                  </li>
                  <li class="footer"><a href="#">Lihat semua pesan</a></li>
                </ul>
              </li>
              <!-- Notifications: style can be found in dropdown.less -->
              <li class="dropdown notifications-menu">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                  <i class="fa fa-bell-o"></i>
                  <span class="label label-warning">10</span>
                </a>
                <ul class="dropdown-menu">
                  <li class="header">Anda memiliki 10 notifikasi</li>
                  <li>
                    <!-- inner menu: contains the actual data -->
                    <ul class="menu">
                      <li>
                        <a href="#">
                          <i class="fa fa-users text-aqua"></i> 5 anggota baru bergabung hari ini
                        </a>
                      </li>
                    </ul>
                  </li>
                  <li class="footer"><a href="#">Lihat semua</a></li>
                </ul>
              </li>
              <!-- Tasks: style can be found in dropdown.less -->
              <li class="dropdown tasks-menu">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                  <i class="fa fa-flag-o"></i>
                  <span class="label label-danger">9</span>
                </a>
                <ul class="dropdown-menu">
                  <li class="header">Anda memiliki 9 Tugas</li>
                  <li>
                    <!-- inner menu: contains the actual data -->
                    <ul class="menu">
                      <li><!-- Task item -->
                        <a href="#">
                          <h3>
                            Rekap data siswa
                            <small class="pull-right">20%</small>
                          </h3>
                          <div class="progress xs">
                            <div class="progress-bar progress-bar-aqua" style="width: 20%" role="progressbar" aria-valuenow="20" aria-valuemin="0" aria-valuemax="100">
                              <span class="sr-only">20% Complete</span>
                            </div>
                          </div>
                        </a>
                      </li><!-- end task item -->
                    </ul>
                  </li>
                  <li class="footer">
                    <a href="#">Lihat semua tugas</a>
                  </li>
                </ul>
              </li>
              <!-- User Account: style can be found in dropdown.less -->
              <li class="dropdown user user-menu">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                  <?php if ($this->session->get('id_jenis') == 1): ?>
                  <img class="user-image" src="<?= PUBLIC_URL ?>img/sdm/<?= $this->session->get('foto'); ?>" alt="User Avatar">
                  <?php else: ?>
                  <img class="user-image" src="<?= PUBLIC_URL ?>img/mhs/<?= $this->session->get('foto'); ?>" alt="User Avatar">
                  <?php endif ?>
                  <span class="hidden-xs"><?= $this->session->get('nama'); ?></span>
                </a>
                <ul class="dropdown-menu">
                  <!-- User image -->
                  <li class="user-header">
                    <?php if ($this->session->get('id_jenis') == 1): ?>
                    <img class="img-circle" src="<?= PUBLIC_URL ?>img/sdm/<?= $this->session->get('foto'); ?>" alt="User Avatar">
                    <?php else: ?>
                    <img class="img-circle" src="<?= PUBLIC_URL ?>img/mhs/<?= $this->session->get('foto'); ?>" alt="User Avatar">
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
                      <a href="#" onclick="return load_page2('user/gantiLogin')">Ubah Akun Login</a>
                    </div>

                  </li>
                  <!-- Menu Footer-->
                  <li class="user-footer">
                    <div class="pull-left">
                      <a href="#" onclick="return load_page2('user/profil')" class="btn btn-default btn-flat">Ubah Profil</a>
                    </div>
                    <div class="pull-right">
                      <a href="account/logout" class="btn btn-default btn-flat">Keluar</a>
                    </div>
                  </li>
                </ul>
              </li>
              <!-- Control Sidebar Toggle Button -->
              <li>
                <a href="account/logout"><i class="fa fa-sign-out"></i></a>
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
              <img class="img-circle" src="<?= PUBLIC_URL ?>img/sdm/<?= $this->session->get('foto'); ?>" alt="User Avatar">
              <?php else: ?>
              <img class="img-circle" src="<?= PUBLIC_URL ?>img/mhs/<?= $this->session->get('foto'); ?>" alt="User Avatar">
              <?php endif ?>
            </div>
            <div class="pull-left info">
              <p><?= $this->session->get('nama'); ?></p>
              <a href="#"><i class="fa fa-circle text-success"></i> Online</a>
            </div>
          </div>
          <div id="manu">
          
          </div>
        </section>
        <!-- /.sidebar -->
      </aside>

