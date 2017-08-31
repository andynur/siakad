<section class="content-header">
  <h1>
    List Dosen
    <small>it all starts here</small>
  </h1>
  <ol class="breadcrumb">
    <li><a href="#"><i class="fa fa-dashboard"></i> List</a></li>
    <li class="active">Dosen</li>
  </ol>
</section>

<!-- Main content -->
<section class="content">
  <div class="row">
    <div class="col-md-12">
      <div class="box">
        <div class="box-header with-border">
          <h3 class="box-title">Bordered Table</h3>
        </div><!-- /.box-header -->
        <div class="box-body">
          <table id="example2" class="table table-bordered table-striped">
            <thead>
              <tr>
                <th style="width: 10px">No</th>
                <th style="">NIP</th>
                <th>Nama</th>
                <th>Status</th>
                <th>Kelamin</th>
                <th></th>
              </tr>
            </thead>
            <tbody>
            
            {% set no=1 %}
            {% for v in sdm %}
            <tr>
              <td>{{no}}</td>
              <td>{{v.nip}}</td>
              <td><a id="res" data-toggle="modal" href="#" data-target="#myModal{{v.nip}}">{{v.namag}} </a></td>
              <td>
                {% if v.id_status == "1" %}
                  <span class="badge bg-green">{{v.id_status}}</span>
                {% else %}
                  <span class="badge bg-red">{{v.id_status}}</span>
                {% endif %}
              </td>
              <td>{{v.kelamin}}</td>
              <td>
                  <!-- Modal -->
                  <div class="modal fade" id="myModal{{v.nip}}" role="dialog">
                    <div class="modal-dialog">
                    
                      <!-- Modal content-->
                      <div class="modal-content">
                        <div class="modal-header" style="text-align: center;">
                          <button type="button" class="close" data-dismiss="modal">&times;</button>
                          <h2 class="box-title text-red">ANDA AKAN MENGAKSES DATA PENTING! </h2>
                        </div>
                        <div class="modal-body" style="  border: 1px solid #eee;  width: 80%; margin: 0 auto;">
                            <div class="form">
                              <div class="box-body">
                                <div class="row">
                                  <div class="col-md-12">
						    		<div class="col-md-9">
							    		<div class="form-group has-warning">
						                 <label class="control-label" for="inputError"><i class="fa fa-times-circle-o"></i> SILAKAN MASUKKAN PASSWORD ANDA :</label>
						                  <input type="password" style="width: 100%;" class="form-control" id="pass{{v.nip}}" placeholder="Enter ...">
						                </div>
					                </div>
						    		<div class="col-md-3" style="padding:11px 5px;">
						    		<button onclick="cek_pass('{{v.nip}}')" class="pull-left btn bg-navy btn-flat margin">Lanjutkan</button>
						    		</div>    			
					    		</div>
                                </div>
                              </div>
                            </div>
                        </div>
                        <div class="modal-footer">
                          <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                        </div>
                      </div>
                      
                    </div>
                  </div>
              </td>
            </tr>
            {% set no=no+1 %}
            {% endfor %}

            </tbody>            
          </table>
        </div><!-- /.box-body -->
      </div><!-- /.box -->
    </div>

  </div>

      
</section><!-- /.content -->

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

function cek_pass(nip) {
	var pass = $("#pass"+nip).val();
	var datas = "pass="+pass+"&nip_yang_di_ganti="+nip;
    var urel = '{{ url("akdresetpass/rubahPass/") }}';
    $.ajax({
        type: "POST",
        dataType: "JSON",
        url: urel,
        data: datas,
        success: function(data){ 
        	$('#myModal'+nip).modal('hide');
    			$('body').removeClass('modal-open');
    			$("body").css("padding-right", "0px");
    			$('.modal-backdrop').remove();
        	
          if (data.status == true) {
            	var link = '{{ url("akdresetpass/viewPass/") }}';
    			    var datas = "pass="+data.pass+"&nip="+data.nip;
    			    go_page_data(link,datas); 
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