<section class="content-header">
    <h1>
        Status Mahasiswa
        <small>it all starts here</small>
    </h1>
    <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i> Mahasiswa</a></li>
        <li class="active">Status</li>
    </ol>
</section>

<!-- Main content -->
<section class="content">
<nav class="navbar navbar-default" role="navigation" style="    height: 50px;">
  <!-- Collect the nav links, forms, and other content for toggling -->
  <div class="collapse navbar-collapse navbar-ex1-collapse">
  <ul class="nav navbar-nav" style="align-text: center;">
    <li><a href="javascript:void(0)" onclick="return go_page('akdstatusmhs/rekapStatus/')" data-toggle="tab">REKAP STATUS</a></li>
    <li><a href="javascript:void(0)" onclick="return go_page('akdmhsregistrasi/find/')" data-toggle="tab">REGISTRASI MHS</a></li>
    <li class="active"><a href="javascript:void(0)" onclick="return go_page('akdmhscuti/find/')" data-toggle="tab">CUTI</a></li>
    <li><a href="javascript:void(0)" onclick="return go_page('akdstatusmhs/editStatus/')" data-toggle="tab">EDIT STATUS</a></li>
    <li><a href="javascript:void(0)" onclick="return console.log('LULUS')" data-toggle="tab">MHS LULUS</a></li>
    <li><a href="javascript:void(0)" onclick="return go_page('akdmhsna/find/')" data-toggle="tab">NON AKTIF</a></li>
  </ul>
  </div><!-- /.navbar-collapse -->
</nav>

    <!-- row -->
    <div class="row">
<p class="lead" style="text-align: center;">Tambah Cuti Mahasiswa</p>
    <div class="col-lg-2"></div>

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
                  <td><input type="text" class="form-control" id="nama_mhs" name="nama_mhs" placeholder="Enter..."></td>
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
                      <option value=""></option>
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
      <div class="col-md-12 data_mhs">
          
      </div>
    </div>


</section><!-- /.content -->


<script type="text/javascript">
    function cari() {
        nama_mhs    = $('#nama_mhs').val();
        range1 = $('#range1').val();
        range2 = $('#range2').val();
        angkatan= $('#angkatan').val();

        if(range1 && range2 || nama_mhs || angkatan) {
            var link = '{{ url("akdmhscuti/data/") }}';
            var datas = $('form').serialize();
            $.ajax({
              type: "POST",
              url: link,
              dataType : "html",
              data: datas
            }).done(function( data ) {
              $('.data_mhs').html(data);
            });
        } else {
            new PNotify({
               title: 'Warning Notice',
               text: 'Masukkan Data Dengan Benar',
               type: 'Warning'
           	});
        }
    }
    $(function() {
    })
</script>
