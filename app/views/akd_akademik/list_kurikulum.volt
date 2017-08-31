<section class="content-header">
  <h1>
    <button type="button" onclick="back()" class="btn bg-navy btn-flat"><i class="fa fa-fw fa-arrow-left"></i> Back</button>
  </h1>
  <ol class="breadcrumb">
    <li><a href="#"><i class="fa fa-book"></i> Akademik</a></li>
    <li class="">Kurikulum</li>
    <li class="active">list Kurikulum</li>
  </ol>
</section>

<!-- Main content -->
<section class="content">
  <div class="row">

    <nav class="navbar navbar-default" role="navigation" style="    height: 50px;">
      <!-- Collect the nav links, forms, and other content for toggling -->
      <div class="collapse navbar-collapse navbar-ex1-collapse">
        <ul class="nav navbar-nav">
          <li class="active"><a href="javascript:void(0)" onclick="return go_page('akademik/kurikulum')">KURIKULUM</a></li>
          <li><a href="javascript:void(0)" onclick="return go_page('akademik/pemetaanKurikulum')">PEMETAAN KURIKULUM</a></li>
        </ul>
      </div><!-- /.navbar-collapse -->
    </nav>

<div class="col-md-12">
  <div class="box">
    <div class="box-header with-border">
      <h3 class="box-title">Data Table</h3>
      <div class="pull-right">
      <button type="button" class="btn bg-navy btn-flat" onclick="tambah_data('{{thn_kur}}')"><i class="fa fa-fw fa-plus-square"></i> Tambah {{thn_kur}}</button>
      </div>
    </div><!-- /.box-header -->
    <div class="box-body">
      <table class="table table-bordered">
        <tbody>
        <tr style="    background: #F2F1EF;">
          <th style="width: 10px">No</th>
          <th style="width: 40px">Kode</th>
          <th>Nama</th>
          <th>Sem.</th>
          <th>SKS</th>
          <th>SKS TEORI</th>
          <th>SKS PRAKTEK</th>
          <th>SKS KLINIK</th>
          <th>W/P</th>
          <th>Klp</th>
          <th>Urut</th>
          <th>SAP</th>
          <th>Silabus</th>
          <th>Modul1</th>
          <th>Modul2</th>
          <th>Video</th>
          <th>Del</th>
        </tr>
        {% set no=1 %}
        {% for v in mku %}
	        <tr>
	          <td>{{no}}</td>
            <td class="text-center">{{v.kode_mk}}</td>
	          <td class="text-aqua"><a href="javascript:void(0)" onclick="edit_mku('{{v.id}}')">{{v.nama}}</a></td>
	          <td class="text-center">{{v.semester}}</td>
	          <td class="text-center">{{v.sks}}</td>
	          <td class="text-center">{{v.sks_teori}}</td>
	          <td class="text-center">{{v.sks_praktek}}</td>
	          <td class="text-center">{{v.sks_klinik}}</td>
	          <td class="text-center">{{v.jenis}}</td>
	          <td class="text-center">{{v.kelompok}}</td>
	          <td class="text-center">{{v.urut}}</td>
            <td class="text-center"><a data-toggle="modal" data-target="#sap{{v.id}}" class="btn btn-{% if v.file_sap != "" %}info{% else %}warning{% endif %} btn-xs btn-flat"><i class="fa fa-fw fa-cloud-upload"></i></a> </td>
            <td class="text-center"><a data-toggle="modal" data-target="#silabus{{v.id}}" class="btn btn-{% if v.file_silabus != "" %}info{% else %}warning{% endif %} btn-xs btn-flat"><i class="fa fa-fw fa-cloud-upload"></i></a> </td>
            <td class="text-center"><a data-toggle="modal" data-target="#modul{{v.id}}" class="btn btn-{% if v.file_modul != "" %}info{% else %}warning{% endif %} btn-xs btn-flat"><i class="fa fa-fw fa-cloud-upload"></i></a> </td>
            <td class="text-center"><a data-toggle="modal" data-target="#modul_per_kelas{{v.id}}" class="btn bg-navy btn-xs btn-flat"><i class="fa fa-fw fa-cloud-upload"></i></a> </td>
            <td class="text-center"><a data-toggle="modal" data-target="#modul_video{{v.id}}" class="btn bg-navy btn-xs btn-flat"><i class="fa fa-fw fa-cloud-upload"></i></a> </td>
	          <td class="text-center"><a id="delete" onclick="del('{{v.id}}')" class="btn btn-danger btn-xs btn-flat"><i class="glyphicon glyphicon-trash"></i></a> </td>
	        </tr>

