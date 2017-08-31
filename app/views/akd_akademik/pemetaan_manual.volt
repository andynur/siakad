<section class="content-header">
  <h1>
    <button type="button" onclick="back('{{ps_idA}}/{{kurA}}','{{kurB}}')" class="btn bg-navy btn-flat"><i class="fa fa-fw fa-arrow-left"></i> Back</button>
  </h1>
  <ol class="breadcrumb" style="top: 5px;    padding: 0px 5px;">
    <li class="box-title text-navy"><h4>PEMETAAN KURIKULUM {{ps_idA}}/{{kurA}} KE KURIKULUM {{ps_idB}}/{{kurB}}</h4></li>
  </ol>
</section>

<!-- Main content -->
<section class="content">
  <div class="row">

<div class="col-md-12">
  <div class="box">
    <div class="box-header" style="text-align: center;">
      <h2 class="box-title text-red">PILIH MATA KULIAH YANG AKAN DIPETAKAN :</h2>
    </div>
    <div class="box-body">
    	<table class="table table-bordered table-striped" style="font-size: 13px;">

<form method="post" id="pemetaaan">
        <input type="text" form="pemetaaan" name="asal" value="{{ps_idA}}/{{kurA}}" style="display:none">
        <input type="text" form="pemetaaan" name="tujuan" value="{{kurB}}" style="display:none">
        <tbody>
          <tr>
            <th class="text-center" style="width: 10%"></th>
            <th class="text-center" style="width: 30%">Kurikulum {{ps_idA}}/{{kurA}}</th>
            <th class="text-center" style="width: 10%"></th>
            <th class="text-center" style="width: 30%">Kurikulum {{ps_idB}}/{{kurB}}</th>

          </tr>
          <tr>
            <td class="text-center"><b>$mkA0 :</b></td>
            <td>
              <select form="pemetaaan" name="mkA0" class="form-control">
                  <option value=""></option>
                {% for v in asal %}
                  <option value="{{v.kode_mk}}">{{v.nama}} ({{v.kode_mk}})</option>
                {% endfor %}
                </select>
            </td>
            <td class="text-center"><b>$mkB0 :</b></td>
            <td>
              <select form="pemetaaan" name="mkB0" class="form-control">
                  <option value=""></option>
                  {% for v in tujuan %}
                  <option value="{{v.kode_mk}}">{{v.nama}} ({{v.kode_mk}})</option>
                  {% endfor %}
                </select>
            </td>
          </tr>
          <tr>
            <td class="text-center"><b>$mkA1 :</b></td>
            <td>
              <select form="pemetaaan" name="mkA1" class="form-control">
                  <option value=""></option>
                  {% for v in asal %}
                  <option value="{{v.kode_mk}}">{{v.nama}} ({{v.kode_mk}})</option>
                  {% endfor %}
                </select>
            </td>
            <td class="text-center"><b>$mkB1 :</b></td>
            <td>
              <select form="pemetaaan" name="mkB1" class="form-control">
                  <option value=""></option>
                  {% for v in tujuan %}
                  <option value="{{v.kode_mk}}">{{v.nama}} ({{v.kode_mk}})</option>
                  {% endfor %}
                </select>
            </td>
          </tr>
          <tr>
            <td class="text-center"><b>$mkA2 :</b></td>
            <td>
              <select form="pemetaaan" name="mkA2" class="form-control">
                  <option value=""></option>
                  {% for v in asal %}
                  <option value="{{v.kode_mk}}">{{v.nama}} ({{v.kode_mk}})</option>
                  {% endfor %}
                </select>
            </td>
            <td class="text-center"><b>$mkB2 :</b></td>
            <td>
              <select form="pemetaaan" name="mkB2" class="form-control">
                  <option value=""></option>
                  {% for v in tujuan %}
                  <option value="{{v.kode_mk}}">{{v.nama}} ({{v.kode_mk}})</option>
                  {% endfor %}
                </select>
            </td>
          </tr>

          <tr>
            <td class="text-center"><label>Catatan</label></td>
            <td>
              <div class="form-group">
                <textarea form="pemetaaan" name="catatan" class="form-control" style="width: 90%;height: 100px;" rows="3" placeholder="Enter ..."></textarea>
              </div>
              <button type="button" onclick="save_mapmku()" class="btn bg-navy btn-flat"><i class="fa fa-fw fa-save"></i> Rekam</button>
            </td>
            <td></td>
            <td></td>
          </tr>
        </tbody>
</form>

      </table>
    </div>
  </div>
</div>



  </div><!-- /.row -->
</section><!-- /.content -->


<script type="text/javascript">

function back(asal,tujuan) {
  var datas = "asal="+asal+"&tujuan="+tujuan;
  var link = '{{ url("akademik/vewMap/") }}';
  go_page_data(link,datas);
}

function save_mapmku() {
  var datas = $('#pemetaaan').serialize().toString();

  $.ajax({
    type: "POST",
    url: "{{ url('akademik/seveMapmku') }}",
    dataType : "json",
    data: datas
  }).done(function(data) {
    if (data.status == true) {
      var asal = "{{ps_idA}}/{{kurA}}";
      var tujuan = "{{kurB}}";
      back(asal,tujuan)
    }else{
      new PNotify({
         title: data.title,
         text: data.text,
         type: data.type
      });
    }
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

