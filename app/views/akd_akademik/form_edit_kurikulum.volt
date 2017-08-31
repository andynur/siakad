{% for v in data %}

<section class="content-header">
  <h1><button type="button" onclick="back('{{v.thn_kur}}')" class="btn bg-navy btn-flat"><i class="fa fa-fw fa-arrow-left"></i> Back</button></h1>
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
          <b><h2 class="box-title text-navy">Edit Kurikulum = <span class="text-aqua">{{v.kode_mk}}</span> {{v.nama}} <span class="text-red"></span></h2></b>
        </div>
        <div class="box-body">

    	<form method="post" class="edit_form">
            <div class="row">
              <div class="col-lg-12">
                <div class="row">
                  <div class="col-lg-6">
                    <div class="col-lg-12">
                      <div class="form-group">
                        <label>Tahun <span style="color:red">*</span></label>
                        <p id="label_thn" style="display:none;padding:7px;border:solid #ddd 1px;"><span>Tahun </span></p>
                        <input name="thn_kur" value="{{v.thn_kur}}" type="number" id="tahun" class="form-control" disabled>
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
                    <input type="text" id="kode_mk" value="{{v.kode_mk}}" class="form-control" disabled>
                    <p class="help-block text-red">* Kode MK tidak boleh sama dengan yang lain</p>	
                  </div>
                </div><!-- /.col-lg-12 -->

                <div class="col-lg-6">
                  <div class="form-group">
                    <label>Semester <span style="color:red">*</span></label>
                    <input name="semester" value="{{v.semester}}" type="number" id="semester" class="form-control" >
                  </div>
                </div><!-- /.col-lg-12 -->

                <div class="col-lg-12">
                  <div class="form-group">
                    <label>Nama <span style="color:red">*</span></label>
                    <input name="nama" type="text" id="nama" value="{{v.nama}}" class="form-control" >
                  </div>
                </div><!-- /.col-lg-12 -->

                <div class="col-lg-12">
                  <div class="form-group">
                    <label>Nama English</label>
                    <input name="nama_en" type="text" id="nama_en" value="{{v.nama_en}}" class="form-control" >
                  </div>
                </div><!-- /.col-lg-12 -->

                <div class="col-lg-12">
                  <div class="form-group">
                    <label>SKS</label><span style="color:red">*</span>
                    <input name="sks" type="number" id="sks" value="{{v.sks}}" class="form-control" >
                  </div>
                </div><!-- /.col-lg-12 -->

                <div class="col-lg-6">
                  <div class="form-group">
                    <label>SKS Teori</label>
                    <input name="sks_teori" type="text" id="sks_teori" value="{{v.sks_teori}}" class="form-control" >
                  </div>
                </div><!-- /.col-lg-12 -->

                <div class="col-lg-6">
                  <div class="form-group">
                    <label>SKS Klinik</label>
                    <input name="sks_klinik" type="text" id="sks_klinik" value="{{v.sks_klinik}}" class="form-control" >
                  </div>
                </div><!-- /.col-lg-12 -->

                <div class="col-lg-6">
                  <div class="form-group">
                    <label>SKS Praktek</label>
                    <input name="sks_praktek" type="text" id="sks_praktek" value="{{v.sks_praktek}}" class="form-control" >
                  </div>
                </div><!-- /.col-lg-12 -->

              </div><!-- /.col-lg-6 -->

              <div class="col-lg-6">

              <div class="col-lg-6">
                <div class="form-group">
                  <label>Kelompok 
                  <input name="kelompok" type="text" id="kelompok" value="{{v.kelompok}}"s class="form-control" >
                </div>
              </div><!-- /.col-lg-12 -->

              <div class="col-lg-6">
                <div class="form-group">
                  <label>Jenis <span style="color:red">*</span></label>
                  <select name="jenis" class="form-control">
                        <option value="W" {% if v.jenis == "W" %} selected {% endif %}>Wajib</option>
                        <option value="P" {% if v.jenis == "P" %} selected {% endif %}>Pilihan</option>
                  </select>
                </div>
              </div><!-- /.col-lg-12 -->

                <div class="col-lg-12">
                  <div class="form-group">
                    <label>Prasyarat</label>
                    <input name="prasyarat" type="text" id="prasyarat" value="{{v.prasyarat}}" class="form-control" >
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
                      {% for a in agama %}
		                    <option value="{{a.id_agama}}">{{a.nama}}</option>
		              {% endfor %}
                    </select>
                  </div>
                </div><!-- /.col-lg-12 -->

                <div class="col-lg-6">
                  <div class="form-group">
                    <label>Urut <span style="color:red">*</span></label>
                    <input name="urut" type="text" id="urut" value="{{v.urut}}" class="form-control" >
                  </div>
                </div><!-- /.col-lg-12 -->

                <div class="col-lg-12">
                  <div class="form-group">
                    <label>Deskripsi</label>
                    <textarea type="text" id="deskripsi" class="form-control" name="deskripsi" rows="5" cols="80">{{v.deskripsi}}</textarea>
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
            	<button type="button" class="btn btn-success pull-right" onclick="edit_data('{{v.id}}')">Save changes</button>
  			</form>
        </div>
      </div><!-- /.box -->
    </div>

  </div>
      
</section><!-- /.content -->

{% endfor %}


<script type="text/javascript">

function back(thn) {
	var link = '{{ url("akademik/listKurikulum/") }}'+thn;
    go_page(link);	
}

function reload(id) {
  var link = '{{ url("akademik/formEdit/") }}'+id;
	reload_page2(link);
}

function edit_data(id){
    var datas = $('.edit_form').serialize();
    // console.log(datas);
    $.ajax({
		type: "POST",
		url: "{{ url('akademik/editKurikulum/') }}"+id,
		dataType : "json",
		data: datas
	    }).done(function(data) {
	    new PNotify({
			title: data.title,
			text: data.text,
			type: data.type
		});
		if (data.type == "success") {
			reload(id);
		}
    });
}

</script>