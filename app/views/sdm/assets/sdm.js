(function (document, window, $) {
    
    // Set page title
    setPageTitle("SDM");

    // Define variables
    var pageUrl         = "{{ url('sdm') }}",
        pageReload      = "sdm/index";

    // Form elements object
    var $form           = $("#form_input"),   
        $title          = $("#form_title"),   
        $delete         = $(".delete"),
        $edit           = $(".edit"),
        $submit         = $("#submit"),
        $reset          = $("#reset"),
        $foto           = $(".img-murid");

            
    // replace image when error
    $foto.on("error", function() {
        $(this).attr('src', 'img/user.png');
    });

    // ImageModal show when image click
    $foto.on("click", function() {
        var judul = $(this).attr('alt'),
            imgSource = $(this).attr('src');

        $('.modal-dialog').addClass('modal-sm');
        $('#imageModal').modal('show');            
        $('#imageModalLabel').html(judul);
        $('#imageModalSource').attr('src', imgSource)
    });

        
    // redirect to edit form
    $edit.on("click", function() {
        var editId = $(this).attr("data-id"),
            editUrl = pageUrl + '/formEditSdm/' + editId,
            data = 'url_back='+pageUrl;

        go_page_data(editUrl, data); 
    });

    // Delete data when confirmed
    $delete.on("click", function() {
        var deleteId = $(this).attr("data-id"),
            deleteUrl = pageUrl + '/deleteSdm/' + deleteId;

        deleteData(deleteUrl, pageReload);
    });

    // Intialize datatable
    dataTableConfig();

}(document, window, jQuery));