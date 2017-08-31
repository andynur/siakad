	<!-- floating refresh button  -->
	<a href="#" onclick="return reload_page2('dashboard/home')" class="float-button">
		<i class="fa fa-refresh my-float-button"></i>
	</a>
	<div class="float-label-container">
		<div class="float-label-text">Refresh Halaman</div>
		<i class="fa fa-play float-label-arrow"></i>
	</div>	
	<!-- end floating refresh button  -->

	<footer class="main-footer">
	    <div class="container">
	      <strong>Copyright &copy; 2017 <a href="#"> SIAKAD Al Azhar</a>.</strong> All rights
	      reserved.
	    </div>
	    <!-- /.container -->
	</footer>
	</div>
	<!-- ./wrapper -->

	<script src="plugins/jQuery/jquery-2.2.3.min.js"></script>
	
	<!-- Bootstrap 3.3.6 -->
	<script src="bootstrap/js/bootstrap.min.js"></script>

	<script src="js/jquery.maskMoney.min.js"></script>
	<!-- jquery InputMask -->
	<script src="plugins/input-mask/jquery.inputmask.js"></script>
	<script src="plugins/input-mask/jquery.inputmask.date.extensions.js"></script>
	<script src="plugins/input-mask/jquery.inputmask.extensions.js"></script>
	<script src="plugins/input-mask/jquery.inputmask.numeric.extensions.js"></script>

	<!-- DataTables -->
	<script src="plugins/datatables/jquery.dataTables.min.js"></script>
	<script src="plugins/datatables/dataTables.bootstrap.min.js"></script>

	<script src="https://cdn.datatables.net/buttons/1.2.4/js/dataTables.buttons.min.js"></script>
	<script src="https://cdn.datatables.net/buttons/1.2.4/js/buttons.bootstrap.min.js"></script>
	<script src="//cdn.datatables.net/buttons/1.2.4/js/buttons.flash.min.js"></script>
	<script src="//cdnjs.cloudflare.com/ajax/libs/jszip/2.5.0/jszip.min.js"></script>
	<script src="//cdn.rawgit.com/bpampuch/pdfmake/0.1.18/build/pdfmake.min.js"></script>
	<script src="//cdn.rawgit.com/bpampuch/pdfmake/0.1.18/build/vfs_fonts.js"></script>
	<script src="//cdn.datatables.net/buttons/1.2.4/js/buttons.html5.min.js"></script>
	<script src="//cdn.datatables.net/buttons/1.2.4/js/buttons.print.min.js "></script>

	<script src="plugins/select2/select2.full.min.js"></script>

	<!-- bootstrap datepicker -->
	<script src="plugins/datepicker/bootstrap-datepicker.js"></script>
	<script src="plugins/timepicker/bootstrap-timepicker.min.js"></script>
	<!-- SlimScroll -->
	<script src="plugins/slimScroll/jquery.slimscroll.min.js"></script>
	<!-- FastClick -->
	<script src="plugins/fastclick/fastclick.js"></script>
	<!-- AdminLTE App -->
	<script src="js/app.js"></script>
	<!-- AdminLTE for demo purposes -->
	<script src="js/demo.js"></script>

	<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.11.2/moment.min.js"></script>
	<!-- PNotify -->
  	
  	{{ javascript_include("plugins/notify/pnotify.custom.min.js") }}
  	{{ javascript_include("https://cdn.ckeditor.com/4.4.3/standard/ckeditor.js") }}
</body>
</html>

<script>
$(document).ready(function () {
    var urel = "{{url('Index/sessionLoginJenis')}}";
    $.ajax({
        method: "GET",
        dataType: "json",
        url: urel,
        success: function (res) {
            // cek login sebagai apa
            // console.log(res);
            // 1 = DOSEN
            // 2 = MHS
            if (res.id_jenis == "1") {
                var link = "{{url('Index/menuArea')}}";
                $.ajax({
                    method: "GET",
                    dataType: "html",
                    url: link,
                    success: function (res) {
                        $('#manu').html(res);
                    }
                });
            } else if (res.id_jenis == "2") {
                var link = "{{url('Index/menuMhs')}}";
                $.ajax({
                    method: "GET",
                    dataType: "html",
                    url: link,
                    success: function (res) {
                        $('#manu').html(res);
                    }
                });
            }
        }
    });
});

function menu(id, ps_id, nama_area) {
    var cek_link = "{{url('Index/cekSession')}}";
    var login = "{{url('account/login')}}";
    $.ajax({
        method: "GET",
        dataType: "json",
        url: cek_link,
        success: function (res) {
            // cek session
            if (res.session == "true") {
                var link = "{{url('Index/menuUser?id=')}}" + id + "&ps_id=" + ps_id + "&nama_area=" + nama_area;
                $.ajax({
                    type: "GET",
                    dataType: "html",
                    url: link,
                    success: function (res) {
                        // console.log(ps_id);
                        $('#manu').html(res);
                        // localStorage.setItem('ps_id_menu', base_url);
                    }
                });
            } else {
                window.location.replace(login);
            }
        }
    });

    $("#activeMenu li a").click(function () {
        $(this).parent().addClass('active').siblings().removeClass('active');
        alert("Sudah dipanggil!");
    });
}

function back_menu() {
    // cek session
    var cek_link = "{{url('Index/cekSession')}}";
    var login = "{{url('account/login')}}";
    $.ajax({
        method: "GET",
        dataType: "json",
        url: cek_link,
        success: function (res) {
            // cek session
            if (res.session == "true") {
                var link = "{{url('Index/menuArea')}}";
                $.ajax({
                    method: "GET",
                    dataType: "html",
                    url: link,
                    success: function (res) {
                        $('#manu').html(res);
                    }
                });
            } else {
                window.location.replace(login);
            }
        }
    });
}

function notif(tipe, judul, isi) {
    $('#notif').addClass('alert-' + tipe);
    $('#notif .notif-title').html(judul);
    $('#notif .notif-body').html(isi);
    $('#notif').fadeIn();
    setTimeout(function () {
        $('#notif').fadeOut(function () {
            $('#notif').removeClass('alert-' + tipe);
        });
    }, 4000);
}
</script>