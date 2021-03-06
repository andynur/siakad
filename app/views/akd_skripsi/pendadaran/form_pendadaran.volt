<section class="content-header">
    <h1>
        <button type="button" onclick="back()" class="btn bg-navy btn-flat"><i class="fa fa-fw fa-arrow-left"></i> Back</button>
    </h1>
    <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i> Mahasiswa</a></li>
        <li class="active">Skripsi</li>
    </ol>
</section>

<!-- Main content -->
<section class="content">


    <!-- row -->
    <div class="row">
    	<div class="col-lg-2"></div>
    	<div class="col-md-8">
		    <div class="box">
		        <div class="box-header">
		          <h3 class="box-title">Isi Skripsi</h3>
		        </div><!-- /.box-header -->
		        <div class="box-body">
		        <form method="post">
		        <input type="text" name="psmhs_id" style="display: none;" value="{{psmhs_id}}">
		        <input type="text" name="nomhs" style="display: none;" value="{{nomhs}}">
		            <table class="table table-condensed">
		              <tbody>
		               	<tr>
		                  <td style="padding: 11px 6px;width: 130px; background: #eee" class="text-left"><b>Nomhs :</b></td>
		                  	<td>{{nama}}</td>                  
		                </tr>
		                <tr>
		                  <td style="padding: 11px 6px;width: 130px; background: #eee" class="text-left"><b>Nama :</b></td>
		                  	<td>{{nomhs}}</td>                  
		                </tr>
		                <tr>
		                  <td style="padding: 11px 6px;width: 130px; background: #eee" class="text-left"><b>Jurusan :</b></td>
		                  	<td>{{nama_jurusan}}</td>                  
		                </tr>
		                <tr>
							<td style="padding: 11px 6px;width: 130px; background: #eee" class="text-left"><b>Periode :</b></td>
							<td><input type="text" name="dd1" size="2" maxlength="2" value="">                 
							
								<select name="mm1">
									<option value="1" selected="">Januari</option>
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
							                
							<input type="text" maxlength="4" name="yyyy1" size="4" value=""></td>                  
		                </tr>
		                <tr>
		                  <td style="padding: 11px 6px;width: 130px; background: #eee" class="text-left"><b>Ujian :</b></td>
		                  	<td>
			                  	<div class="input-group">
			                      <select class="form-control" name="ujian_id" >
				                        <option value=""> </option>
		                       			{% for v in ujian %}
                                            <option value="{{v.id}}">{{v.nama}}</option>
                                        {% endfor %}			                       
			                      </select>
			                    </div><!-- /.input group -->
		                   	</td>                  
		                </tr>
		                <tr>
		                  <td style="padding: 11px 6px;width: 130px; background: #eee" class="text-left"><b>Ujian Ke :</b></td>
		                  	<td>
			                  	<div class="input-group">
			                      <select name="ujian_ke" class="form-control" >
				                        <option value=""> </option>
			                        	<?php for ($a=1; $a<=5; $a++) {
										     echo "<option value='$a'>$a</option>";
										   }
										?>
			                      </select>
			                    </div><!-- /.input group -->
		                   	</td>                  
		                </tr>

		                <tr>
		                  <td style="padding: 11px 6px;width: 130px; background: #eee" class="text-left"><b>Judul :</b></td>
		                  	<td>
			                  	<div class="input-group">
			                      <textarea class="form-control" name="judul" placeholder="Enter ..." style="margin: 0px; width: 430px; height: 74px;"></textarea>
			                    </div><!-- /.input group -->
		                   	</td>                  
		                </tr>
		                <tr>
		                  <td style="padding: 11px 6px;width: 130px; background: #eee" class="text-left"><b>Pembimbing 1 :</b></td>
		                  	<td>
			                  	<div class="input-group">
			                      <select name="pembimbing1" class="form-control" >
				                        <option value=""> </option>
			                        	{% for val in dosen %}
		                                        <option value="{{val.nip}}" selected>{{val.nama_dosen}}</option>
		                                {% endfor %}
			                      </select>
			                    </div><!-- /.input group -->
		                   	</td>                  
		                </tr>
		                <tr>
		                  <td style="padding: 11px 6px;width: 130px; background: #eee" class="text-left"><b>Pembimbing 2 :</b></td>
		                  	<td>
			                  	<div class="input-group">
			                      <select name="pembimbing2" class="form-control" >
				                        <option value=""> </option>
			                        	{% for val in dosen %}
		                                        <option value="{{val.nip}}" selected>{{val.nama_dosen}}</option>
		                                {% endfor %}
			                      </select>
			                    </div><!-- /.input group -->
		                   	</td>                  
		                </tr>

		              </tbody>
		            </table>

		            <button style="margin: 0;" type="button" onclick="add_pendadaran()" class="btn bg-navy btn-flat pull-right"><i class="fa fa-fw fa-edit"></i> Tambah</button>
		            </form>
		        </div>
		    </div>
		  </div>


    </div>




</section><!-- /.content -->


<script type="text/javascript">

function back() {
	nama = '{{nama}}';
	nomhs = '{{nomhs}}';
	psmhs_id = '{{psmhs_id}}';
	angkatan = '{{angkatan}}';
    var link = '{{ url("akdpendadaran/dataSkripsi/") }}';
    var datas = 'nama='+nama+'&nomhs='+nomhs+'&psmhs_id='+psmhs_id+'&angkatan='+angkatan;
    go_page_data(link,datas);
}

function add_pendadaran() {
	var link = '{{ url("akdpendadaran/addPendadaran/") }}';
	var datas = $('form').serialize();
	$.ajax({
		type: "POST",
		url: link,
		dataType : "json",
		data: datas
	}).done(function( data ) {
		new PNotify({
		   title: data.title,
		   text: data.text,
		   type: data.type
		});
		back();
	});
}
</script>
