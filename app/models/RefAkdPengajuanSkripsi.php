<?php

class RefAkdPengajuanSkripsi extends \Phalcon\Mvc\Model
{
	
    public function getSource()
    {
        return 'ref_akd_pengajuan_skripsi';
    }

    /**
     * Allows to query a set of records that match the specified conditions
     *
     * @param mixed $parameters
     * @return RefAkdRuang[]
     */
    public static function find($parameters = null)
    {
        return parent::find($parameters);
    }

    /**
     * Allows to query the first record that match the specified conditions
     *
     * @param mixed $parameters
     * @return RefAkdRuang
     */
    public static function findFirst($parameters = null)
    {
        return parent::findFirst($parameters);
    }

}
