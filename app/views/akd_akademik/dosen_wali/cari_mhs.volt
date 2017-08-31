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

    <div class="col-md-1"></div>
    <div class="col-md-10">
      <div class="box">
        <div class="box-header">
          <h3 class="box-title">Data Table With Full Features</h3>
        </div><!-- /.box-header -->
        <div class="box-body">
          <table id="example2" class="table table-bordered table-striped">
            <thead>
              <tr>
                <th style="padding: 1px;" style="width: 10px">No</th>
                <th style="padding: 1px;" style="">NoMhs</th>
                <th style="padding: 1px;">Nama</th>
                <th style="padding: 1px;">Angkatan</th>
                <th style="padding: 1px;">Tambah</th>
              </tr>
            </thead>
            <tbody>
            
            {% set no=1 %}
            {% for v in mhs %}
            <tr>
              <td style="padding: 1px;">{{no}}</td>
              <td style="padding: 1px;">{{v.id_mhs}}</td>
              <td style="padding: 1px;">{{v.nama}}</td>
              <td style="padding: 1px;">{{v.angkatan}}</td>
              <td style="padding: 1px;">
              	{% if v.nama_dsn == '' %}
              		<input type="checkbox" id="ch" value="{{v.id_mhs}}">
              	{% else %}
              		<p class="text-green"> {{v.nama_dsn}}</p>
              	{% endif %}
              </td>
            </tr>
            {% set no=no+1 %}
            {% endfor %}

            </tbody>     
          </table><br>
            <div class="row">
    			<div class="col-md-4">
		          	<div class="form-group">
			          <label>Select Sesi Membimbing</label>
			          <select id="session" class="form-control">
			        	{% for v in session %}
			            	<option value="{{v.thn_akd}}-{{v.session_id}}">{{v.nama}} {{v.thn_akd}}/{{v.thn_akd+1}}</option>
			        	{% endfor %}
			          </select>
			        </div>
    			</div>
    			<div class="col-md-4">
    				<button style="margin-top: 24px;" type="button" onclick="add_bimbingan('')" class="btn bg-navy btn-flat margin pull-left"><i class="fa fa-fw fa-plus-square"></i> Simpan</button>
    			</div>
    		</div>
            
        </div><!-- /.box-body -->
      </div><!-- /.box -->
    </div>
    <div class="col-md-1"></div>
  </div>
      
</section><!-- /.content -->

<script type="text/javascript">

$(function () {

});

function back() {
    var nip = "{{nip}}";
    var link = '{{ url("akddosenwali/dosenWali/") }}'+nip;
    go_page(link);  
}

function add_bimbingan() {
	var nomhs =[];
	$('input[type=checkbox]:checked').each(function(index){
		nomhs.push($(this).val());
	});
	nomhs.toString();
	var session = $("#session").val();
	var nip = "{{nip}}";

	var datas = "nomhs="+nomhs+"&session="+session+"&nip="+nip;
	var urel = '{{ url("akddosenwali/addMhsBimbingan/") }}';

	if (nomhs.length == 0) {
      new PNotify({
        title: 'Regular Notice',
        text: 'Pilih MHS yang akan di Pilih',
        type:'warning'
      });
    }else{ 
		$.ajax({
		   type: "POST",
		   url: urel,
		   dataType : "json",
		   data: datas
		}).done(function( data ) {	  
		   	new PNotify({
				title: 'Regular Notice',
				text: 'data telah disimpan',
				type:'success'
		   	});
		  	back();
		});
    }


}
  
</script>