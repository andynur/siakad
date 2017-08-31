<?php

use Phalcon\Mvc\Collection;

class LogAktifitasUser extends Collection
{
    public function getSource()
    {
        return "log_aktifitas_user"; //namaCollection
    }
}