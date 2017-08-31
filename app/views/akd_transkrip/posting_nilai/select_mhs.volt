<section class="content-header">
	<h1>
    Posting Nilai
  </h1>
  <ol class="breadcrumb">
    <li><a href="#"><i class="fa fa-dashboard"></i> Transkrip</a></li>
    <li class="">Posting Nilai</li>
  </ol>
</section>

<!-- Main content -->
<section class="content">

  <div class="row">
    <div class="col-md-2"></div>
    <div class="col-md-8">
      <div class="box">
        <div class="box-header">
          <h3 class="box-title">Search Mhs</h3>
        </div><!-- /.box-header -->
        <div class="box-body">
          <form method="post">
            <table class="table">
              <tbody>
                <tr>
                  <td>Nomor Mahasiswa :</td>
                  <td><input type="text" class="form-control" id="nomhs" name="nomhs" placeholder="Enter..."></td>
                  <td></td>
                  <td></td>
                </tr>
                <tr class="form-horizontal">
                  <td>Range Nomor Mahasiswa :</td>
                  <td><input type="text" class="form-control" id="range1" name="range1" placeholder="Enter..."></td>
                  <td><label for="inputEmail3" class="col-sm-2 control-label">S/D</label></td>
                  <td><input type="text" class="form-control" id="range2" name="range2" placeholder="Enter..."></td>
                </tr>
                <tr>
                  <td>Angkatan :</td>
                  <td>
                    <select id="angkatan" name="angkatan" class="form-control">
                      <option ></option>
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
            <button style="margin: 0;" type="button" onclick="cari()" class="btn bg-navy btn-flat pull-right"><i class="fa fa-fw fa-search"></i> Cari</button>
          </form>
        </div>
      </div>
    </div>
  </div>


  <div class="row">
    <div class="col-md-12">
      <div class="box">
        <div class="box-header">
          <h3 class="box-title">Transkrip Mhs</h3>
        </div><!-- /.box-header -->
        <div class="box-body data_mhs">
          
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


  function cari() {
    var link = '{{ url("akdpostingnilai/cariMhs/") }}';
    var datas = $('form').serialize();
    $.ajax({
      type: "POST",
      url: link,
      dataType : "html",
      data: datas
    }).done(function( data ) {
      $('.data_mhs').html(data);
    });
  }



</script>