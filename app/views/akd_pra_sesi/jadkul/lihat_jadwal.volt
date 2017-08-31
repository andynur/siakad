<section class="content-header">
  <button type="button" onclick="back('{{thn_akd}}','{{session_id}}')" class="btn bg-navy btn-flat margin"><i class="fa fa-fw fa-arrow-left"></i> Back</button>
  
  <ol class="breadcrumb">
    <li><a href="#"><i class="fa fa-dashboard"></i> Lihat</a></li>
    <li class="active">Jadwal {{id_mkkpkl}}</li>
  </ol>
</section>

<!-- Main content -->
<section class="content">
  <div class="row">
    <!-- left column -->
    <div class="col-md-5">
        <div class="box">
          <div class="box-body">
          <h3 class=""> 
              {{thn_kur}} <span class="text-green">{{kode_mk}}</span>
              <small>{{nama}}</small>
            </h3>
            <p class=""> 
              Kelas <span class="text-green">{{nama_kelas}}</span> - 
              SKS <span class="text-green">{{sks}}</span> | 
              Kapasitas : <span class="text-green">{{kapasitas}}</span> Mahasiswa 
            </p>
            
            <div class="box-group" id="accordion">
              <!-- we are adding the .panel class so bootstrap.js collapse plugin detects it -->
              <div class="panel box box-success">
                <div class="box-header with-border">
                  <h4 class="box-title">
                    <a data-toggle="collapse" data-parent="#accordion" href="#collapseOne" aria-expanded="false" class="collapsed">
                      Dosen Mengajar
                    </a>
                  </h4>
                </div>
                <div id="collapseOne" class="panel-collapse collapse" aria-expanded="false" style="height: 0px;">
                  <div class="box-body">
                    <ol>
                      {% for v in dosen %}
                        <li>{{v.nama}}</li>
                      {% endfor %}
                    </ol>
                  </div>
                </div>
              </div>              
            </div>
          </div><!-- /.box-body -->
        </div>
    </div>

    <div class="col-md-7">
      <div class="box">
        <div class="box-header">
          <h3 class="box-title">Jadwal {{nama}}</h3>
        </div><!-- /.box-header -->
        <div class="box-body">
          <table class="table table-bordered">
            <tbody><tr>
              <th>Hari</th>
              <th>Awal</th>
              <th>Akhir</th>
              <th>Ruang</th>
              <th>Dosen</th>
              <th>Edit</th>
            </tr>
            {% for v in jadwal %}
              <tr>
                <td>{{ helper.hari(v.hari)}}</td>
                <td><span class="text-green"> {{v.jam_awal}} </span></td>
                <td><span class="text-red"> {{v.jam_akhir}} </span></td>
                <td>{{v.nama_ruang}}</td>
                <td>{{v.dosen}}</td>
                <td>
                <a class="btn btn-primary btn-xs btn-flat" onclick="edit_jadkul('{{v.jadkul_id}}','{{v.id}}')"><i class="glyphicon glyphicon-edit"></i> </a>
                <a onclick="delete_data('{{v.jadkul_id}}')" class="btn btn-danger btn-xs btn-flat"><i class="glyphicon glyphicon-trash"></i></a> 
              </td>
              </tr>
            {% endfor %}
            
          </tbody></table>
        </div><!-- /.box-body -->
      </div>
    </div>
  </div>
  <div class="row">
    <div class="col-md-12">
      <table border="0" bgcolor="#ffffff" cellpadding="2" cellspacing="5">
   <tbody><tr>
   <td bgcolor="white"><font face="arial,helvetica" size="2">&nbsp;</font></td>
   <td bgcolor="#ffffff"><font face="arial,helvetica" size="2">Kosong</font></td>
   <td bgcolor="#00aaaa"><font face="arial,helvetica" size="2">&nbsp;</font></td>
   <td bgcolor="#ffffff"><font face="arial,helvetica" size="2">Terpakai</font></td>
   <td bgcolor="#aaaa00"><font face="arial,helvetica" size="2">&nbsp;</font></td>
   <td bgcolor="#ffffff"><font face="arial,helvetica" size="2">Mhs di tempat lain</font></td>
   <td bgcolor="#ff55cc"><font face="arial,helvetica" size="2">&nbsp;</font></td>
   <td bgcolor="#ffffff"><font face="arial,helvetica" size="2">Dosen di tempat lain</font></td>
   <td bgcolor="#ccccff"><font face="arial,helvetica" size="2">&nbsp;</font></td>
   <td bgcolor="#ffffff"><font face="arial,helvetica" size="2">Kelas lain</font></td>
   <td bgcolor="#0000ff"><font face="arial,helvetica" size="2">&nbsp;</font></td>
   <td bgcolor="#ffffff"><font face="arial,helvetica" size="2">Kelas ini</font></td>
   </tr>
   </tbody></table>
    </div>
  </div>
    
  <div class="row">
    <div class="col-md-12">
      <div class="box box-primary">
        <div class="box-header">
          <h3 class="box-title">Tambah Jadwal</h3>
        </div><!-- /.box-header -->
        <div class="box-body">
        <form method="post" id="add_data"> 
        <input type="text" id="thn_akd" name="thn_akd" value="{{thn_akd}}" style="display:none;">
        <input type="text" id="session_id" name="session_id" value="{{session_id}}" style="display:none;">
        <input type="text" id="thn_kur" name="thn_kur" value="{{thn_kur}}" style="display:none;">
        <input type="text" id="nama_kelas" name="nama_kelas" value="{{nama_kelas}}" style="display:none;">
        <input type="text" id="kode_mk" name="kode_mk" value="{{kode_mk}}" style="display:none;">
        <input type="text" id="id_jadkul" name="id_jadkul" value="{{id_jadkul}}" style="display:none;">
          <table class="table table-bordered">
            <tbody>
            <tr>
              <th>ID</th>
              <th>Hari</th>
              <th>Awal</th>
              <th>Akhir</th>
              <th>Ruang</th>
              <th>Dosen</th>
              <th></th>
            </tr>

            <tr>
              <td>{{id_jadkul}}</td>
              <td>
                <select name="hari" class="form-control">
                  <option value=""></option>
                  <option value="1">Senin</option>
                  <option value="2">Selasa</option>
                  <option value="3">Rabu</option>
                  <option value="4">Kamis</option>
                  <option value="5">Jum'at</option>
                  <option value="6">Saptu</option>
                  <option value="7">Minggu</option>
                </select>
              </td>
              <td>
                <div class="bootstrap-timepicker">
                  <div class="input-group">
                    <input name="awal" type="text" style="width: 100px;" class="form-control">
                  </div>
                </div>
              </td>
              <td>
                <div class="bootstrap-timepicker">
                  <div class="input-group">
                    <input name="akhir" type="text" style="width: 100px;" class="form-control">
                  </div>
                </div>
              </td>
              <td>
                <select name="ruang" class="form-control">
                <option value=""></option>
                  {% for v in ruang %}
                    <option value="{{v.ruang_id}}">{{v.nama_ruang}}</option>
                  {% endfor %}
                </select>
              </td>
              <td>
                <select name="dosen" class="form-control">
                <option value=""></option>
                  {% for v in dosen %}
                    {% if v.nip != '' %}
                      <option value="{{v.nip}}">{{v.nama}}</option>
                    {% endif %}
                  {% endfor %}
                </select>
              </td>
              <td>  <button type="button" onclick="add_jadkul()" class="btn bg-navy btn-flat">Simpan</button>
              </td>
            </tr>            
          </tbody></table>
          </form>
        </div><!-- /.box-body -->
      </div>
    </div>
  </div>



