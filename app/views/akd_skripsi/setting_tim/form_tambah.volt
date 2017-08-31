<section class="content-header">
    <h1>
        <button type="button" onclick="back()" class="btn bg-navy btn-flat margin"><i class="fa fa-fw fa-arrow-left"></i> Back</button>
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
          <h3 class="box-title">Tambah Setting Skripsi</h3>
        </div><!-- /.box-header -->
        <div class="box-body">
        <form method="post">
            <table class="table table-condensed">
              <tbody>
                <tr>
					<td style="padding: 11px 6px;width: 130px; background: #eee" class="text-left"><b>Periode :</b></td>
					<td>Tgl : <input type="text" name="dd_periode" size="2" maxlength="2" value="<?= date('d') ?>">                 
					
						<select name="mm_periode">
							<option value="1" >Januari</option>
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
					                
					<input type="text" maxlength="4" name="yyyy_periode" size="4" value="<?= date('Y') ?>">            
                </tr>

                <tr>
                  <td style="padding: 11px 6px;width: 130px; background: #eee" class="text-left"><b>Tim :</b></td>
                  	<td>
	                  	<div class="input-group">
	                      <select class="form-control" name="tim" id="ruang_ujian" >
		                        <option value=""> </option>
		                        	
		                        <?php foreach ($tim as $key => $value): ?>
			                    <option value="<?= $value ?>"><?= $value ?> </option>
		                        <?php endforeach ?>
		                       
	                      </select>
	                    </div><!-- /.input group -->
                   	</td>                  
                </tr>
                <tr>
                  <td style="padding: 11px 6px;width: 130px; background: #eee" class="text-left"><b>Penguji 1 :</b></td>
                  	<td>
	                  	<div class="input-group">
	                      <select class="form-control" name="penguji_1" id="ruang_ujian" >
		                        <option value=""> </option>
		                        	
		                        <?php foreach ($dosen as $key => $value): ?>
			                    <option value="<?= $value['nip'] ?>"><?= $value['nama'] ?> </option>
		                        <?php endforeach ?>
		                       
	                      </select>
	                    </div><!-- /.input group -->
                   	</td>                  
                </tr>
                <tr>
                  <td style="padding: 11px 6px;width: 130px; background: #eee" class="text-left"><b>Penguji 2 :</b></td>
                  	<td>
	                  	<div class="input-group">
	                      <select class="form-control" name="penguji_2" id="ruang_ujian" >
		                        <option value=""> </option>
		                        	
		                        <?php foreach ($dosen as $key => $value): ?>
			                    <option value="<?= $value['nip'] ?>"><?= $value['nama'] ?> </option>
		                        <?php endforeach ?>
		                       
	                      </select>
	                    </div><!-- /.input group -->
                   	</td>                  
                </tr>
                <tr>
                  <td style="padding: 11px 6px;width: 130px; background: #eee" class="text-left"><b>Penguji 3 :</b></td>
                  	<td>
	                  	<div class="input-group">
	                      <select class="form-control" name="penguji_3" id="ruang_ujian" >
		                        <option value=""> </option>
		                        	
		                        <?php foreach ($dosen as $key => $value): ?>
			                    <option value="<?= $value['nip'] ?>"><?= $value['nama'] ?> </option>
		                        <?php endforeach ?>
		                       
	                      </select>
	                    </div><!-- /.input group -->
                   	</td>                  
                </tr>
                <tr>
                  <td style="padding: 11px 6px;width: 130px; background: #eee" class="text-left"><b>Mata Kuliah 1 :</b></td>
                  	<td>
	                  	<div class="input-group">
	                      <select class="form-control" name="mk_1" id="ruang_ujian" >
		                        <option value=""> </option>
		                        	
		                        <?php foreach ($mk as $key => $value): ?>
			                    <option value="<?= $value['kode_mk'] ?>"><?= $value['mk_2'] ?> </option>
		                        <?php endforeach ?>
		                       
	                      </select>
	                    </div><!-- /.input group -->
                   	</td>                  
                </tr>
                <tr>
                  <td style="padding: 11px 6px;width: 130px; background: #eee" class="text-left"><b>Mata Kuliah 2 :</b></td>
                  	<td>
	                  	<div class="input-group">
	                      <select class="form-control" name="mk_2" id="ruang_ujian" >
		                        <option value=""> </option>
		                        	
		                        <?php foreach ($mk as $key => $value): ?>
			                    <option value="<?= $value['kode_mk'] ?>"><?= $value['mk_2'] ?> </option>
		                        <?php endforeach ?>
		                       
	                      </select>
	                    </div><!-- /.input group -->
                   	</td>                  
                </tr>
                <tr>
                  <td style="padding: 11px 6px;width: 130px; background: #eee" class="text-left"><b>Mata Kuliah 3 :</b></td>
                  	<td>
	                  	<div class="input-group">
	                      <select class="form-control" name="mk_3" id="ruang_ujian" >
		                        <option value=""> </option>
		                        	
		                        <?php foreach ($mk as $key => $value): ?>
			                    <option value="<?= $value['kode_mk'] ?>"><?= $value['mk_2'] ?> </option>
		                        <?php endforeach ?>
		                       
	                      </select>
	                    </div><!-- /.input group -->
                   	</td>                  
                </tr>
                <tr>
					<td style="padding: 11px 6px;width: 130px; background: #eee" class="text-left"><b>Tanggal Skripsi :</b></td>
					<td>Tgl : <input type="text" name="dd_skripsi" size="2" maxlength="2" value="<?= date('d') ?>">                 
					
						<select name="mm_skripsi">
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
					                
					<input type="text" maxlength="4" name="yyyy_skripsi" size="4" value="<?= date('Y') ?>">            
					 Jam : <input type="text" name="jam_skripsi" id="t1" size="5" maxlength="5" value="<?= date('H:i') ?>"></td>                  
                </tr>
                <tr>
                  <td style="padding: 11px 6px;width: 130px; background: #eee" class="text-left"><b>No Surat :</b></td>
                  	<td>
	                  	<div class="input-group">
	                  		<input type="text" class="form-control" name="no_surat" placeholder="No Surat">
	                    </div><!-- /.input group -->
                   	</td>                  
                </tr>
                <tr>
					<td style="padding: 11px 6px;width: 130px; background: #eee" class="text-left"><b>Tanggal Surat :</b></td>
					<td>Tgl : <input type="text" name="dd_surat" size="2" maxlength="2" value="<?= date('d') ?>">                 
					
						<select name="mm_surat">
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
					                
					<input type="text" maxlength="4" name="yyyy_surat" size="4" value="<?= date('Y') ?>">            
                </tr>
              </tbody>
            </table>
            <button style="margin: 0;" type="button" onclick="add_setting()" class="btn bg-navy btn-flat pull-right"><i class="fa fa-fw fa-edit"></i> Tambah</button>
            </form>
        </div>
    </div>
  </div>

    </div>

    <div class="row">
      <div class="col-md-12 data_mhs">
          
      </div>
    </div>


</section><!-- /.content -->


<script type="text/javascript">

function back() {
	var link = '{{ url("akdsettingtim/cariTim/") }}';
    go_page(link);
}

function add_setting() {
	var link = '{{ url("akdsettingtim/addData/") }}';
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
	});
}
</script>
