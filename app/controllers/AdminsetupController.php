<?php

use Phalcon\Mvc\View;
use Phalcon\Validation;
use  Phalcon\Validation\Validator\PresenceOf;
class AdminsetupController extends \Phalcon\Mvc\Controller
{
	public function initialize()
    {
        if (empty($this->session->get('uid'))) {
            $this->response->redirect('account/loginEnd');
        }
    }
    public function indexAction()
    {

    }

    public function deleteIdAction()
    {
    	$id = $_POST['id'];
    	$modul = $_POST['modul'];
    	$this->view->setRenderLevel(View::LEVEL_ACTION_VIEW);
    	$user = $modul::findFirst($id);
    	if ($user->delete()) {
    		$notif = array(
				'class' => 'success',
				'pesan1' => 'Data berhasil di hapus',
				'pesan2' => 'Success',
			);
    	}	
    	echo json_encode($notif);
		
    }


    //////////////////////////////
    /////////GROUP ACCESS//////////
    /////////////////////////////

    public function webGroupAction(){
    	$usergroup = RefUsergroup::find();
    	$this->view->usergroup = $usergroup;
    	$this->view->pick('admin/setup/web_group');
    	$this->view->setRenderLevel(View::LEVEL_ACTION_VIEW);
    }

    function editUsergroupAction($id)
    {
    	$this->view->setRenderLevel(View::LEVEL_ACTION_VIEW);

    	$validation = new Phalcon\Validation(); 
		$validation->add('nama', new PresenceOf(array(
		    'message' => 'Nama Area tidak boleh kosong'
		)));
		$validation->add('id_group', new PresenceOf(array(
		    'message' => 'ID Group tidak boleh kosong'
		)));

		$messages = $validation->validate($_POST);
		$pesan = '';
		//jika gagal falidasi
		if (count($messages)) {
		    foreach ($messages as $message) {
		        $pesan .= "$message"."</br>";
		    }
			$notif = array(
				'title' => 'warning',
				'text' => $pesan,
				'type' => 'warning',
			);
		}else{
			$RefUsergroup = RefUsergroup::findFirstById($id);
            $RefUsergroup->assign(array(
                        'id' => $_POST['id_group'],
                        'nama' => $_POST['nama'],
                        'deskripsi' => $_POST['deskripsi'],
                        'aktif' => $_POST['aktif']
                        )
                    );

            $RefUsergroup->save();
			$notif = array(
				'title' => 'success',
				'text' => 'Data berhasil di Edit',
				'type' => 'success',
			);
		}

		echo json_encode($notif);
		
    }

    function submitWebGroupAction($value='')
    {
    	$this->view->setRenderLevel(View::LEVEL_ACTION_VIEW);

    	$validation = new Phalcon\Validation(); 
		$validation->add('nama', new PresenceOf(array(
		    'message' => 'Nama tidak boleh kosong'
		)));
		$validation->add('id_group', new PresenceOf(array(
		    'message' => 'Id Group tidak boleh kosong'
		)));
		 
		$messages = $validation->validate($_POST);
		$pesan = '';
		if (count($messages)) {
		    foreach ($messages as $message) {
		        $pesan .= "$message"."</br>";
		    }
			$notif = array(
				'class' => 'warning',
				'pesan1' => $pesan,
				'pesan2' => 'Warning',
			);
		}else{
			$user_group = new RefUsergroup();
            $user_group->assign(array(
                        'id' => $_POST['id_group'],
                        'nama' => $_POST['nama'],
                        'deskripsi' => $_POST['deskripsi'],
                        'aktif' => $_POST['aktif']
                        )
                    );

            $user_group->save();
			$notif = array(
				'class' => 'success',
				'pesan1' => 'Data berhasil di input',
				'pesan2' => 'Success',
			);
		}

		echo json_encode($notif);
		
    }

    /////////////////////////////////
    /////////MENU AREA//////////
    /////////////////////////////

    public function webAreaAction($value='')
    {
        $usergroup = RefUsergroup::find()->toArray();
    	$phql = "SELECT * from RefArea ";
        $area = $this->modelsManager->executeQuery($phql);

        $phql2 = "SELECT id_ps,nama from RefAkdPs ";
        $ps = $this->modelsManager->executeQuery($phql2);

        $f = "SELECT id_fakultas,nama from RefSysFakultas ";
        $fak = $this->modelsManager->executeQuery($f);

        $this->view->usergroup = $usergroup;
        $this->view->area = $area;
        $this->view->ps = $ps;
        $this->view->fakultas = $fak;
    	$this->view->pick('admin/setup/menu_area');
    	$this->view->setRenderLevel(View::LEVEL_ACTION_VIEW);
    }

