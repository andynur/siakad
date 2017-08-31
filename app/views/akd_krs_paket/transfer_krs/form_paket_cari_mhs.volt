<section class="content-header">
  <h1><button type="button" onclick="back()" class="btn bg-navy btn-flat margin"><i class="fa fa-fw fa-arrow-left"></i> Back</button></h1>
  <ol class="breadcrumb">
    <li><a href="#"><i class="fa fa-dashboard"></i> {{nama_sesi}}</a></li>
  </ol>
</section>

<!-- Main content -->
<section class="content">

  <div class="row">
    <div class="col-md-1"></div>
    <div class="col-md-10">
      <div class="box">
        <div class="box-header with-border">
          <h3 class="box-title">CROSS CHECK PAKET</h3>
        </div><!-- /.box-header -->
        <div class="box-body">
          <table id="" class="table table-bordered">
            <thead>
              <tr>
                <th style="width: 10px">No</th>
                <th>Thn Kur</th>
                <th>Kode MK</th>
                <th>Nama MK</th>
                <th>Kelas</th>
                <th>Keterangan</th>
              </tr>
            </thead>
            <tbody>
            
            {% set no=1 %}
            {% for v in mk_paket %}
            <?php $is_admin = ($v->kode_mk == '') ? "tidak_ditawarkan" : ''; ?>
            <tr>
				<td>{{no}}</td>
				<td>{{v.thn_kur}}</td>
				<td>{{v.kode_mk}}</td>
				<td>{{v.nama}}</td>
				<td>{{v.nama_kelas}}</td>
				{% if v.kode_mk != "" %}
				    <td>OK</td>
				{% else %}
				    <td>... tidak ditawarkan ...</td>
				{% endif %}
            </tr>
            {% set no=no+1 %}
            {% endfor %}

            </tbody>            
          </table><br>
        </div><!-- /.box-body -->
      </div><!-- /.box -->
    </div>

  </div>

  <div class="row">
    <div class="col-md-2"></div>
    <div class="col-md-8">
      <div class="box">
        <div class="box-header with-border">
          <h3 class="box-title">Pilih Mahasiswa</h3>
        </div><!-- /.box-header -->
        <div class="box-body">
          <table class="table">
		    <tbody>
		      <tr>
		        <td>Nomor Mahasiswa :</td>
		        <td><input type="text" class="form-control" id="nomhs" placeholder="Enter..."></td>
		        <td></td>
		        <td></td>
		      </tr>
		      <tr class="form-horizontal">
		        <td>Range Nomor Mahasiswa :</td>
		        <td><input type="text" class="form-control" id="range1" placeholder="Enter..."></td>
		        <td><label for="inputEmail3" class="col-sm-2 control-label">S/D</label></td>
		        <td><input type="text" class="form-control" id="range2" placeholder="Enter..."></td>
		      </tr>
		      <tr>
		        <td>Angkatan :</td>
		        <td><select id="angkatan" class="form-control">
			            <option value="">- pilih tahun -</option>
			            {% for a in angkatan %}
			            <option value="{{a.angkatan}}">{{a.angkatan}}</option>
			            {% endfor %}
			        </select>
			    </td>
		        <td></td>
		        <td></td>
		      </tr>
		    </tbody>
		 </table>
		 <button type="button" onclick="select_mhs()" class="btn btn-flat bg-navy pull-right "><i class="fa fa-fw fa-search"></i> Cari</button>
        </div><!-- /.box-body -->
      </div><!-- /.box -->
    </div>

  </div>

      
</section><!-- /.content -->

<style type="text/css">
	.tidak_ditawarkan{
		background-color: antiquewhite;
	}
</style>
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

function back() {
	var sesi = "{{sesi}}";
	var link = '{{ url("akdkrspaket/formSelectPaket/") }}';
	var datas = 'sesi='+sesi;
    go_page_data(link,datas);
}

function select_mhs() {
	var nomhs = $("#nomhs").val();
	var range1 = $("#range1").val();
	var range2 = $("#range2").val();
	var angkatan = $("#angkatan").val();

	if (nomhs == '' || renge1 == '' && range2 == '' || angkatan == '') {
		new PNotify({
			title: 'Regular Notice',
			text: 'Form Pilih MHS tidak boleh kosong!',
			type:'warning'
		});
	}else{
		var paket_id = "{{paket_id}}";
		var sesi = "{{sesi}}";

		var datas = "nomhs="+nomhs+"&range1="+range1+"&range2="+range2+"&angkatan="+angkatan+"&sesi="+sesi+"&paket_id="+paket_id;
		var link = '{{ url("akdkrspaket/cariMhsPaket/") }}';
		go_page_data(link,datas);
	}
	
}

</script>