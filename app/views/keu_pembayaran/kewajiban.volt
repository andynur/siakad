<section class="content-header">
  <h1>
    <button type="button" onclick="back('{{thn_akd}}','{{session_id}}')" class="btn bg-navy btn-flat margin"><i class="fa fa-fw fa-arrow-left"></i> Back</button>
  </h1>
  <ol class="breadcrumb">
    <li><a href="#"><i class="fa fa-dashboard"></i> Setup</a></li>
    <li class="active">Angkatan</li>
  </ol>
</section>

<!-- Main content -->
<section class="content">
  <div class="row">
    <!-- left column -->
    <div class="col-md-12">
      <div class="box">
        <div class="box-header with-border">
          <h3 class="box-title text-navy">DEFINISI PRASYARAT PEMBAYARAN</h3>
        </div><!-- /.box-header -->
        <div class="box-body">
        <table id="example3" class="table table-bordered table-striped">
            <thead>
              <tr>
                <th style="width: 10px">ID</th>
                <th>Mahasiswa</th>
                <th>Kode Kewajiban</th>
                <th>Nama Kewajiban</th>
                <th>Hapus</th>
              </tr>
            </thead>
            <tbody>
            
            {% for v in data_kwjb %}
            <tr>
              <td>{{v.def_id}}</td>
              <td>
                <a href="#" data-toggle="modal" data-target="#myModal{{v.def_id}}"> {{v.targetmhs}}</a>
              </td>
              <td>{{v.kode_byr}}</td>
              <td><?= $nama_defkwjb[$v->kode_byr] ?></td>
              <td>
              <a id="delete" onclick="del_data('{{v.def_id}}')" class="btn btn-danger btn-xs btn-flat"><i class="glyphicon glyphicon-trash"></i></a>
              </td>
               <!-- Modal -->
                  <div class="modal fade" id="myModal{{v.def_id}}" role="dialog">
                    <div class="modal-dialog">
                    
                      <!-- Modal content-->
                      <div class="modal-content">
                        <div class="modal-header">
                          <button type="button" class="close" data-dismiss="modal">&times;</button>
                          <h4 class="modal-title">Edit Data</h4>
                        </div>
                        <div class="modal-body" style="  border: 1px solid #eee;  width: 80%; margin: 0 auto;">
                          <div class="form">
                            <form id="edit_data{{v.def_id}}" method="post">
                              <div class="box-body">
                        <div class="row">
                          <div class="col-lg-12">
                              <label>Nama Kewajiban</label><br>
                              <select form="edit_data{{v.def_id}}" name="kode_byr" class="form-control">
                                <?php foreach ($nama_defkwjb as $key => $value): ?>
                                  <?php if ($key == $v->kode_byr): ?>
                                    <option selected= value="<?= $key ?>"><?= $value ?></option>
                                  <?php else: ?>
                                    <option value="<?= $key ?>"><?= $value ?></option>
                                  <?php endif ?>
                                <?php endforeach ?>
                              </select>
                          </div>
                          <div class="col-lg-12">
                              <label>Mahasiswa</label><br>
                              <input type="text" form="edit_data{{v.def_id}}" name="targetmhs" value="{{v.targetmhs}}" class="form-control">
                          </div>
                        </div>
                              </div><!-- /.box-body -->
                            </form>
                          </div>
                        </div>
                        <div class="modal-footer">
                          <button type="button" onclick="edit_data('{{v.def_id}}')" class="btn btn-info">Edit</button>
                          <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                        </div>
                      </div>
                      
                    </div>
                  </div>
              
            </tr>
            {% endfor %}

            </tbody>            
          </table>
      </div>
      </div><!-- /.box -->
    </div>


    <div class="col-md-12">
      <div class="box">
        <div class="box-header">
          <h3 class="box-title text-green">TAMBAH DEFINISI PRASYARAT PEMBAYARAN</h3>
        </div><!-- /.box-header -->
        <div class="box-body">
          <table id="example2" class="table table-bordered table-striped">
            <thead>
              <tr>
                <th style="width: 10px">No</th>
                <th>Sesi Keu</th>
                <th>Mulai</th>
                <th>Selesai</th>
              </tr>
            </thead>
            <tbody>
            <?php $no=1; foreach ($ses as $key => $v): ?>
            <tr>
              <td><?= $no ?></td>
              <td>
                <a href="#" data-toggle="modal" data-target="#modall{{no}}"> <?= $v['keu_thn'] ?> <?= $v['keu_ses_nm'] ?></a> 
                <a href="javascript:void(0)" onclick="add_data_download('<?= $v['keu_thn'] ?>','<?= $v['keu_ses_id'] ?>','<?= $v['keu_ses_nm'] ?>')"><span class="text-green">[Download]</span></a>
              <!-- Modal -->
                  <div class="modal fade" id="modall{{no}}" role="dialog">
                    <div class="modal-dialog">
                    
                      <!-- Modal content-->
                      <div class="modal-content">
                        <div class="modal-header">
                          <button type="button" class="close" data-dismiss="modal">&times;</button>
                          <h4 class="modal-title">Edit Data</h4>
                        </div>
                        <div class="modal-body" style="  border: 1px solid #eee;  width: 80%; margin: 0 auto;">
                          <div class="form">
                            <form id="add_data{{no}}" method="post">
                              <div class="box-body">
                        <div class="row">
                          <div class="col-lg-12">
                              <label>Nama Kewajiban</label><br>
                              <select form="add_data{{no}}" name="kode_byr" class="form-control">
                                <?php foreach ($nama_defkwjb as $a => $b): ?>
                                    <option value="<?= $a ?>"><?= $b ?></option>
                                <?php endforeach ?>
                              </select>
                          </div>
                          <div class="col-lg-12">
                              <label>Mahasiswa</label><br>
                              <input type="text" form="add_data{{no}}" name="targetmhs" class="form-control">
                              <input type="text" form="add_data{{no}}" value="{{thn_akd}}" name="thn_akd" style="display: none;">
                              <input type="text" form="add_data{{no}}" value="{{session_id}}" name="session_id" style="display: none;">
                              <input type="text" form="add_data{{no}}" value="<?= $v['keu_thn'] ?>" name="keu_thn" style="display: none;">
                              <input type="text" form="add_data{{no}}" value="<?= $v['keu_ses_id'] ?>" name="keu_ses_id" style="display: none;">
                          </div>
                        </div>
                              </div><!-- /.box-body -->
                            </form>
                          </div>
                        </div>
                        <div class="modal-footer">
                          <button type="button" onclick="add_data('{{no}}')" class="btn btn-info">Tambah</button>
                          <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                        </div>
                      </div>
                      
                    </div>
                  </div>
              </td>              
              <td><?= $v['mulai_dttm'] ?></td>
              <td><?= $v['selesai_dttm'] ?></td>
            </tr>
            <?php $no++; endforeach ?>

            </tbody>            
          </table>
        </div><!-- /.box-body -->
      </div><!-- /.box -->
    </div>
  </div>
      
