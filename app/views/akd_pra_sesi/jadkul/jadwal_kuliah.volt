<section class="content-header">
	<h1>
    Jadwal Kuliah
    <small>it all starts here</small>
  </h1>
  <ol class="breadcrumb">
    <li><a href="#"><i class="fa fa-dashboard"></i> Setup</a></li>
    <li class="">Jadwal</li>
    <li class="active">Kuliah</li>
  </ol>
</section>

<!-- Main content -->
<section class="content">

<div class="row">
  <div class="col-md-3"></div>
  <div class="col-md-6">
    <div class="box">
        <div class="box-header">
          <h3 class="box-title">MANAJEMEN JADWAL</h3>
        </div><!-- /.box-header -->
        <div class="box-body">
        <form method="post">
            <table class="table table-condensed">
              <tbody>
                <tr>
                  <td style="padding: 11px 6px;width: 100px; background: #eee" class="text-left"><b>Janis :</b></td>
                  	<td><div class="radio">
                        <label>
                          <input type="radio" name="optionsRadios" id="optionsRadios1" value="option1" checked="">
                          KULIAH REGULER
                        </label>
                      </div></td>
                </tr>
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
            <button style="margin: 0;" type="button" onclick="list_mk_jadwal()" class="btn bg-navy btn-flat pull-right"><i class="fa fa-fw fa-edit"></i> Tampilkan</button>
            </form>
        </div>
    </div>
  </div>
  <div class="col-md-3"></div>
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

function list_mk_jadwal() {
	var sesi = $('#sesi').val();
	var link = '{{ url("akdjadkul/listMkJadwal/") }}';
    var datas = "sesi="+sesi;
    go_page_data(link,datas);
}


</script>