(function (document, window, $) {
    
    // Set page title
    setPageTitle("Berita Pengumuman");

    // Define variables
    var pageUrl         = "{{ url('sysinformasi') }}",
        jenisBerita     = "pengumuman",
        pageReload      = "sysinformasi/berita/" + jenisBerita;

    // Form elements object
    var $form           = $("#form_input"),   
        $title          = $("#form_title"),   
        $delete         = $(".delete"),
        $edit           = $(".edit"),
        $submit         = $("#submit"),
        $reset          = $("#reset");

    // Initialize CKEDITOR
    CKEDITOR.config.height = 300;
    CKEDITOR.replace('editor');

    // Input elements object            
    var $berita         = CKEDITOR.instances['editor'],
        $aktif          = $('select[name=aktif]'),
        $judul          = $('input[name=judul]'),
        $foto           = $('input[name=foto]'),
        $fotoLama       = $('input[name=foto_lama]'),
        $aktif          = $('select[name=aktif]');        
    
    // Save data when submit
    $form.on("submit", function(e) {
        var saveUrl     = $(this).prop('action'),   
            _berita     = $berita.getData(),
            _aktif      = $aktif.val(),
            storeData   = "berita="+_berita+"&aktif="+_aktif;        
            
        saveData(storeData, saveUrl, pageReload);
        e.preventDefault();            
    });

    // Set data from table to form when edit
    $edit.on("click", function() {
        var editId      = $(this).attr("data-id"),
            editUrl     = pageUrl + '/editBerita/' + editId + '/' + jenisBerita,
            row         = $('#data_' + editId),
            _no         = row.find('td').eq(0).html(),
            _berita     = row.find('td').eq(1).html(),
            _aktif      = row.find('td').eq(2).find('span').html();

        $berita.setData(_berita);
        $aktif.val(_aktif);
        
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
        var deleteId  = $(this).attr("data-id"),
            deleteUrl = pageUrl + '/deleteBerita/' + deleteId;

        deleteData(deleteUrl, pageReload);
    });

    // Reset or cancel form
    $reset.on("click", function() {
        $form.attr('action', pageUrl + '/addBerita/' + jenisBerita);
        $title.text('Tambah Data');
        $berita.setData('');
        $reset
            .removeClass('btn-danger').addClass('btn-default')
            .html('<i class="fa fa-refresh"></i>&nbsp; Reset');
        $submit
            .removeClass('btn-success').addClass('btn-primary')
            .html('<i class="fa fa-send"></i>&nbsp; Simpan');
    });        

    // Intialize datatable
    dataTableConfig();

    // Initialize bootstrap filestyle
    $foto.filestyle({
        input: false,
        buttonText: "Upload",
        buttonName: "btn-danger",            
        iconName: "fa fa-cloud-upload"
    });  

}(document, window, jQuery));