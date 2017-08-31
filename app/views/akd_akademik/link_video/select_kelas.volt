<section class="content-header">
  <h1><button type="button" onclick="back('{{thn_kur}}')" class="btn bg-navy btn-flat"><i class="fa fa-fw fa-arrow-left"></i> Back</button></h1>
  <ol class="breadcrumb">
    <li><a href="#"><i class="fa fa-dashboard"></i> {{nama_sesi}}</a></li>
  </ol>
</section>

<!-- Main content -->
<section class="content">

  <div class="row">
    <div class="col-md-2"></div>
    <div class="col-md-8">
      <div class="box">
        <div class="box-header with-border">
          <h3 class="box-title">DAFTAR KELAS</h3>
        </div><!-- /.box-header -->
        <div class="box-body">
          <table id="" class="table table-bordered table-striped">
            <thead>
              <tr>
                <th style="width: 10px">No</th>
                <th>Thn Kur</th>
                <th>Kode MK</th>
                <th>Nama</th>
                <th>Nama Kelas</th>
                <th>Upload</th>
                <th>Lihat</th>
              </tr>
            </thead>
            <tbody>
            
            {% set no=1 %}
            {% for v in mk_kelas %}
            <tr>
				<td>{{no}}</td>
				<td>{{v.thn_kur}}</td>
				<td>{{v.kode_mk}}</td>
				<td>{{v.nama}}</td>
				<td>{{v.nama_kelas}}</td>
				<td class="text-center"><a data-toggle="modal" data-target="#modul{{no}}" class="btn btn-{% if v.link != "" %}info{% else %}warning{% endif %} btn-xs btn-flat"><i class="fa fa-fw fa-cloud-upload"></i></a> </td>
				<input type="text" id="kode_mk{{no}}" value="{{v.kode_mk}}" style="display:none">
				<input type="text" id="nama_kelas{{no}}" value="{{v.nama_kelas}}" style="display:none">
				<input type="text" id="thn_kur{{no}}" value="{{v.thn_kur}}" style="display:none">
				<input type="text" id="sesi{{no}}" value="{{sesi}}" style="display:none">
					<!-- Modal -->
					<div id="modul{{no}}" class="modal fade" role="dialog">
					  <div class="modal-dialog">

					    <!-- Modal content-->
					    <div class="modal-content">
					      <div class="modal-header">
					        <button type="button" class="close" data-dismiss="modal">&times;</button>
					        <h4 class="modal-title">Modal Header</h4>
					      </div>
					      <div class="modal-body">
					        {% if v.link != "" %}
					            <div class="row">
					                <div class="col-md-12">
					                  <div class="col-md-2"></div>
					                    <div class="col-md-6">
					                      <div class="form-group">
					                        <span for="exampleInputFile">Link Video :</span>
					                        <div class="form-group">
						                      <input type="text" class="form-control" id="video_edit{{no}}" value="{{v.link}}">
						                    </div>
					                      </div>
					                    </div>
					                  <div class="col-md-4">
					                  	<div class="form-group">
					                    	<button onclick="video_edit('{{no}}','{{v.id_link}}')" style="margin-top: 20px;" class="pull-left btn bg-navy btn-flat margin">Ganti</button>
					                	</div>          
					                </div>          
					              </div>
					            </div>


					        {% else %}

					            <div class="row">
					                <div class="col-md-12">
					                  <div class="col-md-2"></div>
					                  <div class="col-md-6">
					                    <div class="form-group">
					                        <span for="exampleInputFile">Link Video :</span>
					                        <div class="form-group">
						                      <input type="text" class="form-control" id="video_input{{no}}">
						                    </div>
					                      </div>
					                    </div>
					                  <div class="col-md-4">
					                  	<div class="form-group">
					                  		<button onclick="video_input('{{no}}')" style="margin-top: 20px;" class="pull-left btn bg-navy btn-flat margin">Simpan</button>
					                	</div>          
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
				<td>
					{% if v.link != "" %}
						<a href="{{v.link}}" target="_blank">Link Video</a>
					{% else %}
						-- Belum Tersedia --
					{% endif %}
				</td>
            </tr>
            {% set no=no+1 %}
            {% endfor %}

            </tbody>            
          </table><br>
          <p class="text-aqua">* Link Sudah di upluoad (Bisa di replace)</p>
          <p class="text-yellow">* Link Belum di upluoad</p>
        </div><!-- /.box-body -->
      </div><!-- /.box -->
    </div>

  </div>

      
</section><!-- /.content -->



<script type="text/javascript">
$(function () {
    $('#example2').DataTable({
        "paging": true,
        "lengthChange": true,
        "searching": true,
        "ordering": true,
        "info": true,
        "autoWidth": true
      });
  });

function back(thn) {
	var link = '{{ url("akademik/listKurikulum/") }}'+thn;
    go_page(link);	
}

function reload() {
	var sesi = "{{sesi}}";
	var thn_kur = "{{thn_kur}}";
	var kode_mk = "{{kode_mk}}";

	var datas = "sesi="+sesi+"&kode_mk="+kode_mk+"&thn_kur="+thn_kur;
	var link = '{{ url("akademik/listKelasMkVideo/") }}';

	reload_page_data(link,datas);
}

function video_input(no) {

    var kode_mk = $('#kode_mk'+no).val();   
    var nama_kelas = $('#nama_kelas'+no).val();   
    var thn_kur = $('#thn_kur'+no).val();   
    var link_input = $('#video_input'+no).val();   
    var sesi = "{{sesi}}";   
    
	var link = '{{ url("akademik/simpanLink") }}';
	var datas = "sesi="+sesi+"&kode_mk="+kode_mk+"&thn_kur="+thn_kur+"&nama_kelas="+nama_kelas+"&link="+link_input;

	if (link_input == '') {
		new PNotify({
			title: 'Warning',
			text: "Link tidak boleh Kosong",
			type: 'warning'
		});
	}else{
	  	$.ajax({
			type: "POST",
			url: link,
			dataType : "json",
			data: datas
		}).done(function( data ) {

			$('#modul'+no).modal('hide');
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
}

function video_edit(no,id) {
  
    var link_input = $('#video_edit'+no).val();   
    
	var link = '{{ url("akademik/editLink") }}';
	var datas = "id="+id+"&link="+link_input;

	if (link_input == '') {
		new PNotify({
			title: 'Warning',
			text: "Link tidak boleh Kosong",
			type: 'warning'
		});
	}else{
	  	$.ajax({
			type: "POST",
			url: link,
			dataType : "json",
			data: datas
		}).done(function( data ) {

			$('#modul'+no).modal('hide');
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
}

</script>