<?php

class RefTahunAjaran extends \Phalcon\Mvc\Model
{

    /**
     *
     * @var integer
     * @Primary
     * @Identity
     * @Column(type="integer", length=11, nullable=false)
     */
    public $Tahun_ajaran_id;

    /**
     *
     * @var string
     * @Column(type="string", length=10, nullable=false)
     */
    public $Nama;

    /**
     *
     * @var integer
     * @Column(type="integer", length=11, nullable=false)
     */
    public $Periode_aktif;

    /**
     *
     * @var string
     * @Column(type="string", nullable=false)
     */
    public $Tanggal_mulai;

    /**
     *
     * @var string
     * @Column(type="string", nullable=false)
     */
    public $Tanggal_selesai;

    /**
     *
     * @var string
     * @Column(type="string", length=6, nullable=false)
     */
    public $Create_date;

    /**
     *
     * @var string
     * @Column(type="string", length=6, nullable=false)
     */
    public $Last_update;

    /**
     *
     * @var string
     * @Column(type="string", length=6, nullable=false)
     */
    public $Expired_date;

    /**
     *
     * @var string
     * @Column(type="string", length=6, nullable=false)
     */
    public $Last_sync;

    /**
     * Initialize method for model.
     */
    // public function initialize()
    // {
    //     $this->setSchema("siakad");
    //     $this->setSource("ref_tahun_ajaran");
    // }

    /**
     * Returns table name mapped in the model.
     *
     * @return string
     */
    public function getSource()
    {
        return 'ref_tahun_ajaran';
    }

    /**
     * Allows to query a set of records that match the specified conditions
     *
     * @param mixed $parameters
     * @return RefTahunAjaran[]|RefTahunAjaran|\Phalcon\Mvc\Model\ResultSetInterface
     */
    public static function find($parameters = null)
    {
        return parent::find($parameters);
    }

    /**
     * Allows to query the first record that match the specified conditions
     *
     * @param mixed $parameters
     * @return RefTahunAjaran|\Phalcon\Mvc\Model\ResultInterface
     */
    public static function findFirst($parameters = null)
    {
        return parent::findFirst($parameters);
    }

}
