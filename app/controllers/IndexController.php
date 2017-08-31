<?php
use Phalcon\Mvc\View;
use Phalcon\Mvc\Controller;
use Phalcon\Session\Adapter\Files as SessionAdapter;


class IndexController extends ControllerBase
{

    public function initialize()
    {   
        // if (empty($this->session->get('uid'))) {
        //     $this->response->redirect('account/loginEnd');
        // }
    }
    
    public function sessionLoginJenisAction($value='')
    {
        $this->view->setRenderLevel(View::LEVEL_ACTION_VIEW);
        if (empty($this->session->get('id_jenis'))) {
            $data['session'] = 'false';
            $data['id_jenis'] = $this->session->get('id_jenis');
            echo json_encode($data);
        }else{
            $data['session'] = 'true';
            $data['id_jenis'] = $this->session->get('id_jenis');
            echo json_encode($data);
        }
    }

    public function psAreaAction($value='')
    {
        $this->view->setRenderLevel(View::LEVEL_ACTION_VIEW);
        if (empty($this->session->get('id_jenis'))) {
            $data['session'] = 'false';
            $data['id_jenis'] = $this->session->get('id_jenis');
            echo json_encode($data);
        }else{
            $data['session'] = 'true';
            $data['id_jenis'] = $this->session->get('id_jenis');
            echo json_encode($data);
        }
    }

    public function cekSessionAction($value='')
    {
        $this->view->setRenderLevel(View::LEVEL_ACTION_VIEW);
        if (empty($this->session->get('uid'))) {
            $data['session'] = 'false';
            $data['uid'] = $this->session->get('uid');
            echo json_encode($data);
        }else{
            $data['session'] = 'true';
            $data['uid'] = $this->session->get('uid');
            echo json_encode($data);
        }
    }

    public function indexAction()
    {

        if (empty($this->session->get('uid'))) {
            $this->response->redirect('account/login');
        }else{
            $this->view->menu=$this->menuAction(1);
        }
        
        // $this->view->setRenderLevel(View::LEVEL_ACTION_VIEW);
    }


    public function index2Action()
    {

        if (empty($this->session->get('uid'))) {
            $this->response->redirect('account/loginEnd');
        }else{
            $this->view->menu=$this->menuAction(1);
        }
        
        $this->view->setRenderLevel(View::LEVEL_ACTION_VIEW);
    }

    public function menuAreaAction()
    {
        if (empty($this->session->get('uid'))) {
            echo "session";
        }else{            
            // $usergroup = $this->session->get('usergroup');
            // $uid = $this->session->get('id');
            // if (!empty($usergroup)) {
            //     $ug_arr=explode(",",$usergroup);
            //     foreach ($ug_arr as $k => $v) {
            //         if ($v!='') {
            //             $ug_sql[]="usergroup_id like '%,$v,%'";
            //         }
            //     }
            // }
            // $ug_sql_string=implode(" or ",$ug_sql);

            $area = $this->session->get('area');
            if (!empty($area)) {
                $ar_arr=explode(",",$area);
                foreach ($ar_arr as $k => $v) {
                    if ($v!='') {
                        $area_sql[]="id = '$v' ";
                    }
                }
            }
            $area_sql_string=implode(" or ",$area_sql);

            $phql = "SELECT * from RefArea where aktif = 'Y' and $area_sql_string ";
            // echo "<pre>".print_r($phql,1)."</pre>";die();
            $menu = $this->modelsManager->executeQuery($phql)->toArray();
            $this->view->menuArea = $menu;
            $this->view->pick('index/menuArea');
        }

        $this->view->setRenderLevel(View::LEVEL_ACTION_VIEW);
    }

////////////////////////////////////////////////
/////////////MENU MAHASISWA REK//////////////////
////////////////////////////////////////////////

    public function menuMhsAction()
    {
        if (empty($this->session->get('uid'))) {
            echo "session";
        }else{  
            $id = $_GET['id'];
            $this->view->menu=$this->menuMhsAcl();
            $this->view->pick('index/menuMhs');
            $this->view->setRenderLevel(View::LEVEL_ACTION_VIEW);
        }
    }

