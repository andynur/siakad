<div class="modal fade" id="editModal{{ d.cuti_id }}" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog modal-md" role="document">
        <div class="modal-content">

            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">Edit Cuti Kuliah</h4>
            </div>

            <div class="modal-body">
                <div class="row">
                    <form method="post" id="edit_form{{ d.cuti_id }}" name="edit_form{{ d.cuti_id }}">
                        <div class="col-lg-12">
                            <div class="form-group">
                                <label>Keterangan <span style="color:red">*</span></label>
                                <input form="edit_form{{d.cuti_id}}" name="keterangan{{d.cuti_id}}" id="keterangan{{d.cuti_id}}" type="text" id="keterangan{{d.cuti_id}}" placeholder=" Keterangan" class="form-control" value="{{d.keterangan}}">
                            </div>
                        </div><!-- /.col-lg-12 -->

                        <div class="col-lg-12">
                            <div class="form-group">
                                <label>Tanggal Mulai <span style="color:red">*</span></label>
                                <input form="edit_form{{d.cuti_id}}" name="tgl_mulai{{d.cuti_id}}" id="tgl_mulai{{d.cuti_id}}" type="text" id="tgl_mulai{{d.cuti_id}}" placeholder=" Tanggal Mulai" class="form-control"  value="{{d.tgl_start}}">
                            </div>
                        </div><!-- /.col-lg-12 -->

                        <div class="col-lg-12">
                            <div class="form-group">
                                <label>Tanggal Selesai <span style="color:red">*</span></label>
                                <input form="edit_form{{d.cuti_id}}" name="tgl_selesai{{d.cuti_id}}" id="tgl_selesai{{d.cuti_id}}" type="text" id="tgl_selesai{{d.cuti_id}}" placeholder=" Tanggal Selesai" class="form-control"  value="{{d.tgl_stop}}">
                            </div>
                        </div><!-- /.col-lg-12 -->

                        <div class="col-lg-12">
                            <div class="form-group">
                                <label>Nomor Surat <span style="color:red">*</span></label>
                                <input form="edit_form{{d.cuti_id}}" name="no_surat{{d.cuti_id}}" id="no_surat{{d.cuti_id}}" type="text" id="no_surat{{d.cuti_id}}" placeholder=" Nomor Surat" class="form-control"  value="{{d.no_surat}}">
                            </div>
                        </div><!-- /.col-lg-12 -->

                        <div class="col-lg-12">
                            <div class="form-group">
                                <label>Tanggal Surat/Persetujuan <span style="color:red">*</span></label>
                                <input form="edit_form{{d.cuti_id}}" name="tgl_surat{{d.cuti_id}}" id="tgl_surat{{d.cuti_id}}" type="text" id="tgl_surat{{d.cuti_id}}" placeholder=" Tanggal Surat" class="form-control"  value="{{d.tgl_surat}}">
                            </div>
                        </div><!-- /.col-lg-12 -->
                    </form>
                </div><!-- /.row -->
            </div><!-- /.modal footer -->

            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                <button id="frm_data" type="button" class="btn btn-primary" onclick="edit_data({{ d.cuti_id }})">Save changes</button>
            </div>
        </div>
    </div>
</div>
