<section class="content-header">
  <button type="button" onclick="back('{{thn_akd}}','{{session_id}}')" class="btn bg-navy btn-flat margin"><i class="fa fa-fw fa-arrow-left"></i> Back</button>
  
  <ol class="breadcrumb">
    <li><a href="#"><i class="fa fa-dashboard"></i> Lihat</a></li>
    <li class="active">Jadwal</li>
  </ol>
</section>

<!-- Main content -->
<section class="content">
  <div class="row">
    <div class="col-md-12">
      <div class="box box-primary">
        <div class="box-header">
          <h3 class="box-title">Edit Jadwal {{id}}</h3>
        </div><!-- /.box-header -->
        <div class="box-body">
        <form method="post" id="edit_data"> 
        <input type="text" id="id_jadkul" name="id_jadkul" value="{{id_jadkul}}" style="display:none;">
        <input type="text" id="id" name="id" value="{{id}}" style="display:none;">
          <table class="table table-bordered">

          {% for value in jadwal %}
            <tbody>
            <tr>
              <th>Hari</th>
              <th>Awal</th>
              <th>Akhir</th>
              <th>Ruang</th>
              <th>Dosen</th>
              <th></th>
            </tr>

            <tr>
              <td>
                <select name="hari" class="form-control">
                  <option value=""></option>
                  <option value="1" {% if value.hari == 1 %} {{'selected'}} {% endif %}>Senin</option>
                  <option value="2" {% if value.hari == 2 %} {{'selected'}} {% endif %}>Selasa</option>
                  <option value="3" {% if value.hari == 3 %} {{'selected'}} {% endif %}>Rabu</option>
                  <option value="4" {% if value.hari == 4 %} {{'selected'}} {% endif %}>Kamis</option>
                  <option value="5" {% if value.hari == 5 %} {{'selected'}} {% endif %}>Jum'at</option>
                  <option value="6" {% if value.hari == 6 %} {{'selected'}} {% endif %}>Saptu</option>
                  <option value="7" {% if value.hari == 7 %} {{'selected'}} {% endif %}>Minggu</option>
                </select>
              </td>
              <td>
                <div class="bootstrap-timepicker">
                  <div class="input-group">
                    <input name="awal" type="text" style="width: 100px;" class="form-control timepicker">
                  </div>
                </div>
              </td>
              <td>
                <div class="bootstrap-timepicker">
                  <div class="input-group">
                    <input name="akhir" type="text" style="width: 100px;" class="form-control timepicker2">
                  </div>
                </div>
              </td>
              <td>
                <select name="ruang" class="form-control">
                <option value=""></option>
                  {% for v in ruang %}
                    <option value="{{v.ruang_id}}" {% if value.ruang_id == v.ruang_id %} {{'selected'}} {% endif %}>{{v.nama_ruang}}</option>
                  {% endfor %}
                </select>
              </td>
              <td>
                <select name="dosen" class="form-control">
                <option value=""></option>
                  {% for v in dosen %}
                    {% if v.nip != '' %}
                      <option value="{{v.nip}}" {% if value.nip_dosen == v.nip %} {{'selected'}} {% endif %}>{{v.nama}}</option>
                    {% endif %}
                  {% endfor %}
                </select>
              </td>
              <td>  <button type="button" onclick="edit_jadkul()" class="btn bg-navy btn-flat">Simpan</button>
              </td>
            </tr>            
          </tbody>
          {% endfor %}

          </table>
          </form>
        </div><!-- /.box-body -->
      </div>
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

  $(".timepicker").timepicker({
    showInputs: false,
    defaultTime: '{{awal}}'
  });
  $(".timepicker2").timepicker({
    showInputs: false,
    defaultTime: '{{akhir}}'
  });

});

function back() {
  var thn_akd = "{{thn_akd}}";
  var session_id = "{{session_id}}";
  var thn_kur = "{{thn_kur}}";
  var nama = "{{nama}}";
  var kapasitas = "{{kapasitas}}";
  var nama_kelas = "{{nama_kelas}}";
  var kode_mk = "{{kode_mk}}";
  var sks = "{{sks}}";
  var id_mkkpkl = "{{id_mkkpkl}}";
  var link = '{{ url("akdjadkul/lihatJadwal/") }}';
  var datas = "thn_akd="+thn_akd+"&session_id="+session_id+"&thn_kur="+thn_kur+"&kode_mk="+kode_mk+"&nama_kelas="+nama_kelas+"&nama="+nama+"&sks="+sks+"&kapasitas="+kapasitas+"&id_mkkpkl="+id_mkkpkl;
  go_page_data(link,datas);
}

function reload() {
  var thn_akd = "{{thn_akd}}";
  var session_id = "{{session_id}}";
  var thn_kur = "{{thn_kur}}";
  var nama = "{{nama}}";
  var kapasitas = "{{kapasitas}}";
  var nama_kelas = "{{nama_kelas}}";
  var kode_mk = "{{kode_mk}}";
  var sks = "{{sks}}";
  var id_mkkpkl = "{{id_mkkpkl}}";
  var id_jadkul = "{{id_jadkul}}";
  var link = '{{ url("akdjadkul/editJadkul/") }}';
  var datas = "thn_akd="+thn_akd+"&session_id="+session_id+"&thn_kur="+thn_kur+"&kode_mk="+kode_mk+"&nama_kelas="+nama_kelas+"&nama="+nama+"&sks="+sks+"&kapasitas="+kapasitas+"&id_mkkpkl="+id_mkkpkl+"&id_jadkul="+id_jadkul;
  reload_page_data(link,datas);
}


function edit_jadkul() {
	var thn_akd = "{{thn_akd}}";
	var session_id = "{{session_id}}";
	var thn_kur = "{{thn_kur}}";
	var nama_kelas = "{{nama_kelas}}";
	var kode_mk = "{{kode_mk}}";
	var dt = "&thn_akd="+thn_akd+"&session_id="+session_id+"&thn_kur="+thn_kur+"&kode_mk="+kode_mk+"&nama_kelas="+nama_kelas
  var datas = $('#edit_data').serialize()+dt;
  var link = '{{ url("akdjadkul/submitEditJadkul") }}';
  console.log(datas);
  // go_page_data(link,datas);
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
        reload();
  });
}

</script>