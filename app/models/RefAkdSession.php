<?php

class RefAkdSession extends \Phalcon\Mvc\Model
{

    /**
     *
     * @var integer
     * @Primary
     * @Column(type="integer", length=6, nullable=false)
     */
    public $ps_id;

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
     * @Column(type="string", nullable=true)
     */
    public $begin_dt;

    /**
     *
     * @var string
     * @Column(type="string", nullable=true)
     */
    public $end_dt;

    /**
     *
     * @var string
     * @Column(type="string", nullable=false)
     */
    public $nama;

    /**
     *
     * @var string
     * @Column(type="string", nullable=false)
     */
    public $libcheck;

    /**
     *
     * @var string
     * @Column(type="string", nullable=true)
     */
    public $libcheck_dt;

    /**
     *
     * @var double
     * @Column(type="double", length=8, nullable=false)
     */
    public $ip_pin_krs;

    /**
     *
     * @var string
     * @Column(type="string", nullable=false)
     */
    public $pin_krs_wali;

    /**
     *
     * @var string
     * @Column(type="string", nullable=false)
     */
    public $max_sks_wali;

    /**
     *
     * @var string
     * @Column(type="string", nullable=false)
     */
    public $ips_check;

    /**
     *
     * @var string
     * @Column(type="string", nullable=false)
     */
    public $ipk_check;

    /**
     *
     * @var string
     * @Column(type="string", length=4, nullable=false)
     */
    public $pthn_akd;

    /**
     *
     * @var string
     * @Column(type="string", length=3, nullable=false)
     */
    public $psession_id;

    /**
     *
     * @var string
     * @Column(type="string", nullable=false)
     */
    public $spp_check;

    /**
     *
     * @var string
     * @Column(type="string", length=16, nullable=false)
     */
    public $passwd;

    /**
     *
     * @var double
     * @Column(type="double", length=8, nullable=false)
     */
    public $kpinjaman;

    /**
     *
     * @var string
     * @Column(type="string", nullable=false)
     */
    public $blockkrs;

    /**
     * Returns table name mapped in the model.
     *
     * @return string
     */
    public function getSource()
    {
        return 'ref_akd_session';
    }

    /**
     * Allows to query a set of records that match the specified conditions
     *
     * @param mixed $parameters
     * @return RefAkdSession[]
     */
    public static function find($parameters = null)
    {
        return parent::find($parameters);
    }

    /**
     * Allows to query the first record that match the specified conditions
     *
     * @param mixed $parameters
     * @return RefAkdSession
     */
    public static function findFirst($parameters = null)
    {
        return parent::findFirst($parameters);
    }

}
