<?php

class RefAkdPsMkstatus extends \Phalcon\Mvc\Model
{

    /**
     *
     * @var integer
     * @Primary
     * @Identity
     * @Column(type="integer", length=11, nullable=false)
     */
    public $id;

    /**
     *
     * @var integer
     * @Primary
     * @Column(type="integer", length=6, nullable=false)
     */
    public $ps_id;

    /**
     *
     * @var integer
     * @Primary
     * @Column(type="integer", length=6, nullable=false)
     */
    public $ps_allow;

    /**
     *
     * @var string
     * @Primary
     * @Column(type="string", length=10, nullable=false)
     */
    public $kode_mk;

    /**
     *
     * @var string
     * @Primary
     * @Column(type="string", length=8, nullable=false)
     */
    public $thn_kur;

    /**
     *
     * @var string
     * @Primary
     * @Column(type="string", length=4, nullable=false)
     */
    public $thn_akd;

    /**
     *
     * @var string
     * @Primary
     * @Column(type="string", length=3, nullable=false)
     */
    public $session_id;

    /**
     *
     * @var string
     * @Column(type="string", length=200, nullable=false)
     */
    public $prasyt;

    /**
     *
     * @var string
     * @Column(type="string", length=230, nullable=false)
     */
    public $prasyt_ang;

    /**
     *
     * @var string
     * @Column(type="string", length=80, nullable=false)
     */
    public $st_nonsks_ang;

    /**
     *
     * @var string
     * @Column(type="string", length=80, nullable=false)
     */
    public $st_ambil_ang;

    /**
     *
     * @var string
     * @Column(type="string", nullable=false)
     */
    public $st_nonbatalmk;

    /**
     * Returns table name mapped in the model.
     *
     * @return string
     */
    public function getSource()
    {
        return 'ref_akd_ps_mkstatus';
    }

    /**
     * Allows to query a set of records that match the specified conditions
     *
     * @param mixed $parameters
     * @return RefAkdPsMkstatus[]
     */
    public static function find($parameters = null)
    {
        return parent::find($parameters);
    }

    /**
     * Allows to query the first record that match the specified conditions
     *
     * @param mixed $parameters
     * @return RefAkdPsMkstatus
     */
    public static function findFirst($parameters = null)
    {
        return parent::findFirst($parameters);
    }

}
