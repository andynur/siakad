(function (document, window, $) {

    // Set page title
    setPageTitle("Pengumuman");

    // Define variables
    var pageUrl         = "{{ url('pengumuman') }}",
        imgPath         = "{{ url('img/pengumuman/') }}",
        pageReload      = "pengumuman/index";

    // Form elements object
    var $form           = $("#form_input"),   
        $title          = $("#form_title"),   
        $delete         = $(".delete"),
        $edit           = $(".edit"),
        $submit         = $("#submit"),
        $reset          = $("#reset"),
        $showImage      = $(".show_image"),
        $imagePreview   = $("#uploadPreview");

    // Input elements object            
    var $judul          = $('input[name=judul]'),
        $tanggal        = $('input[name=tanggal]'),
        $tglKirim       = $('input[name=tgl_kirim]'),
        $isi            = $('textarea[name=isi]'),
        $foto           = $('input[name=foto]'),
        $fotoLama       = $('input[name=foto_lama]'),
        $tujuan         = $('select[name=tujuan]'),
        $tujuanHidden   = $('input[name=tujuan_hidden]'),
        $draft          = $('input[name=status][value=draft]'),
        $publish        = $('input[name=status][value=publish]');

    // Image preview when upload button click
    $foto.on("change", function() {
        previewImage("uploadImage", "uploadPreview");
    });

    // ImageModal show when image click
    $showImage.on("click", function() {
        var $dataId = $('#' + $(this).closest('tr').attr('id'));
        var judul = $dataId.find('td').eq(1).html();     
        var imgSource = $(this).attr('data-image');

        $('#imageModal').modal('show');            
        $('#imageModalLabel').html(judul);
        $('#imageModalSource').attr('src', imgPath + imgSource);
    });

    // Add select2 value to hidden input when change
    $tujuan.on("change", function(e) { 
        $tujuanHidden.val(',' + $tujuan.val() + ',');
    });    

    // Save data when submit
    $form.on("submit", function(e) {
        var saveUrl = $(this).prop('action');            
        
        saveData(this, saveUrl, pageReload);
        e.preventDefault();            
    });
        
    // Set data from table to form when edit
    $edit.on("click", function() {
        var editId      = $(this).attr("data-id"),
            editUrl     = pageUrl + '/editPengumuman/' + editId,
            getUrl      = pageUrl + '/getPengumuman/' + editId,
            dataSend    = "id="+editId,
            _no         = $('#data_' + editId).find('td').eq(0).html();

        var getData = $.ajax({
            type: 'POST',
            url: getUrl,
            dataType: 'json',
            data: dataSend
        });
    
        getData.done(function(res) {            
            $judul.val(res.judul).focus();
            $isi.val(res.isi);            
            $tanggal.val( tanggalIndonesia(res.tanggal) );
            $tglKirim.val(res.tanggal);
            checkedRadio(res.status, 'draft', $draft, $publish);
            multipleSelect2($tujuan, res.tujuan);
            $fotoLama.val(res.lampiran);
            
            if (res.lampiran != '') {
                $imagePreview.attr('src', imgPath + res.lampiran);
            } else {
                $imagePreview.attr('src', 'img/user.png');
            }
        });            
    
        // smooth scroll
        $('html,body').animate({scrollTop: $("#scroll_target").offset().top}, 'slow');        

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
            deleteUrl = pageUrl + '/deletePengumuman/' + deleteId;

        deleteData(deleteUrl, pageReload);
    });

    // Reset or cancel form
    $reset.on("click", function() {
        $form.attr('action', pageUrl + '/addPengumuman');
        $title.text('Tambah Data');
        $imagePreview.attr('src', 'img/user.png');
        $tujuan.val(null).trigger("change");
        $tujuanHidden.val('');
        $fotoLama.val('');
        $reset
            .removeClass('btn-danger').addClass('btn-default')
            .html('<i class="fa fa-refresh"></i>&nbsp; Reset');
        $submit
            .removeClass('btn-success').addClass('btn-primary')
            .html('<i class="fa fa-send"></i>&nbsp; Simpan');
    });        

    // Initialize datatable
    dataTableConfig();

    // Initialize select2
    $('.select2').select2({
        placeholder: '-- Pilih Kelas --'
    }); 

    // Initialize filestyle
    $(":file").filestyle({
        input: false,
        buttonText: "Upload Lampiran",
        buttonName: "btn-danger",            
        iconName: "fa fa-cloud-upload"
    });    

    // Initialize datepicker
    $tanggal.datepicker({
        language: 'id',
        format: 'dd-MM-yyyy',
        autoclose: true,
        startDate: `-1y`,
        endDate: '+1y',
        todayBtn: true,
        todayHighlight: true,
        title: "Pilih Tanggal"
    }).on('changeDate', function (ev) {
        var selectedDate = ev.format(0, "yyyy-mm-dd");
        $tglKirim.val(selectedDate);
    });

}(document, window, jQuery));