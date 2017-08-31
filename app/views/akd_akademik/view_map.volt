<section class="content-header">
  <h1>
    <button type="button" onclick="back()" class="btn bg-navy btn-flat"><i class="fa fa-fw fa-arrow-left"></i> Back</button>
  </h1>
  <ol class="breadcrumb" style="top: 5px;    padding: 0px 5px;">
    <li class="box-title text-navy"><h4>PEMETAAN KURIKULUM {{ps_idA}}/{{kurA}} KE KURIKULUM {{ps_idB}}/{{kurB}}</h4></li>
  </ol>
</section>

<!-- Main content -->
<section class="content">
  <div class="row">

<div class="col-md-3"></div>
<div class="col-md-3">
  <button type="button" onclick="manual_pemetaan('{{ps_idA}}/{{kurA}}','{{kurB}}')" class="btn bg-navy btn-flat pull-right"><i class="fa fa-fw fa-file-powerpoint-o"></i>PEMETAAN BARU</button>
</div>
<div class="col-md-3">
  <button type="button" onclick="auto_pemetaan('{{ps_idA}}/{{kurA}}','{{kurB}}')" class="btn bg-navy btn-flat"><i class="fa fa-fw fa-clone"></i>PEMETAAN OTOMATIS</button>
</div>
<div class="col-md-3"></div>
<hr>

<div class="col-md-12">
  <div class="box">
    <div class="box-header" style="text-align: center;">
      <h2 class="box-title text-green">MATA KULIAH YANG SUDAH DIPETAKAN :</h2>
    </div>
    <div class="box-body">
    	<table class="table table-bordered table-striped" style="font-size: 13px;">
        <tbody>
          <tr>
            <th style="width: 10px">No</th>
            <th class="text-center">Kurikulum {{ps_idA}}/{{kurA}}</th>
            <th class="text-center">Kurikulum {{ps_idB}}/{{kurB}}</th>

          </tr>
          <?php $no=1; foreach ($map as $key => $value): ?>
          <?php if ($value['mkA0'] != '' ) {$br = "<br/>";} else {$br = "";}?>
          <?php if ($value['mkA1'] != '' ) {$br2 = "<br/>";} else {$br2 = "";}?>
          <?php if ($value['mkB0'] != '' ) {$br3 = "<br/>";} else {$br3 = "";}?>
          <?php if ($value['mkB1'] != '' ) {$br4 = "<br/>";} else {$br4 = "";}?>
          <tr>
            <td><?= $no ?></td>
            <td>
              <b><?=$value['mkA0']?></b> 
              <a href="javascript:void(0)" onclick="edit_pemetaan('<?=$value['map_id']?>')">
                <?=$value['nama_mkA0']?>
              </a>  <?= $br ?>

              <b><?= $value['mkA1'] ?></b> 
              <a href="javascript:void(0)" onclick="edit_pemetaan('<?=$value['map_id']?>')">
                <?=$value['nama_mkA1']?>
              </a> <?= $br2 ?>

              <b><?= $value['mkA2'] ?></b> <?=$value['nama_mkA2']?>
            </td>
            <td>
              <b><?=$value['mkB0']?></b> 
              <a href="javascript:void(0)" onclick="edit_pemetaan('<?=$value['map_id']?>')">
                <?=$value['nama_mkB0']?>
              </a>  <?= $br3 ?>

              <b><?= $value['mkB1'] ?></b>
               <a href="javascript:void(0)" onclick="edit_pemetaan('<?=$value['map_id']?>')">
                <?=$value['nama_mkB1']?>
              </a> <?= $br4 ?>

              <b><?= $value['mkB2'] ?></b> <?=$value['nama_mkB2']?>
            </td>
          </tr>
          <?php $no++; endforeach ?>
        </tbody>
      </table>
    </div>
  </div>
</div>

<div class="col-md-6">
  <div class="box">
    <div class="box-header" style="text-align: center;">
      <h2 class="box-title text-red">Mata kuliah ({{ps_idA}}/{{kurA}}) yang belum terpetakan:</h2>
    </div>
    <div class="box-body">
      <table class="table table-bordered table-striped" style="font-size: 11px;">
        <tbody>
          <tr>
            <th style="width: 10px">No</th>
            <th>Kode MK</th>
            <th>Nama MK</th>
            <th style="width: 40px">W/P</th>
            <th style="width: 40px">Kelp.</th>
          </tr>
          <?php $no=1; foreach ($MKA as $key => $value): ?>
          <?php $explode = explode('/', $value) ?>
          <tr>
            <td><?= $no ?></td>
            <td><?= $key ?></td>
            <td><?= $explode[0] ?></td>
            <td><span class="badge bg-navy"><?= $explode[1] ?></span></td>
            <td><?= $explode[2] ?></td>
          </tr>
          <?php $no++; endforeach ?>
        </tbody>
      </table>
    </div>
  </div>
</div>

<div class="col-md-6">
  <div class="box">
    <div class="box-header" style="text-align: center;">
      <h2 class="box-title text-red">Mata kuliah ({{ps_idB}}/{{kurB}}) yang belum terpetakan:</h2>
    </div>
    <div class="box-body">
    	<table class="table table-bordered table-striped" style="font-size: 11px;">
        <tbody>
          <tr>
            <th style="width: 10px">No</th>
            <th>Kode MK</th>
            <th>Nama MK</th>
            <th style="width: 40px">W/P</th>
            <th style="width: 40px">Kelp.</th>
          </tr>
          <?php $no=1; foreach ($MKB as $key => $value): ?>
          <?php $explode = explode('/', $value) ?>
          <tr>
            <td><?= $no ?></td>
            <td><?= $key ?></td>
            <td><?= $explode[0] ?></td>
            <td><span class="badge bg-navy"><?= $explode[1] ?></span></td>
            <td><?= $explode[2] ?></td>
          </tr>
          <?php $no++; endforeach ?>
        </tbody>
      </table>
  </div>
</div>


  </div><!-- /.row -->
</section><!-- /.content -->


<script type="text/javascript">

function back() {
    var back = '{{ url("akademik/pemetaanKurikulum") }}';
    go_page(back);
}

function manual_pemetaan(asal,tujuan) {
  var datas = "asal="+asal+"&tujuan="+tujuan;
  var link = '{{ url("akademik/pemetaanManual/") }}';
  go_page_data(link,datas);
}

function edit_pemetaan(map_id) {
  var link = '{{ url("akademik/editPemetaan/") }}'+map_id;
  go_page(link);
}

function auto_pemetaan(asal,tujuan) {
    (new PNotify({
        title: 'Confirmation Needed',
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
    })).get().on('pnotify.confirm', function() {
        var datas = "asal="+asal+"&tujuan="+tujuan;
        var link = '{{ url("akademik/autoPemetaan/") }}';
        $.ajax({
            type: "POST",
            dataType: "JSON",
            url: link,
            data: datas,
            success: function(data){ 
                var urel = '{{ url("akademik/vewMap/") }}';
                go_page_data(urel,datas);
            }
        });
    }).on('pnotify.cancel', function() {
       console.log('batal');
    });

}



</script>

<style type="text/css">
.navbar .navbar-nav {
    display: inline-block;
    float: none;
}

.navbar .navbar-collapse {
    text-align: center;
}
</style>

