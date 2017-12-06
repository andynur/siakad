(function (document, window, $) {
    
        // Set page title
        setPageTitle("Galeri Slider");
    
        // Define variables
        var pageUrl         = "{{ url('sysinformasi') }}",
            pageReload      = "sysinformasi/slider";
    
        // Form elements object
        var $form           = $("#form_input"),   
            $title          = $("#form_title"),   
            $delete         = $(".delete"),
            $edit           = $(".edit"),
            $submit         = $("#submit"),
            $reset          = $("#reset"),
            $showImage      = $(".show_image img"),
            $imagePreview   = $("#uploadPreview");
    
        // Input elements object            
        var $judul          = $('input[name=judul]'),
            $deskripsi      = $('textarea[name=deskripsi]'),
            $foto           = $('input[name=foto]'),
            $fotoLama       = $('input[name=foto_lama]'),
            $aktif          = $('select[name=aktif]');
    
        // Image preview when upload button click
        $foto.on("change", function() {
            previewImage("uploadImage", "uploadPreview");
        });

        // ImageModal show when image click
        $showImage.on("click", function() {
            var $dataId = $('#' + $(this).closest('tr').attr('id'));
            var judul = $dataId.find('td').eq(2).html();     
            var deskripsi = $dataId.find('td').eq(3).html();            
            var imgSource = $(this).attr('src');
            var imgReal = imgSource.replace('thumb/', '');

            $('#imageModal').modal('show');            
            $('#imageModalLabel').html(judul);
            $('#imageModalSource').attr('src', imgReal);
            $('#imageModalDescription').html('"' + deskripsi + '"');
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
                editUrl     = pageUrl + '/editSlider/' + editId,
                row         = $('#data_' + editId),
                _no         = row.find('td').eq(0).html(),
                _foto       = row.find('td').eq(1).find('img').attr('src'),
                _judul      = row.find('td').eq(2).html(),
                _deskripsi  = row.find('td').eq(3).html(),
                _aktif      = row.find('td').eq(4).find('span').html();
    
            $judul.val(_judul).focus();
            $deskripsi.val(_deskripsi);
            $aktif.val(_aktif);
            $fotoLama.val(_foto.split('/')[3]);
            $imagePreview.attr('src', _foto);
            
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
                deleteUrl = pageUrl + '/deleteSlider/' + deleteId;
    
            deleteData(deleteUrl, pageReload);
        });
    
        // Reset or cancel form
        $reset.on("click", function() {
            $form.attr('action', pageUrl + '/addTingkat');
            $title.text('Tambah Data');
            $imagePreview.attr('src', 'img/user.png');
            $judul.focus();
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