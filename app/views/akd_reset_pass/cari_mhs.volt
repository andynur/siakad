<section class="content-header">
  <h1>
    RESET PASSWORD INDIVIDU/KOLEKTIF MAHASISWA
    <small>it all inform here</small>
  </h1>
  <ol class="breadcrumb">
    <li><a href="#"><i class="fa fa-dashboard"></i> Reset</a></li>
    <li class="active">Password</li>
  </ol>
</section>

<!-- Main content -->
<section class="content">
  <div class="row">
    <!-- left column -->
    <div class="col-md-12">
      <div class="box box-info">
      <div class="box-header with-border" style="text-align: center;">
          <h2 class="box-title text-info">Pilih mode reset! </h2>
        </div>
        <div class="box-body" style="height: 300px;">
    		<div class="col-md-2"></div>
    		<div class="col-md-8">
	    		  <table class="table">
    <tbody>
      <tr>
        <td>Nomor Mahasiswa :</td>
        <td><input type="radio" name="optionsRadios" id="radio" value="mhs"></td>
        <td><input type="text" class="form-control" id="no_mhs" placeholder="Enter..."></td>
        <td></td>
        <td></td>
      </tr>
      <tr class="form-horizontal">
        <td>Range Nomor Mahasiswa :</td>
        <td><input type="radio" name="optionsRadios" id="radio" value="range"></td>
        <td><input type="text" class="form-control" id="range1" placeholder="Enter..."></td>
        <td><label for="inputEmail3" class="col-sm-2 control-label">S/D</label></td>
        <td><input type="text" class="form-control" id="range2" placeholder="Enter..."></td>
      </tr>
      <tr>
        <td>Angkatan :</td>
        <td><input type="radio" name="optionsRadios" id="radio" value="angkatan"></td>
        <td><select id="angkatan" class="form-control">
	            <option></option>
	            <option>2017</option>
	            <option>2016</option>
	            <option>2015</option>
	        </select></td>
        <td></td>
        <td></td>
      </tr>
      <tr>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td><button onclick="cek_pass()" class="pull-right btn bg-navy btn-flat margin">Reset</button></td>
      </tr>
    </tbody>
  </table>   			
    		</div>
    		<div class="col-md-2"></div>    	
        </div>
      </div><!-- /.box -->
    </div>

  </div>
      
</section><!-- /.content -->

<script type="text/javascript">
function cek_pass() {
	var radio = $('input[name=optionsRadios]:checked').val();

	var no_mhs = $("#no_mhs").val();
	var range1 = $("#range1").val();
	var range2 = $("#range2").val();
	var angkatan = $("#angkatan").val();

	var datas = "no_mhs="+no_mhs+"&range1="+range1+"&range2="+range2+"&angkatan="+angkatan+"&radio="+radio;
    var urel = '{{ url("akdresetpass/resetMhs/") }}';

    (new PNotify({
        title: 'Confirmation Needed',
        text: 'Apakah Anda Yakin meRESET Password?',
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
            data: datas,
            success: function(data){ 
                if (data.status == true) {
            	var link = '{{ url("akdresetpass/berhasilMhs/") }}';
    			    var datas = "no_mhs="+no_mhs+"&range1="+range1+"&range2="+range2+"&angkatan="+angkatan+"&radio="+radio;
    			    go_page_data(link,datas); 
	            }else{
	            	new PNotify({
      					title: 'Regular Notice',
      					text: 'Gagal Reset.!',
      					type:'warning'
      				});
	            }
            }
        });
    }).on('pnotify.cancel', function() {
       console.log('batal');
    });
}
</script>