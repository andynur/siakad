<section class="content-header">
  <h1>
    User Profil
    <small>it all starts here</small>
  </h1>
  <ol class="breadcrumb">
    <li><a href="#"><i class="fa fa-dashboard"></i> User</a></li>
    <li class="active">Profil</li>
  </ol>
</section>

<!-- Main content -->
<section class="content">
  <div class="row">
	<div class="col-md-4">
      <!-- Widget: user widget style 1 -->
      <div class="box box-widget widget-user" >
        <!-- Add the bg color to the header using any of the bg-* classes -->
        <div class="widget-user-header bg-aqua-active" style="padding: 15px;height: 200px;">
          <h3 class="widget-user-username"><?= $this->session->get('nama'); ?></h3>
          <h5 class="widget-user-desc"><?= $this->session->get('nip'); ?></h5>
        </div>
        <div class="widget-user-image asd">
          <?php if ($this->session->get('id_jenis') == 1): ?>
          <img class="profile-user-img img-responsive img-circle" src="<?= PUBLIC_URL ?>img/sdm/<?= $this->session->get('foto'); ?>" alt="User Avatar">
          <?php else: ?>
          <img class="profile-user-img img-responsive img-circle" src="<?= PUBLIC_URL ?>img/mhs/<?= $this->session->get('foto'); ?>" alt="User Avatar">
          <?php endif ?>
          <div class="middle">
			<div class="text"><a href="#" style="color:white;" data-toggle="modal" data-target="#myModal">GANTI</a></div>
		  </div>
        </div>
        <div id="myModal" class="modal fade" role="dialog">
		  <div class="modal-dialog">

		    <!-- Modal content-->
		    <div class="modal-content">
		      <div class="modal-header">
		        <button type="button" class="close" data-dismiss="modal">&times;</button>
		        <h4 class="modal-title">Upload Foto</h4>
		      </div>
		    <div class="modal-body">
		    <div class="row">
    		<div class="col-md-12">
	    		<div class="col-md-8">
		    		<div class="form-group has-warning">
               <label class="control-label" for="inputError"><i class="fa fa-times-circle-o"></i> Pilih File :</label>
                <input type="file" class="form-control" id="foto" placeholder="Enter ...">
              </div>
            </div>
	    		<div class="col-md-4" style="padding:14px 5px;">
	    		<button onclick="upload()" class="pull-left btn bg-navy btn-flat margin">Upload</button>
	    		</div>    			
    		</div>
    		</div>

		      </div>
		      <div class="modal-footer">
		        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
		      </div>
		    </div>

		  </div>
		</div>
        <div class="box-footer">
          <div class="row">
            <div class="col-sm-4 border-right">
              <div class="description-block">
                <h5 class="description-header">3,200</h5>
                <span class="description-text">SALES</span>
              </div><!-- /.description-block -->
            </div><!-- /.col -->
            <div class="col-sm-4 border-right">
              <div class="description-block">
                <h5 class="description-header">13,000</h5>
                <span class="description-text">FOLLOWERS</span>
              </div><!-- /.description-block -->
            </div><!-- /.col -->
            <div class="col-sm-4">
              <div class="description-block">
                <h5 class="description-header">35</h5>
                <span class="description-text">PRODUCTS</span>
              </div><!-- /.description-block -->
            </div><!-- /.col -->
          </div><!-- /.row -->
        </div>
      </div><!-- /.widget-user -->
    </div>

    <div class="col-md-8">
      <div class="nav-tabs-custom">
        <ul class="nav nav-tabs">
          <li class="active"><a href="#activity" data-toggle="tab">Activity</a></li>
          <li><a href="#timeline" data-toggle="tab">Timeline</a></li>
          <li><a href="#settings" data-toggle="tab">Settings</a></li>
        </ul>
        <div class="tab-content">
          <div class="active tab-pane" id="activity">
            <!-- Post -->
            <div class="post">
              <div class="user-block">
                <img class="img-circle img-bordered-sm" src="img/user1-128x128.jpg" alt="user image">
                <span class='username'>
                  <a href="#">Jonathan Burke Jr.</a>
                  <a href='#' class='pull-right btn-box-tool'><i class='fa fa-times'></i></a>
                </span>
                <span class='description'>Shared publicly - 7:30 PM today</span>
              </div><!-- /.user-block -->
              <p>
                Lorem ipsum represents a long-held tradition for designers,
                typographers and the like. Some people hate it and argue for
                its demise, but others ignore the hate as they create awesome
                tools to help create filler text for everyone from bacon lovers
                to Charlie Sheen fans.
              </p>
              <ul class="list-inline">
                <li><a href="#" class="link-black text-sm"><i class="fa fa-share margin-r-5"></i> Share</a></li>
                <li><a href="#" class="link-black text-sm"><i class="fa fa-thumbs-o-up margin-r-5"></i> Like</a></li>
                <li class="pull-right"><a href="#" class="link-black text-sm"><i class="fa fa-comments-o margin-r-5"></i> Comments (5)</a></li>
              </ul>

              <input class="form-control input-sm" type="text" placeholder="Type a comment">
            </div><!-- /.post -->

            <!-- Post -->
            <div class="post clearfix">
              <div class='user-block'>
                <img class='img-circle img-bordered-sm' src='img/user7-128x128.jpg' alt='user image'>
                <span class='username'>
                  <a href="#">Sarah Ross</a>
                  <a href='#' class='pull-right btn-box-tool'><i class='fa fa-times'></i></a>
                </span>
                <span class='description'>Sent you a message - 3 days ago</span>
              </div><!-- /.user-block -->
              <p>
                Lorem ipsum represents a long-held tradition for designers,
                typographers and the like. Some people hate it and argue for
                its demise, but others ignore the hate as they create awesome
                tools to help create filler text for everyone from bacon lovers
                to Charlie Sheen fans.
              </p>

              <form class='form-horizontal'>
                <div class='form-group margin-bottom-none'>
                  <div class='col-sm-9'>
                    <input class="form-control input-sm" placeholder="Response">
                  </div>                          
                  <div class='col-sm-3'>
                    <button class='btn btn-danger pull-right btn-block btn-sm'>Send</button>
                  </div>                          
                </div>                        
              </form>
            </div><!-- /.post -->

            <!-- Post -->
            <div class="post">
              <div class='user-block'>
                <img class='img-circle img-bordered-sm' src='img/user6-128x128.jpg' alt='user image'>
                <span class='username'>
                  <a href="#">Adam Jones</a>
                  <a href='#' class='pull-right btn-box-tool'><i class='fa fa-times'></i></a>
                </span>
                <span class='description'>Posted 5 photos - 5 days ago</span>
              </div><!-- /.user-block -->
              <div class='row margin-bottom'>
                <div class='col-sm-6'>
                  <img class='img-responsive' src='img/photo1.png' alt='Photo'>
                </div><!-- /.col -->
                <div class='col-sm-6'>
                  <div class='row'>
                    <div class='col-sm-6'>
                      <img class='img-responsive' src='img/photo2.png' alt='Photo'>
                      <br>
                      <img class='img-responsive' src='img/photo3.jpg' alt='Photo'>
                    </div><!-- /.col -->
                    <div class='col-sm-6'>
                      <img class='img-responsive' src='img/photo4.jpg' alt='Photo'>
                      <br>
                      <img class='img-responsive' src='img/photo1.png' alt='Photo'>
                    </div><!-- /.col -->
                  </div><!-- /.row -->
                </div><!-- /.col -->
              </div><!-- /.row -->

              <ul class="list-inline">
                <li><a href="#" class="link-black text-sm"><i class="fa fa-share margin-r-5"></i> Share</a></li>
                <li><a href="#" class="link-black text-sm"><i class="fa fa-thumbs-o-up margin-r-5"></i> Like</a></li>
                <li class="pull-right"><a href="#" class="link-black text-sm"><i class="fa fa-comments-o margin-r-5"></i> Comments (5)</a></li>
              </ul>

              <input class="form-control input-sm" type="text" placeholder="Type a comment">
            </div><!-- /.post -->
          </div><!-- /.tab-pane -->
          <div class="tab-pane" id="timeline">
            <!-- The timeline -->
            <ul class="timeline timeline-inverse">
              <!-- timeline time label -->
              <li class="time-label">
                <span class="bg-red">
                  10 Feb. 2014
                </span>
              </li>
              <!-- /.timeline-label -->
              <!-- timeline item -->
              <li>
                <i class="fa fa-envelope bg-blue"></i>
                <div class="timeline-item">
                  <span class="time"><i class="fa fa-clock-o"></i> 12:05</span>
                  <h3 class="timeline-header"><a href="#">Support Team</a> sent you an email</h3>
                  <div class="timeline-body">
                    Etsy doostang zoodles disqus groupon greplin oooj voxy zoodles,
                    weebly ning heekya handango imeem plugg dopplr jibjab, movity
                    jajah plickers sifteo edmodo ifttt zimbra. Babblely odeo kaboodle
                    quora plaxo ideeli hulu weebly balihoo...
                  </div>
                  <div class="timeline-footer">
                    <a class="btn btn-primary btn-xs">Read more</a>
                    <a class="btn btn-danger btn-xs">Delete</a>
                  </div>
                </div>
              </li>
              <!-- END timeline item -->
              <!-- timeline item -->
              <li>
                <i class="fa fa-user bg-aqua"></i>
                <div class="timeline-item">
                  <span class="time"><i class="fa fa-clock-o"></i> 5 mins ago</span>
                  <h3 class="timeline-header no-border"><a href="#">Sarah Young</a> accepted your friend request</h3>
                </div>
              </li>
              <!-- END timeline item -->
              <!-- timeline item -->
              <li>
                <i class="fa fa-comments bg-yellow"></i>
                <div class="timeline-item">
                  <span class="time"><i class="fa fa-clock-o"></i> 27 mins ago</span>
                  <h3 class="timeline-header"><a href="#">Jay White</a> commented on your post</h3>
                  <div class="timeline-body">
                    Take me to your leader!
                    Switzerland is small and neutral!
                    We are more like Germany, ambitious and misunderstood!
                  </div>
                  <div class="timeline-footer">
                    <a class="btn btn-warning btn-flat btn-xs">View comment</a>
                  </div>
                </div>
              </li>
              <!-- END timeline item -->
              <!-- timeline time label -->
              <li class="time-label">
                <span class="bg-green">
                  3 Jan. 2014
                </span>
              </li>
              <!-- /.timeline-label -->
              <!-- timeline item -->
              <li>
                <i class="fa fa-camera bg-purple"></i>
                <div class="timeline-item">
                  <span class="time"><i class="fa fa-clock-o"></i> 2 days ago</span>
                  <h3 class="timeline-header"><a href="#">Mina Lee</a> uploaded new photos</h3>
                  <div class="timeline-body">
                    <img src="http://placehold.it/150x100" alt="..." class="margin">
                    <img src="http://placehold.it/150x100" alt="..." class="margin">
                    <img src="http://placehold.it/150x100" alt="..." class="margin">
                    <img src="http://placehold.it/150x100" alt="..." class="margin">
                  </div>
                </div>
              </li>
              <!-- END timeline item -->
              <li>
                <i class="fa fa-clock-o bg-gray"></i>
              </li>
            </ul>
          </div><!-- /.tab-pane -->

          <div class="tab-pane" id="settings">
            <form class="form-horizontal">
              <div class="form-group">
                <label for="inputName" class="col-sm-2 control-label">Name</label>
                <div class="col-sm-10">
                  <input type="email" class="form-control" id="inputName" placeholder="Name">
                </div>
              </div>
              <div class="form-group">
                <label for="inputEmail" class="col-sm-2 control-label">Email</label>
                <div class="col-sm-10">
                  <input type="email" class="form-control" id="inputEmail" placeholder="Email">
                </div>
              </div>
              <div class="form-group">
                <label for="inputName" class="col-sm-2 control-label">Name</label>
                <div class="col-sm-10">
                  <input type="text" class="form-control" id="inputName" placeholder="Name">
                </div>
              </div>
              <div class="form-group">
                <label for="inputExperience" class="col-sm-2 control-label">Experience</label>
                <div class="col-sm-10">
                  <textarea class="form-control" id="inputExperience" placeholder="Experience"></textarea>
                </div>
              </div>
              <div class="form-group">
                <label for="inputSkills" class="col-sm-2 control-label">Skills</label>
                <div class="col-sm-10">
                  <input type="text" class="form-control" id="inputSkills" placeholder="Skills">
                </div>
              </div>
              <div class="form-group">
                <div class="col-sm-offset-2 col-sm-10">
                  <div class="checkbox">
                    <label>
                      <input type="checkbox"> I agree to the <a href="#">terms and conditions</a>
                    </label>
                  </div>
                </div>
              </div>
              <div class="form-group">
                <div class="col-sm-offset-2 col-sm-10">
                  <button type="submit" class="btn btn-danger">Submit</button>
                </div>
              </div>
            </form>
          </div><!-- /.tab-pane -->
        </div><!-- /.tab-content -->
      </div><!-- /.nav-tabs-custom -->
    </div><!-- /.col -->
  </div><!-- /.row -->
