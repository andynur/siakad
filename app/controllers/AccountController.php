<?php
use Phalcon\Mvc\Url;
use Phalcon\Mvc\View;
use Phalcon\Mvc\Controller;
use Phalcon\Security;
use Phalcon\Mvc\Router;
use Phalcon\Session\Adapter\Files as SessionAdapter;

    	
class AccountController extends \Phalcon\Mvc\Controller
{

    public function initialize()
    {        
        
    }

    public function indexAction()
    {

    }

    public function loginEndAction($value='')
    {
        if (!empty($this->session->get('uid'))) {
            return $this->response->redirect('index');
        }

        $this->view->setRenderLevel(View::LEVEL_ACTION_VIEW);
    }

    

    public function loginAction(){
        if (!empty($this->session->get('uid'))) {
            return $this->response->redirect('index');
        }
    	$this->view->pick("account/login");
        $this->view->setRenderLevel(View::LEVEL_ACTION_VIEW);
    }    

    public function loginProsesAction(){

        if ($this->request->isPost()) {

            $uid    = $this->request->getPost('uid');
            $passwd = $this->request->getPost('passwd');

            // Find the user in the database
            $user = RefUser::findFirst(
                [
                    "uid = :uid: AND passwd = :passwd: AND aktif = 'Y'",
                    "bind" => [
                        "uid"    => $uid,
                        "passwd" => md5($passwd),
                    ]
                ]
            );

            if ($user !== false) {

                //data_session_yang_dikirim
                $data_session = ViewUser::findFirst(
                    [
                        "nip = :uid: OR login = :uid:",
                        "bind" => [
                            "uid"    => $uid,
                        ]
                    ]
                );
                $session = new SessionAdapter();
                $session->start();
                $session->set('uid', $user->uid);
                $session->set('id_jenis', $data_session->id_jenis);
                $session->set('login', $data_session->login);
                $session->set('nip', $data_session->nip);
                $session->set('nama', $data_session->nama);
                $session->set('foto', $data_session->foto);
                $session->set('id_ps', $data_session->id_ps);
                $session->set('id_status', $data_session->id_status);
                $session->set('usergroup', $user->usergroup);
                $session->set('area', $user->area);
                
                return $this->response->redirect('index');

            }

            $this->flashSession->error("GAGAl MASUK");
            return $this->response->redirect('account/login');
            
        }

        $this->flashSession->error("GAGAl MASUK");
        return $this->response->redirect('account/login');

    }

    public function registerProsesAction(){
    	$user = new RefUser();
    	if ($this->request->isPost()) {
	        $uid    = $this->request->getPost('uid');
	        $passwd = $this->request->getPost('password');
	        $email 	= $this->request->getPost('email');
    		$user->assign(array(
		        'uid' => $uid,
		        'email' => $email,
		        'nama' => 'poh',
		        'aktif' => 'Y',
    			'passwd' => $this->security->hash($passwd)
    			)
    		);
    	}

        // Store the password hashed

        // if($user->save()){
        // 	echo "register successfull.";
        // }else{
        // 	echo "register failed.";
        // }
    }

    public function logoutAction(){
        session_destroy();
        $this->session->destroy();
        return $this->response->redirect('account/login');
    }

