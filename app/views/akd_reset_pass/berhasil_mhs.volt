<section class="content-header">
  <h1>
    RESET PASSWORD MAHASISWA
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
          <h2 class="box-title text-info">RESET PASSWORD BERHASIL ! </h2>
        </div>
        <div class="box-body" style="height: 300px;">
    		<div class="col-md-3"></div>
    		<div class="col-md-6">
	    		<div class="col-md-8">
		    		<div class="form-group has-success">
	                 <label class="control-label" for="inputError"><i class="fa fa-times-circle-o"></i> No Mhs yang di RESET:</label>

                   {% if radio == "mhs" %}
                    <input type="text" class="form-control" id="pass" value="{{no_mhs}}" readonly>
                   {% elseif radio == "range" %}
                    <input type="text" class="form-control" id="pass" value="{{range1}} sampai {{range2}}" readonly>                   
                   {% elseif radio == "angkatan" %}
                    <input type="text" class="form-control" id="pass" value="Angkatan {{angkatan}}" readonly>
                   {% endif %}

              </div>
                   <p class="text-aqua">* Passwordnya Mahasiswa adalah tanggal lahir Mhs tersebut</p>
                   <p class="text-aqua">* contoh <code>28-09-2011</code> passwordnya adalah <code>28092011</code></p>
            </div>
	    		<div class="col-md-4" style="padding:14px 5px;">
	    		<button onclick="back()" class="pull-left btn bg-navy btn-flat margin">Ok !</button>
	    		</div>    			
    		</div>
    		<div class="col-md-3"></div>    	
        </div>
      </div><!-- /.box -->
    </div>

  </div>
      
</section><!-- /.content -->

<script type="text/javascript">
function back() {
    var link = '{{ url("akdresetpass/mhsPass/") }}';
    go_page(link);	
}
</script>