<section class="content-header">
	<h1>
    KRS
    <small>it all starts here</small>
  </h1>
  <ol class="breadcrumb">
    <li><a href="#"><i class="fa fa-dashboard"></i> Setup</a></li>
    <li class="">KRS</li>
    <li class="active">Mhs</li>
  </ol>
</section>

<!-- Main content -->
<section class="content">

<div class="row">
  <div class="col-md-2"></div>
  <div class="col-md-8">
    <div class="box">
        <div class="box-header">
          <h3 class="box-title">Pengajuan KRS</h3>
        </div><!-- /.box-header -->
        <div class="box-body">
        <form method="post">
            <table class="table table-condensed">
              <tbody>
                <tr>
                  	<td style="padding: 11px 6px;width: 140px; background: #eee" class="text-left"><b>Nomhs :</b></td>
                  	<td>
                  		<div class="input-group">
	                        <label>
	                          <input type="text" name="nomhs" id="nomhs">
	                        </label>
                     	</div>
                    </td>
                </tr>
                <tr>
                  <td style="padding: 11px 6px;width: 140px; background: #eee" class="text-left"><b>Sesi :</b></td>
                  	<td>
	                  	<div class="input-group">
	                      <div class="input-group-addon">
	                        <i class="fa fa-calendar"></i>
	                      </div>
	                      <select style="width:70%;" name="krs_ol" id="sesi" class="form-control">
	                       	{% for val in krs_ol %}
		                        <option value="{{val.thn_akd}}-{{val.session_id}}-{{val.ol_id}}" >{{val.nama_ol}} - {{val.nama}} {{ helper.format_thn_akd(val.thn_akd) }}</option>
		                    {% endfor %}   
	                      </select>
	                    </div><!-- /.input group -->
                   	</td>                  
                </tr>
                <tr>
                  <td style="padding: 11px 6px;width: 140px; background: #eee" class="text-left"><b>Lacak Tidak Lolos :</b></td>
                  	<td><div class="radio">
                        <label>
                          <input type="checkbox" name="tracetidaklolos" id="tracetidaklolos" value="1" >
                        </label>
                      </div></td>
                </tr>
                <tr>
                  <td style="padding: 11px 6px;width: 140px; background: #eee" class="text-left"><b>Bypass Prasyarat :</b></td>
                  	<td><div class="radio">
                        <label>
                          <input type="checkbox" name="bypassprasyarat" id="bypassprasyarat" value="1" >
                        </label>
                      </div></td>
                </tr>
                <tr>
                  <td style="padding: 11px 6px;width: 140px; background: #eee" class="text-left"><b>Bypass MK/Kelas :</b></td>
                  	<td><div class="radio">
                        <label>
                          <input type="checkbox" name="bypasskelas" id="bypasskelas" value="1" >
                        </label>
                      </div></td>
                </tr>
              </tbody>
            </table>
            <button style="margin: 0;" type="button" onclick="lihat()" class="btn bg-navy btn-flat pull-right"><i class="fa fa-fw fa-edit"></i> Tampilkan</button>
            </form>
        </div>
    </div>
  </div>
</div>
      
</section><!-- /.content -->


<style type="text/css">
	.over{
		/*background: crimson;*/
    	color: crimson;
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


function lihat() {
  var link = '{{ url("akdkrsmhs/Krs/") }}';
    var datas = $('form').serialize();
    go_page_data_get(link,datas);
}



</script>