<section class="content-header">
  <h1>
    <button type="button" onclick="back('{{thn_akd}}','{{session_id}}')" class="btn bg-navy btn-flat"><i class="fa fa-fw fa-arrow-left"></i> Back</button>
  </h1>
</section>

<!-- Main content -->
<section class="content">
  <div class="row">

<div class="col-md-12">
  <div class="box">
    <div class="box-header" style="text-align: center;">
      <h2 class="box-title text-navy">{{nama}} <span class="text-green">{{kode_mk}}</span> | KELAS : <span class="text-green">{{nama_kelas}}</span> | SKS : <span class="text-green">{{sks}}</span></h2>
    </div>
    <div class="box-body">

<?php 

for ($i=1; $i <= 9 ; $i++) { 
	if (array_key_exists($i, $dosen)) {
		$data[$i] = $dosen[$i]['nip'];
		if ($dosen[$i]['aktif'] == 'Y') {
			$cek[$i] = 'checked';
		} else {
			$cek[$i] = '';
		}
		
		$sks_dosen[$i] = $dosen[$i]['sks'];
	} else {
		$data[$i] = '';
		$cek[$i] = '';
		$sks_dosen[$i] = '';
	}	
}
// echo "<pre>".print_r($dosen,1)."</pre>";
?>

			<form method="post">
    	<table class="table table-bordered " style="font-size: 13px;">
        <input type="text" id="thn_akd" name="thn_akd" value="{{thn_akd}}" style="display: none;">
        <input type="text" id="session_id" name="session_id" value="{{session_id}}" style="display: none;">
        <input type="text" id="session_id" name="session_id" value="{{session_id}}" style="display: none;">
        <tbody>
          <tr>
            <th class="text-center text-green" style="width: 10%"></th>
            <th class="text-center text-green" style="width: 30%">Pilih Dosen </th>
            <th class="text-center text-green" style="width: 5%">Aktif</th>
            <th class="text-center text-green" style="width: 5%">SKS</th>
            <th class="text-center text-green" style="width: 10%"></th>
            <th class="text-center text-green" style="width: 30%">Pilih Dosen </th>
            <th class="text-center text-green" style="width: 5%">Aktif</th>
            <th class="text-center text-green" style="width: 5%">SKS</th>

          </tr>
          <tr>
            <td class="text-center"><b>Koordinator :</b></td>
            <td>
              <select name="dosen_1" class="form-control">
              	<option value=""></option>
                {% for v in sdm %}
                <?php if ($data[1] == $v->nip): ?>
                  <option value="{{v.nip}}" selected>{{v.nama}}</option>
                <?php else: ?>
                  <option value="{{v.nip}}">{{v.nama}}</option>
                <?php endif ?>
                {% endfor %}
                </select>
            </td>
            <td><input type="checkbox" value="1" <?= $cek[1] ?>></td>
            <td><input type="text" name="sks_1" style="width: 50px;" value="<?= $sks_dosen[1] ?>" ></td>

            <td class="text-center"><b>Dosen 5 :</b></td>
            <td>
              <select name="dosen_6" class="form-control">
              	<option value=""></option>
                {% for v in sdm %}
                <?php if ($data[6] == $v->nip): ?>
                  <option value="{{v.nip}}" selected>{{v.nama}}</option>
                <?php else: ?>
                  <option value="{{v.nip}}">{{v.nama}}</option>
                <?php endif ?>
                {% endfor %}
                </select>
            </td>     
            <td><input type="checkbox" value="6" <?= $cek[6] ?>></td>
          	<td><input type="text" name="sks_6" style="width: 50px;" value="<?= $sks_dosen[6] ?>" ></td>

            
          </tr>
          <tr>
          	<td class="text-center"><b>Dosen 1 :</b></td>
            <td>
              <select name="dosen_2" class="form-control">
              	<option value=""></option>
                {% for v in sdm %}
                <?php if ($data[2] == $v->nip): ?>
                  <option value="{{v.nip}}" selected>{{v.nama}}</option>
                <?php else: ?>
                  <option value="{{v.nip}}">{{v.nama}}</option>
                <?php endif ?>
                {% endfor %}
                </select>
            </td>
            <td><input type="checkbox" value="2" <?= $cek[2] ?>></td>
            <td><input type="text" name="sks_2" style="width: 50px;" value="<?= $sks_dosen[2] ?>" ></td>
            <td class="text-center"><b>Dosen 6 :</b></td>
            <td>
              <select name="dosen_7" class="form-control">
                  <option dosen_7</option>
                {% for v in sdm %}
                <?php if ($data[7] == $v->nip): ?>
                  <option value="{{v.nip}}" selected>{{v.nama}}</option>
                <?php else: ?>
                  <option value="{{v.nip}}">{{v.nama}}</option>
                <?php endif ?>
                {% endfor %}
                </select>
            </td>    

			<td><input type="checkbox" value="7" <?= $cek[7] ?>></td>
          	<td><input type="text" name="sks_7" style="width: 50px;" value="<?= $sks_dosen[7] ?>" ></td>
            
          </tr>
          <tr>
          	<td class="text-center"><b>Dosen 2 :</b></td>
            <td>
              <select name="dosen_3" class="form-control">
                 <option value=""></option>
                {% for v in sdm %}
                <?php if ($data[3] == $v->nip): ?>
                  <option value="{{v.nip}}" selected>{{v.nama}}</option>
                <?php else: ?>
                  <option value="{{v.nip}}">{{v.nama}}</option>
                <?php endif ?>
                {% endfor %}
                </select>
            </td>
            <td><input type="checkbox" value="3" <?= $cek[3] ?>></td>
            <td><input type="text" name="sks_3" style="width: 50px;" value="<?= $sks_dosen[3] ?>" ></td>
            <td class="text-center"><b>Asisten :</b></td>
            <td>
              <select name="dosen_8" class="form-control">
                 <option value=""></option>
	                {% for v in sdm %}
	                <?php if ($data[8] == $v->nip): ?>
	                  <option value="{{v.nip}}" selected>{{v.nama}}</option>
	                <?php else: ?>
	                  <option value="{{v.nip}}">{{v.nama}}</option>
	                <?php endif ?>
	                {% endfor %}
                </select>
            </td>   
            <td><input type="checkbox" value="8" <?= $cek[8] ?>></td>
          	<td><input type="text" name="sks_8" style="width: 50px;" value="<?= $sks_dosen[8] ?>" ></td>

          </tr>
          <tr>
          	<td class="text-center"><b>Dosen 3 :</b></td>
            <td>
              <select name="dosen_4" class="form-control">
                  <option value=""></option>
	                {% for v in sdm %}
	                <?php if ($data[4] == $v->nip): ?>
	                  <option value="{{v.nip}}" selected>{{v.nama}}</option>
	                <?php else: ?>
	                  <option value="{{v.nip}}">{{v.nama}}</option>
	                <?php endif ?>
	                {% endfor %}
                </select>
            </td>
            <td><input type="checkbox" value="4" <?= $cek[4] ?>></td>
            <td><input type="text" name="sks_4" style="width: 50px;" value="<?= $sks_dosen[4] ?>" ></td>
            <td class="text-center"><b>Laboran :</b></td>
            <td>
              <select name="dosen_9" class="form-control">
                  <option value=""></option>
                {% for v in sdm %}
                <?php if ($data[9] == $v->nip): ?>
                  <option value="{{v.nip}}" selected>{{v.nama}}</option>
                <?php else: ?>
                  <option value="{{v.nip}}">{{v.nama}}</option>
                <?php endif ?>
                {% endfor %}
                </select>
            </td>    
            <td><input type="checkbox" value="9" <?= $cek[9] ?>></td>
          <td><input type="text" name="sks_9" style="width: 50px;" value="<?= $sks_dosen[9] ?>" ></td>

            
          </tr>
          <tr>
            <td class="text-center"><b>Dosen 4 :</b></td>
            <td>
              <select name="dosen_5" class="form-control">
                  <option value=""></option>
                {% for v in sdm %}
                <?php if ($data[5] == $v->nip): ?>
                  <option value="{{v.nip}}" selected>{{v.nama}}</option>
                <?php else: ?>
                  <option value="{{v.nip}}">{{v.nama}}</option>
                <?php endif ?>
                {% endfor %}
                </select>
            </td>            
	          <td><input type="checkbox" value="5" <?= $cek[5] ?>></td>
	          <td><input type="text" name="sks_5" style="width: 50px;" value="<?= $sks_dosen[5] ?>" ></td>
	          <td></td>
	          <td></td>
	          <td></td>
	          <td></td>

          </tr>

          <tr>
            <td class="text-center"></td>
            <td>
              <button type="button" onclick="save_dosen('{{id}}')" class="btn bg-navy btn-flat"><i class="fa fa-fw fa-save"></i> Rekam</button>
            </td>
            <td></td>
            <td></td>
          </tr>
        </tbody>

      </table>