<!-- Modal -->
<div id="modul_per_kelas{{v.id}}" class="modal fade" role="dialog">
  <div class="modal-dialog">

    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">Pilih SESI :</h4>
      </div>
      <div class="modal-body">
      <select style="width:80%;" id="sesi{{v.id}}" class="form-control">
        {% for val in tahun_sesi %}
          <option value="{{val.thn_akd}}-{{val.session_id}}" >{{val.nama}} {{ helper.format_thn_akd(val.thn_akd) }}</option>
        {% endfor %}   
      </select>

      </div>
      <div class="modal-footer">
        <button type="button" onclick="list_kelas('{{v.id}}','{{v.kode_mk}}')" class="btn btn-flat bg-navy margin "><i class="fa fa-fw fa-search"></i> Cari</button>
        <button type="button" class="btn btn-flat btn-default" data-dismiss="modal">Close</button>
      </div>
    </div>

  </div>
</div>

<!-- Modal -->
<div id="modul_video{{v.id}}" class="modal fade" role="dialog">
  <div class="modal-dialog">

    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">Pilih SESI :</h4>
      </div>
      <div class="modal-body">
      <select style="width:80%;" id="sesi{{v.id}}" class="form-control">
        {% for val in tahun_sesi %}
          <option value="{{val.thn_akd}}-{{val.session_id}}" >{{val.nama}} {{ helper.format_thn_akd(val.thn_akd) }}</option>
        {% endfor %}   
      </select>

      </div>
      <div class="modal-footer">
        <button type="button" onclick="list_kelas_video('{{v.id}}','{{v.kode_mk}}')" class="btn btn-flat bg-navy margin "><i class="fa fa-fw fa-search"></i> Cari</button>
        <button type="button" class="btn btn-flat btn-default" data-dismiss="modal">Close</button>
      </div>
    </div>

  </div>
</div>

<!-- Modal -->
  <div class="modal fade" id="sap{{v.id}}" role="dialog">
    <div class="modal-dialog">
    
      <!-- Modal content-->
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal">&times;</button>
          <h4 class="modal-title">Upload SAP {{v.kode_mk}} {{v.nama}}</h4>
        </div>
        <div class="modal-body">
        {% if v.file_sap != "" %}

            <div class="row">
                <div class="col-md-12">
                  <div class="col-md-2"></div>
                    <div class="col-md-6">
                      <div class="form-group">
                        <span for="exampleInputFile">File input :</span>
                        <input style="border: 1px solid;" type="file" id="upload_sap">
                        <p class="help-block text-red">File type : PDF</p>                 
                        <p class="help-block text-red">Max : 10Mb </p>                 
                      </div>
                      <hr>
                      <a href="<?= BASE_URL ?>data/mata_kuliah/SAP/{{v.file_sap}}" target="_blank"><button class="btn btn-block btn-success btn-flat"><i class="fa fa-fw fa-download"></i> Download File SAP</button></a>
                    </div>
                  <div class="col-md-4">
                    <button onclick="upload_sap('{{v.kode_mk}}')" class="pull-left btn bg-navy btn-flat margin">Ganti</button>
                </div>          
              </div>
            </div>


        {% else %}

            <div class="row">
                <div class="col-md-12">
                  <div class="col-md-2"></div>
                  <div class="col-md-6">
                    <div class="form-group">
                        <span for="exampleInputFile">File input :</span>
                        <input style="border: 1px solid;" type="file" id="upload_sap">
                        <p class="help-block text-red">File type : PDF</p>                 
                        <p class="help-block text-red">Max : 10Mb </p>                 
                      </div>
                    </div>
                  <div class="col-md-4">
                  <button onclick="upload_sap('{{v.kode_mk}}')" class="pull-left btn bg-navy btn-flat margin">Upload</button>
                </div>          
              </div>
            </div>

        {% endif %}


        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        </div>
      </div>
      
    </div>
  </div>
<!-- Modal SAP-->