    public function loginProsesAgainAction(){

        if ($this->request->isPost()) {

            $uid    = $this->request->getPost('uid');
            $passwd = $this->request->getPost('passwd');

            // Find the user in the database
            $user = RefUser::findFirst(
                [
                    "uid = :uid: AND passwd = :passwd: AND aktif = 'Y'",
                    "bind" => [
                        "uid"    => $uid,
                        "passwd" => md5($passwd),
                    ]
                ]
            );

            if ($user !== false) {
                //data_session_yang_dikirim
               $data_session = ViewUser::findFirst(
                    [
                        "nip = :uid: OR login = :uid:",
                        "bind" => [
                            "uid"    => $uid,
                        ]
                    ]
                );
                $session = new SessionAdapter();
                $session->start();
                $session->set('uid', $user->uid);
                $session->set('id_jenis', $data_session->id_jenis);
                $session->set('login', $data_session->login);
                $session->set('nip', $data_session->nip);
                $session->set('nama', $data_session->nama);
                $session->set('foto', $data_session->foto);
                $session->set('id_ps', $data_session->id_ps);
                $session->set('id_status', $data_session->id_status);
                $session->set('usergroup', $user->usergroup);
                $session->set('area', $user->area);
                
                return $this->response->redirect('index');
            }

            $this->flashSession->error("GAGAl MASUK");
            return $this->response->redirect('account/login');
            
        }

        $this->flashSession->error("GAGAl MASUK");
        return $this->response->redirect('account/login');

    }


    // public function captchaAction(){
    //     $this->view->setRenderLevel(View::LEVEL_ACTION_VIEW);
    //     $gbr = $this->url->get("public/img/capcay_hitam.jpg"); //gambar untuk background
    //     //warna
    //     $merah = "255"; // range nya dari 0 - 255
    //     $ijo = "255"; //range nya = diatas
    //     $biru = "255";

    //     //--- mari menggambar ----
    //     $car = "puytrewmnbvcxasdfhjk23456789";
    //     $acak1 = '';
    //     for ($i=1;$i<=4;$i++){
    //         $acak1 .= $car{mt_rand(0,29)};
    //     }

    //     $hasil = $acak1;
    //     $bikingbr = imagecreatefromjpeg($gbr);
    //     $teks = imagecolorallocate($bikingbr, $merah, $ijo, $biru);
    //     imagestring($bikingbr, 20, 30, 10, $hasil, $teks);
    //     // $_SESSION['capcay'] = $hasil;
    //     $this->session->set("capcay", $hasil);
    //     header("Content-type: image/jpeg");
    //     imagejpeg($bikingbr);
    // }

    

    // public function loginProsesAction(){

    //     if ($this->request->isPost()) {

    //         $uid    = $this->request->getPost('uid');
    //         $passwd = $this->request->getPost('passwd');
    //         $ccek = $this->request->getPost('ccek');

    //         // Find the user in the database
    //         $user = RefUser::findFirst(
    //             [
    //                 "uid = :uid: AND passwd = :passwd: AND aktif = 'Y'",
    //                 "bind" => [
    //                     "uid"    => $uid,
    //                     "passwd" => md5($passwd),
    //                 ]
    //             ]
    //         );

    //         if ($user !== false) {

    //             //cek capca
    //             if ($this->session->get("capcay") == $ccek) {
    //                 //data_session_yang_dikirim
    //                 $data_session = ViewUser::findFirst(
    //                     [
    //                         "nip = :uid: OR login = :uid:",
    //                         "bind" => [
    //                             "uid"    => $uid,
    //                         ]
    //                     ]
    //                 );
    //                 $session = new SessionAdapter();
    //                 $session->start();
    //                 $session->set('uid', $user->uid);
    //                 $session->set('id_jenis', $data_session->id_jenis);
    //                 $session->set('login', $data_session->login);
    //                 $session->set('nip', $data_session->nip);
    //                 $session->set('nama', $data_session->nama);
    //                 $session->set('foto', $data_session->foto);
    //                 $session->set('id_ps', $data_session->id_ps);
    //                 $session->set('id_status', $data_session->id_status);
    //                 $session->set('usergroup', $user->usergroup);
                    
    //                 return $this->response->redirect('index');
    //             }else{
    //                 $this->flashSession->error("GAGAl MASUK");
    //                 return $this->response->redirect('account/login');
    //             }
    //         }

    //         $this->flashSession->error("GAGAl MASUK");
    //         return $this->response->redirect('account/login');
            
    //     }

    //     $this->flashSession->error("GAGAl MASUK");
    //     return $this->response->redirect('account/login');

    // }

}