    public function deleteAreaAction($id)
    {
    	$this->view->setRenderLevel(View::LEVEL_ACTION_VIEW);
    	$user = RefArea::findFirst($id);
    	$user->delete();
    	echo json_encode(array("status" => true));
    }

    function editWebAreaAction($id)
    {
    	$this->view->setRenderLevel(View::LEVEL_ACTION_VIEW);

    	$validation = new Phalcon\Validation(); 
		$validation->add('nama_area', new PresenceOf(array(
		    'message' => 'Nama Area tidak boleh kosong'
		)));
		 
		$messages = $validation->validate($_POST);
		$pesan = '';
		//jika gagal falidasi
		if (count($messages)) {
		    foreach ($messages as $message) {
		        $pesan .= "$message"."</br>";
		    }
			$notif = array(
				'title' => 'warning',
				'text' => $pesan,
				'type' => 'warning',
			);
		}else{
			$acl = RefArea::findFirstById($id);
            $acl->assign(array(
                        'label_menu' => $_POST['nama_area'],
                        'aktif' => $_POST['aktif'],
                        'ps_id' => $_POST['ps_id'],
                        'usergroup_id' => ','.$_POST['usergroup'].',',
                        )
                    );

            $acl->save();
			$notif = array(
				'title' => 'success',
				'text' => 'Data berhasil di Edit',
				'type' => 'success',
			);
		}

		echo json_encode($notif);
		
    }


    function submitWebAreaAction($value='')
    {
    	$this->view->setRenderLevel(View::LEVEL_ACTION_VIEW);
    	// echo "<pre>".print_r($_POST,1)."</pre>";

    	$validation = new Phalcon\Validation(); 
		$validation->add('nama_area', new PresenceOf(array(
		    'message' => 'Nama Area tidak boleh kosong'
		)));
		 
		$messages = $validation->validate($_POST);
		$pesan = '';
		//jika gagal falidasi
		if (count($messages)) {
		    foreach ($messages as $message) {
		        $pesan .= "$message"."</br>";
		    }
			$notif = array(
				'title' => 'warning',
                'text' => $pesan,
                'type' => 'warning',
			);
		}else{
			$acl = new RefArea();
            $acl->assign(array(
                        'label_menu' => $_POST['nama_area'],
                        'ps_id' => $_POST['ps_id'],
                        'aktif' => $_POST['aktif'],
                        'usergroup_id' => ','.$_POST['usergroup'].',',
                        )
                    );

            $acl->save();
			$notif = array(
				'title' => 'success',
                'text' => 'Data berhasil di input',
                'type' => 'success',
			);
		}

		echo json_encode($notif);
    }

//////////////////////////////////////////////////////////////////////
////////////////////// /* HAK AKSES SDM */ ////////////////////////////
///////////////////////////////////////////////////////////////////////

    public function hakAksesSdmAction($value='')
    {
        $this->view->setRenderLevel(View::LEVEL_ACTION_VIEW);

        $area = RefArea::find()->toArray();
        foreach ($area as $key => $value) {
            $data_area[$value['id']] = $value['label_menu'];
        }

        $phql = "SELECT a.nip,a.nama,b.area from RefAkdSdm a left join RefUser b on a.nip=b.nip ";
        $sdm = $this->modelsManager->executeQuery($phql)->toArray();

        $this->view->sdm = $sdm;
        $this->view->data_area = $data_area;

        $this->view->pick('admin/setup/hak_akses_sdm');
    }

    public function listAreaAksesAction($value='')
    {
        $this->view->setRenderLevel(View::LEVEL_ACTION_VIEW);
        $list_area = RefArea::find()->toArray();

        $nip = $_POST['nip'];
        $phql = "SELECT area from RefUser where nip = '$nip' ";
        $area_nip = $this->modelsManager->executeQuery($phql)->toArray();

        $data_nip = explode(',', $area_nip[0]['area']) ;
        $data_area=[];
        foreach ($data_nip as $k => $v) {
            if ($v != '') {
                $data_area[] = $v;
            }
        }

        $this->view->list_area = $list_area;
        $this->view->data_area = $data_area;
        $this->view->nip = $_POST['nip'];
        $this->view->nama = $_POST['nama'];
        $this->view->pick('admin/setup/list_area_akses');
    }

    public function addSdmAreaAction($value='')
    {
        $this->view->setRenderLevel(View::LEVEL_ACTION_VIEW);
        $nip = $this->session->get('nip');

        foreach ($_POST as $key => $value) {
            $area_id = explode('_', $key);
            if ($area_id[0] == 'area') {
                $data_id_area[] = $area_id[1];
            }
        }
        $area = implode(',', $data_id_area);
        $area2 = ",$area,";
        $phql = "UPDATE RefUser SET area= '$area2' where nip = '$nip' ";
        $this->modelsManager->executeQuery($phql);
        echo json_encode(array('status' => true));
    }

}

