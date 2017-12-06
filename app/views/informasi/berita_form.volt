{# Define variables #} 
{% set tanggalIndo = helper.dateBahasaIndo(date('Y-m-d')) %} 
{% set urlPost = url('sysinformasi/addBerita/' . jenis) %} 
{# Global css #}
<style>{% include "include/view.css" %}</style>

<!-- Header content -->
<section class="content-header">
    <h1>
        <button type="button" onclick="back('{{url_back}}')" class="btn bg-navy btn-flat"><i class="fa fa-arrow-circle-left"></i> &nbsp; Kembali</button>
    </h1>
    <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i>Guru</a></li>
        <li class="active">Tambah</li>
    </ol>
</section>

<!-- Main content -->
<section class="content">
    <div class="row">
        <div class="col-md-offset-2 col-md-8">
            <div class="box box-primary">
                <div class="box-header">
                    <h3 class="box-title" id="form_title">Tambah Data</h3>
                </div>
                <!-- /.box-header -->
                <div class="box-body pad">
                    <form id="form_input" method="POST" action="{{ urlPost }}/{{ jenis }}">
                        <div class="form-group">
                            <input type="text" name="judul" class="form-control" placeholder="Judul">
                        </div>
                        <div class="form-group">
                            <label>Isi Berita Pengumuman</label>
                            <textarea id="editor"></textarea>
                        </div>
                        <div class="form-group">
                            <label>Aktif</label>
                            <select name="aktif" class="form-control">
                                <option value="Y">Ya</option>
                                <option value="N">Tidak</option>
                            </select>
                        </div>

                        <div class="form-group">
                            <div class="pull-right">
                                <button type="reset" class="btn btn-default" id="reset"><i class="fa fa-refresh"></i> Reset</button>
                                <button type="submit" class="btn btn-primary" id="submit"><i class="fa fa-send"></i> Simpan</button>
                            </div>
                        </div>
                    </form>
                </div>
                <!-- /.box-body -->
            </div>
            <!-- /.box -->
        </div>
    </div>
</section>
<!-- /.content -->

<script src="js/bootstrap-filestyle.min.js"></script>

<script type="text/javascript">
    $(function () {
        // filestyle config
        $(":file").filestyle({
            input: false,
            buttonText: "Upload",
            buttonName: "btn-danger",            
            iconName: "fa fa-cloud-upload"
        });
    });
</script>