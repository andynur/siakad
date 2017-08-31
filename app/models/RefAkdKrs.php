<?php

class RefAkdKrs extends \Phalcon\Mvc\Model
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
     * @var string
     * @Primary
     * @Column(type="string", length=25, nullable=false)
     */
    public $nomhs;

    /**
     *
     * @var integer
     * @Primary
     * @Column(type="integer", length=6, nullable=false)
     */
    public $psmhs_id;

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
     * @Column(type="string", length=10, nullable=false)
     */
    public $nama_kelas;

    /**
     *
     * @var string
     * @Column(type="string", nullable=false)
     */
    public $st_ulang;

    /**
     *
     * @var string
     * @Column(type="string", nullable=false)
     */
    public $st_nonsks;

    /**
     *
     * @var string
     * @Column(type="string", length=1, nullable=false)
     */
    public $st_ambil;

    /**
     *
     * @var string
     * @Column(type="string", nullable=true)
     */
    public $tgl_updt;

    /**
     *
     * @var integer
     * @Column(type="integer", length=3, nullable=false)
     */
    public $sks;

    /**
     *
     * @var string
     * @Column(type="string", length=3, nullable=false)
     */
    public $nilai;

    /**
     *
     * @var integer
     * @Column(type="integer", length=6, nullable=false)
     */
    public $gs_id;

    /**
     *
     * @var integer
     * @Column(type="integer", length=6, nullable=false)
     */
    public $psgs_id;

    /**
     *
     * @var double
     * @Column(type="double", length=4, nullable=false)
     */
    public $nilai_num;

    /**
     *
     * @var integer
     * @Column(type="integer", length=4, nullable=false)
     */
    public $jmlhadirkul;

    /**
     *
     * @var string
     * @Column(type="string", nullable=false)
     */
    public $st_batal;

    /**
     *
     * @var double
     * @Column(type="double", length=3, nullable=true)
     */
    public $nilai_mutu;

    /**
     * Returns table name mapped in the model.
     *
     * @return string
     */
    public function getSource()
    {
        return 'ref_akd_krs';
    }

    /**
     * Allows to query a set of records that match the specified conditions
     *
     * @param mixed $parameters
     * @return RefAkdKrs[]
     */
    public static function find($parameters = null)
    {
        return parent::find($parameters);
    }

    /**
     * Allows to query the first record that match the specified conditions
     *
     * @param mixed $parameters
     * @return RefAkdKrs
     */
    public static function findFirst($parameters = null)
    {
        return parent::findFirst($parameters);
    }

}
