<?php

class RefAkdSdm extends \Phalcon\Mvc\Model
{

    /**
     *
     * @var string
     * @Primary
     * @Column(type="string", length=19, nullable=false)
     */
    public $nip;

    /**
     *
     * @var string
     * @Column(type="string", length=19, nullable=false)
     */
    public $nip_riil;

    /**
     *
     * @var integer
     * @Column(type="integer", length=11, nullable=false)
     */
    public $id_ps;

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
    public $gelar;

    /**
     *
     * @var string
     * @Column(type="string", length=10, nullable=false)
     */
    public $alias0;

    /**
     *
     * @var string
     * @Column(type="string", nullable=false)
     */
    public $e_mail;

    /**
     *
     * @var string
     * @Column(type="string", nullable=true)
     */
    public $kelamin;

    /**
     *
     * @var string
     * @Column(type="string", nullable=false)
     */
    public $alamat;

    /**
     *
     * @var string
     * @Column(type="string", length=3, nullable=false)
     */
    public $kode_kota;

    /**
     *
     * @var string
     * @Column(type="string", length=2, nullable=false)
     */
    public $kode_prop;

    /**
     *
     * @var string
     * @Column(type="string", length=5, nullable=false)
     */
    public $kodepos;

    /**
     *
     * @var string
     * @Column(type="string", nullable=false)
     */
    public $telpon;

    /**
     *
     * @var string
     * @Column(type="string", nullable=true)
     */
    public $fax;

    /**
     *
     * @var string
     * @Column(type="string", nullable=true)
     */
    public $tgl_lahir;

    /**
     *
     * @var string
     * @Column(type="string", nullable=false)
     */
    public $tmp_lahir;

    /**
     *
     * @var string
     * @Column(type="string", nullable=true)
     */
    public $gol_darah;

    /**
     *
     * @var string
     * @Column(type="string", length=1, nullable=false)
     */
    public $kode_agama;

    /**
     *
     * @var string
     * @Column(type="string", length=30, nullable=false)
     */
    public $kelp;

    /**
     *
     * @var string
     * @Column(type="string", length=16, nullable=false)
     */
    public $nickname;

    /**
     *
     * @var string
     * @Column(type="string", nullable=false)
     */
    public $gelar_dpn;

    /**
     *
     * @var string
     * @Column(type="string", nullable=false)
     */
    public $gelar_blk;

    /**
     *
     * @var string
     * @Column(type="string", length=500, nullable=false)
     */
    public $foto;

    /**
     *
     * @var integer
     * @Column(type="integer", length=1, nullable=false)
     */
    public $id_status;

    /**
     *
     * @var string
     * @Column(type="string", nullable=false)
     */
    public $created;

    /**
     * Returns table name mapped in the model.
     *
     * @return string
     */
    public function getSource()
    {
        return 'ref_akd_sdm';
    }

    /**
     * Allows to query a set of records that match the specified conditions
     *
     * @param mixed $parameters
     * @return RefAkdSdm[]
     */
    public static function find($parameters = null)
    {
        return parent::find($parameters);
    }

    /**
     * Allows to query the first record that match the specified conditions
     *
     * @param mixed $parameters
     * @return RefAkdSdm
     */
    public static function findFirst($parameters = null)
    {
        return parent::findFirst($parameters);
    }

}
