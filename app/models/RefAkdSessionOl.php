<?php

class RefAkdSessionOl extends \Phalcon\Mvc\Model
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
    public $ol_id;

    /**
     *
     * @var string
     * @Column(type="string", nullable=false)
     */
    public $nama_ol;

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
    public $olstart_dttm;

    /**
     *
     * @var string
     * @Column(type="string", nullable=true)
     */
    public $olstop_dttm;

    /**
     *
     * @var string
     * @Column(type="string", nullable=true)
     */
    public $olstart_tm;

    /**
     *
     * @var string
     * @Column(type="string", nullable=true)
     */
    public $olstop_tm;

    /**
     *
     * @var integer
     * @Column(type="integer", length=4, nullable=false)
     */
    public $mkmax;

    /**
     *
     * @var integer
     * @Column(type="integer", length=4, nullable=false)
     */
    public $mkbarumax;

    /**
     *
     * @var integer
     * @Column(type="integer", length=4, nullable=false)
     */
    public $mkulangmax;

    /**
     *
     * @var integer
     * @Column(type="integer", length=4, nullable=false)
     */
    public $sksmax;

    /**
     *
     * @var integer
     * @Column(type="integer", length=4, nullable=false)
     */
    public $sksbarumax;

    /**
     *
     * @var integer
     * @Column(type="integer", length=4, nullable=false)
     */
    public $sksulangmax;

    /**
     *
     * @var integer
     * @Column(type="integer", length=4, nullable=false)
     */
    public $mkmaxp;

    /**
     *
     * @var integer
     * @Column(type="integer", length=4, nullable=false)
     */
    public $mkbarumaxp;

    /**
     *
     * @var integer
     * @Column(type="integer", length=4, nullable=false)
     */
    public $mkulangmaxp;

    /**
     *
     * @var integer
     * @Column(type="integer", length=4, nullable=false)
     */
    public $sksmaxp;

    /**
     *
     * @var integer
     * @Column(type="integer", length=4, nullable=false)
     */
    public $sksbarumaxp;

    /**
     *
     * @var integer
     * @Column(type="integer", length=4, nullable=false)
     */
    public $sksulangmaxp;

    /**
     *
     * @var string
     * @Column(type="string", nullable=false)
     */
    public $aktif;

    /**
     *
     * @var string
     * @Column(type="string", nullable=false)
     */
    public $batalmk;

    /**
     *
     * @var string
     * @Column(type="string", nullable=false)
     */
    public $pindahkls;

    /**
     *
     * @var string
     * @Column(type="string", nullable=false)
     */
    public $gantimk;

    /**
     *
     * @var string
     * @Column(type="string", nullable=false)
     */
    public $pinjaman;

    /**
     *
     * @var double
     * @Column(type="double", length=4, nullable=true)
     */
    public $npinjaman;

    /**
     *
     * @var string
     * @Column(type="string", nullable=false)
     */
    public $jatahfix;

    /**
     *
     * @var integer
     * @Column(type="integer", length=5, nullable=false)
     */
    public $mkpenalti;

    /**
     *
     * @var integer
     * @Column(type="integer", length=5, nullable=false)
     */
    public $skspenalti;

    /**
     * Returns table name mapped in the model.
     *
     * @return string
     */
    public function getSource()
    {
        return 'ref_akd_session_ol';
    }

    /**
     * Allows to query a set of records that match the specified conditions
     *
     * @param mixed $parameters
     * @return RefAkdSessionOl[]
     */
    public static function find($parameters = null)
    {
        return parent::find($parameters);
    }

    /**
     * Allows to query the first record that match the specified conditions
     *
     * @param mixed $parameters
     * @return RefAkdSessionOl
     */
    public static function findFirst($parameters = null)
    {
        return parent::findFirst($parameters);
    }

}
