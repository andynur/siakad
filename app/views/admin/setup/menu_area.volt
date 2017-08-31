<section class="content-header">
  <h1>
    Web Area
    <small>it all starts here</small>
  </h1>
  <ol class="breadcrumb">
    <li><a href="#"><i class="fa fa-dashboard"></i> Setup</a></li>
    <li class="active">Menu Area</li>
  </ol>
</section>

<!-- Main content -->
<section class="content">
  <div class="row">
    <!-- left column -->
    <div class="col-md-5">
      <div class="box">
        <div class="box-header with-border">
          <h3 class="box-title">Form Web Area</h3>
        </div><!-- /.box-header -->
        <!-- form start -->
        <div class="form">
          <div class="box-body">
            <div class="row">
              <div class="col-lg-8">
                  <label>Nama Area</label>
                  <input type="text" id="nama_area" placeholder="Area" class="form-control">
              </div><!-- /.col-lg-6 -->
              <div class="col-lg-4">
                  <label>Aktif</label>
                  <select class="form-control" id="aktif">
                    <option value="Y">Ya</option>
                    <option value="N">Tidak</option>
                  </select>
              </div><!-- /.col-lg-6 -->
            </div><br>

            <div class="row">
              <div class="col-lg-12">
                <label>Usergroup</label>
                <select id="usergroup" class="form-control select2" multiple="multiple" data-placeholder="Select a State" style="width: 100%;">
	              <?php foreach ($usergroup as $key => $value): ?>
	                <option value="<?= $value['id'] ?>"><?= $value['nama'] ?></option>            
	              <?php endforeach ?>
	            </select>
              </div><!-- /.col-lg-6 -->
            </div><br>
            <div class="row">
              <div class="col-lg-10">
                  <label>Program Studi</label>
                  <select class="form-control" id="ps_id">
                    {% for v in ps %}
                      <option value="ps-{{v.id_ps}}">Program studi-{{v.nama}}-{{v.id_ps}}</option>
                    {% endfor %}

                    {% for v in fakultas %}
                      <option value="fak-{{v.id_fakultas}}">Fakultas-{{v.nama}}-{{v.id_fakultas}}</option>
                    {% endfor %}
                  </select>
              </div>
            </div>

          </div><!-- /.box-body -->
          <div class="box-footer">
            <button type="submit" onclick="add_group()" class="btn btn-info pull-right">Tambah</button>
          </div><!-- /.box-footer -->
        </div>
      </div><!-- /.box -->
    </div>


    <div class="col-md-7">
      <div class="box">
        <div class="box-header">
          <h3 class="box-title">Data Table With Full Features</h3>
        </div><!-- /.box-header -->
        <div class="box-body">
          <table id="example2" class="table table-bordered table-striped">
            <thead>
              <tr>
                <th style="width: 10px">No</th>
                <th style="">Id Group</th>
                <th>Nama Area</th>
                <th>ps/fak id</th>
                <th>Aktif</th>
                <th>Aksi</th>
              </tr>
            </thead>
            <tbody>
            
            {% set no=1 %}
            {% for v in area %}
            <tr>
              <td>{{no}}</td>
              <td><span class="badge bg-green">{{v.id}}</span></td>
              <td>{{v.label_menu}}</td>
              <td><span data-toggle="tooltip" data-placement="bottom" title="{{v.ps_id}}">{{v.ps_id}}</span></td>
              <td>
                {% if v.aktif === "Y" %}
                  <span class="badge bg-green">{{v.aktif}}</span>
                {% else %}
                  <span class="badge bg-red">{{v.aktif}}</span>
                {% endif %}
              </td>
              <td>
                <a id="edit" class="btn btn-primary btn-xs btn-flat" data-toggle="modal" data-target="#myModal{{v.id}}"><i class="glyphicon glyphicon-edit"></i> </a>
                  <!-- Modal -->
                  <div class="modal fade" id="myModal{{v.id}}" role="dialog">
                    <div class="modal-dialog">
                    
                      <!-- Modal content-->
                      <div class="modal-content">
                        <div class="modal-header">
                          <button type="button" class="close" data-dismiss="modal">&times;</button>
                          <h4 class="modal-title">Edit Data</h4>
                        </div>
                        <div class="modal-body" style="  border: 1px solid #eee;  width: 80%; margin: 0 auto;">
                          <div class="form">
                            <div class="box-body">
                              <div class="row">
                                <div class="col-lg-8">
                                    <label>Nama Area</label>
                                    <input type="text" id="nama_area{{v.id}}" style="width: 70%;" value="{{v.label_menu}}" placeholder="Area" class="form-control">
                                </div><!-- /.col-lg-6 -->
                                <div class="col-lg-4">
                                    <label>Aktif</label>
                                    <select class="form-control" id="aktif{{v.id}}">
                                      <option value="Y">Ya</option>
                                      <option value="N">Tidak</option>
                                    </select>
                                </div><!-- /.col-lg-6 -->
                              </div><br>

                              <div class="row">
                                <div class="col-lg-12">
                                  <label>Usergroup </label>
                                  <select id="usergroup{{v.id}}" class="form-control select2" multiple="multiple" data-placeholder="Select a State" style="width: 100%;">
                                  <?php $r = array_filter(explode(',', $v->usergroup_id));?>
                                  <?php foreach ($usergroup as $key => $value): ?>
                                  <?php if (in_array($value['id'], $r)): ?>
                                    <option value="<?= $value['id'] ?>" selected><?= $value['nama'] ?></option>            
                                  <?php else: ?>
                                    <option value="<?= $value['id'] ?>"><?= $value['nama'] ?></option>            
                                  <?php endif ?>
                                  <?php endforeach ?>
                                </select>
                                </div><!-- /.col-lg-6 -->
                              </div><br>
                              <div class="row">
                                 <div class="col-lg-7">
                                    <label>Program Studi</label>
                                    <select class="form-control" id="ps_id{{v.id}}">
                                      {% for val in ps %}
                                      {% if v.ps_id == val.id_ps %}
                                        <option value="ps-{{val.id_ps}}" selected>{{val.nama}}</option>
                                      {% else %}
                                        <option value="ps-{{val.id_ps}}">{{val.nama}}</option>
                                      {% endif %}
                                      {% endfor %}

                                      {% for val in fakultas %}
                                      {% if v.ps_id == val.id_fakultas %}
                                        <option value="fak-{{val.id_fakultas}}" selected>{{val.nama}}</option>
                                      {% else %}
                                        <option value="fak-{{val.id_fakultas}}">{{val.nama}}</option>
                                      {% endif %}
                                      {% endfor %}
                                    </select>
                                </div>
                              </div>

                            </div><!-- /.box-body -->
                          </div>
                        </div>
                        <div class="modal-footer">
                          <button type="button" onclick="edit_group('{{v.id}}')" class="btn btn-info">Edit</button>
                          <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                        </div>
                      </div>
                      
                    </div>
                  </div>
                <a id="delete" onclick="del_data('{{v.id}}')" class="btn btn-danger btn-xs btn-flat"><i class="glyphicon glyphicon-trash"></i></a> 
              </td>
            </tr>
            {% set no=no+1 %}
            {% endfor %}

            </tbody>            
          </table>
        </div><!-- /.box-body -->
      </div><!-- /.box -->
    </div>
  </div>
      
