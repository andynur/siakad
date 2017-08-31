<section class="content-header">
  <h1>
    RESET PASSWORD SDM 
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
          <h2 class="box-title text-red">ANDA AKAN MENGAKSES DATA PENTING! </h2>
        </div>
        <div class="box-body" style="height: 300px;">
    		<div class="col-md-3"></div>
    		<div class="col-md-6">
	    		<div class="col-md-8">
		    		<div class="form-group has-warning">
               <label class="control-label" for="inputError"><i class="fa fa-times-circle-o"></i> SILAKAN MASUKKAN PASSWORD ANDA :</label>
                <input type="password" class="form-control" id="pass" placeholder="Enter ...">
              </div>
            </div>
	    		<div class="col-md-4" style="padding:14px 5px;">
	    		<button onclick="cek_pass()" class="pull-left btn bg-navy btn-flat margin">Login</button>
	    		</div>    			
    		</div>
    		<div class="col-md-3"></div>    	
        </div>
      </div><!-- /.box -->
    </div>

  </div>
      
</section><!-- /.content -->

<script type="text/javascript">
function cek_pass() {
	var pass = $("#pass").val();
	var datas = "pass="+pass;
    var urel = '{{ url("akdresetpass/cek/") }}';
    $.ajax({
        type: "POST",
        dataType: "JSON",
        url: urel,
        data: datas,
        success: function(data){ 
            if (data.status == true) {
            	var link = '{{ url("akdresetpass/cariMhs/") }}';
    			go_page(link);
            }else{
            	new PNotify({
					title: 'Regular Notice',
					text: 'Password salah.!',
					type:'warning'
				});
            }
        }
    });
}
</script>