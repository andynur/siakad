<section class="content-header">
  <h1>
    Akademik Kurikulum
    <small>it all starts here</small>
  </h1>
  <ol class="breadcrumb">
    <li><a href="#"><i class="fa fa-dashboard"></i> Akademik</a></li>
    <li class="active">Kurikulum</li>
  </ol>
</section>

<!-- Main content -->
<section class="content">
  <div class="row">
  
    <!-- Modal -->
    <div class="form">
      <form method="post" class="add_form">
        <div class="modal fade" id="addModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
          <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
              <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">Tambah Kurikulum</h4>
              </div>

              <div class="modal-body">
                <div class="row">
                  <div class="col-lg-12">
                    <div class="row">
                      <div class="col-lg-6">
                        <div class="col-lg-12">
                          <div class="form-group">
                            <label>Tahun <span style="color:red">*</span></label>
                            <p id="label_thn" style="display:none;padding:7px;border:solid #ddd 1px;"><span>Tahun </span></p>
                            <input name="tahun" type="text" id="tahun" placeholder=" Tahun" class="form-control" >
                          </div>
                        </div><!-- /.col-lg-12 -->
                      </div>
                      <div class="col-lg-12">
                        <div class="col-lg-12">
                          <div class="form-group">
                            <label>Data Kurikulum </label>
                          </div>
                        </div><!-- /.col-lg-12 -->
                      </div>
                    </div>

                  </div>

                  <div class="col-lg-6">
                    <!-- id Kurikulum -->
                    <input type="hidden" id="id_data">

                    <div class="col-lg-6">
                      <div class="form-group">
                        <label>Kode MK <span style="color:red">*</span></label>
                        <p style="display:none;padding:7px;border:solid #ddd 1px;" id="label_kode_mk" style="display:none">Kode MK</p>
                        <input name="kode_mk" type="text" id="kode_mk" placeholder=" Kode MK" class="form-control" >
                      </div>
                    </div><!-- /.col-lg-12 -->

                    <div class="col-lg-6">
                      <div class="form-group">
                        <label>Semester <span style="color:red">*</span></label>
                        <input name="semester" type="text" id="semester" placeholder=" Semester" class="form-control" >
                      </div>
                    </div><!-- /.col-lg-12 -->

                    <div class="col-lg-12">
                      <div class="form-group">
                        <label>Nama <span style="color:red">*</span></label>
                        <input name="nama" type="text" id="nama" placeholder=" Nama" class="form-control" >
                      </div>
                    </div><!-- /.col-lg-12 -->

                    <div class="col-lg-12">
                      <div class="form-group">
                        <label>Nama English</label>
                        <input name="nama_en" type="text" id="nama_en" placeholder=" Nama En" class="form-control" >
                      </div>
                    </div><!-- /.col-lg-12 -->

                    <div class="col-lg-6">
                      <div class="form-group">
                        <label>SKS</label>
                        <input name="sks" type="text" id="sks" placeholder=" SKS" class="form-control" >
                      </div>
                    </div><!-- /.col-lg-12 -->

                    <div class="col-lg-6">
                      <div class="form-group">
                        <label>SKS Teori</label>
                        <input name="sks_teori" type="text" id="sks_teori" placeholder=" SKS Praktek" class="form-control" >
                      </div>
                    </div><!-- /.col-lg-12 -->

                    <div class="col-lg-6">
                      <div class="form-group">
                        <label>SKS Praktek</label>
                        <input name="sks_praktek" type="text" id="sks_praktek" placeholder=" SKS Praktek" class="form-control" >
                      </div>
                    </div><!-- /.col-lg-12 -->

                    <div class="col-lg-6">
                      <div class="form-group">
                        <label>SKS Klinik</label>
                        <input name="sks_klinik" type="text" id="sks_klinik" placeholder=" SKS Klinik" class="form-control" >
                      </div>
                    </div><!-- /.col-lg-12 -->

                  </div><!-- /.col-lg-6 -->

                  <div class="col-lg-6">

                  <div class="col-lg-6">
                    <div class="form-group">
                      <label>Kelompok <span style="color:red">*</span></label>
                      <input name="kelompok" type="text" id="kelompok" placeholder=" Kelompok" class="form-control" >
                    </div>
                  </div><!-- /.col-lg-12 -->

                  <div class="col-lg-6">
                    <div class="form-group">
                      <label>Jenis <span style="color:red">*</span></label>
                      <input name="jenis" type="text" id="jenis" placeholder=" Jenis" class="form-control" >
                    </div>
                  </div><!-- /.col-lg-12 -->

                    <div class="col-lg-12">
                      <div class="form-group">
                        <label>Prasyarat</label>
                        <input name="prasyarat" type="text" id="prasyarat" placeholder=" Persyaratan" class="form-control" >
                      </div>
                    </div><!-- /.col-lg-12 -->

                    <div class="col-lg-6">
                      <div class="form-group">
                        <label>Kode Agama <span style="color:red">*</span></label>
                        <input name="kode_agama" type="text" id="kode_agama" placeholder=" Kode Agama" class="form-control" >
                      </div>
                    </div><!-- /.col-lg-12 -->

                    <div class="col-lg-6">
                      <div class="form-group">
                        <label>Urut <span style="color:red">*</span></label>
                        <input name="urut" type="text" id="urut" placeholder=" Urut" class="form-control" >
                      </div>
                    </div><!-- /.col-lg-12 -->

                    <div class="col-lg-12">
                      <div class="form-group">
                        <label>Deskripsi</label>
                        <textarea name="diskripsi" type="text" id="deskripsi" placeholder=" Deskripsi" class="form-control" name="deskripsi" rows="5" cols="80"></textarea>
                      </div>
                    </div><!-- /.col-lg-12 -->

                  </div><!-- /.col-lg-6 -->
                  <div class="col-md-12">
                    <div class="col-lg-12">
                      <div class="form-group">
                        <label> <span style="color:red">*</span> Wajib di isi</label>
                      </div>
                    </div>
                  </div>

                </div><!-- /.row -->
              </div><!-- /.modal footer -->

              <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                <button id="frm_data" type="button" class="btn btn-primary" onclick="add_data()">Save changes</button>
              </div>
            </div>
          </div>
        </div>
      </form>
    </div>

    <!-- table -->
    <div class="col-lg-12">
      <div class="box box-primary">
        <!-- /.box-header -->
        <div class="box-body">
          <!-- Panel -->
          <!-- Nav tabs -->
          <ul class="nav nav-tabs" role="tablist">
            <li role="presentation" class="active"><a href="#kurikulum" aria-controls="kurikulum" role="tab" data-toggle="tab">Kurikulum</a></li>
            <li role="presentation"><a href="#kurikulum_map" aria-controls="kurikulum_map" role="tab" data-toggle="tab">Pemetaan</a></li>
          </ul>

          <!-- Tab panes -->
          <div class="tab-content">
            <div role="tabpanel" class="tab-pane active" id="kurikulum">
              <button id="add" style="margin:5px" type="button" class="btn btn-success btn-sm pull-right" data-toggle="modal" data-target="#addModal">Tambah Data <i class="glyphicon glyphicon-plus"></i> </button>

              <h4 style="margin-left:5px;"><b id="label_tahun"> Tahun Kurikulum</b></h4>

              {#<?php echo "<pre>".print_r($data,1)."<pre>"; ?>#}

              <div id="tahun_kur" style="margin-bottom: -15px;">
              </div>

              <hr>
              <div id="data_kur" style="display:none; width:100%;">
                <table class="table table-hover table-bordered table-striped table-responsive" id="table" width="100%">
                  <thead>
                    <tr>
                      <th style="width:0px;">No</th>
                      <th style="width:0px;">Kode</th>
                      <th style="width:200px;">Nama</th>
                      <th>Semester</th>
                      <th>SKS</th>
                      <th>SKS Teori</th>
                      <th>SKS Praktek</th>
                      <th>SKS Klinik</th>
                      <th>Jenis</th>
                      <th>Kelompok</th>
                      <th>Urut</th>
                      <th style="width:0px;">Action</th>
                    </tr>
                  </thead>
                </table>
              </div>
              <button id="add_kur" style="margin:5px; display:none;" type="button" class="btn btn-success btn-sm pull-right" data-toggle="modal" data-target="#addModal" ><i class="glyphicon glyphicon-plus"></i> </button>
            </div>
            <div role="tabpanel" class="tab-pane" id="kurikulum_map">
              <table class="table table-bordered table-striped table-hover" id="contohTable">
                <thead>
                  <tr>
                    <th>Table Header 1</th>
                    <th>Table Header 2</th>
                    <th>Table Header 3</th>
                    <th>Table Header 4</th>
                    <th>Table Header 5</th>
                  </tr>
                </thead>
                <tbody>
                  <tr>
                    <td>Table Body 1</td>
                    <td>Table Body 2</td>
                    <td>Table Body 3</td>
                    <td>Table Body 4</td>
                    <td>Table Body 5</td>
                  </tr>
                  <tr>
                    <td>Table Body 1</td>
                    <td>Table Body 2</td>
                    <td>Table Body 3</td>
                    <td>Table Body 4</td>
                    <td>Table Body 5</td>
                  </tr>
                  <tr>
                    <td>Table Body 1</td>
                    <td>Table Body 2</td>
                    <td>Table Body 3</td>
                    <td>Table Body 4</td>
                    <td>Table Body 5</td>
                  </tr>
                  <tr>
                    <td>Table Body 1</td>
                    <td>Table Body 2</td>
                    <td>Table Body 3</td>
                    <td>Table Body 4</td>
                    <td>Table Body 5</td>
                  </tr>
                </tbody>
              </table>
            </div>
          </div>
        </div><!-- /.box-body -->
      </div><!-- /.box -->
    </div><!-- /.col-lg -->
  </div><!-- /.row -->
</section><!-- /.content -->
<script type="text/javascript">
  //
  // Date picker
  $('#tahun').datepicker({
    viewMode: "years",
    minViewMode: "years",
    format: "yyyy",
    startDate: '-8y',
    endDate: '+1d',
  });
  // /.Date Picker
  //
  // kur Data
  function kur(tahun){
    // reload_page('akademik/kurikulum','kurikulum');
    document.getElementById("label_tahun").innerHTML="Tahun Kurikulum "+tahun;
    $("#add").css({display: 'none'});
    $('#tahun_kur').css({ display: 'none' });
    $('#add_kur').css({ display: 'block' });
    $('#data_kur').css({ display: 'block' });
    $('#add_kur').val(tahun);
    document.getElementById("add_kur").innerHTML="Tambah Data "+tahun;
    var i = 1;
    tbl = $('#table').DataTable({
       "ajax"       : "{{ url('akademik/dataKurikulum/') }}"+tahun,
       "columns": [
         {"data": ""},
         {"data": "kodemk"},
         {"data": "nama"},
         {"data": "semester"},
         {"data": "sks"},
         {"data": "sks_teori"},
         {"data": "sks_praktek"},
         {"data": "sks_klinik"},
         {"data": "jenis"},
         {"data": "kelompok"},
         {"data": "urut"}
       ],
       "columnDefs": [
       {
         "targets"   : 0,"data": null,
         "sortable"  :false,
         "mRender"   : function (data, type, row) {
           return i++;
         }
       },
       {
         "targets"   : 11,"data": null,
         "sortable"  :false,
         "mRender"   : function (data, type, row) {
           return '<a id="edit" class="btn btn-primary btn-xs btn-flat" data-toggle="modal" data-target="#addModal"><i class="glyphicon glyphicon-edit"></i>  </a> <a id="delete" class="btn btn-danger btn-xs btn-flat" onclick="del_data('+data.id_ps+')"><i class="glyphicon glyphicon-trash"></i></a> ';
         }
       },
      ]
    });

    //
  }
  // /.kur Data


  // ==============
  // Insert Data
  // ==============
  // Add Data

  // Mengubah form update menjadi tambah
  $(document).on('click','#add',function(){
    $('.add_form')[0].reset();
    $("#tahun").css({display: 'block'});
    $("#label_thn").css({display: 'none'});
    $("#kode_mk").css({display: 'block'});
    $("#label_kode_mk").css({display: 'none'});
    $('#frm_data').removeAttr('onclick');
    $('#frm_data').attr({onclick : 'add_data()'});
    document.getElementById("frm_data").innerHTML="Save changes";
  });

  // /.Add Data
  //
  // Ajax Insert Data
  function add_data(){
    //  console.log($('.add_form').serialize());
    var datas = $('.add_form').serialize();
    console.log(datas);
    $.ajax({
      type: "POST",
      url: '{{ url('akademik/submitKurikulum') }}',
      dataType : "json",
      data: datas
    }).done(function(data) {
      // console.log(data);
      tbl.ajax.reload();
      // reload_page('akademik/kurikulum','kurikulum');
      $("#tahun_kur").load(location.href + " #tahun_kur");
      $('.add_form')[0].reset();
      $('#addModal').modal('hide');
      notif(data.class,data.pesan2,data.pesan1);
    });
  }
  // /.Ajax Insert Data
  //
  // Add Data in Tahun
  $(document).on('click','#add_kur',function(){
    var add_thn = $('#add_kur').val();
    $('.add_form')[0].reset(); //reset form
    //merubah menjadi form tambah
    $("#tahun").css({display: 'none'});
    $("#label_thn").css({display: 'block'});
    $("#kode_mk").css({display: 'block'});
    $("#label_kode_mk").css({display: 'none'});
    $('#tahun').val(add_thn);
    $('#frm_data').removeAttr('onclick');
    $('#frm_data').attr({onclick : 'add_data_tahun()'});
    document.getElementById("label_thn").innerHTML=add_thn;
    document.getElementById("frm_data").innerHTML="Save changes";
  });
  // /.Add Data
  //
  // Ajax Insert Data
  function add_data_tahun(){
    //  console.log($('.add_form').serialize());
    var datas = $('.add_form').serialize();
    console.log(datas);
    $.ajax({
      type: "POST",
      url: '{{ url('akademik/submitKurikulum') }}',
      dataType : "json",
      data: datas
    }).done(function(data) {
      // console.log(data);
      tbl.ajax.reload();
      // reload_page('akademik/kurikulum','kurikulum');
      tbl.ajax.reload();
      $('.add_form')[0].reset();
      $('#addModal').modal('hide');
      notif(data.class,data.pesan2,data.pesan1);
    });
  }
  // /.Ajax Insert Data
  //


  // ==============
  // Edit Data
  // ==============
  // Edit Data, menampilkan data di form

  $(document).on('click','#edit',function(){

    var tr          = $(this).parent().parent('tr');
    var data        = tbl.row(tr).data();
    var id          = data.id_ps;
    var kode_mk          = data.kodemk;
    var nama        = data.nama;
    var nama_en     = data.nama_en;
    var tahun       = data.tahun;
    var semester    = data.semester;
    var sks         = data.sks;
    var sks_teori   = data.sks_teori;
    var sks_praktek = data.sks_praktek;
    var sks_klinik  = data.sks_klinik;
    var kelompok    = data.kelompok;
    var jenis       = data.jenis;
    var prasyarat   = data.prasyarat;
    var kode_agama  = data.kode_agama;
    var urut        = data.urut;
    var deskripsi   = data.deskripsi;
    console.log(id);
    // Mengubah form tambah menjadi update
    $('#frm_data').removeAttr('onclick');
    $('#frm_data').attr({onclick: 'update_data('+id+')'});
    document.getElementById("frm_data").innerHTML="Update";

    // Mengirim data json ke form update
    $('#id_data').val(id);
    $('#nama').val(nama);
    $('#kode_mk').val(kode_mk);
    $('#nama_en').val(nama_en);
    $('#tahun').val(tahun);
    $('#semester').val(semester);
    $('#sks').val(sks);
    $('#sks_teori').val(sks_teori);
    $('#sks_praktek').val(sks_praktek);
    $('#sks_klinik').val(sks_klinik);
    $('#kelompok').val(kelompok);
    $('#jenis').val(jenis);
    $('#prasyarat').val(prasyarat);
    $('#kode_agama').val(kode_agama);
    $('#urut').val(urut);
    $('#deskripsi').val(deskripsi);

    //merubah menjadi form Edit
    $("#tahun").css({display: 'none'});
    $("#label_thn").css({display: 'block'});
    $("#kode_mk").css({display: 'none'});
    $("#label_kode_mk").css({display: 'block'});
    document.getElementById("label_kode_mk").innerHTML=kode_mk;
    document.getElementById("label_thn").innerHTML=tahun;
  });
  // /.Edit data
  //
  // Ajax Update Data
  function update_data(id){
    //  console.log($('.add_form').serialize());
    var datas = $('.add_form').serialize();
    // console.log(datas);
    $.ajax({
      type: "POST",
      url: '{{ url('akademik/updateData/') }}'+id,
      dataType : "json",
      data: datas
    }).done(function(data) {
      // console.log(data);
      tbl.ajax.reload();
      $('.add_form')[0].reset();
      $('#addModal').modal('hide');
      // reload_page('akademik/kurikulum','kurikulum');
      notif(data.class,data.pesan2,data.pesan1);
    });
  }
  // /.Ajax Update Data


  // ==============
  // Delete Data
  // ==============
  // Ajax Delete Data akademik

  function del_data(id) {
    var urel = '{{ url('akademik/deleteKurikulum/') }}'+id;
    if(confirm('Hapus Data???')) {
      $.ajax({
        type: "POST",
        url: urel,
        dataType : "json",
      }).done(function( data ) {
        // console.log(data);
        tbl.ajax.reload()
        notif(data.class,data.pesan2,data.pesan1);
        // reload_page('akademik/kurikulum','kurikulum');
      });
    }
  }

  // /.Ajax Delete Data akademik
  //
  // Button tahun

  $.ajax({
    url         : "{{ url('akademik/tahun')}}",
    type        : "GET",
    dataType    : "json",
    data        : {'tahun_kur' : 'value'},
    success     : function(data){
        jmlData = data.length;

        buatButton = "";
        for(a = 0; a < jmlData; a++){
            buatButton += '<button id="thn_kur'+data[a]["tahun_kur"]+'" style="margin:5px" type="button" class="btn btn-primary btn-sm" onclick="kur('+data[a]["tahun_kur"]+')"> ' +data[a]["tahun_kur"]+ ' <i class="glyphicon glyphicon-calendar"></i> </button>';
        }
        document.getElementById("tahun_kur").innerHTML += buatButton;
    }
  });


</script>
