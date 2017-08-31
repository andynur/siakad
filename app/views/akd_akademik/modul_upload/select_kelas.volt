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
                <th>Download</th>
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
				<td class="text-center"><a data-toggle="modal" data-target="#modul{{no}}" class="btn btn-{% if v.file != "" %}info{% else %}warning{% endif %} btn-xs btn-flat"><i class="fa fa-fw fa-cloud-upload"></i></a> </td>
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
					        {% if v.file != "" %}
					            <div class="row">
					                <div class="col-md-12">
					                  <div class="col-md-2"></div>
					                    <div class="col-md-6">
					                      <div class="form-group">
					                        <span for="exampleInputFile">File input :</span>
					                        <input style="border: 1px solid;" type="file" id="upload_modul{{no}}">
					                        <p class="help-block text-red">File type : PDF</p>                 
					                        <p class="help-block text-red">Max : 10Mb </p>                 
					                      </div>
					                      <hr>
					                      <a href="<?= BASE_URL ?>data/mata_kuliah/modul_kelas/{{v.file}}" target="_blank"><button class="btn btn-block btn-success btn-flat"><i class="fa fa-fw fa-download"></i> Download</button></a>
					                    </div>
					                  <div class="col-md-4">
					                    <button onclick="upload_modul('{{no}}')" class="pull-left btn bg-navy btn-flat margin">Ganti</button>
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
					                        <input style="border: 1px solid;" type="file" id="upload_modul{{no}}">
					                        <p class="help-block text-red">File type : PDF</p>                 
					                        <p class="help-block text-red">Max : 10Mb </p>                 
					                      </div>
					                    </div>
					                  <div class="col-md-4">
					                  <button onclick="upload_modul('{{no}}')" class="pull-left btn bg-navy btn-flat margin">Upload</button>
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
					{% if v.file != "" %}
						<a href="<?= BASE_URL ?>data/mata_kuliah/modul_kelas/{{v.file}}" target="_blank"><button class="btn btn-block btn-success btn-flat"><i class="fa fa-fw fa-download"></i> Download File</button></a>
					{% else %}
						-- Belum Tersedia --
					{% endif %}
				</td>
            </tr>
            {% set no=no+1 %}
            {% endfor %}

            </tbody>            
          </table><br>
          <p class="text-aqua">* File Sudah di upluoad (Bisa di replace)</p>
          <p class="text-yellow">* File Belum di upluoad</p>
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
	var link = '{{ url("akademik/listKelasMk/") }}';

	reload_page_data(link,datas);
}

function upload_modul(no) {


    var kode_mk = $('#kode_mk'+no).val();   
    var nama_kelas = $('#nama_kelas'+no).val();   
    var thn_kur = $('#thn_kur'+no).val();   
    var sesi = "{{sesi}}";   
    
	var link = '{{ url("akademik/uploadModulKelas?kode_mk=") }}'+kode_mk+"&nama_kelas="+nama_kelas;
    var file_data = $('#upload_modul'+no).prop('files')[0];   
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
          url: link, // point to server-side PHP script 
          dataType: 'json',  // what to expect back from the PHP script, if anything
          cache: false,
          type: 'POST',
          contentType: false,
          processData: false,
          data: form_data,                         
          type: 'post',
          success: function(data){
          	var datas = "sesi="+sesi+"&kode_mk="+kode_mk+"&thn_kur="+thn_kur+"&nama_kelas="+nama_kelas+"&file="+data.file;
			var urel = '{{ url("akademik/dataUploadModulKelas") }}';

          	$.ajax({
				type: "POST",
				url: urel,
				dataType : "json",
				data: datas
			}).done(function( data ) {
				console.log('upload berhasil');
			});

			new PNotify({
				title: data.title,
				text: data.text,
				type: data.type
			});

			reload();

			$('#modul'+no).modal('hide');
			$('body').removeClass('modal-open');
			$("body").css("padding-right", "0px");
			$('.modal-backdrop').remove();
          }
       });
    }

}

</script>