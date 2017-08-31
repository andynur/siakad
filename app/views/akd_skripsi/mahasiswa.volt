<section class="content-header">
    <h1><button type="button" onclick="back()" class="btn bg-navy btn-flat margin"><i class="fa fa-fw fa-arrow-left"></i> Back</button></h1>
    <ol class="breadcrumb">
        <li class="lead">{{sesi_nama}}</li>
    </ol>
</section>

<!-- Main content -->
<section class="content">

<div class="row">
    <div class="col-md-12">
        <div class="box">
            <div class="box-header">
              <h3 class="box-title">Mahasiswa Yang Mengambil Skripsi Baru TA <b class="text-green">{{sesi_nama}}</b></h3>
            </div><!-- /.box-header -->

            <div class="box-body">
            <form method="post">
                <input type="text" name="sesi" value="{{sesi}}" style="display: none;">
                <table class="table table-bordered" id="table" style="padding-right:0; margin-right:0;">
                    <thead>
                        <tr>
                            <td width="50">NO</td>
                            <td width="">Nomhs</td>
                            <td width="300">Nama</td>
                            <td width="">Dosen Pembimbing</td>
                            <td width="">Dosen Pembimbing2</td>
                            <td width="">Skripsi ke</td>
                            </td>
                        </tr>
                    </thead>
                    <tbody>
                        <?php $no = 1 ?>
                        <?php foreach ($mhs_skripsi as $key => $v): ?>
                        <?php $class = ($v['total_skripsi'] > 1) ? 'peringatan' : ''; ?>
                            
                        <tr class="<?= $class ?>">
                            <td><?= $no ?></td>
                            <td><?= $v['nomhs'] ?></td>
                            <td><?= $v['nama'] ?></td>
                            <td>
                                <select style="width:80%;" id="dosen<?= $no ?>" onchange="edit_dosen_pembimbing('<?= $v['id_dosen_bimbing'] ?>','<?= $no ?>','<?= $v['nomhs'] ?>','<?= $v['psmhs_id'] ?>')" class="form-control">
                                {% for val in dosen %}
                                    <?php if ($v['nip'] == $val->nip): ?>
                                        <option value="{{val.nip}}" selected>{{val.nama_dosen}}</option>
                                    <?php else: ?>
                                        <option value="{{val.nip}}" >{{val.nama_dosen}}</option>
                                    <?php endif ?>
                                {% endfor %}   
                                </select>
                            </td>
                            <td>
                                <select style="width:80%;" id="dosen2<?= $no ?>" onchange="edit_dosen_pembimbing2('<?= $v['id_dosen_bimbing'] ?>','<?= $no ?>','<?= $v['nomhs'] ?>','<?= $v['psmhs_id'] ?>')" class="form-control">
                                {% for val in dosen %}
                                    <?php if ($v['nip2'] == $val->nip): ?>
                                        <option value="{{val.nip}}" selected>{{val.nama_dosen}}</option>
                                    <?php else: ?>
                                        <option value="{{val.nip}}" >{{val.nama_dosen}}</option>
                                    <?php endif ?>
                                {% endfor %}   
                                </select>
                            </td>
                            <td><?= $v['total_skripsi'] ?></td>
                        </tr>
                        <?php $no++; endforeach ?>
                    </tbody>
                </table>
                </form>
            </div>
        </div>
    </div>
</div>

</section><!-- /.content -->

<style type="text/css">
    .peringatan{
        background-color: #FFDDDD;
    }
</style>
<script type="text/javascript">


function back() {
    var link = '{{ url("akdskripsi/selectSesi/") }}';
    go_page(link);
}

function edit_dosen_pembimbing(id='',no,nomhs,psmhs_id) {
    if (id == '') {

        var nip = $('#dosen'+no).val();
        var sesi = "{{sesi}}";
        var link = '{{ url("akdskripsi/addDosenBimbing/") }}';
        var datas = 'nip='+nip+'&sesi='+sesi+'&nomhs='+nomhs+'&psmhs_id='+psmhs_id+'&dosen=1';
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

    }else{
        var nip = $('#dosen'+no).val();
        var link = '{{ url("akdskripsi/updateDosenBimbing/") }}'+id;
        var datas = 'nip='+nip+'&dosen=1';
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

function edit_dosen_pembimbing2(id='',no,nomhs,psmhs_id) {
    if (id == '') {

        var nip = $('#dosen2'+no).val();
        var sesi = "{{sesi}}";
        var link = '{{ url("akdskripsi/addDosenBimbing/") }}';
        var datas = 'nip='+nip+'&sesi='+sesi+'&nomhs='+nomhs+'&psmhs_id='+psmhs_id+'&dosen=2';
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

    }else{
        var nip = $('#dosen2'+no).val();
        var link = '{{ url("akdskripsi/updateDosenBimbing/") }}'+id;
        var datas = 'nip='+nip+'&dosen=2';
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


</script>
