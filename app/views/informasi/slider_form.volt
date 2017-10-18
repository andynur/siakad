<div class="col-md-4">
    <div class="box box-primary">
        <div class="box-header">
            <h3 class="box-title" id="form_title">Tambah Foto</h3>
        </div>
        <!-- /.box-header -->
        <div class="box-body pad">
            <div class="row">
                <form id="form_input" method="POST" action="{{ urlPost }}">
                    <div class="form-group col-md-12">
                        <label>Judul</label>
                        <input name="judul" type="text" placeholder="Judul Foto" class="form-control">
                    </div>                    
                    <div class="form-group col-md-8">
                        <label>Deskripsi</label>
                        <textarea name="deskripsi" rows="2" placeholder="Deskripsi Foto" class="form-control"></textarea>
                    </div>                      
                    <div class="form-group col-md-4">
                        <label>Aktif</label>
                        <select name="aktif" class="form-control">
                            <option value="Y">Ya</option>
                            <option value="N">Tidak</option>
                        </select>
                    </div>                     
                    <div class="form-group col-md-6">
                        <label>Foto Galeri</label>
                        <div style="width:100%; align-text:center;">
                            <img src="img/user.png" alt="foto galeri" class="img-preview" id="uploadPreview" />
                        </div>
                    </div>
                    <div class="form-group col-md-6 margin-upload">
                        <p class="help-block">File type:<br> <i>jpg, jpeg, gif, png</i></p>
                        <input type="file" name="foto" id="uploadImage">
                        <input type="hidden" name="foto_lama">
                    </div>

                    <div class="form-group col-md-12 line-top">
                        <div class="pull-right">
                            <button type="reset" class="btn btn-default" id="reset"><i class="fa fa-refresh"></i> Reset</button>
                            <button type="submit" class="btn btn-primary" id="submit"><i class="fa fa-send"></i> Simpan</button>
                        </div>                          
                    </div>
                </form>
            </div>
        </div>
        <!-- /.box-body -->
    </div>
    <!-- /.box -->
</div>