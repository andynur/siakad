<?php

use Phalcon\Mvc\View;
use Phalcon\Validation;
use Phalcon\Validation\Validator\PresenceOf;
use Phalcon\Mvc\Url;
use Phalcon\Mvc\Model\Query\Builder;
use Phalcon\Http\Request\File;

class PresensiController extends \Phalcon\Mvc\Controller
{
    protected $messages;
    protected $title;
    protected $type;
    protected $text;

    public function initialize()
    {
        if (empty($this->session->get('uid'))) {
            $this->response->redirect('account/loginEnd');
        }
        
        $this->view->setRenderLevel(View::LEVEL_ACTION_VIEW);
    }
    
    public function indexAction($rombel_id, $date='')
    {
        $data = $this->modelsManager->createBuilder()
                ->addFrom('RefRombelAnggota', 'a')
                ->join('RefRombonganBelajar', 'a.rombongan_belajar_id = r.rombongan_belajar_id', 'r')
                ->join('RefTingkatPendidikan', 'r.tingkat_pendidikan_id = t.tingkat_pendidikan_id', 't')
                ->join('RefAkdMhs', 'a.peserta_didik_id = m.id_mhs', 'm')
                ->columns(['a.anggota_rombel_id', 'r.nama AS nama_rombel', 't.nama AS nama_tingkat', 'm.id_mhs AS murid_id', 'm.nama AS nama_murid', 'm.nis', 'm.nisn', 'm.foto', 'm.email'])
                ->where('a.rombongan_belajar_id = ' . $rombel_id)
                ->orderBy('m.nama ASC')
                ->getQuery()
                ->execute();

        $anggota = RefRombelAnggota::find([
            "columns" => "peserta_didik_id",
            "conditions" => "rombongan_belajar_id = $rombel_id"
        ])->toArray();        
        
        $list_id = '';
        for ($i=0; $i < count($anggota); $i++) { 
            $list_id .= $anggota[$i]['peserta_didik_id'] . ', ';
        }
        $get_list_id = substr($list_id, 0, -2);
        
        if ($date == '') {
            $date = date('Y-m-d');
        }

        $presensi = RefPresensi::find([
            "conditions" => "rombongan_belajar_id = $rombel_id AND peserta_didik_id IN ($get_list_id) AND tanggal = '$date'"
        ]);
        
        foreach($presensi->toArray() as $p => $v){
            foreach($v as $field => $v2){
                $hadir[$v['peserta_didik_id']][$v['tipe']][$field] = $v2;
            }
        }        
        
        $this->view->setVars([
            "data" => $data,
            "hadir" => $hadir,
            "rombel_id" => $rombel_id,
            "tanggal" => $date
        ]);

        $this->view->pick('presensi/index');
    }

    public function statusAction()
    {
        $this->checkValidation();
        
        if (count($this->messages) == 0) {
            $data_murid = json_decode($_POST['data_murid']);
                    
            for ($i=0; $i < count($data_murid); $i++) { 
                $data = new RefPresensi();
                $this->save($data_murid[$i]->murid_id, $data, 'tambah');
            }            
        }        
        
        $notif = ['title' => $this->title, 'text' => $this->text, 'type' => $this->type];
        echo json_encode($notif);        
    }    

    public function save($murid_id, $data, $message) 
    {
        $session = explode('-', $this->session->get('ps_id'));
        $user_id = $session[1];

        $data->assign([
            'rombongan_belajar_id' => $_POST['rombel_id'],
            'tanggal' => $_POST['tanggal'],
            'waktu' => $_POST['waktu'],
            'tipe' => $_POST['tipe'],
            'peserta_didik_id' => $murid_id,
            'semester_id' => '20171',
            'presensi' => $_POST['presensi'],
            'status_email' => 'T',
            'keterangan' => $_POST['keterangan'],
            'created_by' => $user_id
        ]);
        
        if ($data->save()) {
            $this->title = 'Sukses';
            $this->text = 'Data berhasil di' . $message;
            $this->type = 'success';
        } else {
            $errors = $data->getMessages();
            foreach ($errors as $error) {
                $this->text .= "$error"."</br>";
            }
            $this->title = 'Error!';
            $this->type = 'warning';
        }         
    }   

    public function validation($validation, $column, $name) 
    {
        $validation->add($column, new PresenceOf([
            'message' => '<b>'.$name.'</b> tidak boleh kosong'
        ]));
    }

    public function checkValidation() 
    {
        $check = new Validation();    
        
        $this->validation($check, 'data_murid', 'Murid Id');        
        $this->validation($check, 'rombel_id', 'Rombel id');        
        $this->validation($check, 'tipe', 'Tipe');        
        $this->validation($check, 'presensi', 'Presensi');        
        $this->validation($check, 'tanggal', 'Tanggal');        
        $this->validation($check, 'waktu', 'Waktu');        

        $this->messages = $check->validate($_POST);

        foreach ($this->messages as $message) {
            $this->text .= "$message"."</br>";
        }
        $this->title = 'Gagal';
        $this->type = 'warning';  
    }    
    
