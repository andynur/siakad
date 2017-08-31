<ul class="sidebar-menu" id="activeMenu">
    <li class="header" style="color: white">
      <h5><i class="fa fa-fw fa-bookmark"></i> {{nama_area}}</h5>
    </li>

    <li>
      <a href="#" onclick="return reload_page2('dashboard/home')" >
        <i class="fa fa-dashboard"></i> <span>Dashboard</span>
      </a>
    </li>
    <?php 
      date_default_timezone_set('Asia/Jakarta');
      $date = new DateTime();

      $time = $date->format('U');
      $link_log = BASE_URL."syslog/logAktifitasUser";
      $area = $this->session->get('ps_id');
      $nama = $this->session->get('nama');
      $id_jenis = $this->session->get('id_jenis');
      $nip = $this->session->get('nip');

      function loop($menu)
      {
        foreach ($menu as $key => $value) {
          if (!empty($value['child'])) {

            echo "<li class=\"treeview\">
            <a href=\"javascript:void(0)\" >

              <i class=\"fa ".$value['icon']."\"></i> 
              <span>".$value['label_menu']."</span> 
              <i class=\"fa fa-angle-left pull-right\"></i>
              
            </a>
            <ul class=\"treeview-menu\"> ";
              loop($value['child']);
            echo "</ul>
          </li> ";
          }else{
            echo "<li><a href=\"javascript:void(0)\" class=\"historyAPI\" onclick=\"return load_page2('".$value['controller'].'/'.$value['action']."')\" ><i class=\"fa ".$value['icon']."\"></i> <span>".$value['label_menu']."</span></a>";
          }
        }
      }

    ?>
    <?php loop($menu); ?>    

    <li class="header">Kembali</li>     
  	<li>
      <a href="javascript:void(0)" onclick="back_menu()">
        <i class="fa fa-circle-o text-yellow"></i> <span>Pilih Area</span>
      </a>
    </li>         
    
  </ul>