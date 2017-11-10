<div class="col-md-offset-2 col-md-8" id="scroll_target">
    <div class="box">
        <div class="box-header">
            <h3 class="box-title" id="form_title">Tambah Data</h3>
        </div>
        <!-- /.box-header -->
        <div class="box-body pad">
            <form id="form_input" method="POST" action="{{ urlPost }}">
                <div class="row">
                    <div class="col-md-8 form-group">
                        <label>Judul</label>
                        <input type="text" class="form-control" name="judul" placeholder="Judul">
                    </div>
                    <div class="col-md-4 form-group">
                        <label>Tanggal Kirim</label>
                        <input type="text" class="form-control" name="tanggal" value="{{ tanggalIndo }}">
                        <input type="hidden" class="form-control" name="tgl_kirim" value="{{ date('Y-m-d') }}">
                    </div>     
                    <div class="col-md-8 form-group">
                        <label>Isi Pengumuman</label>
                        <textarea rows="12" class="form-control" name="isi" placeholder="Isi Pengumuman"></textarea>
                    </div>                                   
                    <div class="col-md-4 form-group">
                        <label>Lampiran (<i>jpg, jpeg, gif, png</i>)</label>
                        <img src="img/user.png" alt="foto galeri" class="img-preview" id="uploadPreview" />

                        <input type="file" name="foto" id="uploadImage" accept="image/*">
                        <input type="hidden" name="foto_lama">
                    </div> 
                    <div class="col-md-8 form-group">
                        <label>Tujuan</label>
                        <select class="form-control select2" multiple="multiple" name="tujuan" style="width: 100%">
                            {% for opt in rombel %}
                            <option value="{{ opt.id }}">{{ opt.tingkat }} - {{ opt.nama }}</option>
                            {% endfor %}
                        </select>
                        <input type="hidden" name="tujuan_hidden">                        
                    </div>
                    <div class="col-md-4 form-group">
                        <label>Status</label>
                        <div>
                            <label class="radio-inline">
                                <input type="radio" name="status" value="draft"> Draft
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="status" value="publish" checked="checked"> Publish
                            </label>
                        </div>
                    </div>    
                </div>                    

                <div class="pull-right">
                    <button type="reset" class="btn btn-default" id="reset"><i class="fa fa-refresh"></i> Reset</button>
                    <button type="submit" class="btn btn-primary" id="submit"><i class="fa fa-send"></i> Simpan</button>
                </div>
            </form>
        </div>
        <!-- /.box-body -->
    </div>
    <!-- /.box -->
</div>      