    protected function sendMail($to, $subject, $content) 
    { 
        $mail = new PHPMailer;
        $config = $this->config;
        // $mail->SMTPDebug = 3;
        
        $mail->isSMTP();
        $mail->SMTPDebug    = 1;
        $mail->SMTPAuth     = true;
        $mail->SMTPSecure   = 'tls';
        $mail->Host         = $config->mail->info->server;
        $mail->Username     = $config->mail->info->username;
        $mail->Password     = $config->mail->info->password;
        $mail->Port         = $config->mail->info->port;
        
        $mail->setFrom($config->mail->fromEmail, $config->mail->fromName);
        $mail->addAddress($to);  
        $mail->isHTML(true); 
        
        $mail->Subject = $subject;
        $mail->Body    = $content;
        
        if(!$mail->send()) {
            return false;
        }

        return true;
    } 

    public function mailAction() 
    {
        $data_murid = json_decode($_POST['data_murid']);
        $tanggal = $_POST['tanggal'];
        $tipe = $_POST['tipe'];
        $jumlah_data = count($data_murid);

        if ($jumlah_data > 1) {
            // update status email menjadi diproses (P)
            // kirim semua email lewat cronjob
            $get_id = '';
            for ($x = 0; $x < $jumlah_data; $x++) {
                $get_id .= $data_murid[$x]->murid_id . ',';
            }
            $get_id = substr($get_id, 0, -1);
            
            $phql = "UPDATE RefPresensi SET status_email = 'P' WHERE peserta_didik_id IN ($get_id) AND tanggal = '$tanggal' AND tipe = '$tipe'";
    
            $update = $this->modelsManager->executeQuery($phql);
    
            if ($update) {
                $this->title = 'Sukses';
                $this->text = 'Email dalam proses pengiriman';
                $this->type = 'success';
            } else {
                $this->title = 'Error!';
                $this->text .= 'Email gagal diproses';
                $this->type = 'warning';
            } 
        } else {
            // kirim langsung email
            // update status email menjadi terkirim (Y)
            $id = $data_murid[0]->murid_id;

            $get_murid = $this->modelsManager->createBuilder()
                ->addFrom('RefPresensi', 'p')
                ->join('RefRombonganBelajar', 'p.rombongan_belajar_id = r.rombongan_belajar_id', 'r')
                ->join('RefTingkatPendidikan', 'r.tingkat_pendidikan_id = t.tingkat_pendidikan_id', 't')
                ->join('RefAkdMhs', 'p.peserta_didik_id = m.id_mhs', 'm')
                ->columns(['p.presensi_id', 'p.presensi', 'p.status_email', 'p.waktu', 'r.nama AS nama_rombel', 't.nama AS nama_tingkat', 'm.nama', 'm.email'])
                ->where('p.peserta_didik_id = ' . $id)
                ->andWhere('p.tanggal = "' . $tanggal . '"')
                ->andWhere('p.tipe = "' . $tipe . '"')
                ->limit(1)
                ->getQuery()
                ->execute();            

            $nama = $get_murid[0]->nama;
            $email = $get_murid[0]->email;
            $tingkat = $get_murid[0]->nama_tingkat;
            $rombel = $get_murid[0]->nama_rombel;
            $presensi = $get_murid[0]->presensi;
            $waktu = $get_murid[0]->waktu;
            $tanggal_indo = $this->helper->dateFormatIndo($tanggal);            
            $tanggal_indo_long = $this->helper->dateBahasaIndo($tanggal);            

            $subject = "SISKO SD Al-Azhar - Presensi murid $tipe ($tanggal_indo)";                  
            $content = "Diberitahukan kepada orangtua/wali murid, <br> bahwa murid dengan nama <b>$nama</b> dari $nama_tingkat $nama_rombel telah $tipe dengan status <i>$presensi</i> pada tanggal $tanggal_indo_long pukul $waktu. <br><br> - Admin Al-Azhar BSB City";
    
            $send_mail = self::sendMail($email, $subject, $content);
            
            if ($send_mail) {
                $presensi_id = $get_murid[0]->presensi_id;
                $get_presensi = RefPresensi::findFirst([
                    "conditions" => "presensi_id = ".$presensi_id
                ]);
                $get_presensi->status_email = 'Y';                                
                
                if ($get_presensi->save()) {
                    $this->title = 'Sukses';
                    $this->text = 'Email berhasil dikirim ke <b>'.$email.'</b>';
                    $this->type = 'success';
                } else {
                    $errors = $get_presensi->getMessages();
                    foreach ($errors as $error) {
                        $this->text .= "$error"."</br>";
                    }
                    $this->title = 'Error!';
                    $this->type = 'warning';
                }          
            } else {
                $this->title = 'Gagal!';
                $this->text .= "Email gagal dikirim!";        
                $this->type = 'warning';            
            }
        }
        
        $notif = ['title' => $this->title, 'text' => $this->text, 'type' => $this->type];
        echo json_encode($notif);                                   
    }
    
}

