<section class="content-header">
    <h1>
        Skripsi Mahasiswa
        <small>it all starts here</small>
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
<p class="lead" style="text-align: center;">Sesi Skripsi</p>
    <div class="col-lg-3"></div>

    <div class="col-md-6">
	    <div class="box">
	        <div class="box-header">
	          <h3 class="box-title">Select Sesi</h3>
	        </div><!-- /.box-header -->
	        <div class="box-body">
	        <form method="post">
	            <table class="table table-condensed">
	              <tbody>
	                <tr>
	                  <td style="padding: 11px 6px;width: 100px; background: #eee" class="text-left"><b>Sesi :</b></td>
	                  	<td>
		                  	<div class="input-group">
		                      <div class="input-group-addon">
		                        <i class="fa fa-calendar"></i>
		                      </div>
		                      <select style="width:80%;" id="sesi" class="form-control">
		                       	{% for val in tahun_sesi %}
			                        <option value="{{val.thn_akd}}-{{val.session_id}}" >{{val.nama}} {{ helper.format_thn_akd(val.thn_akd) }}</option>
			                    {% endfor %}   
		                      </select>
		                    </div><!-- /.input group -->
	                   	</td>                  
	                </tr>
	              </tbody>
	            </table>
	            <button style="margin: 0;" type="button" onclick="mhs_skripsi()" class="btn bg-navy btn-flat pull-right"><i class="fa fa-fw fa-edit"></i> Tampilkan</button>
	        </form>
	        </div>
	    </div>
	 </div>

    </div>

    <div class="row">
      <div class="col-md-12 data_mhs">
          
      </div>
    </div>


</section><!-- /.content -->


<script type="text/javascript">

function mhs_skripsi() {
	var sesi = $("#sesi").val();
	var datas = 'sesi='+sesi;
	var link = '{{ url("akdskripsi/listMhsSkripsi/") }}';
    go_page_data(link,datas);
}

</script>
