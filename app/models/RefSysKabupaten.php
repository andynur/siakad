<?php

class RefSysKabupaten extends \Phalcon\Mvc\Model
{

    /**
     *
     * @var string
     * @Primary
     * @Column(type="string", length=4, nullable=false)
     */
    public $id;

    /**
     *
     * @var string
     * @Column(type="string", length=2, nullable=false)
     */
    public $province_id;

    /**
     *
     * @var string
     * @Column(type="string", length=255, nullable=false)
     */
    public $name;

    /**
     * Initialize method for model.
     */
    public function initialize()
    {
        $this->setSchema("siakad");
        $this->hasMany('id', 'RefSysKecamatan', 'regency_id', ['alias' => 'RefSysKecamatan']);
        $this->belongsTo('province_id', '\RefSysProvinsi', 'id', ['alias' => 'RefSysProvinsi']);
    }

    /**
     * Returns table name mapped in the model.
     *
     * @return string
     */
    public function getSource()
    {
        return 'ref_sys_kabupaten';
    }

    /**
     * Allows to query a set of records that match the specified conditions
     *
     * @param mixed $parameters
     * @return RefSysKabupaten[]|RefSysKabupaten
     */
    public static function find($parameters = null)
    {
        return parent::find($parameters);
    }

    /**
     * Allows to query the first record that match the specified conditions
     *
     * @param mixed $parameters
     * @return RefSysKabupaten
     */
    public static function findFirst($parameters = null)
    {
        return parent::findFirst($parameters);
    }

}
