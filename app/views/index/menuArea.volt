<ul class="sidebar-menu" style="padding-bottom: 3em;">
  <li class="header">PILIH AREA </li>
  <?php foreach ($menuArea as $key => $value): ?>  	
  <li><a href="javascript:void(0)" class="menuArea" onclick="menu('<?= $value['id'] ?>','<?= $value['ps_id'] ?>','<?= $value['label_menu'] ?>')"><i class="fa fa-circle-o text-aqua"></i> <span><?= $value['label_menu'] ?></span></a></li>   
  <?php endforeach ?>  
</ul>

