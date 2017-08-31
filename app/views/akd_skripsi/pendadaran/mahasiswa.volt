    <div class="box">
        <div class="box-header">
          <h3 class="box-title">Pilih Mahasiswa</h3>
        </div><!-- /.box-header -->
        <div class="box-body">

            <table class="table table-bordered table striped table-hover" id="table" style="padding-right:0; margin-right:0;">
                <thead>
                    <tr>
                        <td width="50">NO</td>
                        <td width="200">No Mahasiswa</td>
                        <td width="">Nama</td>
                        <td width="100">Angkatan</td>
                        <td width="100">Jurusan</td>
                    </tr>
                </thead>
                <tbody>
                    <?php $i = 1 ?>
                    {% for m in mhs %}
                    <tr>
                        <td><?= $i++ ?></td>
                        <td>{{m.id_mhs}}</td>
                        <td><a href="javascript:void(0)" onclick="data_skripsi('{{m.id_mhs}}','{{m.angkatan}}','{{m.nama}}','{{m.id_ps}}')">{{m.nama}}</a></td>
                        <td>{{m.angkatan}}</td>
                        <td>{{m.ext}}</td>
                    </tr>
                    {% endfor %}
                </tbody>
            </table>

        </div>
    </div>
<script type="text/javascript">

function data_skripsi(nomhs,angkatan,nama,psmhs_id) {
    var link = '{{ url("akdpendadaran/dataSkripsi/") }}';
    var datas = 'nomhs='+nomhs+'&angkatan='+angkatan+'&nama='+nama+'&psmhs_id='+psmhs_id;
    go_page_data(link,datas);
}


</script>
