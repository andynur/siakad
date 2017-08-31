<section class="content-header">
  <h1>
    <button type="button" onclick="back()" class="btn bg-navy btn-flat margin"><i class="fa fa-fw fa-arrow-left"></i> Back</button>
  </h1>
  <ol class="breadcrumb">
    <li><a href="#"><i class="fa fa-dashboard"></i> Setup</a></li>
    <li class="">Pembimbing</li>
    <li class="active">View</li>
  </ol>
</section>

<!-- Main content -->
<section class="content">
  

<div class="row">
  <div class="col-md-2"></div>
  <div class="col-md-8">
    <div class="box">
        <div class="box-header">
          <h3 class="box-title">Cari Mahasiswa </h3>
        </div><!-- /.box-header -->
        <div class="box-body">
            <table class="table table-condensed">
              <tbody>
                <tr>
                  <td style="padding: 11px 6px; background: #eee" class="text-left"><b>Nomor MHS :</b></td>
                  <td style="padding: 11px 6px;"><input type="radio" name="optionsRadios" id="radio" value="nomhs"></td>
                  <td><input id="no_mhs" type="text" class="form-control" placeholder="Enter..."></td>
                  <td class="text-center"></td>
                  <td></td>
                </tr>
                <tr>
                  <td style="padding: 11px 6px; background: #eee" class="text-left"><b>Range NOMHS :</b></td>
                  <td style="padding: 11px 6px;"><input type="radio" name="optionsRadios" id="radio" value="range"></td>
                  <td><input id="range1" type="text" class="form-control" placeholder="Enter..."></td>
                  <td style="padding: 11px 6px;" class="text-center">s/d</td>
                  <td><input id="range2" type="text" class="form-control" placeholder="Enter..."></td>
                </tr>
                <tr>
                  <td style="padding: 11px 6px; background: #eee" class="text-left"><b>Angkatan :</b></td>
                  <td style="padding: 11px 6px;"><input type="radio" name="optionsRadios" id="radio" value="angkatan"></td>
                  <td><select id="angkatan" class="form-control">
                        <option>option 1</option>
                        <option>option 2</option>
                        <option>option 3</option>
                        <option>option 4</option>
                        <option>option 5</option>
                      </select></td>
                  <td class="text-center"></td>
                  <td><button style="margin: 0;" type="button" onclick="cari()" class="btn bg-navy btn-flat margin pull-right"><i class="fa fa-fw fa-search"></i> Cari</button></td>
                </tr>
              </tbody>
            </table>
        </div>
    </div>
  </div>
  <div class="col-md-2"></div>
</div>

<div class="row">
    <div class="col-md-1"></div>
    <div class="col-md-10">
      <div class="box">
        <div class="box-header">
          <h3 class="box-title text-green">Data Bimbingan Aktif</h3>
        </div><!-- /.box-header -->
        <div class="box-body">
          <table id="example2" class="table table-bordered table-striped">
            <thead>
              <tr>
                <th style="" style="width: 10px">No</th>
                <th style="" style="">NOMHS</th>
                <th style="">Nama</th>
                <th style="">Angkatan</th>
                <th style="">Session</th>
                <th style="">Hapus</th>
                <th style="">Aktif</th>
              </tr>
            </thead>
            <tbody>
            
            {% set no=1 %}
            {% for v in mhs_aktif %}
            <tr>
              <td style="padding: 1px;">{{no}}</td>
              <td style="padding: 1px;">{{v.id_mhs}}</td>
              <td style="padding: 1px;">{{v.nama}}</td>
              <td style="padding: 1px;">{{v.angkatan}}</td>
              <td style="padding: 1px;">
                {% if v.session_id == 1 %}
                  GANJIL
                {% else %}
                  GENAP
                {% endif %}
                {{v.thn_akd}}/{{v.thn_akd+1}}
              </td>
              <td style="padding: 1px;"><input type="checkbox" id="ch" name="hapus_m" value="{{v.id}}"></td>
              <td style="padding: 1px;"><input type="checkbox" name="non_aktif" value="{{v.id}}"></td>
            </tr>
            {% set no=no+1 %}
            {% endfor %}

            </tbody>     
          </table>
          <button style="" type="button" onclick="non_aktif_mhs()" class="btn bg-navy btn-flat margin pull-right"><i class="fa fa-fw fa-check-square-o"></i> Non Aktif</button>       
            <button style="" type="button" onclick="hapus_mhs()" class="btn bg-navy btn-flat margin pull-right"><i class="fa fa-fw fa-trash"></i> Hapus</button>
        </div><!-- /.box-body -->
      </div><!-- /.box -->
    </div>
  <div class="col-md-1"></div>
</div>