<!-- ####### --><!-- ####### --><!-- ####### --><!-- JADWAL --><!-- ####### --><!-- ####### --><!-- ####### -->
<!-- ####### --><!-- ####### --><!-- ####### --><!-- JADWAL --><!-- ####### --><!-- ####### --><!-- ####### -->
<!-- ####### --><!-- ####### --><!-- ####### --><!-- JADWAL --><!-- ####### --><!-- ####### --><!-- ####### -->
<?php 
error_reporting(0);
$namahari[1] = "Senin";
$namahari[2] = "Selasa";
$namahari[3] = "Rabu";
$namahari[4] = "Kamis";
$namahari[5] = "Jum`at";
$namahari[6] = "Sabtu";
$namahari[7] = "Minggu";

$batas1 = 7;
$batas2 = 20;
$menitbatas1 = $batas1*60;
$menitbatas2 = $batas2*60;
$fullspan = ($menitbatas2 - $menitbatas1)/30 + 2;
$divcount = 1;
?>
<div class="row">
  <div class="col-md-1"></div>
  <div class="col-md-10">
<?php for($i = 1; $i <= 7; $i++) { ?>
    <div class="box">
      <div class="box-header with-border">
        <h3 class="box-title">Hari <span class="text-red"><?= $namahari[$i] ?></span></h3>
      </div><!-- /.box-header -->
      <div class="box-body">
          <table style="width:100%">
            <tr>
              <td id='onblack'>RUANG/JAM</td>
              <?php for ($n=$batas1;$n<=$batas2;$n++) {
                 printf ("<td id=onblack colspan=2><font size=2>%02d:00</font></td>",$n);
              } ?>
            </tr>
            <?php 
            $get_session = $this->session->get('ps_id');
            $explode = explode('-', $get_session);
            $ps_id = $explode[1];
            $xc = 0;
            foreach ($ruang_jadwal as $key => $value){
              if(!array_key_exists("$i|$value[ruang_id]", $kuliah_jadwal_data)) {
                echo "<tr>
                <td>$value[nama_ruang]</td>";
                for($n=0;$n<$fullspan;$n++) echo "<td>&nbsp;</td>";
                echo "</tr>";
              }else{
                echo "<tr>
                <td>$value[nama_ruang]</td>";

                $events = substr($kuliah_jadwal_data["$i|$value[ruang_id]"],0,-1);
                $event = explode(";",$events);
                $count = count($event);
                $colspansisa = $fullspan;
                $cellpos = 1;

                // echo "<pre>".print_r($event,1)."</pre>";
                for ($e = 0; $e < $count; $e++) {
                    $exp = explode("|",$event[$e]);
                    $ps_id0 = $exp[0];
                    $thn_kur0 = $exp[1];
                    $kode_mk0 = $exp[2];
                    $thn_akd0 = $exp[3];
                    $session_id0 = $exp[4];
                    $nama_kelas0 = $exp[5];
                    $id0 = $exp[6];
                    $sem0 = $exp[7];
                    $jam_awal = $exp[8];
                    $jam_akhir = $exp[9];
                    $ruang_id0 = $exp[10];
                    $nip[0] = $exp[11];
                    $nip[1] = $exp[12];
                    $nip[2] = $exp[13];
                    $nip[3] = $exp[14];
                    $nip[4] = $exp[15];
                    $nip[5] = $exp[16];
                    $nip[6] = $exp[17];
                    $nip[7] = $exp[18];
                    $nip[8] = $exp[19];
                    $nama_mk = $exp[20];
                    $dosen_jadwal[0] = $exp[21];
                    $dosen_jadwal[1] = $exp[22];
                    $dosen_jadwal[2] = $exp[23];
                    $dosen_jadwal[3] = $exp[24];
                    $dosen_jadwal[4] = $exp[25];
                    $dosen_jadwal[5] = $exp[26];
                    $dosen_jadwal[6] = $exp[27];
                    $dosen_jadwal[7] = $exp[28];
                    $dosen_jadwal[8] = $exp[29];
                    $dosenajar = $exp[30];
                    
                    list($jam1,$menit1) = explode(":",$jam_awal);
                    list($jam2,$menit2) = explode(":",$jam_akhir);


                    /////////////////////// $x1 : adalah posisi sel waktu mulai
                    $x1 = (($jam1-$batas1) * 2) + 1;
                    if($x1 < 0) $x1 = 1;
                    if($menit1 > 15) $x1++;
                    if($menit1 >= 40) $x1++;
                    /////////////////////// $x2 : adalah posisi sel waktu selesai
                    $x2 = (($jam2-$batas1) * 2) + 1;
                    if($x2 < 0) $x2 = 1;
                    if($menit2 >= 15) $x2++;
                    if($menit2 > 30) $x2++;

                    /////////////// Tambahkan sel-sel kosong sampai waktu mulai
                    if( $cellpos < $x1 ) {
                    $cellcount = $x1 - $cellpos;
                    for($n=0;$n<$cellcount;$n++) echo "<td>&nbsp;</td>";
                    $cellpos += $cellcount;
                    } else $x1 = $cellpos;

                    ////////// Sekarang mulai hitung sel dari mulai sampai selesai
                    $cellcount = $x2 - $x1;

                    if($cellcount > 0) {
                      $bentrokdosen = 0;
                      for($m = 0; $m < 9; $m++) {
                         for($k = 0; $k < 9; $k++) {
                            // echo "<pre>".print_r("xx".$nip_jadwal[$m].' '.$nip[$k],1)."</pre>";
                            if($nip_jadwal[$m] == $nip[$k] && $nip_jadwal[$m] != '') {
                               $bentrokdosen++;
                               $mynip = $nip_jadwal[$m];
                            } else $mynip = "&nbsp;";
                         }
                      }

                      if ($thn_kur == $thn_kur0 && $ps_id == $ps_id0 && $kode_mk == $kode_mk0 && $nama_kelas == $nama_kelas0) {
                         $bg = "#0000ff"; // kelas ini
                      } elseif ($bentrokdosen > 0) {
                         $bg = "#ff55cc"; //bentrok dosen
                      } elseif($ruang_id0 != $ruang_id0 && $sem == $sem0 && $kode_mk != $kode_mk0 && $thn_kur == $thn_kur0 && $ps_id == $ps_id0) {
                         $bg = "#aaaa00"; // mhs ditempat lain
                      } elseif ($thn_kur == $thn_kur0 && $ps_id == $ps_id0 && $kode_mk == $kode_mk0 && $nama_kelas != $nama_kelas0) {
                         $bg = "#ccccff"; // kelas lain
                      } else $bg = "#00aaaa";
                      $mkkelas = "$ps_id $kode_mk $nama_mk </br> kelas = $nama_kelas </br>";
                      $namadosen = trim("$dosen_jadwal[0]",",")." ";
                      for($ds = 1; $ds < 9; $ds++) {
                         if($dosen_jadwal[$ds] != '') $namadosen .= "<br>".trim($dosen_jadwal[$ds],",");
                      }
                      $namadosen = str_replace("'","\\'",$namadosen);
                      echo "<td bgcolor=$bg colspan=$cellcount onClick=\"
                      new PNotify({
                           title: 'Regular Notice',
                           text: '$mkkelas Dosen = $dosenajar',
                           type:'success'
                      });
                      \">&nbsp;</td>\n";
                      $divcount++;

                      $cellpos += $cellcount;
                    }
                    // echo "<pre>".print_r($event[$e+1],1)."</pre>";
                    if($event[$e+1] == '') {
                        $cellcount = $fullspan - $cellpos + 1;
                        for($n=0;$n<$cellcount;$n++) echo "<td>&nbsp;</td>";
                        continue;
                    }
                }
                echo "</tr>\n";
              }
            } 
            ?>
          </table>
      </div><!-- /.box-body -->
    </div>

<?php } ?>
  </div>
