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
    <li class="active"><a href="javascript:void(0)" onclick="return go_page('akdmhsregistrasi/find/')" data-toggle="tab">REGISTRASI MHS</a></li>
    <li><a href="javascript:void(0)" onclick="return go_page('akdmhscuti/find/')" data-toggle="tab">CUTI</a></li>
    <li ><a href="javascript:void(0)" onclick="return go_page('akdstatusmhs/editStatus/')" data-toggle="tab">EDIT STATUS</a></li>
    <li><a href="javascript:void(0)" onclick="return console.log('LULUS')" data-toggle="tab">MHS LULUS</a></li>
    <li ><a href="javascript:void(0)" onclick="return go_page('akdmhsna/find/')" data-toggle="tab">NON AKTIF</a></li>
  </ul>
  </div><!-- /.navbar-collapse -->
</nav>

    <!-- row -->
    <div class="row">
<p class="lead text-navy" style="text-align: center;"><b>Mahasiswa Registrasi</b></p>
    <div class="col-lg-3"></div>

    <div class="col-md-6">
      <div class="box">
        <div class="box-header">
          <h3 class="box-title">Search Mhs</h3>
        </div><!-- /.box-header -->
        <div class="box-body">
          <form method="post">
            <table class="table">
              <tbody>
                <tr>
                  <td>Sesi :</td>
                  <td>
                    <select style="width:80%;" name="sesi" class="form-control">
                    {% for val in tahun_sesi %}
                        <option value="{{val.thn_akd}}-{{val.session_id}}" >{{val.nama}} {{ helper.format_thn_akd(val.thn_akd) }}</option>
                    {% endfor %}   
                    </select>
                  </td>
                  <td></td>
                  <td></td>
                </tr>
                <tr>
                  <td>Angkatan :</td>
                  <td>
                    <select id="angkatan" name="angkatan" class="form-control">
                      <!-- <option value=""></option> -->
                      {% for a in angkatan %}
                        <option value="{{a.angkatan}}">{{a.angkatan}}</option>
                      {% endfor %}
                    </select>
                  </td>
                  <td></td>
                  <td></td>
                </tr>
                <tr>
                  <td>Keuangan :</td>
                  <td>
                    <select id="angkatan" name="bayar" class="form-control">
                      <!-- <option value=""></option> -->
                      {% for a in data_defkwjb %}
                        <option value="<?= $a['kode_byr'] ?>#<?= $a['nama_byr'] ?>"><?= $a['nama_byr'] ?></option>
                      {% endfor %}
                    </select>
                  </td>
                  <td></td>
                  <td></td>
                </tr>
                <tr>
                  <td>Cek KRS :</td>
                  <td>
                    <div class="checkbox" style="margin-top: 0px">
                      <label>
                        <input type="checkbox" name="cek_krs"> mahasiswa yang tidak melekukan krs,an
                      </label>
                    </div>
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


</section><!-- /.content -->


<script type="text/javascript">
    function cari() {

        angkatan= $('#angkatan').val();

        if(angkatan) {
            var link = '{{ url("akdmhsregistrasi/mahasiswa/") }}';
            var datas = $('form').serialize();
            go_page_data(link,datas)
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
