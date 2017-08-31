<?php

class RefSysProvinsi extends \Phalcon\Mvc\Model
{

    /**
     *
     * @var string
     * @Primary
     * @Column(type="string", length=2, nullable=false)
     */
    public $id;

    /**
     *
     * @var string
     * @Column(type="string", length=255, nullable=false)
     */
    public $name;

    /**
     * Initialize method for model.
     */
    // public function initialize()
    // {
    //     $this->setSchema("siakad");
    //     $this->hasMany('id', 'RefSysKabupaten', 'province_id', ['alias' => 'RefSysKabupaten']);
    // }

    /**
     * Returns table name mapped in the model.
     *
     * @return string
     */
    public function getSource()
    {
        return 'ref_sys_provinsi';
    }

    /**
     * Allows to query a set of records that match the specified conditions
     *
     * @param mixed $parameters
     * @return RefSysProvinsi[]|RefSysProvinsi
     */
    public static function find($parameters = null)
    {
        return parent::find($parameters);
    }

    /**
     * Allows to query the first record that match the specified conditions
     *
     * @param mixed $parameters
     * @return RefSysProvinsi
     */
    public static function findFirst($parameters = null)
    {
        return parent::findFirst($parameters);
    }

}
