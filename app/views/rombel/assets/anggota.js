(function (document, window, $) {
    
    // Set page title
    setPageTitle("Rombel Anggota");

    // Define variables
    var pageUrl         = "{{ url('rombelanggota') }}",
        pageReload      = "rombelanggota/index/{{ rombel_id }}";

    // Form elements object
    var $form           = $("#form_input"),   
        $title          = $("#form_title"),   
        $delete         = $(".delete"),
        $edit           = $(".edit"),
        $submit         = $("#submit"),
        $reset          = $("#reset"),
        $proses         = $('#proses');

    // Input elements object
    var $rombel         = $('select[name=rombongan_belajar_id]'),
        $semester       = $('select[name=semester_id]'),
        $siswa          = $('select[name=siswa_id]'),
        $jenis          = $('select[name=jenis_pendaftaran_id]'),
        $siswaHidden    = $('input[name=siswa_id_hidden]'),
        $siswaView      = $('#siswa'),
        $siswaAdd       = $('#siswa_add'),
        filterRombel    = $('#filter_rombel'),
        filterSemester  = $('#filter_semester');

    // Save data when submit
    $form.on("submit", function(e) {
        var saveUrl = $(this).prop('action');            
        
        pageReload = pageReload + '/' + filterRombel.val() + '/' + filterSemester.val();        
        saveData(this, saveUrl, pageReload);
        e.preventDefault();            
    });

    // Set data from table to form when edit
    $edit.on("click", function() {
        var editId      = $(this).attr("data-id"),
            editUrl     = pageUrl + '/editRombelAnggota/' + editId,
            row         = $('#data_' + editId),
            _no         = row.find('td').eq(0).html(),
            _jenis      = row.find('td').eq(2).html(),
            _nis        = row.find('#nis').html(),
            _siswa      = row.find('#siswa').html(),
            _siswa_id   = row.find('#siswa_id').html(),
            _rombel     = filterRombel.val(),
            _semester   = filterSemester.val(),
            _siswa_join = _siswa + ' (' + _nis + ')';

        $rombel.val(_rombel);
        $semester.val(_semester);
        selectedByText($jenis, _jenis);
        selectedSelect2($siswa, _siswa_id, _siswa_join);
               
        $form.attr('action', editUrl);
        $title.text('Ubah Data #' + _no);
        $reset
            .removeClass('btn-default').addClass('btn-danger')
            .html('<i class="fa fa-times"></i>&nbsp; Batal');
        $submit
            .removeClass('btn-primary').addClass('btn-success')
            .html('<i class="fa fa-send"></i>&nbsp; Update');
    });

    // Delete data when confirmed
    $delete.on("click", function() {
        var deleteId = $(this).attr("data-id"),
            deleteUrl = pageUrl + '/deleteRombelAnggota/' + deleteId;

        pageReload = pageReload + '/' + filterRombel.val() + '/' + filterSemester.val();
        deleteData(deleteUrl, pageReload);
    });

    // Reset or cancel form
    $reset.on("click", function() {
        $form.attr('action', pageUrl + '/addRombelAnggota');
        $title.text('Tambah Anggota');
        $rombel.removeAttr('disabled');
        $semester.removeAttr('disabled');
        $siswa.val('').trigger('change');
        $reset
            .removeClass('btn-danger').addClass('btn-default')
            .html('<i class="fa fa-refresh"></i>&nbsp; Reset');
        $submit
            .removeClass('btn-success').addClass('btn-primary')
            .html('<i class="fa fa-send"></i>&nbsp; Simpan');
    });        

    // Filter data when click
    $proses.on("click", function() {      
        pageReload = 'rombelanggota/index/' + filterRombel.val() + '/' + filterSemester.val();
        reload_page2(pageReload);
    });

    // add select2 value to hidden input when change
    $siswa.on("change", function(e) { 
        $siswaHidden.val( $siswa.val() );
    });

    // view detail murid on murid name click
    $siswaView.on("click", function(e) {
        var id = $(this).attr('data-siswa');
        var rombel = $(this).attr('data-rombel');
        var url = '{{ url("pesertadidik/editMurid/") }}' + id + '/' + rombel;
        var back_link = '{{ url("rombelanggota/index/") }}' + rombel;
        var data = 'back_link=' + back_link;
    
        go_page_data(url, data);
    });

    // add new murid on click
    $siswaAdd.on("click", function(e) {
        var url = '{{ url("pesertadidik/addMurid") }}';
        var back_link = '{{ url("rombelanggota/index/") }}' + '{{ rombel_id }}';
        var data = 'back_link='+back_link;

        go_page_data(url, data);
    });    

    // Intialize datatable
    dataTableConfig();

    // Intialize select2
    $('.select2').select2({
        placeholder: '-- Pilih Murid --',
        minimumInputLength: 3
    }); 

    $(".img-murid").on("error", function() {
        $(this).attr('src', 'img/user.png');
    });

}(document, window, jQuery));