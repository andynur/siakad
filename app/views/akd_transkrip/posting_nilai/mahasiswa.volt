<table id="" class="table table-bordered table-striped">
  <thead>
    <tr>
      <th style="width: 10px">No</th>
      <th>Angkatan</th>
      <th>Nomhs</th>
      <th>Nama Mhs</th>
    </tr>
  </thead>
  <tbody>

    {% set no=1 %}
    {% for v in mhs %}
    <tr>
     <td>{{no}}</td>
     <td>{{v.angkatan}}</td>
     <td>{{v.id_mhs}}</td>
     <td><a href="javascript:void(0)" onclick="posting_nilai('{{v.id_ps}}','{{v.id_mhs}}','{{v.nama}}','{{v.angkatan}}','{{v.id_kur}}')"> {{v.nama}} </a></td>
   </tr>
   {% set no=no+1 %}
   {% endfor %}

 </tbody>            
</table>

<script type="text/javascript">

  function posting_nilai(psmhs_id,nomhs,nama,angkatan,kur_mhs) {
    var link = '{{ url("akdpostingnilai/postingNilai/") }}';
    var datas = 'psmhs_id='+psmhs_id+'&nomhs='+nomhs+'&nama='+nama+'&angkatan='+angkatan+'&kur_mhs='+kur_mhs;
    go_page_data(link,datas);
  }


</script>