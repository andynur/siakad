(function (document, window, $) {

    // Set page title
    setPageTitle("Jenjang Pendidikan");

    // Define variables
    var pageUrl         = "{{ url('jenjangPendidikan') }}",
        pageReload      = "jenjangpendidikan/index";

    // Form elements object
    var $form           = $("#form_input"),   
        $title          = $("#form_title"),   
        $delete         = $(".delete"),
        $edit           = $(".edit"),
        $submit         = $("#submit"),
        $reset          = $("#reset");

    // Input elements object            
    var $jenjangNama    = $('input[name=nama]'),
        $jenjangLembaga = $('input[name=jenjang_lembaga]'),
        $jenjangOrang   = $('input[name=jenjang_orang]');

    // Save data when submit
    $form.on("submit", function(e) {
        var saveUrl = $(this).prop('action');            
        
        saveData(this, saveUrl, pageReload);
        e.preventDefault();            
    });

    // Set data from table to form when edit
    $edit.on("click", function() {
        var editId      = $(this).attr("data-id"),
            editUrl     = pageUrl + '/editJenjang/' + editId,
            row         = $('#data_' + editId),
            _no         = row.find('td').eq(0).html(),
            _nama       = row.find('td').eq(1).html(),
            _lembaga    = row.find('td').eq(2).html(),
            _orang      = row.find('td').eq(3).html();
        
        $jenjangNama.val(_nama).focus();
        $jenjangLembaga.val(_lembaga);
        $jenjangOrang.val(_orang);
        
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
            deleteUrl = pageUrl + '/deleteJenjang/' + deleteId;

        deleteData(deleteUrl, pageReload);
    });

    // Reset or cancel form
    $reset.on("click", function() {
        $form.attr('action', pageUrl + '/addJenjang');
        $title.text('Tambah Data');
        $reset
            .removeClass('btn-danger').addClass('btn-default')
            .html('<i class="fa fa-refresh"></i>&nbsp; Reset');
        $submit
            .removeClass('btn-success').addClass('btn-primary')
            .html('<i class="fa fa-send"></i>&nbsp; Simpan');
    });        

    // Intialize datatable
    dataTableConfig();

}(document, window, jQuery));