<div class="row">
  <div class="col-md-1"></div>
  <div class="col-md-10">
      <div class="box">
        <div class="box-header">
          <h3 class="box-title text-red">Data Bimbingan Tidak Aktif</h3>
        </div><!-- /.box-header -->
        <div class="box-body">
          <table id="example3" class="table table-bordered table-striped">
            <thead>
              <tr>
                <th style="" style="width: 10px">No</th>
                <th style="" style="">NOMHS</th>
                <th style="">Nama</th>
                <th style="">Angkatan</th>
                <th style="">Session</th>
                <th style="">Hapus</th>
                <th style="">Aktif</th>
              </tr>
            </thead>
            <tbody>
            
            {% set no=1 %}
            {% for v in mhs_not %}
            <tr>
              <td style="padding: 1px;">{{no}}</td>
              <td style="padding: 1px;">{{v.id_mhs}}</td>
              <td style="padding: 1px;">{{v.nama}}</td>
              <td style="padding: 1px;">{{v.angkatan}}</td>
              <td style="padding: 1px;">
                {% if v.session_id == 1 %}
                  GANJIL
                {% else %}
                  GENAP
                {% endif %}
                {{v.thn_akd}}/{{v.thn_akd+1}}
              </td>
              <td style="padding: 1px;"><input type="checkbox" id="ch" name="hapus_m" value="{{v.id}}"></td>
              <td style="padding: 1px;"><input type="checkbox" id="ch" name="aktifkan" value="{{v.id}}"></td>
            </tr>
            {% set no=no+1 %}
            {% endfor %}

            </tbody>     
          </table>
          <button style="" type="button" onclick="aktif_mhs()" class="btn bg-navy btn-flat margin pull-right"><i class="fa fa-fw fa-check-square-o"></i> Aktif</button>       
            <button style="" type="button" onclick="hapus_mhs()" class="btn bg-navy btn-flat margin pull-right"><i class="fa fa-fw fa-trash"></i> Hapus</button>
        </div><!-- /.box-body -->
      </div><!-- /.box -->
    </div>
  <div class="col-md-1"></div>

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
      "info": false,
      "autoWidth": true
  });

  $('#example3').DataTable({
      "paging": true,
      "lengthChange": true,
      "searching": true,
      "ordering": true,
      "info": false,
      "autoWidth": true
  });
});

function back() {
    var link = '{{ url("akddosenwali/listDosen/") }}';
    go_page(link);  
}

function reload() {
    var nip = "{{nip}}";
    var link = '{{ url("akddosenwali/dosenWali/") }}'+nip;
    reload_page(link);  
}

function non_aktif_mhs() {
  var id =[];
  $('input[name=non_aktif]:checked').each(function(index){
    id.push($(this).val());
  });
  id.toString();

  var link = '{{ url("akddosenwali/nonAktifMhs/") }}';
  var datas = "id="+id;


  if (id.length == 0) {
      new PNotify({
        title: 'Regular Notice',
        text: 'Pilih MHS yang akan di Non Aktifkan',
        type:'warning'
      });
    }else{
      $.ajax({
           type: "POST",
           url: link,
           dataType : "json",
           data : datas,
      }).done(function( data ) {
            new PNotify({
               title: 'Regular Notice',
               text: 'data telah Non Aktifkan',
               type:'success'
            });
          reload();
      });     
    }
}

function aktif_mhs() {
  var id =[];
  $('input[name=aktifkan]:checked').each(function(index){
    id.push($(this).val());
  });
  id.toString();

  var link = '{{ url("akddosenwali/aktifMhs/") }}';
  var datas = "id="+id;


  if (id.length == 0) {
      new PNotify({
        title: 'Regular Notice',
        text: 'Pilih MHS yang akan di Non Aktifkan',
        type:'warning'
      });
    }else{
      $.ajax({
           type: "POST",
           url: link,
           dataType : "json",
           data : datas,
      }).done(function( data ) {
            new PNotify({
               title: 'Regular Notice',
               text: 'data telah Non Aktifkan',
               type:'success'
            });
          reload();
      });     
    }
}

function cari() {
  var nip = "{{nip}}";
  var radio = $('input[name=optionsRadios]:checked').val();
  var no_mhs = $("#no_mhs").val();
  var range1 = $("#range1").val();
  var range2 = $("#range2").val();
  var angkatan = $("#angkatan").val();
  var datas = "no_mhs="+no_mhs+"&range1="+range1+"&range2="+range2+"&angkatan="+angkatan+"&radio="+radio;
  var urel = '{{ url("akddosenwali/cariMhs/") }}'+nip;
  go_page_data(urel,datas);  
}

function hapus_mhs() {
  var nomhs =[];
  $('input[name=hapus_m]:checked').each(function(index){
    nomhs.push($(this).val());
  });
  nomhs.toString();

  var link = '{{ url("akddosenwali/delMhsBimbingan/") }}';
  var datas = "radio="+nomhs;
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

    if (nomhs.length == 0) {
      new PNotify({
        title: 'Regular Notice',
        text: 'Pilih MHS yang akan di hapus',
        type:'warning'
      });
    }else{
      $.ajax({
           type: "POST",
           url: link,
           dataType : "json",
           data : datas,
      }).done(function( data ) {
            new PNotify({
               title: 'Regular Notice',
               text: 'data telah dihapus',
               type:'success'
            });
          reload();
      });     
    }

    }).on('pnotify.cancel', function() {
       console.log('batal');
    });
}
  
</script>