
      <div class="box">
        <div class="box-header with-border">
          <h3 class="box-title">Data Periode Skripsi</h3>
        </div><!-- /.box-header -->
        <div class="box-body">
        <form method="post">
          <table id="" class="table table-bordered">
            <thead>
              <tr>
                <th style="width: 10px">No</th>
                <th>Nomhs</th>
                <th>Nama</th>
                <th width="30">Ke</th>
                <th width="400">Judul</th>
                <th>Pembimbing</th>
                <th width="75">Tim</th>
              </tr>
            </thead>
            <tbody>
            
			<?php $no=1; foreach ($data_skripsi as $key => $v): ?>
            <tr>
				<td><?= $no ?></td>
				<td><?= $v['nomhs'] ?></td>
				<td><?= $v['nama'] ?></td>
				<td><?= $v['ujian_ke'] ?></td>
				<td><?= $v['judul'] ?></td>
				<td>
					<p><?= $v['dosen1'] ?></p>
					<p><?= $v['dosen2'] ?></p>
				</td>
				<td>
					<select class="form-control" name="tim" id="tim<?= $v['id'] ?>" onchange="edit('<?= $v['id'] ?>')">
						<option value=""></option>
						<?php foreach ($tim as $key => $value): ?>
	                    	<?php if ($v['tim'] == $value): ?>
	                    	<option value="<?= $value ?>" selected><?= $value ?> </option>
	                    	<?php else: ?>
	                    	<option value="<?= $value ?>"><?= $value ?> </option>
	                    	<?php endif ?>
	                    <?php endforeach ?>
	                </select>
				</td>

            </tr>
			<?php $no++; endforeach ?>


            </tbody>            
          </table><br>
          </form>
        </div><!-- /.box-body -->
      </div><!-- /.box -->



<script type="text/javascript">

function edit(id) {
	var datas = 'tim='+$("#tim"+id).val();
	var link = '{{ url("akdisitim/editTim/") }}'+id;
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