</section><!-- /.content -->

<script type="text/javascript">
	$(function () {
    $('[data-toggle="tooltip"]').tooltip()
		$(".select2").select2();

    $('#example2').DataTable({
        "paging": true,
        "lengthChange": true,
        "searching": true,
        "ordering": true,
        "info": true,
        "autoWidth": true
      });
	});

  function del_data(id) {
    var link = "<?= BASE_URL ?>adminsetup/deleteArea/"+id;
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
          reload_page2('adminsetup/webArea');
      });
    }).on('pnotify.cancel', function() {
       console.log('batal');
    });
  }

  

  function edit_group(id) {
      var nama_area = $("#nama_area"+id).val();
      var aktif = $("#aktif"+id).val();
      var usergroup = $("#usergroup"+id).val();
      var ps_id = $("#ps_id"+id).val();

      if (usergroup == '' || usergroup == null) {
          new PNotify({
               title: 'Regular Notice',
               text: 'Usergroup tidakboleh kosong.',
               type:'warning'
           });
      }else{
        var datas = "nama_area="+nama_area+"&aktif="+aktif+"&usergroup="+usergroup+"&ps_id="+ ps_id;
        var urel = '{{ url("adminsetup/editWebArea/") }}'+id;
        $.ajax({
           type: "POST",
           url: urel,
           dataType : "json",
           data: datas
        }).done(function( data ) {
          console.log(data);
          $('#myModal'+id).modal('hide');
          $('body').removeClass('modal-open');
          $("body").css("padding-right", "0px");
          $('.modal-backdrop').remove();
          
          new PNotify({
            title: data.title,
            text: data.text,
            type: data.type
          });
          reload_page2('adminsetup/webArea');
        });
      }
  }

  function add_group() {
    var nama_area = $("#nama_area").val();
    var aktif = $("#aktif").val();
    var usergroup = $("#usergroup").val();
    var ps_id = $("#ps_id").val();
  	if (usergroup == '' || usergroup == null) {
      new PNotify({
           title: 'Regular Notice',
           text: 'Usergroup tidak boleh kosong',
           type:'warning'
      });
  	}else{
	    var datas = "nama_area="+nama_area+"&aktif="+aktif+"&usergroup="+usergroup+"&ps_id="+ ps_id;
	    var urel = '{{ url("adminsetup/submitWebArea") }}';
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
        reload_page('adminsetup/webArea','webArea');
	    });
  	}

  }
</script>