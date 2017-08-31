<section class="content-header">
  <h1>
    Akademik
    <small>it all starts here</small>
  </h1>
  <ol class="breadcrumb">
    <li><a href="#"><i class="fa fa-dashboard"></i> Akademik</a></li>
    <li class="active">Kurikulum</li>
  </ol>
</section>

<!-- Main content -->
<section class="content">
  <div class="row">

    <nav class="navbar navbar-default" role="navigation" style="    height: 50px;">
      <!-- Collect the nav links, forms, and other content for toggling -->
      <div class="collapse navbar-collapse navbar-ex1-collapse">
        <ul class="nav navbar-nav">
          <li><a href="javascript:void(0)" onclick="return go_page('akademik/kurikulum')">KURIKULUM</a></li>
          <li class="active"><a href="javascript:void(0)" onclick="return go_page('akademik/pemetaanKurikulum')">PEMETAAN KURIKULUM</a></li>
        </ul>
      </div><!-- /.navbar-collapse -->
    </nav>

<div class="col-md-6">
  <div class="box">
    <div class="box-header" style="text-align: center;">
      <h2 class="box-title text-blue">Daftar Kurikulum</h2>
    </div>
    <div class="box-body">
    	<div class="col-md-12">    		
<table class="table">
    <tbody>
      <tr>
        <td class="text-center"><div class="form-group">
          <label>Asal</label>
          <select name="asal" id="asal" class="form-control">
            {% for v in asal %}
            	<option value="{{v.ps_id}}/{{v.thn_kur}}">{{v.nama}}/{{v.thn_kur}}</option>
    		{% endfor %}
          </select>
        </div></td>
        <td class="text-center"><div class="form-group">
          <label>Tujuan</label>
          <select name="tujuan" id="tujuan" class="form-control">
            {% for v in thn %}
            	<option value="{{v.thn_kur}}">{{v.thn_kur}}</option>
    		{% endfor %}
          </select>
        </div></td>
      </tr>
      <tr>
        <td></td>
        <td><button class="btn bg-navy btn-flat margin pull-right" onclick="view_map()">BARU</button></td>
      </tr>
    </tbody>
</table>

    	</div>
    </div>
  </div>
</div>
<div class="col-md-1"></div>

<div class="col-md-6">
  <div class="box">
    <div class="box-header" style="text-align: center;">
      <h2 class="box-title text-blue">Daftar Pemetaan</h2>
    </div>
    <div class="box-body">
    	<div class="col-md-12">    		
        	{% for v in daftar_pemetaan_ps %}
          		<button class="btn bg-navy btn-flat margin btn-block" onclick="go_to_view_map('{{v.ps_idA}}/{{v.kurA}}','{{v.kurB}}')">
          		{{v.namaA}}/{{v.kurA}} - {{v.namaB}}/{{v.kurB}}</button>
    		{% endfor %}
    	</div>
    </div>
  </div>
</div>


  </div><!-- /.row -->
</section><!-- /.content -->


<script type="text/javascript">

function view_map() {
	var asal = $('#asal').val();
	var tujuan = $('#tujuan').val();
	var datas = "asal="+asal+"&tujuan="+tujuan;
	var link = '{{ url("akademik/vewMap/") }}';
	go_page_data(link,datas);
}

function go_to_view_map(asal,tujuan) {
	var datas = "asal="+asal+"&tujuan="+tujuan;
	var link = '{{ url("akademik/vewMap/") }}';
	go_page_data(link,datas);
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

