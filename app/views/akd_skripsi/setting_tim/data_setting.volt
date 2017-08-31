
      <div class="box">
        <div class="box-header with-border">
          <h3 class="box-title">Data Periode Skripsi</h3>
        </div><!-- /.box-header -->
        <div class="box-body">
          <table id="" class="table table-bordered">
            <thead>
              <tr>
                <th style="width: 10px">No</th>
                <th>Tim</th>
                <th>Penguji 1</th>
                <th>Penguji 2</th>
                <th>Penguji 3</th>
                <th>MK 1</th>
                <th>MK 2</th>
                <th>MK 3</th>
                <th>Tgl Skripsi</th>
                <th>No Surat</th>
                <th>Tgl Surat</th>
              </tr>
            </thead>
            <tbody>
            
			<?php $no=1; foreach ($data_setting as $key => $v): ?>
            <tr>
				<td><?= $no ?></td>
				<td><a href="javascript:void(0)" onclick="edit_tim('<?= $v['id'] ?>')"><?= $v['tim'] ?></a></td>
				<td><?= $v['nama1'] ?></td>
				<td><?= $v['nama2'] ?></td>
				<td><?= $v['nama3'] ?></td>
				<td><?= $v['mk1'] ?></td>
				<td><?= $v['mk2'] ?></td>
				<td><?= $v['mk3'] ?></td>
				<td><?= $v['tgl_skripsi'] ?></td>
				<td><?= $v['no_surat'] ?></td>
				<td><?= $v['tgl_surat'] ?></td>
            </tr>
			<?php $no++; endforeach ?>


            </tbody>            
          </table><br>
        </div><!-- /.box-body -->
      </div><!-- /.box -->



<script type="text/javascript">

function dataPeriodeSkripsi() {
	var link = '{{ url("akdsettingtim/dataPeriodeSkripsi/") }}';
	var datas = $('form').serialize();
    go_page_data(link,datas);
}

function tambah_setting() {
	var link = '{{ url("akdsettingtim/formTambah/") }}';
    go_page(link);
}

function edit_tim(id) {
	var link = '{{ url("akdsettingtim/formEdit/") }}'+id;
    go_page(link);
}
</script>