</section><!-- /.content -->

<script type="text/javascript">

function back(thn_akd,session_id) {
    var link = '{{ url("manajemensesi/viewSession/") }}';
    var datas = "thn_akd="+thn_akd+"&session_id="+session_id;
    go_page_data(link,datas);
}


function reload() {
    thn_akd = "{{thn_akd}}";
    session_id = "{{session_id}}";
    var link = '{{ url("keupembayaran/kewajibanPembayaran/") }}';
    var datas = "thn_akd="+thn_akd+"&session_id="+session_id;
    reload_page_data(link,datas);
}

$(function () {
  $('#example2').DataTable({
      "paging": true,
      "searching": true
    });
});


function add_data_download(keu_thn,keu_ses_id,keu_ses_nm) {
    (new PNotify({
        title: 'Confirmation Needed',
        text: 'Apakah Anda Yakin Menambahkan data <br/> <b>Sesi '+keu_thn+' '+keu_ses_nm+'</b>',
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
        var datas = "keu_thn="+keu_thn+"&keu_ses_id="+keu_ses_id+"&thn_akd="+thn_akd+"&session_id="+session_id;
        var urel = '{{ url("keupembayaran/addDefkwjbDownload") }}';
        $.ajax({
           type: "POST",
           url: urel,
           dataType : "json",
           data: datas
        }).done(function( data ) {
          new PNotify({
            title: data.title,
            text: data.text,
            type: data.type
          });
          reload();
        });
    }).on('pnotify.cancel', function() {
       console.log('batal');
    });

}

function add_data(no) {
	var datas = $('#add_data'+no).serialize();
  var urel = '{{ url("keupembayaran/addDefkwjb") }}';
  $.ajax({
     type: "POST",
     url: urel,
     dataType : "json",
     data: datas
  }).done(function( data ) {
    $('#modall'+no).modal('hide');
    $('body').removeClass('modal-open');
    $("body").css("padding-right", "0px");
    $('.modal-backdrop').remove();
  	new PNotify({
      title: data.title,
      text: data.text,
      type: data.type
    });
  	reload();
  });
}

function edit_data(id) {

	var datas = $('#edit_data'+id).serialize();
  var urel = '{{ url("keupembayaran/editDefkwjb/") }}'+id;

	$.ajax({
	   type: "POST",
	   url: urel,
	   dataType : "json",
	   data: datas
	}).done(function( data ) {
	  $('#myModal'+id).modal('hide');
	  $('body').removeClass('modal-open');
	  $("body").css("padding-right", "0px");
	  $('.modal-backdrop').remove();
	  
	  new PNotify({
	    title: data.title,
	    text: data.text,
	    type: data.type
	  });
	  reload();
	});
}

function del_data(id) {
    var link = "<?= BASE_URL ?>keupembayaran/delDefkwjb/"+id;
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
        $.ajax({
         type: "GET",
         url: link,
         dataType : "json",
      }).done(function( data ) {
          new PNotify({
             title: 'Regular Notice',
             text: 'data telah dihapus',
             type:'success'
          });
          reload();
      });
    }).on('pnotify.cancel', function() {
       console.log('batal');
    });
  }

</script>