<section class="content-header">
  <h1>
    Akademik
    <small>it all starts here</small>
  </h1>
  <ol class="breadcrumb">
    <li><a href="#"><i class="fa fa-dashboard"></i> Akademik</a></li>
    <li class="active">Kurikulum</li>
  </ol>
</section>

<!-- Main content -->
<section class="content">
  <div class="row">

    <nav class="navbar navbar-default" role="navigation" style="    height: 50px;">
      <!-- Collect the nav links, forms, and other content for toggling -->
      <div class="collapse navbar-collapse navbar-ex1-collapse">
        <ul class="nav navbar-nav">
          <li class="active"><a href="javascript:void(0)" onclick="return go_page('akademik/kurikulum')">KURIKULUM</a></li>
          <li><a href="javascript:void(0)" onclick="return go_page('akademik/pemetaanKurikulum')">PEMETAAN KURIKULUM</a></li>
        </ul>
      </div><!-- /.navbar-collapse -->
    </nav>

<div class="col-md-12">
  <div class="box">
    <div class="box-header" style="text-align: center;">
      <h2 class="box-title text-blue">Tahun Kurikulum</h2>
    </div>
    <div class="box-body">
    	<div class="col-md-5"></div>
    	<div class="col-md-2">    		
          <button class="btn bg-olive btn-flat margin btn-block" onclick="tambah_data()">TAMBAH</button>
        {% for v in thn %}
          <button class="btn bg-navy btn-flat margin btn-block" onclick="list_kur('{{v.thn_kur}}')">{{v.thn_kur}}</button>
    		{% endfor %}
    	</div>
    	<div class="col-md-5"></div>      
    </div>
  </div>
</div>



  </div><!-- /.row -->
</section><!-- /.content -->

<script type="text/javascript">

function tambah_data() {
    var link = '{{ url("akademik/formTambah/") }}';
    go_page(link);	
}


function list_kur(thn) {
    var link = '{{ url("akademik/listKurikulum/") }}'+thn;
    go_page(link);  
}

function reload() {
  var link = '{{ url("akademik/kurikulum/") }}';
  reload_page2(link); 
}

function add_data(){
    var datas = $('.add_form').serialize();
    console.log(datas);
    $.ajax({
      type: "POST",
      url: "{{ url('akademik/submitKurikulum') }}",
      dataType : "json",
      data: datas
    }).done(function(data) {
      $('#addModal').modal('hide');
    $('body').removeClass('modal-open');
    $("body").css("padding-right", "0px");
    $('.modal-backdrop').remove();
    new PNotify({
         title: data.title,
         text: data.text,
         type: data.type
      });
      if (data.type == "success") {
        reload();
      }
    });
}

</script>


<style type="text/css">
.navbar .navbar-nav {
    display: inline-block;
    float: none;
}

.navbar .navbar-collapse {
    text-align: center;
}
</style>