<!-- Modal SILABUS-->
  <div class="modal fade" id="silabus{{v.id}}" role="dialog">
    <div class="modal-dialog">
    
      <!-- Modal content-->
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal">&times;</button>
          <h4 class="modal-title">Upload SILABUS {{v.kode_mk}} {{v.nama}}</h4>
        </div>
        <div class="modal-body">
        {% if v.file_silabus != "" %}

            <div class="row">
                <div class="col-md-12">
                  <div class="col-md-2"></div>
                    <div class="col-md-6">
                      <div class="form-group">
                        <span for="exampleInputFile">File input :</span>
                        <input style="border: 1px solid;" type="file" id="upload_silabus">
                        <p class="help-block text-red">File type : PDF</p>                 
                        <p class="help-block text-red">Max : 10Mb </p>                 
                      </div>
                      <hr>
                      <a href="<?= BASE_URL ?>data/mata_kuliah/silabus/{{v.file_silabus}}" target="_blank"><button class="btn btn-block btn-success btn-flat"><i class="fa fa-fw fa-download"></i> Download File SAP</button></a>
                    </div>
                  <div class="col-md-4">
                    <button onclick="upload_silabus('{{v.kode_mk}}')" class="pull-left btn bg-navy btn-flat margin">Ganti</button>
                </div>          
              </div>
            </div>


        {% else %}

            <div class="row">
                <div class="col-md-12">
                  <div class="col-md-2"></div>
                  <div class="col-md-6">
                    <div class="form-group">
                        <span for="exampleInputFile">File input :</span>
                        <input style="border: 1px solid;" type="file" id="upload_silabus">
                        <p class="help-block text-red">File type : PDF</p>                 
                        <p class="help-block text-red">Max : 10Mb </p>                 
                      </div>
                    </div>
                  <div class="col-md-4">
                  <button onclick="upload_silabus('{{v.kode_mk}}')" class="pull-left btn bg-navy btn-flat margin">Upload</button>
                </div>          
              </div>
            </div>

        {% endif %}


        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        </div>
      </div>
      
    </div>
  </div>
<!-- Modal SILABUS-->



<!-- Modal upload_modul-->
  <div class="modal fade" id="modul{{v.id}}" role="dialog">
    <div class="modal-dialog">
    
      <!-- Modal content-->
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal">&times;</button>
          <h4 class="modal-title">Upload MODUL {{v.kode_mk}} {{v.nama}}</h4>
        </div>
        <div class="modal-body">
        {% if v.file_modul != "" %}

            <div class="row">
                <div class="col-md-12">
                  <div class="col-md-2"></div>
                    <div class="col-md-6">
                      <div class="form-group">
                        <span for="exampleInputFile">File input :</span>
                        <input style="border: 1px solid;" type="file" id="upload_modul">
                        <p class="help-block text-red">File type : PDF, rar</p>                 
                        <p class="help-block text-red">Max : 10Mb </p>                 
                      </div>
                      <hr>
                      <a href="<?= BASE_URL ?>data/mata_kuliah/modul/{{v.file_modul}}" target="_blank"><button class="btn btn-block btn-success btn-flat"><i class="fa fa-fw fa-download"></i> Download File SAP</button></a>
                    </div>
                  <div class="col-md-4">
                    <button onclick="upload_modul('{{v.kode_mk}}')" class="pull-left btn bg-navy btn-flat margin">Ganti</button>
                </div>          
              </div>
            </div>


        {% else %}

            <div class="row">
                <div class="col-md-12">
                  <div class="col-md-2"></div>
                  <div class="col-md-6">
                    <div class="form-group">
                        <span for="exampleInputFile">File input :</span>
                        <input style="border: 1px solid;" type="file" id="upload_modul">
                        <p class="help-block text-red">File type : PDF, rar</p>                 
                        <p class="help-block text-red">Max : 10Mb </p>                 
                      </div>
                    </div>
                  <div class="col-md-4">
                  <button onclick="upload_modul('{{v.kode_mk}}')" class="pull-left btn bg-navy btn-flat margin">Upload</button>
                </div>          
              </div>
            </div>

        {% endif %}


        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        </div>
      </div>
      
    </div>
  </div>
<!-- Modal SILABUS-->




      
    </div>
  </div>
	    {% set no=no+1 %}
    	{% endfor %}
        
      </tbody></table>
    </div><!-- /.box-body -->
  </div><!-- /.box -->
</div>



  </div><!-- /.row -->
</section><!-- /.content -->





<script type="text/javascript">

function tambah_data(thn_kur) {
    var link = '{{ url("akademik/formTambah/") }}'+thn_kur;
    go_page(link);  
}

function back() {
    var back = '{{ url("akademik/kurikulum") }}';
  go_page(back);
}

function edit_mku(id) {
  var link = '{{ url("akademik/formEdit/") }}'+id;
	go_page(link);
}

function reload() {
	var thn = <?= $thn_kur ?>;
	var link = '{{ url("akademik/listKurikulum/") }}'+thn;
    reload_page2(link);	
}

