<?php

$time_start = microtime(true); 

require_once "connect.php";
require_once "tanggal_indo.php";
require_once "/var/www/html/sia/app/library/phpmailer/PHPMailerAutoload.php";

$get_sql = "SELECT p.*, m.nama, m.email, m.nis, r.nama AS nama_rombel, t.nama AS nama_tingkat FROM ref_presensi p, ref_akd_mhs m, ref_rombongan_belajar r, ref_tingkat_pendidikan t WHERE p.peserta_didik_id = m.id_mhs AND p.rombongan_belajar_id = r.rombongan_belajar_id AND r.tingkat_pendidikan_id = t.tingkat_pendidikan_id AND p.status_email = 'T' AND p.tanggal = CURRENT_DATE LIMIT 20";

$result = $conn->query($get_sql);

if ($result->num_rows > 0) {
    // tampung data di array
    $data = [];
    while($get = $result->fetch_assoc()) {
        $data[] = $get;
    }

    // update status email menjadi diproses (P)
    $get_id = '';
    for ($x = 0; $x < count($data); $x++) {
        $get_id .= $data[$x]['presensi_id'] . ',';
    }
    $get_id = substr($get_id, 0, -1);
    
    $proses = "UPDATE ref_presensi SET status_email = 'P' WHERE presensi_id IN ($get_id)";
        
    if ($conn->query($proses)) {
        echo "Status email berhasil diproses\n";
    } else {
        echo "Status email gagal diproses\n";
    }
    
    // kirim email ke orang tua
    $mail = new PHPMailer;
    
    $mail->isSMTP();
    $mail->SMTPAuth = true;
    $mail->Host     = 'tls://email-smtp.eu-west-1.amazonaws.com';
    $mail->Username = 'AKIAJ5GQDG2P6I4QSZYA';
    $mail->Password = 'AgPWeERrMTMlx30sZqfIPl13uNR0XYSGwhxgsBgNWmEL';
    $mail->Port     = 587;
    // $mail->SMTPSecure = 'tls';

    $mail->setFrom('code@ztoro.com', 'Admin SISKO');
    $mail->isHTML(true);
    
    $no = 1;
    for ($y = 0; $y < count($data); $y++) {        
        $subject = "SISKO SD Al-Azhar - Presensi murid ".$data[$y]['tipe']." (".tanggal_indo($data[$y]['tanggal'], 1).")";
        
        $content = "Diberitahukan kepada orangtua/wali murid, <br> bahwa murid dengan nama <b>".$data[$y]['nama']."</b> dari ".$data[$y]['nama_tingkat']." ".$data[$y]['nama_rombel']." telah ".$data[$y]['tipe']." dengan status <u>".$data[$y]['presensi']."</u> pada tanggal ".tanggal_indo($data[$y]['tanggal'])." pukul ".$data[$y]['waktu'].". <br><br> - Admin Al-Azhar BSB City";
        
        $mail->addAddress($data[$y]['email']);  
        $mail->Subject = $subject;
        $mail->Body    = $content;        
        
        if(!$mail->send()) {
            echo "Email gagal dikirim!\n";
            echo "Error: " . $mail->ErrorInfo;
        } else {
            echo "#".$no." Email berhasil dikirim ke ".$data[$y]['email']."\n";    
            $no++;
        }         
        
        $mail->clearAddresses();
    }

    // update status menjadi terkirim (Y)
    $sukses = "UPDATE ref_presensi SET status_email='Y' WHERE presensi_id IN ($get_id)";
    
    if ($conn->query($sukses)) {
        echo "Status email berhasil diupdate\n";        
    } else {
        echo "Gagal mengupdate status email!\n";
        echo "Error: " . $conn->error;
    }        
} else {
    echo "Semua email telah dikirim!\n";
}

$conn->close();

$eksekusi = round(microtime(true) - $time_start, 2);
echo "-------------------------------\n";
echo "Total eksekusi script: " . $eksekusi . " detik";