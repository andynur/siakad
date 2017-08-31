<?php date_default_timezone_set('Asia/Jakarta'); ?>
<section class="content-header">
    <h1><button type="button" onclick="back()" class="btn bg-navy btn-flat"><i class="fa fa-fw fa-arrow-left"></i> Back</button></h1>
    <ol class="breadcrumb">
        <li class="lead"><b>{{nama}}</b> - Nomhs : {{nomhs}} - Angkatan : {{angkatan}}</li>
    </ol>
</section>

<!-- Main content -->
<section class="content">
    <div class="row">
        <form method="post" class="add_form">
            <div class="modal fade" id="addModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
                <div class="modal-dialog modal-md" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                            <h4 class="modal-title" id="myModalLabel">Tambah Cuti</h4>
                        </div>

                        <div class="modal-body">
                            <div class="row">
                                <input name="nomhs" type="hidden" id="id" value="{{nomhs}}" >
                                <input name="angkatan" type="hidden" id="id" value="{{angkatan}}" >
                                <input name="nama" type="hidden" id="id" value="{{nama}}" >
                                <div class="col-lg-12">
                                    <div class="form-group">
                                        <label>Keterangan <span style="color:red">*</span></label>
                                        <input name="keterangan" type="text" id="keterangan" placeholder=" Keterangan" class="form-control" >
                                    </div>
                                </div><!-- /.col-lg-12 -->

                                <div class="col-lg-3">
                                    <div class="form-group">
                                        <label>Tanggal Mulai <span style="color:red">*</span></label>
                                        <input name="tgl_mulai" type="text" value="<?= date('d') ?>" class="form-control" >
                                    </div>
                                </div><!-- /.col-lg-12 -->
                                <div class="col-lg-6">
                                    <div class="form-group">
                                    <label><span style="color:white">*</span></label>
                                        <select class="form-control" name="bln_mulai">
                                            <option value="1">Januari</option>
                                            <option value="2">Februari</option>
                                            <option value="3">Maret</option>
                                            <option value="4">April</option>
                                            <option value="5">Mei</option>
                                            <option value="6">Juni</option>
                                            <option value="7">Juli</option>
                                            <option value="8">Agustus</option>
                                            <option value="9">September</option>
                                            <option value="10">Oktober</option>
                                            <option value="11">November</option>
                                            <option value="12">Desember</option>
                                        </select>
                                    </div>
                                </div><!-- /.col-lg-12 -->
                                <div class="col-lg-3">
                                    <div class="form-group">
                                        <label><span style="color:white">*</span></label>
                                        <input name="thn_mulai" type="text" value="<?= date('Y') ?>" class="form-control" >
                                    </div>
                                </div><!-- /.col-lg-12 -->

                                <div class="col-lg-3">
                                    <div class="form-group">
                                        <label>Tanggal Akhir <span style="color:red">*</span></label>
                                        <input name="tgl_akhir" type="text" id="tgl_akhir" value="<?= date('d') ?>" class="form-control" >
                                    </div>
                                </div><!-- /.col-lg-12 -->
                                <div class="col-lg-6">
                                    <div class="form-group">
                                    <label><span style="color:white">*</span></label>
                                        <select class="form-control" name="bln_akhir">
                                            <option value="1">Januari</option>
                                            <option value="2">Februari</option>
                                            <option value="3">Maret</option>
                                            <option value="4">April</option>
                                            <option value="5">Mei</option>
                                            <option value="6">Juni</option>
                                            <option value="7">Juli</option>
                                            <option value="8">Agustus</option>
                                            <option value="9">September</option>
                                            <option value="10">Oktober</option>
                                            <option value="11">November</option>
                                            <option value="12">Desember</option>
                                        </select>
                                    </div>
                                </div><!-- /.col-lg-12 -->
                                <div class="col-lg-3">
                                    <div class="form-group">
                                        <label><span style="color:white">*</span></label>
                                        <input name="thn_akhir" type="text" value="<?= date('Y') ?>" class="form-control" >
                                    </div>
                                </div><!-- /.col-lg-12 -->

                                <div class="col-lg-12">
                                    <div class="form-group">
                                        <label>Nomor Surat <span style="color:red">*</span></label>
                                        <input name="no_surat" type="text" id="no_surat" placeholder=" Nomor Surat" class="form-control" >
                                    </div>
                                </div><!-- /.col-lg-12 -->

                                <div class="col-lg-3">
                                    <div class="form-group">
                                        <label>Tanggal Surat <span style="color:red">*</span></label>
                                        <input name="tgl_surat" type="text" id="tgl_mulai" value="<?= date('d') ?>" class="form-control" >
                                    </div>
                                </div><!-- /.col-lg-12 -->
                                <div class="col-lg-6">
                                    <div class="form-group">
                                    <label><span style="color:white">*</span></label>
                                        <select class="form-control" name="bln_surat">
                                            <option value="1">Januari</option>
                                            <option value="2">Februari</option>
                                            <option value="3">Maret</option>
                                            <option value="4">April</option>
                                            <option value="5">Mei</option>
                                            <option value="6">Juni</option>
                                            <option value="7">Juli</option>
                                            <option value="8">Agustus</option>
                                            <option value="9">September</option>
                                            <option value="10">Oktober</option>
                                            <option value="11">November</option>
                                            <option value="12">Desember</option>
                                        </select>
                                    </div>
                                </div><!-- /.col-lg-12 -->
                                <div class="col-lg-3">
                                    <div class="form-group">
                                        <label><span style="color:white">*</span></label>
                                        <input name="thn_surat" type="text" id="tgl_mulai" value="<?= date('Y') ?>" class="form-control" >
                                    </div>
                                </div><!-- /.col-lg-12 -->

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

  <div class="row">
    <div class="col-md-1"></div>
    <div class="col-md-10">
      <div class="box">
        <div class="box-header">
          <h3 class="box-title">Cuti Mahasiswa</h3>
          <button type="button" data-toggle="modal" data-target="#addModal" class="btn bg-navy btn-flat pull-right"><i class="fa fa-fw fa-plus"></i> Tambah</button>
        </div><!-- /.box-header -->
        <div class="box-body">
            <table id="" class="table table-bordered table-striped">
              <thead>
                <tr>
                  <th style="width: 10px">No</th>
                  <th>Sejarah Cuti</th>
                  <th>Status Cuti</th>
                </tr>
              </thead>
              <tbody>

                {% set no=1 %}
                {% for v in data_cuti %}
                <tr>
                 <td>{{no}}</td>
                 <td>
                    <a href="javascript:void(0)" onclick="edit('{{v.cuti_id}}')"> {{v.keterangan}} </a>
                    <p>Tanggal Mulai Cuti : {{ helper.dateBahasaIndo(v.tgl_start) }}</p>
                    <p>Tanggal Selesai Cuti : {{ helper.dateBahasaIndo(v.tgl_stop) }}</p>
                    <p>Nomor Surat Cuti : {{v.no_surat}}</p>
                    <p>Tanggal Surat Cuti : {{ helper.dateBahasaIndo(v.tgl_surat) }}</p>
                 </td>
                 <td>
                <?php 
                    $tgl_now = date('Y-m-d', strtotime($tgl_sekarang));
                    $tgl_start = date('Y-m-d', strtotime($v->tgl_start));
                    $tgl_stop = date('Y-m-d', strtotime($v->tgl_stop));
                ?>
                    <?php if (($tgl_start <= $tgl_now) && ($tgl_stop >= $tgl_now)): ?>
                        Aktif
                    <?php else: ?>
                        Inaktif
                    <?php endif ?>
                 </td>
               </tr>
               {% set no=no+1 %}
               {% endfor %}

             </tbody>            
            </table>
        </div>
      </div>
    </div>
  </div>

</section><!-- /.content -->
<script type="text/javascript">

function back() {
    var link = '{{ url("akdmhscuti/find/") }}';
    go_page(link);
}

function reload() {
    var nama = "{{nama}}";
    var nomhs = "{{nomhs}}";
    var angkatan = "{{angkatan}}";
    var link = '{{ url("akdmhscuti/dataCutiMhs/") }}';
    var datas = 'nomhs='+nomhs+'&angkatan='+angkatan+'&nama='+nama;
    reload_page_data(link,datas);
}

function edit(id) {
    var nama = "{{nama}}";
    var nomhs = "{{nomhs}}";
    var angkatan = "{{angkatan}}";
    var link = '{{ url("akdmhscuti/formEdit/") }}';
    var datas = 'id='+id+'&nomhs='+nomhs+'&angkatan='+angkatan+'&nama='+nama;
    go_page_data(link,datas);
}

function add_data() {
    var link = '{{ url("akdmhscuti/insertCuti/") }}';
    var datas = $('form').serialize();
    $.ajax({
      type: "POST",
      url: link,
      dataType : "json",
      data: datas
    }).done(function( data ) {
        $('#addModal').modal('hide');
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

</script>
