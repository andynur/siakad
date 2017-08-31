<section class="content-header">
  <h1><button type="button" onclick="back()" class="btn bg-navy btn-flat"><i class="fa fa-fw fa-arrow-left"></i> Back</button></h1>
  <ol class="breadcrumb">
    <li><a href="#"><i class="fa fa-dashboard"></i> Reset</a></li>
    <li class="active">Password</li>
  </ol>
</section>

<!-- Main content -->
<section class="content">
  <div class="row">
    <!-- left column -->
    <div class="col-md-12">
      <div class="box box-info">
      	<div class="box-header with-border" >
          <b><h2 class="box-title text-navy">Tambah Kurikulum <span class="text-red">{{thn_kur}}</span></h2></b>
        </div>
        <div class="box-body">

    	<form method="post" class="add_form">
            <div class="row">
              <div class="col-lg-12">
                <div class="row">
                  <div class="col-lg-6">
                    <div class="col-lg-12">
                      <div class="form-group">
                        <label>Tahun <span style="color:red">*</span></label>
                        <p id="label_thn" style="display:none;padding:7px;border:solid #ddd 1px;"><span>Tahun </span></p>
                        <input name="thn_kur" value="{{thn_kur}}" type="number" id="tahun" class="form-control">
                      </div>
                    </div><!-- /.col-lg-12 -->
                  </div>
                  <div class="col-lg-12">
                    <div class="col-lg-12">
                      <div class="form-group">
                        <h2 class="color:red;">Data Kurikulum </h2>
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
                    <p class="help-block text-red">* Kode MK tidak boleh sama dengan yang lain</p>	
                  </div>
                </div><!-- /.col-lg-12 -->

                <div class="col-lg-6">
                  <div class="form-group">
                    <label>Semester <span style="color:red">*</span></label>
                    <input name="semester" type="number" id="semester" placeholder=" Semester" class="form-control" >
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

                <div class="col-lg-12">
                  <div class="form-group">
                    <label>SKS</label><span style="color:red">*</span>
                    <input name="sks" type="number" id="sks" placeholder=" SKS" class="form-control" >
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
                    <label>SKS Klinik</label>
                    <input name="sks_klinik" type="text" id="sks_klinik" placeholder="SKS Klinik" class="form-control" >
                  </div>
                </div><!-- /.col-lg-12 -->

                <div class="col-lg-6">
                  <div class="form-group">
                    <label>SKS Praktek</label>
                    <input name="sks_praktek" type="text" id="sks_praktek" placeholder=" SKS Praktek" class="form-control" >
                  </div>
                </div><!-- /.col-lg-12 -->

              </div><!-- /.col-lg-6 -->

              <div class="col-lg-6">

              <div class="col-lg-6">
                <div class="form-group">
                  <label>Kelompok 
                  <input name="kelompok" type="text" id="kelompok" placeholder=" Kelompok" class="form-control" >
                </div>
              </div><!-- /.col-lg-12 -->

              <div class="col-lg-6">
                <div class="form-group">
                  <label>Jenis <span style="color:red">*</span></label>
                  <select name="jenis" class="form-control">
                        <option value="W">Wajib</option>
                        <option value="P">Pilihan</option>
                  </select>
                </div>
              </div><!-- /.col-lg-12 -->

                <div class="col-lg-12">
                  <div class="form-group">
                    <label>Prasyarat</label>
                    <input name="prasyarat" type="text" id="prasyarat" placeholder=" Persyaratan" class="form-control" >
                    <p class="text-red">*Gunakan AND untuk prasyarat lebih dari 1 </p>
                    <p class="text-red">*contoh </p>
                    <p class="text-aqua">AK123 >= D AND AK456 >= A </p>
                    <p class="text-aqua">#IPK >= 3.00 </p>
                    <p class="text-aqua">#IPS >= 3.00 </p>
                  </div>
                </div><!-- /.col-lg-12 -->

                <div class="col-lg-6">
                  <div class="form-group">
                    <label>Kode Agama <span style="color:red">*</span></label>
                    <select name="kode_agama" class="form-control">
                      {% for v in agama %}
		                    <option value="{{v.id_agama}}">{{v.nama}}</option>
		              {% endfor %}
                    </select>
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
                    <label> <span style="color:red">*</span> Wajib di isi</label><br>
                  </div>
                </div>
              </div>

            </div><!-- /.row -->
            	<button type="button" class="btn btn-success pull-right" onclick="add_data()">Save changes</button>
  			</form>
        </div>
      </div><!-- /.box -->
    </div>

  </div>
      
</section><!-- /.content -->

<script type="text/javascript">

function back() {
	var link = '{{ url("akademik/kurikulum/") }}';
    go_page(link);	
}

function reload() {
  var link = '{{ url("akademik/kurikulum") }}';
  go_page(link);  
}

function upload_silabus(){
  var urel = '{{ url("sysinformasi/uploadSilabus") }}';
    var file_data = $('#upload_silabus').prop('files')[0];   
    var form_data = new FormData();                  
    form_data.append('file', file_data);

    // alert(form_data);                             
    $.ajax({
        url: urel, // point to server-side PHP script 
        dataType: 'json',  // what to expect back from the PHP script, if anything
        cache: false,
        contentType: false,
        processData: false,
        data: form_data,                         
        type: 'post',
        success: function(data){
          console.log("upload_silabus");
        }
    });
}

function upload_sap(){
  var urel = '{{ url("sysinformasi/uploadSap") }}';
    var file_data = $('#upload_sap').prop('files')[0];   
    var form_data = new FormData();                  
    form_data.append('file', file_data);

    // alert(form_data);                             
    $.ajax({
        url: urel, // point to server-side PHP script 
        dataType: 'json',  // what to expect back from the PHP script, if anything
        cache: false,
        contentType: false,
        processData: false,
        data: form_data,                         
        type: 'post',
        success: function(data){
          console.log("upload_sap");
        }
    });
}

function upload_modul(){
  var urel = '{{ url("sysinformasi/uploadModul") }}';
    var file_data = $('#upload_modul').prop('files')[0];   
    var form_data = new FormData();                  
    form_data.append('file', file_data);

    // alert(form_data);                             
    $.ajax({
        url: urel, // point to server-side PHP script 
        dataType: 'json',  // what to expect back from the PHP script, if anything
        cache: false,
        contentType: false,
        processData: false,
        data: form_data,                         
        type: 'post',
        success: function(data){
          console.log("upload_modul");
        }
    });
}

function add_data(){
    var datas = $('.add_form').serialize();
    $.ajax({
      type: "POST",
      url: "{{ url('akademik/submitKurikulum') }}",
      dataType : "json",
      data: datas
    }).done(function(data) {
      new PNotify({
         title: data.title,
         text: data.text,
         type: data.type
      });
      if (data.type == "success") {
        reload();
        upload_silabus();
        upload_sap();
        upload_modul();
      }
    });
}

</script>