
  {% for data in edit %}
<section class="content-header">
  <h1>
    Data MHS
    <small>{{ data.nama }} ( {{ data.id_mhs }} )</small>
  </h1>
  <ol class="breadcrumb">
    <li><a href="#"><i class="fa fa-dashboard"></i> MHS</a></li>
    <li class="active">Data MHS</li>
  </ol>
</section>

<!-- Main content -->
<section class="content">
  {#buat input no mhs & nama mhs#}
  <div class="row">

    <div class="col-md-12 form_data">
      <!-- Collect the nav links, forms, and other content for toggling -->
      <nav class="navbar navbar-default" role="navigation" style="    height: 50px;">
        <!-- Collect the nav links, forms, and other content for toggling -->
        <div class="collapse navbar-collapse navbar-ex1-collapse">
        <ul class="nav navbar-nav" style="align-text: center;">
          <li class="active"><a href="#javascript:void(0)" onclick="return go_page('akdmhs/data/'+{{ data.id_mhs }})" data-toggle="tab">BIODATA</a></li>
          <li><a href="javascript:void(0)" onclick="return go_page('akdmhs/krs_khs/'+{{ data.id_mhs }})" data-toggle="tab">KRS/KHS</a></li>
          <li><a href="javascript:void(0)" onclick="return go_page('akdmhs/grafik_ip/'+{{ data.id_mhs }})" data-toggle="tab">GRAFIK IP</a></li>
          <li><a href="javascript:void(0)" onclick="return go_page('akdmhs/sejarah_nilai/'+{{ data.id_mhs }})" data-toggle="tab">SEJARAH NILAI</a></li>
          <li><a href="javascript:void(0)" onclick="return go_page('akdmhs/jadwal/'+{{ data.id_mhs }})" data-toggle="tab">JADWAL</a></li>
          <li><a href="javascript:void(0)" onclick="return go_page('akdmhs/pembayaran/'+{{ data.id_mhs }})" data-toggle="tab">PEMBAYARAN</a></li>
          <li><a href="javascript:void(0)" onclick="return go_page('akdmhs/evaluasi_diri/'+{{ data.id_mhs }})" data-toggle="tab">EVALUASI DIRI</a></li>
        </ul>
        </div><!-- /.navbar-collapse -->
      </nav>

      <div class="col-md-3 side" >
        <!-- Profile Image -->
        <div class="box box-primary">
          <div class="box-body box-profile">
            <img class="profile-user-img img-responsive img-circle foto" src="" alt="User profile picture">

            <h3 class="profile-username text-center">{{ data.nama }}</h3>

            <p class="text-muted text-center" id="juursun">Mahasiswa <?php echo $profil_mhs ?></p>

            <ul class="list-group list-group-unbordered">
              <li class="list-group-item">
                <b>No Mahasiswa</b> <a class="pull-right">{{ data.id_mhs }}</a>
              </li>
              <li class="list-group-item">
                <b>Dosen Wali</b> <a class="pull-right">
                  {% for d in profil_dosen_wali %}
                    {{ d.dosen }}
                  {% endfor %}
                </a>
              </li>
              <li class="list-group-item">
                <b>Angkatan</b> <a class="pull-right">{{ data.angkatan }}</a>
              </li>
              <li class="list-group-item">
                <b>Jenis Kelamin</b> <a class="pull-right profil_jk"></a>
              </li>
            </ul>

            <a href=" javascript:void(0) " class="historyAPI btn btn-primary form-control" onclick="data('{{ data.id_mhs }}')">Edit Mahasiswa</a>
          </div>
          <!-- /.box-body -->
        </div>
        <!-- /.box -->

        <!-- About Me Box -->
        <div class="box box-primary">
          <div class="box-header with-border">
            <h3 class="box-title">About Me</h3>
          </div>
          <!-- /.box-header -->
          <div class="box-body">
            <strong><i class="fa fa-book margin-r-5"></i> Education</strong>

            <p class="text-muted">
              Student of :<br> {{ data.asal_smu}}
            </p>

            <hr>

            <strong><i class="fa fa-map-marker margin-r-5"></i> Location</strong>

            <p class="text-muted">{{ data.alamat_yk }}</p>

            <hr>

            <strong><i class="fa fa-phone margin-r-5"></i> Phone</strong>

            <p class="text-muted">{{ data.telpon }}</p>

            <hr>

            <strong><i class="fa fa-file-text-o margin-r-5"></i> Notes</strong>

            <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam fermentum enim neque.</p>
          </div>
          <!-- /.box-body -->
        </div>
        <!-- /.box -->
      </div>


      <div class="col-md-9">
        <!-- Profile Image -->
        <div class="box box-primary">
          <div class="box-body ">
            <div class="col-lg-12">
              <img class="profile-user-img img-responsive img-circle foto" src="" alt="User profile picture" style="width:130px;">

              <h3 class="profile-username text-center">{{ data.nama }}</h3>

              <p class="text-muted text-center" id="juursun">Mahasiswa <?php echo $profil_mhs ?></p>

              <div style="width :100%; background: #ddd; text-align:center; padding:3px;">
                <b> Data Mahasiswa</b>
              </div>

              <style media="screen">
                tr{
                  border-bottom:1px #ddd solid;
                }
                td{
                  padding:10px 0 2px 10px;
                }
              </style>

                <table width="100%" id="bio1">
                  <tr>
                    <td width="30%"><b>Angkatan </b></td>
                    <td>:</td>
                    <td width="70%"><span class="">{{ data.angkatan }}</span></td>
                  </tr>
                  <tr>
                    <td><b>No Mahasiswa </b></td>
                    <td>:</td>
                    <td><span class="">{{ data.id_mhs }}</span></td>
                  </tr>
                  <tr>
                    <td><b>Nama </b></td>
                    <td>:</td>
                    <td><span class="">{{ data.nama }}</span></td>
                  </tr>
                  <tr>
                    <td><b>Jenis Kelamin </b></td>
                    <td>:</td>
                    <td><span class="profil_jk"></span></td>
                  </tr>
                  <tr>
                    <td><b>Golongan Darah </b></td>
                    <td>:</td>
                    <td><span class="">{{ data.gol_darah }}</span></td>
                  </tr>
                  <tr>
                    <td><b>Tempat Tanggal Lahir </b></td>
                    <td>:</td>
                    <td><span id="ttl"></span></td>
                  </tr>
                  <tr>
                    <td><b>NIK </b></td>
                    <td>:</td>
                    <td><span class="">{{ data.nik }}</span></td>
                  </tr>
                  <tr>
                    <td><b>Agama </b></td>
                    <td>:</td>
                    <td>
                      {% for a in profil_agama %}
                      <span class="">{{ a.agama }}</span></span>
                      {% endfor %}
                    </td>
                  </tr>
                  <tr>
                    <td><b>Tanggal Masuk </b></td>
                    <td>:</td>
                    <td><span class="">{{ data.tgl_masuk }}</span></td>
                  </tr>

                </table><br>

              <div style="width :100%; background: #ddd; text-align:center; padding:3px;">
                <b> Alamat Sekarang</b>
              </div>

              <table width="100%" id="bio2">
                <tr>
                  <td width="30%"><b>Alamat </b></td>
                  <td>:</td>
                  <td width="70%"><span class="">{{ data.alamat_yk }}</span></td>
                </tr>
                <tr>
                  <td><b>Provinsi/Kota </b></td>
                  <td>:</td>
                  <td>
                    {% for p in profil_prov %}<span id="prov">{{ p.provinsi }}{% endfor %}{% for p in profil_kota %}, {{ p.kabupaten }}</span></span>{% endfor %}
                  </td>
                </tr>
                <tr>
                  <td><b>Kode Pos </b></td>
                  <td>:</td>
                  <td><span class="">{{ data.kode_posyk }}</span></td>
                </tr>
                <tr>
                  <td><b>Telepon </b></td>
                  <td>:</td>
                  <td><span class="">{{ data.telpon }}</span></td>
                </tr>

              </table><br>

              <div style="width :100%; background: #ddd; text-align:center; padding:3px;">
                <b> Alamat Asal</b>
              </div>
              <table width="100%" id="bio1">
                <tr>
                  <td width="30%"><b>Alamat </b></td>
                  <td>:</td>
                  <td width="70%"><span class="">{{ data.alamat_asal }}</span></td>
                </tr>
                <tr>
                  <td><b>Provinsi/Kota </b></td>
                  <td>:</td>
                  <td>
                    {% for p in profil_prov2 %}<span id="prov">{{ p.provinsi }}{% endfor %}{% for p in profil_kota %}, {{ p.kabupaten }}</span></span>{% endfor %}
                  </td>
                </tr>
                <tr>
                  <td><b>Kode Pos </b></td>
                  <td>:</td>
                  <td><span class="">{{ data.kdpos_asal }}</span></td>
                </tr>
                <tr>
                  <td><b>Telepon </b></td>
                  <td>:</td>
                  <td><span class="">{{ data.telpon_asal }}</span></td>
                </tr>

              </table><br>

              <div style="width :100%; background: #ddd; text-align:center; padding:3px;">
                <b> Asal Sekolah</b>
              </div>
              <table width="100%" id="bio1">
                <tr>
                  <td width="30%"><b>Nama Asal Sekolah </b></td>
                  <td>:</td>
                  <td width="70%"><span class="">{{ data.asal_smu }}</span></td>
                </tr>
                <tr>
                  <td><b>Alamat Sekolah </b></td>
                  <td>:</td>
                  <td><span class="">{{ data.alamat_sekolah }}</span></td>
                </tr>
                <tr>
                  <td><b>NISN </b></td>
                  <td>:</td>
                  <td><span class="">{{ data.nisn }}</span></td>
                </tr>

              </table><br>

              <div style="width :100%; height:30px; background: #ddd; text-align:center; padding:3px; margin-bottom:40px;">
                <b> </b>
              </div>

            </div>

          </div>
          <!-- /.box-body -->
        </div>
        <!-- /.box -->
      </div>
      <!-- /.box-col-lg -->
    </div><!-- /.col-lg -->
  </div><!-- /.row -->
</section><!-- /.content -->
{% endfor %}

<script type="text/javascript" id="tambahan">

</script>
<script type="text/javascript">

id = "{{ data.id_mhs }}";

function data(id) {
  return load_page('akdMhs/edit/'+id,'page_akdMhs/edit/'+id);
}

prop1  = '{{ data.kode_prop }}';
kab1   = '{{ data.kode_kab }}';

$('#prov_kota1').hide();
if (!prop1 == false && !kab1 == false ){
  $('#prov_kota1').show();
}

prop2  = '{{ data.kdprop_asal }}';
kab2   = '{{ data.kdkab_asal }}';

if (!prop2 == false && !kab2 == false ){
  $('#prov_kota2').html(prop2+', '+kab2);
}

jk = '{{ data.gender }}';

if (jk == "L"){
  $('.profil_jk').html('Laki-Laki');
}else if (jk == "P"){
  $('.profil_jk').html('Perempuan');
}

tgl = '{{ data.tgl_lahir }}';
tmp = '{{ data.tempat_lahir }}';

arr = tgl.split("-");
split = arr[2]+'-'+arr[1]+'-'+arr[0];

if (!tgl == false && !tmp == false ){
  $('#ttl').html(tmp+', '+split);
}

ft = '{{ data.foto }}';
$('.foto').removeAttr('src').attr({src : 'http://localhost/sia/public/img/sdm/030206049.jpeg'});
if (ft){

  $.ajax({
    "url":"{{ url('img/mhs/') }}"+ft,
    "type":'head',
    error: function()
    {
      $('.foto').removeAttr('src').attr({src : 'http://localhost/sia/public/img/sdm/030206049.jpeg'});
    },
    success: function()
    {
      $('.foto').removeAttr('src').attr({src : 'img/mhs/'+ft});
    }
  });
}

width = $(window).width();
if (width < 990) {
  $('.side').hide();
} else {
  $('.side').show();
}

</script>
