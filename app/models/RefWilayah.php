<?php

class RefWilayah extends \Phalcon\Mvc\Model
{

    /**
     *
     * @var string
     * @Primary
     * @Column(type="string", length=8, nullable=false)
     */
    public $Kode_wilayah;

    /**
     *
     * @var string
     * @Column(type="string", length=50, nullable=false)
     */
    public $Nama;

    /**
     *
     * @var integer
     * @Column(type="integer", length=4, nullable=false)
     */
    public $Id_level_wilayah;

    /**
     *
     * @var string
     * @Column(type="string", length=8, nullable=true)
     */
    public $Mst_kode_wilayah;

    /**
     *
     * @var string
     * @Column(type="string", length=2, nullable=false)
     */
    public $Negara_id;

    /**
     *
     * @var string
     * @Column(type="string", length=8, nullable=true)
     */
    public $Asal_wilayah;

    /**
     *
     * @var string
     * @Column(type="string", length=7, nullable=true)
     */
    public $Kode_bps;

    /**
     *
     * @var string
     * @Column(type="string", length=7, nullable=true)
     */
    public $Kode_dagri;

    /**
     *
     * @var string
     * @Column(type="string", length=10, nullable=true)
     */
    public $Kode_keu;

    /**
     *
     * @var string
     * @Column(type="string", nullable=false)
     */
    public $Create_date;

    /**
     *
     * @var string
     * @Column(type="string", nullable=false)
     */
    public $Last_update;

    /**
     *
     * @var string
     * @Column(type="string", nullable=true)
     */
    public $Expired_date;

    /**
     *
     * @var string
     * @Column(type="string", nullable=false)
     */
    public $Last_sync;

    /**
     * Initialize method for model.
     */
    public function initialize()
    {
        $this->setSchema("siakad");
        $this->setSource("ref_wilayah");
    }

    /**
     * Returns table name mapped in the model.
     *
     * @return string
     */
    public function getSource()
    {
        return 'ref_wilayah';
    }

    /**
     * Allows to query a set of records that match the specified conditions
     *
     * @param mixed $parameters
     * @return RefWilayah[]|RefWilayah|\Phalcon\Mvc\Model\ResultSetInterface
     */
    public static function find($parameters = null)
    {
        return parent::find($parameters);
    }

    /**
     * Allows to query the first record that match the specified conditions
     *
     * @param mixed $parameters
     * @return RefWilayah|\Phalcon\Mvc\Model\ResultInterface
     */
    public static function findFirst($parameters = null)
    {
        return parent::findFirst($parameters);
    }

}