</div>     

</section><!-- /.content -->

<style>
table, th, td {
    border: 1px solid black;
    border-collapse: collapse;
}
th, td {
    padding: 2px;

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

  $(".timepicker").timepicker({
    showInputs: false
  });
  $(".timepicker2").timepicker({
    showInputs: false
  });

  $('.content-wrapper').css('height','3450px');

});

function reload() {
  var thn_akd = "{{thn_akd}}";
  var session_id = "{{session_id}}";
  var thn_kur = "{{thn_kur}}";
  var nama = "{{nama}}";
  var kapasitas = "{{kapasitas}}";
  var nama_kelas = "{{nama_kelas}}";
  var kode_mk = "{{kode_mk}}";
  var sks = "{{sks}}";
  var id_mkkpkl = "{{id_mkkpkl}}";
  var link = '{{ url("akdjadkul/lihatJadwal/") }}';
  var datas = "thn_akd="+thn_akd+"&session_id="+session_id+"&thn_kur="+thn_kur+"&kode_mk="+kode_mk+"&nama_kelas="+nama_kelas+"&nama="+nama+"&sks="+sks+"&kapasitas="+kapasitas+"&id_mkkpkl="+id_mkkpkl;
  reload_page_data(link,datas);
}

function edit_jadkul(id_jadkul,id) {
  var thn_akd = "{{thn_akd}}";
  var session_id = "{{session_id}}";
  var thn_kur = "{{thn_kur}}";
  var nama = "{{nama}}";
  var kapasitas = "{{kapasitas}}";
  var nama_kelas = "{{nama_kelas}}";
  var kode_mk = "{{kode_mk}}";
  var sks = "{{sks}}";
  var id_mkkpkl = "{{id_mkkpkl}}";
  var link = '{{ url("akdjadkul/editJadkul/") }}';
  var datas = "thn_akd="+thn_akd+"&session_id="+session_id+"&thn_kur="+thn_kur+"&kode_mk="+kode_mk+"&nama_kelas="+nama_kelas+"&nama="+nama+"&sks="+sks+"&kapasitas="+kapasitas+"&id_mkkpkl="+id_mkkpkl+"&id_jadkul="+id_jadkul+"&id="+id;
  go_page_data(link,datas);
}