    public function menuMhsAcl(){

        $usergroup = $this->session->get('usergroup');
        $uid = $this->session->get('id');
        if (!empty($usergroup)) {
            $ug_arr=explode(",",$usergroup);
            foreach ($ug_arr as $k => $v) {
                if ($v!='') {
                    $ug_sql[]="usergroup_id like '%,$v,%'";
                }
            }
        }
        $ug_sql_string=implode(" or ",$ug_sql);

        $phql = "SELECT id,controller,action,label_menu,icon,child from Acl where area LIKE '%,3,%' and parent = '0' and aktif = 'Y' and except_user not LIKE '%,$uid,%'  ORDER BY urut ASC";
        // echo "<pre>".print_r($phql,1)."</pre>";die();
        $query = $this->modelsManager->executeQuery($phql)->toArray();

        foreach ($query as $key => $value) {

            $query2 = '';
            if ($value['child'] != '') {
                $id = $value['id'];
                $phql2  = "SELECT id,controller,action,label_menu,icon,child from Acl where parent = '$id' and aktif = 'Y' and except_user not LIKE '%,$uid,%'  ORDER BY urut ASC";         
                $query2 = $this->cek_anak_MHS($phql2,$ug_sql_string);
            }

            $dt[] = array(
                'id' => $value['id'], 
                'controller' => $value['controller'], 
                'action' => $value['action'], 
                'label_menu' => $value['label_menu'], 
                'icon' => $value['icon'], 
                'child' => $query2, 

            );
        }

        return $dt;       
    }

    public function cek_anak_MHS($phql2,$ug_sql_string)
    {
        
        $uid = $this->session->get('id');
        $query2 = $this->modelsManager->executeQuery($phql2)->toArray();    
        foreach ($query2 as $key2 => $value2) {
            $n = '';
            if ($value2['child'] != '') {
                $q = $value2['id'];
                $asd  = "SELECT id,controller,action,label_menu,icon,child from Acl where parent = '$q' and except_user not LIKE '%,$uid,%' ORDER BY urut ASC";
                $n = $this->cek_anak($asd,$ug_sql_string);
            }

            $as[] = array(
                'id' => $value2['id'], 
                'controller' => $value2['controller'], 
                'action' => $value2['action'], 
                'label_menu' => $value2['label_menu'], 
                'icon' => $value2['icon'], 
                'child' => $n, 
            );
        }
        return $as;
    }

///////////////////////////////////////////////////
/////////////MENU PEGAWAI ST//////////////////
////////////////////////////////////////////////
    public function menuUserAction()
    {
        if (empty($this->session->get('uid'))) {
            echo "session";
        }else{  
            $fungsi = new FungsiController;

            $id = $_GET['id'];
            $nama_area = $_GET['nama_area'];
            // mengirim session ps_id area
            $ps_id = $_GET['ps_id'];
            $session = new SessionAdapter();
            $session->set('ps_id',$ps_id);
            
            $this->view->nama_area=$nama_area;
            $this->view->menu=$this->menuAction($id);
            $this->view->pick('index/menuUser');
            $this->view->setRenderLevel(View::LEVEL_ACTION_VIEW);
        }
    }

    
    public function menuAction($id){

        $usergroup = $this->session->get('usergroup');
        $uid = $this->session->get('id');
        if (!empty($usergroup)) {
            $ug_arr=explode(",",$usergroup);
            foreach ($ug_arr as $k => $v) {
                if ($v!='') {
                    $ug_sql[]="usergroup_id like '%,$v,%'";
                }
            }
        }
        $ug_sql_string=implode(" or ",$ug_sql);

        $phql = "SELECT id,controller,action,label_menu,icon,child from Acl where area LIKE '%,$id,%' and parent = '0' and aktif = 'Y' and except_user not LIKE '%,$uid,%'  ORDER BY urut ASC";
        // echo "<pre>".print_r($phql,1)."</pre>";die();
        $query = $this->modelsManager->executeQuery($phql)->toArray();

        foreach ($query as $key => $value) {

            $query2 = '';
            if ($value['child'] != '') {
                $id = $value['id'];
                $phql2  = "SELECT id,controller,action,label_menu,icon,child from Acl where parent = '$id' and aktif = 'Y' and except_user not LIKE '%,$uid,%'   ORDER BY urut ASC";         
                $query2 = $this->cek_anak($phql2,$ug_sql_string);
            }

            $dt[] = array(
                'id' => $value['id'], 
                'controller' => $value['controller'], 
                'action' => $value['action'], 
                'label_menu' => $value['label_menu'], 
                'icon' => $value['icon'], 
                'child' => $query2, 

            );
        }

        return $dt;       
    }

    public function cek_anak($phql2,$ug_sql_string)
    {
        
        $uid = $this->session->get('id');
        $query2 = $this->modelsManager->executeQuery($phql2)->toArray();    
        foreach ($query2 as $key2 => $value2) {
            $n = '';
            if ($value2['child'] != '') {
                $q = $value2['id'];
                $asd  = "SELECT id,controller,action,label_menu,icon,child from Acl where parent = '$q' and except_user not LIKE '%,$uid,%' ORDER BY urut ASC";
                $n = $this->cek_anak($asd,$ug_sql_string);
            }

            $as[] = array(
                'id' => $value2['id'], 
                'controller' => $value2['controller'], 
                'action' => $value2['action'], 
                'label_menu' => $value2['label_menu'], 
                'icon' => $value2['icon'], 
                'child' => $n, 
            );
        }
        return $as;
    }

}

