(function (document, window, $) {
    // -------------------------------------------------------------------------------
    // > VARIABLES
    // -------------------------------------------------------------------------------
    var pageUrl         = "{{ url('sdm') }}",
        wilayahUrl      = "{{ url('sdm/searchWilayah') }}",
        imgPath         = "{{ url('img/sdm/') }}",
        pageReload      = "sdm/formSdm";

    // Form elements object
    var $form           = $("#form_input"),   
        $back           = $("#back"),   
        $submit         = $("#submit"),
        $reset          = $("#reset"),
        $imagePreview   = $("#uploadPreview");

    // Input elements object            
    var $tanggal        = $('input[name=tanggal_lahir]'),
        $tglKirim       = $('input[name=tanggal_kirim]'),
        $foto           = $('input[name=foto]'),
        $provinsi       = $('select[name=provinsi]'),
        $kabupaten      = $('select[name=kabupaten]'),
        $kecamatan      = $('select[name=kecamatan]'),
        $kelurahan      = $('select[name=kelurahan]');

    // -------------------------------------------------------------------------------
    // > EVENTS
    // -------------------------------------------------------------------------------  
    // Image preview when upload
    $foto.on("change", function() {
        previewImage("uploadImage", "uploadPreview");
    });

    // Save data when submit
    $form.on("submit", function(e) {
        var saveUrl = $(this).prop('action');            
        
        saveData(this, saveUrl, pageReload);
        e.preventDefault();            
    });        

    // Reset form
    $reset.on("click", function() {
        $imagePreview.attr('src', 'img/user.png');
    });        

    // Back to previous page
    $back.on("click", function() {      
        var url,
            urlBack = '{{ url_back }}',
            urlDefault = 'sdm/index';

        (urlBack == '') ? url = urlDefault : url = urlBack;

        go_page(url);          
        setRefreshPage(urlDefault);
    });        

    // add kabupaten option when provinsi change
    $provinsi.on("change", function() {
        changeWilayah(this.value, 'kabupaten', wilayahUrl);
    });

    // add kecamatan option when kabupaten change
    $kabupaten.on("change", function() {
        changeWilayah(this.value, 'kecamatan', wilayahUrl);
    });

    // add kelurahan option when kecamatan change
    $kecamatan.on("change", function() {
        changeWilayah(this.value, 'kelurahan', wilayahUrl);
    });

    // add selected kelurahan to hidden input
    $kelurahan.on("change", function() {
        changeWilayah(this.value, '', wilayahUrl);
    });

    // -------------------------------------------------------------------------------
    // > OTHERS
    // -------------------------------------------------------------------------------  
    setPageTitle("SDM");

    // Initialize datatable
    dataTableConfig();

    // Initialize filestyle
    $foto.filestyle({
        input: false,
        buttonText: "Upload",
        buttonName: "btn-danger",
        iconName: "fa fa-cloud-upload"
    });

    // Initialize datepicker
    $tanggal.datepicker({
        language: 'id',
        format: 'dd-MM-yyyy',
        autoclose: true,
        startDate: `-80y`,
        endDate: '+1y',
        todayBtn: true,
        todayHighlight: true,
        title: "Pilih Tanggal"
    }).on('changeDate', function (ev) {
        var selectedDate = ev.format(0, "yyyy-mm-dd");
        $tglKirim.val(selectedDate);
    });

}(document, window, jQuery));