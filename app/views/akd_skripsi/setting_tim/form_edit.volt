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
          <h3 class="box-title">Edit Setting Skripsi</h3>
        </div><!-- /.box-header -->
        <div class="box-body">
        <?php foreach ($data_setting as $b => $a): ?>
        <?php 

        	$periode = $a['periode'];
			$skripsi = $a['tgl_skripsi'];
			$surat = $a['tgl_surat'];

			$tgl_periode = date("d", strtotime($periode));
			$bln_periode = date("m", strtotime($periode));
			$tahun_periode = date("Y", strtotime($periode));

			$tgl_skripsi = date("d", strtotime($skripsi));
			$bln_skripsi = date("m", strtotime($skripsi));
			$tahun_skripsi = date("Y", strtotime($skripsi));
			$jam_skripsi = date("H:i", strtotime($skripsi));

			$tgl_surat = date("d", strtotime($surat));
			$bln_surat = date("m", strtotime($surat));
			$tahun_surat = date("Y", strtotime($surat));


        ?>

        <form method="post">
            <table class="table table-condensed">
              <tbody>
                <tr>
					<td style="padding: 11px 6px;width: 130px; background: #eee" class="text-left"><b>Periode :</b></td>
					<td>Tgl : <input type="text" name="dd_periode" size="2" maxlength="2" value="<?= $tgl_periode ?>">                 
					
						<select name="mm_periode">
							<?php foreach ($bulan as $key => $value): ?>
								<?php if ($bln_periode == $key): ?>
								<option value="<?= $key ?>" selected><?= $value ?></option>
								<?php else: ?>
								<option value="<?= $key ?>" ><?= $value ?></option>
								<?php endif ?>
							<?php endforeach ?>
						</select>
					                
					<input type="text" maxlength="4" name="yyyy_periode" size="4" value="<?= $tahun_periode ?>">            
                </tr>

                <tr>
                  <td style="padding: 11px 6px;width: 130px; background: #eee" class="text-left"><b>Tim :</b></td>
                  	<td>
	                  	<div class="input-group">
	                      <select class="form-control" name="tim" id="ruang_ujian" >
		                        <option value=""> </option>
		                        	
		                        <?php foreach ($tim as $key => $value): ?>
		                        	<?php if ($a['tim'] == $value): ?>
			                    	<option value="<?= $value ?>" selected><?= $value ?> </option>
		                        	<?php else: ?>
			                    	<option value="<?= $value ?>"><?= $value ?> </option>
		                        	<?php endif ?>
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
		                        	<?php if ($a['uji_1'] == $value['nip'] ): ?>	
			                    	<option value="<?= $value['nip'] ?>" selected><?= $value['nama'] ?> </option>
		                        	<?php else: ?>
			                    	<option value="<?= $value['nip'] ?>"><?= $value['nama'] ?> </option>
		                        	<?php endif ?>
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
			                    	<?php if ($a['uji_2'] == $value['nip'] ): ?>	
			                    	<option value="<?= $value['nip'] ?>" selected><?= $value['nama'] ?> </option>
		                        	<?php else: ?>
			                    	<option value="<?= $value['nip'] ?>"><?= $value['nama'] ?> </option>
		                        	<?php endif ?>
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
			                    	<?php if ($a['uji_3'] == $value['nip'] ): ?>	
			                    	<option value="<?= $value['nip'] ?>" selected><?= $value['nama'] ?> </option>
		                        	<?php else: ?>
			                    	<option value="<?= $value['nip'] ?>"><?= $value['nama'] ?> </option>
		                        	<?php endif ?>
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
		                        	<?php if ($a['mk_1'] == $value['kode_mk'] ): ?>
			                    	<option value="<?= $value['kode_mk'] ?>" selected><?= $value['mk_2'] ?> </option>
		                        	<?php else: ?>
			                    	<option value="<?= $value['kode_mk'] ?>"><?= $value['mk_2'] ?> </option>
		                        	<?php endif ?>
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
			                    	<?php if ($a['mk_2'] == $value['kode_mk'] ): ?>
			                    	<option value="<?= $value['kode_mk'] ?>" selected><?= $value['mk_2'] ?> </option>
		                        	<?php else: ?>
			                    	<option value="<?= $value['kode_mk'] ?>"><?= $value['mk_2'] ?> </option>
		                        	<?php endif ?>
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
			                    	<?php if ($a['mk_3'] == $value['kode_mk'] ): ?>
			                    	<option value="<?= $value['kode_mk'] ?>" selected><?= $value['mk_2'] ?> </option>
		                        	<?php else: ?>
			                    	<option value="<?= $value['kode_mk'] ?>"><?= $value['mk_2'] ?> </option>
		                        	<?php endif ?>
		                        <?php endforeach ?>
		                       
	                      </select>
	                    </div><!-- /.input group -->
                   	</td>                  
                </tr>
                <tr>
					<td style="padding: 11px 6px;width: 130px; background: #eee" class="text-left"><b>Tanggal Skripsi :</b></td>
					<td>Tgl : <input type="text" name="dd_skripsi" size="2" maxlength="2" value="<?= $tgl_skripsi ?>">                 
					
						<select name="mm_skripsi">
							<?php foreach ($bulan as $key => $value): ?>
								<?php if ($bln_skripsi == $key): ?>
								<option value="<?= $key ?>" selected><?= $value ?></option>
								<?php else: ?>
								<option value="<?= $key ?>" ><?= $value ?></option>
								<?php endif ?>
							<?php endforeach ?>
						</select>
					                
					<input type="text" maxlength="4" name="yyyy_skripsi" size="4" value="<?= $tahun_skripsi ?>">            
					 Jam : <input type="text" name="jam_skripsi" id="t1" size="5" maxlength="5" value="<?= $jam_skripsi ?>"></td>                  
                </tr>
                <tr>
                  <td style="padding: 11px 6px;width: 130px; background: #eee" class="text-left"><b>No Surat :</b></td>
                  	<td>
	                  	<div class="input-group">
	                  		<input type="text" class="form-control" name="no_surat" value="<?= $a['no_surat'] ?>">
	                    </div><!-- /.input group -->
                   	</td>                  
                </tr>
                <tr>
					<td style="padding: 11px 6px;width: 130px; background: #eee" class="text-left"><b>Tanggal Surat :</b></td>
					<td>Tgl : <input type="text" name="dd_surat" size="2" maxlength="2" value="<?= $tgl_surat ?>">                 
					
						<select name="mm_surat">
							<?php foreach ($bulan as $key => $value): ?>
								<?php if ($bln_surat == $key): ?>
								<option value="<?= $key ?>" selected><?= $value ?></option>
								<?php else: ?>
								<option value="<?= $key ?>" ><?= $value ?></option>
								<?php endif ?>
							<?php endforeach ?>
						</select>
					                
					<input type="text" maxlength="4" name="yyyy_surat" size="4" value="<?= $tgl_surat ?>">            
                </tr>
              </tbody>
            </table>
            <button style="margin: 0;" type="button" onclick="edit_setting('<?= $a['id'] ?>')" class="btn bg-navy btn-flat pull-right"><i class="fa fa-fw fa-edit"></i> Edit</button>
            </form>

          <?php endforeach ?>
        </div>
    </div>
  </div>

    </div>



</section><!-- /.content -->


<script type="text/javascript">

function back() {
	var link = '{{ url("akdsettingtim/cariTim/") }}';
    go_page(link);
}

function edit_setting(id) {
	var link = '{{ url("akdsettingtim/editData/") }}'+id;
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
