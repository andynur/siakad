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
          <h3 class="box-title">Paket {{nama_paket}} </h3>
        </div><!-- /.box-header -->
<button type="button" style="display: none;" onclick="cek_all()" class="checkAll btn btn-info btn-flat margin btn-xs"><i class="fa fa-fw fa-check-square-o"></i> Semua</button>
<button type="button" onclick="uncek_all()" class="uncheckAll btn btn-info btn-flat margin btn-xs"><i class="fa fa-fw fa-check-square-o"></i> Semua</button>
<button type="button" onclick="cek_setengah()" class="btn btn-info btn-flat margin btn-xs"><i class="fa fa-fw fa-check-square-o"></i> Setengah</button>
<button type="button" onclick="cek_ganjil()" class="btn btn-info btn-flat margin btn-xs"><i class="fa fa-fw fa-check-square-o"></i> Ganjil</button>
<button type="button" onclick="cek_genap()" class="btn btn-info btn-flat margin btn-xs"><i class="fa fa-fw fa-check-square-o"></i> Genap</button>
<button type="button" onclick="inversi()" class="btn btn-info btn-flat margin btn-xs"><i class="fa fa-fw fa-check-square-o"></i> Inversi</button>
<button type="button" onclick="simpan()" class="btn bg-navy btn-flat margin"><i class="fa fa-fw fa-check-square-o"></i> Simpan</button>
        <div class="box-body">
        <form method="post">
          <table id="" class="table table-bordered table-striped">
            <thead>
              <tr>
                <th style="width: 10px">No</th>
                <th>Nomhs</th>
                <th>Nama Mhs</th>
                <th>Angkatan</th>
                <th>Pilih</th>
              </tr>
            </thead>
            <tbody>
            
            {% set no=1 %}
            {% for v in mhs %}
            <tr>
				<td>{{no}}</td>
				<td>{{v.id_mhs}}</td>
				<td>{{v.nama}}</td>
				<td>{{v.angkatan}}</td>
				<td><input type="checkbox" class="cek{{no}}" name="ck{{no}}" value="{{v.id_mhs}}-{{v.id_ps}}" checked=""></td>
            </tr>
            {% set no=no+1 %}
            {% endfor %}
            <?php $jml_mhs = $no-1; ?>

            </tbody>            
          </table><br>
          <input type="text" id="jml_mhs" style="display: none;" value="<?= $jml_mhs ?>">
        </form>
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



function back() {
	var sesi = "{{sesi}}";
	var link = '{{ url("akdkrspaket/formSelectPaket/") }}';
	var datas = 'sesi='+sesi;
    go_page_data(link,datas);
}

function cek_all() {
	$('input:checkbox').prop('checked', true);
	$(".checkAll").css("display", "none");
	$(".uncheckAll").css("display", "inline");
}

function uncek_all() {
	$('input:checkbox').removeAttr('checked');
	$(".uncheckAll").css("display", "none");
	$(".checkAll").css("display", "inline");
}

function cek_setengah() {
	$('input:checkbox').removeAttr('checked');
	var jml_mhs = $("#jml_mhs").val();
	var setengah = jml_mhs/2;
	var pembulatan = Math.ceil(setengah);
	for (var no = 1; no <= pembulatan; no++) {
		$('.cek'+no).prop('checked', true);
  	}
}

function cek_ganjil() {
	$('input:checkbox').removeAttr('checked');
	var jml_mhs = $("#jml_mhs").val();

	for (var no = 1; no <= jml_mhs; no++) {
		if(no % 2 != 0){
			$('.cek'+no).prop('checked', true);
		}
  	}
}

function cek_genap() {
	$('input:checkbox').removeAttr('checked');
	var jml_mhs = $("#jml_mhs").val();

	for (var no = 1; no <= jml_mhs; no++) {
		if(no % 2 == 0){
			$('.cek'+no).prop('checked', true);
		}
  	}
}

function inversi() {
	$('input:checkbox').removeAttr('checked');
	var jml_mhs = $("#jml_mhs").val();
	var setengah = jml_mhs/2;
	var pembulatan = Math.ceil(setengah);
	var setengah_bawah = jml_mhs-pembulatan;

	var array = new Array();
	for (var no = 1; no <= pembulatan; no++) {
		array[no] = no;
  	}

  	for (var i = 1; i <= jml_mhs; i++) {
		if($.inArray(i,array) == -1){
			console.log(i);
			$('.cek'+no).prop('checked', true);
		};
  	}

}

function simpan() {
	var mhs =[];
	$('input[type=checkbox]:checked').each(function(index){
	  mhs.push($(this).val());
	});

	var sesi = "{{sesi}}";
	var paket_id = "{{paket_id}}";
	var jml_mhs = $("#jml_mhs").val();

	var link = '{{ url("akdkrspaket/simpanKrsPaket/") }}';
	var datas = "sesi="+sesi+"&paket_id="+paket_id+"&jml_mhs="+jml_mhs+"&"+$("form").serialize();

	if (mhs.length == 0) {
  		new PNotify({
  			title: 'Regular Notice',
  			text: 'Pilih Ruang yang akan di Aktifkan',
  			type:'warning'
  		});
    }else{
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
}

</script>