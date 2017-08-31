<?php

class RefAkdUploadModul extends \Phalcon\Mvc\Model
{

    /**
     * Returns table name mapped in the model.
     *
     * @return string
     */
    public function getSource()
    {
        return 'ref_akd_upload_modul';
    }

    /**
     * Allows to query a set of records that match the specified conditions
     *
     * @param mixed $parameters
     * @return RefAkdPs[]
     */
    public static function find($parameters = null)
    {
        return parent::find($parameters);
    }

    /**
     * Allows to query the first record that match the specified conditions
     *
     * @param mixed $parameters
     * @return RefAkdPs
     */
    public static function findFirst($parameters = null)
    {
        return parent::findFirst($parameters);
    }

}
