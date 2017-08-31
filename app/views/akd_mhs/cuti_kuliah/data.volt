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
                        <td width="100">Status</td>
                    </tr>
                </thead>
                <tbody>
                    <?php $i = 1 ?>
                    {% for m in mhs %}
                    <tr>
                        <td><?= $i++ ?></td>
                        <td>{{m.id_mhs}}</td>
                        <td><a href="javascript:void(0)" onclick="data_cuti('{{m.id_mhs}}','{{m.angkatan}}','{{m.nama}}')">{{m.nama}}</a></td>
                        <td>{{m.angkatan}}</td>
                        <td>{{m.nama_status}}</td>

                    </tr>
                    {% endfor %}
                </tbody>
            </table>

        </div>
    </div>
<script type="text/javascript">

function data_cuti(nomhs,angkatan,nama) {
    var link = '{{ url("akdmhscuti/dataCutiMhs/") }}';
    var datas = 'nomhs='+nomhs+'&angkatan='+angkatan+'&nama='+nama;
    go_page_data(link,datas);
}


</script>
