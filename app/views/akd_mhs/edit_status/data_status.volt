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
                            <h4 class="modal-title" id="myModalLabel">Tambah Status</h4>
                        </div>

                        <div class="modal-body">
                            <div class="row">
                                <input name="nomhs" type="hidden" id="id" value="{{nomhs}}" >
                                <div class="col-lg-12">
	                                <div class="col-md-4">
	                                    <div class="form-group">
	                                    <label>Status <span style="color:red">*</span></label>
	                                        <select class="form-control" name="status">
	                                        {% for v in status %}
	                                            <option value="{{v.id_status_keu}}">{{v.nama}}</option>
	                                        {% endfor %}
	                                        </select>
	                                    </div>
	                                </div>
	                                <div class="col-lg-4">
	                                    <div class="form-group">
	                                        <label>Nomor Surat <span style="color:red">*</span></label>
	                                        <input name="no_surat" type="text" id="no_surat" placeholder=" Nomor Surat" class="form-control" >
	                                    </div>
                                	</div>

                                </div><!-- /.col-lg-12 -->

                                <div class="col-lg-12">
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
                                </div>

	                                <div class="col-lg-12">
		                                <div class="col-lg-12">
		                                    <div class="form-group">
		                                        <label>Keterangan <span style="color:red">*</span></label>
		                                        <textarea name="keterangan" class="form-control"></textarea>
		                                    </div>
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
          <h3 class="box-title">Riwayat Status Mahasiswa</h3>
          <button type="button" data-toggle="modal" data-target="#addModal" class="btn bg-navy btn-flat pull-right"><i class="fa fa-fw fa-plus"></i> Tambah</button>
        </div><!-- /.box-header -->
        <div class="box-body">
            <table id="" class="table table-bordered table-striped">
              <thead>
                <tr>
                  <th style="width: 10px">No</th>
                  <th>Sejarah Status</th>
                </tr>
              </thead>
              <tbody>

                {% set no=1 %}
                {% for v in data_status %}

                <?php 
                	$surat = $v->tgl_surat;
	                $tgl_surat = $newDate = date("d", strtotime($surat));
					$bln_surat = $newDate = date("m", strtotime($surat));
					$thn_surat = $newDate = date("Y", strtotime($surat));

                ?>
                <tr>
                 <td>{{no}}</td>
                 <td>
                    <a href="" data-toggle="modal" data-target="#editModal{{no}}" class="lead"> {{v.nama}} </a>
                    <p>Keterangan : {{ v.keterangan }}</p>
                    <p>Nomor Surat : {{v.no_surat}}</p>
                    <p>Tanggal Surat : <span class="text-green">{{ helper.dateBahasaIndo(v.tgl_surat) }}</span></p>
                    <p> <a href="javascript:void(0)" onclick="del_data('{{v.id}}')"><span class="text-red"><i class="fa fa-fw fa-trash"></i> Hapus</span></a></p>
                 </td>

            <div class="modal fade" id="editModal{{no}}" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
                <div class="modal-dialog modal-md" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                            <h4 class="modal-title" id="myModalLabel">Tambah Status</h4>
                        </div>

                        <div class="modal-body">
                            <div class="row">
                                <div class="col-lg-12">
	                                <div class="col-md-4">
	                                    <div class="form-group">
	                                    <label>Status <span style="color:red">*</span></label>
	                                        <select class="form-control" id="status{{v.id}}">
	                                        {% for z in status %}
	                                        <?php if ($z->id_status_keu == $v->status): ?>
	                                            <option value="{{z.id_status_keu}}" selected>{{z.nama}}</option>
	                                        <?php else: ?>
	                                            <option value="{{z.id_status_keu}}">{{z.nama}}</option>
	                                        <?php endif ?>
	                                        {% endfor %}
	                                        </select>
	                                    </div>
	                                </div>
	                                <div class="col-lg-4">
	                                    <div class="form-group">
	                                        <label>Nomor Surat <span style="color:red">*</span></label>
	                                        <input id="no_surat{{v.id}}" type="text" value="{{v.no_surat}}" class="form-control" >
	                                    </div>
                                	</div>

                                </div><!-- /.col-lg-12 -->

                                <div class="col-lg-12">
	                                <div class="col-lg-3">
	                                    <div class="form-group">
	                                        <label>Tanggal Surat <span style="color:red">*</span></label>
	                                        <input id="tgl_surat{{v.id}}" type="text" value="<?= $tgl_surat ?>" class="form-control" >
	                                    </div>
	                                </div><!-- /.col-lg-12 -->
	                                <div class="col-lg-6">
	                                    <div class="form-group">
	                                    <label><span style="color:white">*</span></label>
	                                        <select class="form-control" id="bln_surat{{v.id}}">
	                                            <?php foreach ($bulan as $k => $a): ?>
						                        	<?php if ($bln_surat == $k): ?>	
						                        	<option value="<?= $k ?>" selected><?= $a ?></option>
						                    		<?php else: ?>
						                        	<option value="<?= $k ?>"><?= $a ?></option>
						                    		<?php endif ?>
						                    	<?php endforeach ?>
	                                        </select>
	                                    </div>
	                                </div><!-- /.col-lg-12 -->
	                                <div class="col-lg-3">
	                                    <div class="form-group">
	                                        <label><span style="color:white">*</span></label>
	                                        <input id="thn_surat{{v.id}}" type="text" value="<?= $thn_surat ?>" class="form-control" >
	                                    </div>
	                                </div><!-- /.col-lg-12 -->
                                </div>

	                                <div class="col-lg-12">
		                                <div class="col-lg-12">
		                                    <div class="form-group">
		                                        <label>Keterangan <span style="color:red">*</span></label>
		                                        <textarea id="keterangan{{v.id}}" class="form-control">{{v.keterangan}}</textarea>
		                                    </div>
		                                </div>
	                                </div><!-- /.col-lg-12 -->

                            </div><!-- /.row -->
                        </div><!-- /.modal footer -->

                        <div class="modal-footer">
                            <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                            <button id="frm_data" type="button" class="btn btn-primary" onclick="edit('{{v.id}}')">Save changes</button>
                        </div>
                    </div>
                </div>
            </div>
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
    var link = '{{ url("akdstatusmhs/editStatus/") }}';
    go_page(link);
}

function reload() {
    var nama = "{{nama}}";
    var nomhs = "{{nomhs}}";
    var angkatan = "{{angkatan}}";
    var link = '{{ url("akdstatusmhs/dataStatusMhs/") }}';
    var datas = 'nomhs='+nomhs+'&angkatan='+angkatan+'&nama='+nama;
    reload_page_data(link,datas);
}

function edit(id) {

	var status = $('#status'+id).val();
	var no_surat = $('#no_surat'+id).val();
	var tgl_surat = $('#tgl_surat'+id).val();
	var bln_surat = $('#bln_surat'+id).val();
	var thn_surat = $('#thn_surat'+id).val();
	var keterangan = $('#keterangan'+id).val();

	var link = '{{ url("akdstatusmhs/updateStatus/") }}'+id;
    var datas = 'status='+status+'&no_surat='+no_surat+'&tgl_surat='+tgl_surat+'&bln_surat='+bln_surat+'&thn_surat='+thn_surat+'&keterangan='+keterangan;
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

function add_data() {
    var link = '{{ url("akdstatusmhs/addStatus/") }}';
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

function del_data(id) {
	var link = '{{ url("akdstatusmhs/delStatus/") }}'+id;
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
	      type: "POST",
	      url: link,
	      dataType : "json"
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
</script>