</form>
    </div>
  </div>
</div>



  </div><!-- /.row -->
</section><!-- /.content -->


<script type="text/javascript">

function reload() {
var thn_akd = '{{thn_akd}}';
var session_id = '{{session_id}}';
var id = '{{id}}';
var kode_mk = '{{kode_mk}}';
var nama = '{{nama}}';
var nama_kelas = '{{nama_kelas}}';
var sks = '{{sks}}';

  var datas = "thn_akd="+thn_akd+"&session_id="+session_id+"&id="+id+"&kode_mk="+kode_mk+"&nama="+nama+"&nama_kelas="+nama_kelas+"&sks="+sks;
  var link = '{{ url("manajemensesi/dosenPengajar/") }}';
  reload_page_data(link,datas);
}

function back() {
  var thn_akd = $('#thn_akd').val();
  var session_id = $('#session_id').val();
  var datas = "thn_akd="+thn_akd+"&session_id="+session_id;
  var link = '{{ url("manajemensesi/setDosen/") }}';
  go_page_data(link,datas);
}

function save_dosen(id) {
	var jenis =[];
	$('input[type=checkbox]:checked').each(function(index){
	  jenis.push($(this).val());
	});
	var thn_akd = $('#thn_akd').val();
	var session_id = $('#session_id').val();
	var sks = '{{sks}}';
	var form = $('form').serialize();

  	var link = '{{ url("manajemensesi/addDosenAjar/") }}';
  	var form = $('form').serialize();
	var datas = form+"&jenis="+jenis+"&thn_akd="+thn_akd+"&session_id="+session_id+"&id="+id+"&sks="+sks;
	// go_page_data(link,datas);
	$.ajax({
         type: "POST",
         url: link,
         dataType : "json",
         data : datas,
    }).done(function( data ) {
          new PNotify({
             title: data.title,
	         text: data.text,
	         type: data.type
          });
        reload();
    });
}


</script>

<style type="text/css">
.navbar .navbar-nav {
    display: inline-block;
    float: none;
}

.navbar .navbar-collapse {
    text-align: center;
}
</style>

