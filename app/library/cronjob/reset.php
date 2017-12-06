<?php

$time_start = microtime(true); 

require_once "connect.php";

$reset = "UPDATE ref_presensi SET status_email = 'T'";

if ($conn->query($reset)) {
    echo "Status email berhasil direset\n";
} else {
    echo "Status email gagal direset\n";
}

$conn->close();

$eksekusi = round(microtime(true) - $time_start, 2);
echo "-------------------------------\n";
echo "Total eksekusi script: " . $eksekusi . " detik";