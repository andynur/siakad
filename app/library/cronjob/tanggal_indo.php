<?php

function tanggal_indo($date, $format = '') {
    if (substr($date, 0, 10) == '0000-00-00') {
        return false;
    }

    $bulan = array(
        '01' => 'Januari',
        '02' => 'Februari',
        '03' => 'Maret',
        '04' => 'April',
        '05' => 'Mei',
        '06' => 'Juni',
        '07' => 'Juli',
        '08' => 'Agustus',
        '09' => 'September',
        '10' => 'Oktober',
        '11' => 'November',
        '12' => 'Desember',
    );

    $pecah  = explode('-',$date);
    $bln    = $pecah[1];
    $thn    = $pecah[0];

    if (strlen($date)>10) {
        $tgl_arr    = explode(" ", $pecah[2]);
        $tgl        = $tgl_arr[0];
        $detik      = substr($date,-8,5);
    } else {
        $tgl    = $pecah[2];
        $detik  = '';
    }

    if ($format == 1) {
        return $tgl . '-' . $bln . '-' . $thn;
    } else {
        return $tgl . '-' . $bulan[$bln] . '-' . $thn;
    }    
        
}