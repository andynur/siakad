<section class="content-header">
    <h1><button type="button" onclick="back()" class="btn bg-navy btn-flat margin"><i class="fa fa-fw fa-arrow-left"></i> Back</button></h1>
    <ol class="breadcrumb">
        <li class="lead">{{sesi_nama}}</li>
    </ol>
</section>

<!-- Main content -->
<section class="content">

<div class="row">
    <div class="col-md-12 data_mhs">
        <div class="box">
            <div class="box-header">
              <h3 class="box-title">Mahasiswa Angkatan <span class="text-green">{{angkatan}}</span></h3>
            </div><!-- /.box-header -->


            <div class="box-body">
            <form method="post">
            <input type="text" name="sesi" value="{{sesi}}" style="display: none;">
            <input type="text" name="nama_byr" value="{{nama_byr}}" style="display: none;">
                <table class="table table-bordered table striped table-hover" id="table" style="padding-right:0; margin-right:0;">
                    <thead>
                        <tr>
                            <td width="50">NO</td>
                            <td width="">No Mahasiswa</td>
                            <td width="300">Nama</td>
                            <td width="">Angkatan</td>
                            <td width="">Status</td>
                            <td width="">
<button type="button" onclick="cek_all()" class="checkAll btn btn-info btn-flat margin btn-xs"><i class="fa fa-fw fa-check-square-o"></i> Semua</button>
<button type="button" onclick="uncek_all()" style="display: none;" class="uncheckAll btn btn-info btn-flat margin btn-xs"><i class="fa fa-fw fa-check-square-o"></i> Semua</button>
                            </td>
                        </tr>
                    </thead>
                    <tbody>
                        <?php $i = 1 ?>
                        <?php foreach ($mhs as $key => $v): ?>
                        <tr>
                            <td><?= $i++ ?></td>
                            <td><?= $v['id_mhs'] ?></td>
                            <td><?= $v['nama'] ?></td>
                            <td><?= $v['angkatan'] ?></td>
                            <td><?= $v['nama_status'] ?></td>
                            <td>
                                <input name="mhs[<?= $v['id_mhs'] ?>]" type="checkbox" style="float: left; margin-top: 10px;">
                            </td>

                        </tr>
                        <?php endforeach ?>
                    </tbody>
                </table>
                </form>
            <button type="button" onclick="update_mhs()" class="btn bg-navy btn-flat pull-right"><i class="fa fa-fw fa-pencil"></i> Submit</button>
            </div>
        </div>
    </div>
</div>

</section><!-- /.content -->


<script type="text/javascript">


function update_mhs(){
    var mhs =[];
    $('input[type=checkbox]:checked').each(function(index){
      mhs.push($(this).val());
    });

    if (mhs.length == 0) {
        new PNotify({
            title: 'Regular Notice',
            text: 'Pilih Ruang yang akan di Aktifkan',
            type:'warning'
        });
    }else{
        var link = '{{ url("akdmhsregistrasi/submitMhsNa/") }}';
        var datas = $("form").serialize();
        // go_page_data(link,datas);

        $.ajax({
           type: "POST",
           url: link,
           dataType : "json",
           data: datas
        }).done(function( data ) {
            new PNotify({
               title: data.title,
               text: data.text,
               type: data.type
            });
        });
    }

    
}

function back() {
    var link = '{{ url("akdmhsregistrasi/find/") }}';
    go_page(link);
}

function cek_all() {
    $('input:checkbox').prop('checked', true);
    $(".checkAll").css("display", "none");
    $(".uncheckAll").css("display", "inline");
}

function uncek_all() {
    $('input:checkbox').removeAttr('checked');
    $(".uncheckAll").css("display", "none");
    $(".checkAll").css("display", "inline");
}
</script>
