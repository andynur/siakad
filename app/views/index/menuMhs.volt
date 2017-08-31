<ul class="sidebar-menu">
    <li class="header">MAIN NAVIGATION </li>

    <li><a href="<?= BASE_URL ?>/" class="historyAPI" onclick="return load_page2('index/index2')"><i class="fa fa-dashboard"></i> <span>Dashboard</span></a></li>
    <?php 

    // echo "<pre>".print_r($menu,1)."</pre>";

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
    
  </ul>