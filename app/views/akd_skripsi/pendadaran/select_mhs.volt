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
    <div class="col-lg-3"></div>

    <div class="col-md-6">
      <div class="box">
        <div class="box-header">
          <h3 class="box-title">Cari Mahasiswa</h3>
        </div><!-- /.box-header -->
        <div class="box-body">
          <form method="post">
            <table class="table">
              <tbody>
                <tr>
                  <td>Nomor Mahasiswa :</td>
                  <td><input type="text" class="form-control" id="nomhs" name="nomhs" placeholder="nomhs..."></td>
                  <td></td>
                  <td></td>
                </tr>
                <tr>
                  <td>Nama Mahasiswa :</td>
                  <td><input type="text" class="form-control" id="nama_mhs" name="nama_mhs" placeholder="Nama Mhs..."></td>
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
        nomhs = $('#nomhs').val();
        angkatan= $('#angkatan').val();

        if(nomhs || nama_mhs || angkatan) {
            var link = '{{ url("akdpendadaran/mahasiswa/") }}';
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
