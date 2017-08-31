<?php

class RefAkdMhsCuti extends \Phalcon\Mvc\Model
{

    /**
     *
     * @var integer
     * @Primary
     * @Identity
     * @Column(type="integer", length=11, nullable=false)
     */
    public $cuti_id;

    /**
     *
     * @var string
     * @Column(type="string", length=25, nullable=true)
     */
    public $nomhs;

    /**
     *
     * @var string
     * @Column(type="string", nullable=true)
     */
    public $keterangan;

    /**
     *
     * @var string
     * @Column(type="string", length=4, nullable=true)
     */
    public $thn_akd;

    /**
     *
     * @var string
     * @Column(type="string", length=3, nullable=true)
     */
    public $session_id;

    /**
     *
     * @var string
     * @Column(type="string", nullable=true)
     */
    public $tgl_start;

    /**
     *
     * @var string
     * @Column(type="string", nullable=true)
     */
    public $tgl_stop;

    /**
     *
     * @var string
     * @Column(type="string", length=30, nullable=true)
     */
    public $no_surat;

    /**
     *
     * @var string
     * @Column(type="string", nullable=true)
     */
    public $tgl_surat;

    /**
     * Initialize method for model.
     */
    // public function initialize()
    // {
    //     $this->setSchema("siakad");
    // }

    /**
     * Returns table name mapped in the model.
     *
     * @return string
     */
    public function getSource()
    {
        return 'ref_akd_mhs_cuti';
    }

    /**
     * Allows to query a set of records that match the specified conditions
     *
     * @param mixed $parameters
     * @return RefAkdMhsCuti[]|RefAkdMhsCuti
     */
    public static function find($parameters = null)
    {
        return parent::find($parameters);
    }

    /**
     * Allows to query the first record that match the specified conditions
     *
     * @param mixed $parameters
     * @return RefAkdMhsCuti
     */
    public static function findFirst($parameters = null)
    {
        return parent::findFirst($parameters);
    }

}
