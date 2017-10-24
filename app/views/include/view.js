/**
* Digital clock with Indonesian format
*/
window.setTimeout("clockIndonesia()", 1000);

function clockIndonesia() {
    var tanggal = new Date();
    $('#waktu').html(
        tanggal.getHours() + ':' + 
        tanggal.getMinutes() + ':' + 
        tanggal.getSeconds()
    );
    setTimeout("clockIndonesia()", 1000);
}

/**
* Set page title
* @param {String} title
*/
function setPageTitle(title) {    
    var $pageTitle  = $('title');
    var mainTitle   = $pageTitle.html();
    
    if (mainTitle.indexOf('|') != -1) {        
        $pageTitle.html(title + ' | ' + mainTitle.split('|')[1]);
    } else{
        $pageTitle.html(title + ' | ' + mainTitle);        
    }    
}

/**
* Datatable config with custom length
* @param {Number} length
*/
function dataTableConfig(length = 5) {
    var displayLength = 5,
        lengthMenu = [
            [5, 10, 25, 50, -1],
            [5, 10, 25, 50, "Semua"]
        ];
        
    if (length == 10) {
        displayLength = 10;
        lengthMenu = [
            [10, 25, 50, 100, -1],
            [10, 25, 50, 100, "Semua"]
        ];
    }

    $('#data_table').DataTable({
        "paging": true,
        "lengthChange": true,
        "searching": true,
        "ordering": true,
        "info": true,
        "autoWidth": true,
        "lengthMenu": lengthMenu,
        "iDisplayLength": displayLength,
        "language": {
            "url": "js/Indonesian.json"
        }
    });
}

/**
* Save form data with AJAX
* @param {Mix} formData
* @param {String} url
* @param {String} reload
*/
function saveData(formData, url, reload) {
    var request;

    if (typeof formData === 'object') {
        request = $.ajax({
            type: 'POST',
            url: url,
            dataType: 'json',
            data: new FormData(formData),
            contentType: false,
            cache: false,
            processData: false
        });            
    } else {
        request = $.ajax({
            type: 'POST',
            url: url,
            dataType: 'json',
            data: formData
        }); 
    }

    request.done(function(response){            
        new PNotify({
            title: response.title,
            text: response.text,
            type: response.type
        });

        reload_page2(reload);                            
    });    
}

/**
* Delete form data with AJAX when confirm
* @param {String} url
* @param {String} reload
*/
function deleteData(url, reload) {
    var notify = new PNotify({
        title: 'Pesan Konfirmasi',
        text: 'Apakah Anda Yakin menghapus data ini?',
        icon: 'glyphicon glyphicon-question-sign',
        hide: false,
        confirm: {
            confirm: true
        },
        buttons: {
            closer: false,
            sticker: false
        },
        history: {
            history: false
        }
    }).get();
    
    notify.on('pnotify.confirm', function () {
        var request = $.ajax({type: "POST", dataType: "JSON", url: url});
        
        request.done(function() {
            new PNotify({
                title: 'Sukses',
                text: 'Data berhasil dihapus',
                type: 'success'
            });

            reload_page2(reload);
        });
    });
}

/**
* Selected select2 value
* @param {Object} element
* @param {String} id
* @param {String} text
*/
function selectedSelect2(element, id, text) {
    var newOption = '<option value="' + id + '"' + ' selected="selected">' 
                    + text + '</option>';    

    element.val('').trigger('change').append(newOption).trigger('change');
}

/**
* Selected selectbox by text
* @param {Object} element
* @param {String} text
*/
function selectedByText(element, text) {
    element.val( element.find('option:contains("'+text+'")').attr('value') );
}

/**
* Checked radio button
* @param {String} radioValue
* @param {String} value
* @param {Object} elementOne
* @param {Object} elementTwo
*/
function checkedRadio(radioValue, value, elementOne, elementTwo) {
    if (radioValue == value) {    
        elementOne.prop('checked', true);
    } else {
        elementTwo.prop('checked', true);    
    }
}

/**
* Preview Image when upload
* @param {String} fileInput
* @param {String} previewImg
*/
function previewImage(fileInput, previewImg) {
    var oFReader = new FileReader();
    oFReader.readAsDataURL(document.getElementById(fileInput).files[0]);

    oFReader.onload = function (oFREvent) {
        document.getElementById(previewImg).src = oFREvent.target.result;
    };
}

/**
* Convert date to Indonesian format
* @param {String} date
* @return {String}
*/
function tanggalIndonesia(date){
    var bulanList = [
        "Januari", 
        "Februari",
        "Maret",
        "April",
        "Mei",
        "Juni",
        "Juli",
        "Agustus",
        "September",
        "Oktober",
        "November",
        "Desember"
    ];

    var tanggal = new Date(date),
        _hari   = tanggal.getDate(),
        _bulan  = tanggal.getMonth(),
        _tahun  = tanggal.getYear(),
        bulan   = bulanList[_bulan],
        tahun   = (_tahun < 1000) ? _tahun + 1900 : _tahun;
    
    return _hari + '-' + bulan + '-' + tahun;
}

/**
* Set refresh page in float button
* @param {String} page
*/
function setRefreshPage(page) {
    $('.float-button').attr('onclick', 'return reload_page2(\''+page+'\')');
}

/**
* Change indonesian location option
* @param {String} kode
* @param {String} level
* @param {String} url
*/
function changeWilayah(kode, level, url) {        
    if (level !== '') {        
        $.ajax({
            url       : url + '/' + kode,
            type      : "POST",
            dataType  : "json",
            data      : {'name' : 'value'},
            cache     : false,
            success   : function(data){
                var i,
                    makeOption = "",
                    dataLength = data.length;

                for (i = 0; i < dataLength; i++) {
                    makeOption += '<option value='+data[i]["kode_wilayah"]+'>'
                                +data[i]["nama"]+'</option>';
                }

                $("select[name="+level+"]")
                    .find('option')
                    .remove()
                    .end()
                    .append('<option value="">-- Pilih '+level+': --</option>' + makeOption);
            }
        });
    } else {
        var getText = $("select[name=kelurahan]").find("option:selected").text();
        $('input[name=desa_kelurahan]').val(getText);
    }

    $('input[name=kode_wilayah]').val(kode);
}