{% for val in data %}
<section class="content-header">
  <h1>
    <button id="back" type="button" onclick="back('{{val.ps_idA}}/{{val.kurA}}','{{val.kurB}}')" class="btn bg-navy btn-flat"><i class="fa fa-fw fa-arrow-left"></i> Back</button>
  </h1>
  <ol class="breadcrumb" style="top: 5px;    padding: 0px 5px;">
    <li class="box-title text-navy"><h4>PEMETAAN KURIKULUM {{val.ps_idA}}/{{val.kurA}} KE KURIKULUM {{val.ps_idB}}/{{val.kurB}}</h4></li>
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
        <input type="text" form="pemetaaan" name="asal" value="{{val.ps_idA}}/{{val.kurA}}" style="display:none">
        <input type="text" form="pemetaaan" name="tujuan" value="{{val.kurB}}" style="display:none">
        <tbody>
          <tr>
            <th class="text-center" style="width: 10%"></th>
            <th class="text-center" style="width: 30%">Kurikulum {{val.ps_idA}}/{{val.kurA}}</th>
            <th class="text-center" style="width: 10%"></th>
            <th class="text-center" style="width: 30%">Kurikulum {{val.ps_idB}}/{{val.kurB}}</th>

          </tr>
          <tr>
            <td class="text-center"><b>$mkA0 :</b></td>
            <td>
              <select form="pemetaaan" name="mkA0" class="form-control">
                  <option value=""></option>
                {% for v in asal %}
                	{% if val.mkA0 == v.kode_mk %}
                  		<option value="{{v.kode_mk}}" selected>{{v.nama}} ({{v.kode_mk}})</option>
                	{% else %}
                  		<option value="{{v.kode_mk}}">{{v.nama}} ({{v.kode_mk}})</option>
                	{% endif %}
                {% endfor %}
                </select>
            </td>
            <td class="text-center"><b>$mkB0 :</b></td>
            <td>
              <select form="pemetaaan" name="mkB0" class="form-control">
                  <option value=""></option>
                  {% for v in tujuan %}
                  	{% if val.mkB0 == v.kode_mk %}
                  		<option value="{{v.kode_mk}}" selected>{{v.nama}} ({{v.kode_mk}})</option>
                	{% else %}
                  		<option value="{{v.kode_mk}}">{{v.nama}} ({{v.kode_mk}})</option>
                	{% endif %}
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
                  	{% if val.mkA1 == v.kode_mk %}
                  		<option value="{{v.kode_mk}}" selected>{{v.nama}} ({{v.kode_mk}})</option>
                	{% else %}
                  		<option value="{{v.kode_mk}}">{{v.nama}} ({{v.kode_mk}})</option>
                	{% endif %}
                  {% endfor %}
                </select>
            </td>
            <td class="text-center"><b>$mkB1 :</b></td>
            <td>
              <select form="pemetaaan" name="mkB1" class="form-control">
                  <option value=""></option>
                  {% for v in tujuan %}
                  	{% if val.mkB1 == v.kode_mk %}
                  		<option value="{{v.kode_mk}}" selected>{{v.nama}} ({{v.kode_mk}})</option>
                	{% else %}
                  		<option value="{{v.kode_mk}}">{{v.nama}} ({{v.kode_mk}})</option>
                	{% endif %}
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
                  	{% if val.mkA2 == v.kode_mk %}
                  		<option value="{{v.kode_mk}}" selected>{{v.nama}} ({{v.kode_mk}})</option>
                	{% else %}
                  		<option value="{{v.kode_mk}}">{{v.nama}} ({{v.kode_mk}})</option>
                	{% endif %}
                  {% endfor %}
                </select>
            </td>
            <td class="text-center"><b>$mkB2 :</b></td>
            <td>
              <select form="pemetaaan" name="mkB2" class="form-control">
                  <option value=""></option>
                  {% for v in tujuan %}
                  	{% if val.mkB2 == v.kode_mk %}
                  		<option value="{{v.kode_mk}}" selected>{{v.nama}} ({{v.kode_mk}})</option>
                	{% else %}
                  		<option value="{{v.kode_mk}}">{{v.nama}} ({{v.kode_mk}})</option>
                	{% endif %}
                  {% endfor %}
                </select>
            </td>
          </tr>

          <tr>
            <td class="text-center"><label>Catatan</label></td>
            <td>
              <div class="form-group">
                <textarea form="pemetaaan" name="catatan" class="form-control" style="width: 90%;height: 100px;" rows="3" placeholder="Enter ...">{{val.catatan}}</textarea>
              </div>
              <button type="button" onclick="save_mapmku({{val.map_id}})" class="btn bg-navy btn-flat"><i class="fa fa-fw fa-save"></i> Rekam</button>
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
{% endfor %}

<script type="text/javascript">

function back(asal,tujuan) {
  var datas = "asal="+asal+"&tujuan="+tujuan;
  var link = '{{ url("akademik/vewMap/") }}';
  go_page_data(link,datas);
}

function save_mapmku(id) {
  var datas = $('#pemetaaan').serialize().toString();

  $.ajax({
    type: "POST",
    url: "{{ url('akademik/submitEditPemetaan/') }}"+id,
    dataType : "json",
    data: datas
  }).done(function(data) {
    if (data.status == true) {
      $('#back').trigger('click');
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