</section><!-- /.content -->

<script type="text/javascript">

function upload(){
	var urel = '{{ url("user/uploadFoto") }}';
    var file_data = $('#foto').prop('files')[0];   
    var form_data = new FormData();                  
    form_data.append('file', file_data);
    if (file_data == '' || file_data == null) {
		new PNotify({
		   title: 'Regular Notice',
		   text: 'File tidak boleh kosong.',
		   type:'warning'
		});
	}
    $.ajax({
            url: urel, // point to server-side PHP script 
            dataType: 'json',  // what to expect back from the PHP script, if anything
            cache: false,
            contentType: false,
            processData: false,
            data: form_data,                         
            type: 'post',
            success: function(data){
                $('#myModal').modal('hide');
        				$('body').removeClass('modal-open');
        				$("body").css("padding-right", "0px");
        				$('.modal-backdrop').remove();      
                reload_page2('user/profil');
                new PNotify({
                    title: data.title,
					text: data.text,
					type: data.type
                });
            }
     });
}

</script>

<style type="text/css">
.asd {
    position: relative;
}

.image {
  opacity: 1;
  display: block;
  width: 100%;
  height: auto;
  transition: .5s ease;
  backface-visibility: hidden;
}

.middle {
  transition: .5s ease;
  opacity: 0;
  position: absolute;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
  -ms-transform: translate(-50%, -50%)
}

.asd:hover .image {
  opacity: 0.3;
}

.asd:hover .middle {
  opacity: 1;
}

.text {
  background-color: #00a7d0;
      opacity: 0.8;
  color: white;
  font-size: 16px;
  padding: 16px 32px;
}
</style>