<?php

class RefSysKelurahan extends \Phalcon\Mvc\Model
{

    /**
     *
     * @var string
     * @Primary
     * @Column(type="string", length=10, nullable=false)
     */
    public $Id;

    /**
     *
     * @var string
     * @Column(type="string", length=7, nullable=false)
     */
    public $District_id;

    /**
     *
     * @var string
     * @Column(type="string", length=255, nullable=false)
     */
    public $Name;

    /**
     * Initialize method for model.
     */
    public function initialize()
    {
        $this->setSchema("siakad");
        $this->setSource("ref_sys_kelurahan");
        $this->belongsTo('district_id', '\RefSysKecamatan', 'id', ['alias' => 'RefSysKecamatan']);
    }

    /**
     * Returns table name mapped in the model.
     *
     * @return string
     */
    public function getSource()
    {
        return 'ref_sys_kelurahan';
    }

    /**
     * Allows to query a set of records that match the specified conditions
     *
     * @param mixed $parameters
     * @return RefSysKelurahan[]|RefSysKelurahan|\Phalcon\Mvc\Model\ResultSetInterface
     */
    public static function find($parameters = null)
    {
        return parent::find($parameters);
    }

    /**
     * Allows to query the first record that match the specified conditions
     *
     * @param mixed $parameters
     * @return RefSysKelurahan|\Phalcon\Mvc\Model\ResultInterface
     */
    public static function findFirst($parameters = null)
    {
        return parent::findFirst($parameters);
    }

}