function list_kelas(id,kode_mk) {
  var sesi = $('#sesi'+id).val();
  var thn_kur = "{{thn_kur}}";
  var datas = "sesi="+sesi+"&kode_mk="+kode_mk+"&thn_kur="+thn_kur;
  var link = '{{ url("akademik/listKelasMk/") }}';
  $('#modul_per_kelas'+id).modal('hide');
  $('body').removeClass('modal-open');
  $("body").css("padding-right", "0px");
  $('.modal-backdrop').remove();
  go_page_data(link,datas);
}

function list_kelas_video(id,kode_mk) {
  var sesi = $('#sesi'+id).val();
  var thn_kur = "{{thn_kur}}";
  var datas = "sesi="+sesi+"&kode_mk="+kode_mk+"&thn_kur="+thn_kur;
  var link = '{{ url("akademik/listKelasMkVideo/") }}';
  $('#modul_per_kelas'+id).modal('hide');
  $('body').removeClass('modal-open');
  $("body").css("padding-right", "0px");
  $('.modal-backdrop').remove();
  go_page_data(link,datas);
}

function upload_sap(kode_mk){
  var urel = '{{ url("akademik/uploadSap/") }}'+kode_mk;
    var file_data = $('#upload_sap').prop('files')[0];   
    var form_data = new FormData();                  
    form_data.append('file', file_data);

    if (file_data == '' || file_data == null) {
      new PNotify({
         title: 'Regular Notice',
         text: 'File tidak boleh kosong.',
         type:'warning'
      });
    }else{
      $.ajax({
          url: urel, // point to server-side PHP script 
          dataType: 'json',  // what to expect back from the PHP script, if anything
          cache: false,
          contentType: false,
          processData: false,
          data: form_data,                         
          type: 'post',
          success: function(data){
              $.ajax({
                type: "POST",
                url: urel,
                dataType : "json",
                data: datas
              }).done(function( data ) {
                $('#myModal').modal('hide');
                $('body').removeClass('modal-open');
                $("body").css("padding-right", "0px");
                $('.modal-backdrop').remove();
                back();
              });
              
              new PNotify({
                  title: data.title,
                  text: data.text,
                  type: data.type
              });
              reload();
              $('#sap'+kode_mk).modal('hide');
              $('body').removeClass('modal-open');
              $("body").css("padding-right", "0px");
              $('.modal-backdrop').remove();
          }
       });
    }
}

function upload_silabus(kode_mk){
  var urel = '{{ url("akademik/uploadSilabus/") }}'+kode_mk;
    var file_data = $('#upload_silabus').prop('files')[0];   
    var form_data = new FormData();                  
    form_data.append('file', file_data);

    if (file_data == '' || file_data == null) {
      new PNotify({
         title: 'Regular Notice',
         text: 'File tidak boleh kosong.',
         type:'warning'
      });
    }else{
      $.ajax({
          url: urel, // point to server-side PHP script 
          dataType: 'json',  // what to expect back from the PHP script, if anything
          cache: false,
          contentType: false,
          processData: false,
          data: form_data,                         
          success: function(data){
              new PNotify({
                  title: data.title,
                  text: data.text,
                  type: data.type
              });
              reload();
              $('#silabus'+kode_mk).modal('hide');
              $('body').removeClass('modal-open');
              $("body").css("padding-right", "0px");
              $('.modal-backdrop').remove();
          }
       });
    }
}

function upload_modul(kode_mk){
    var urel = '{{ url("akademik/uploadModul/") }}'+kode_mk;
    var file_data = $('#upload_modul').prop('files')[0];   
    var form_data = new FormData();                  
    form_data.append('file', file_data);

    if (file_data == '' || file_data == null) {
      new PNotify({
         title: 'Regular Notice',
         text: 'File tidak boleh kosong.',
         type:'warning'
      });
    }else{
      $.ajax({
          url: urel, // point to server-side PHP script 
          dataType: 'json',  // what to expect back from the PHP script, if anything
          cache: false,
          type: 'POST',
          contentType: false,
          processData: false,
          data: form_data,                         
          type: 'post',
          success: function(data){
              new PNotify({
                  title: data.title,
                  text: data.text,
                  type: data.type
              });
              reload();
              $('#modul'+kode_mk).modal('hide');
              $('body').removeClass('modal-open');
              $("body").css("padding-right", "0px");
              $('.modal-backdrop').remove();
          }
       });
    }
}

function del(id) {
	var link = '{{ url("akademik/delKurikulum/") }}'+id;
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


<style type="text/css">
.navbar .navbar-nav {
    display: inline-block;
    float: none;
}

.navbar .navbar-collapse {
    text-align: center;
}
</style>