function back(thn_akd,session_id) {
  var datas = "sesi="+thn_akd+'-'+session_id;
  var link = '{{ url("akdjadkul/listMkJadwal/") }}';
  go_page_data(link,datas);
}

function add_jadkul() {
  var datas = $('#add_data').serialize();
  var urel = '{{ url("akdjadkul/addJadkul") }}';
  $.ajax({
       type: "POST",
       url: urel,
       dataType : "json",
       data: datas
    }).done(function( data ) {
      if (data.type == 'error') {
          (new PNotify({
              title: 'Confirmation Needed',
              text: data.text,
              icon: 'glyphicon glyphicon-question-sign',
              hide: false,
              confirm: {
                  confirm: true,
                  buttons: [{
                    text: 'Gabungkan',
                    addClass: 'btn-primary',
                    click: function(notice) {
                      var link = '{{ url("akdjadkul/gabungJadkul") }}';
                      var st = $('#add_data').serialize();
                      $.ajax({
                          type: "POST",
                          url: link,
                          data: st,
                          dataType : "json",
                          success: function(res){ 
                              reload();
                              notice.update({
                                title: res.title,
                                text: res.text,
                                icon: true,
                                type: 'success',
                                hide: false,
                                confirm: {
                                    confirm: true,
                                    buttons: [{
                                        text: 'Ok',
                                        addClass: 'btn-primary',
                                        click: function(notice) {
                                            notice.remove();
                                        }
                                    },
                                    null]
                                },
                                buttons: {
                                    closer: false,
                                    sticker: false
                                }
                              });
                          }
                      });
                        
                    }
                }]
              },
              buttons: {
                  closer: false,
                  sticker: false
              },
              history: {
                  history: false
              },
              addclass: 'stack-modal',
              stack: {
                  'dir1': 'down',
                  'dir2': 'right',
                  'modal': true
              }
          })).get().on('pnotify.cancel', function() {
              console.log('batal');
          });


      }else{
        new PNotify({
           title: data.title,
           text: data.text,
           type: data.type
        });
        reload();
      }
  });
}

function delete_data(id){
  var urel = '{{ url("akdjadkul/deleteJadkul") }}/'+id;
  (new PNotify({
      title: 'Confirmation Needed',
      text: 'Apakah Anda Yakin menghapus data ini?',
      icon: 'glyphicon glyphicon-question-sign',
      hide: false,
      confirm: {
          confirm: true
      },
      buttons: {
          closer: false,
          sticker: false
      },
      history: {
          history: false
      }
  })).get().on('pnotify.confirm', function() {
      $.ajax({
          type: "POST",
          dataType: "JSON",
          url: urel,
          success: function(data){ 
              new PNotify({
                   title: 'Regular Notice',
                   text: 'data telah dihapus',
                   type:'success'
              });
              reload();
          }
      });
  }).on('pnotify.cancel', function() {
     console.log('batal');
  });
}

</script>