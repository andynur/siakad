<?php

class RefAkdMku extends \Phalcon\Mvc\Model
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
     * @Column(type="integer", length=11, nullable=false)
     */
    public $ps_id;

    /**
     *
     * @var string
     * @Column(type="string", length=128, nullable=false)
     */
    public $kode_mk;

    /**
     *
     * @var string
     * @Column(type="string", length=1, nullable=false)
     */
    public $kode_agama;

    /**
     *
     * @var string
     * @Column(type="string", length=8, nullable=false)
     */
    public $thn_kur;

    /**
     *
     * @var string
     * @Column(type="string", length=60, nullable=false)
     */
    public $nama;

    /**
     *
     * @var string
     * @Column(type="string", length=60, nullable=false)
     */
    public $nama_en;

    /**
     *
     * @var integer
     * @Column(type="integer", length=4, nullable=false)
     */
    public $sks;

    /**
     *
     * @var string
     * @Column(type="string", length=6, nullable=false)
     */
    public $kelompok;

    /**
     *
     * @var string
     * @Column(type="string", length=1, nullable=false)
     */
    public $jenis;

    /**
     *
     * @var integer
     * @Column(type="integer", length=4, nullable=false)
     */
    public $semester;

    /**
     *
     * @var string
     * @Column(type="string", nullable=true)
     */
    public $prasyarat;

    /**
     *
     * @var integer
     * @Column(type="integer", length=5, nullable=false)
     */
    public $urut;

    /**
     *
     * @var string
     * @Column(type="string", nullable=true)
     */
    public $deskripsi;

    /**
     *
     * @var string
     * @Column(type="string", length=20, nullable=true)
     */
    public $kodemk;

    /**
     *
     * @var integer
     * @Column(type="integer", length=4, nullable=true)
     */
    public $sks_teori;

    /**
     *
     * @var integer
     * @Column(type="integer", length=4, nullable=true)
     */
    public $sks_praktek;

    /**
     *
     * @var integer
     * @Column(type="integer", length=4, nullable=true)
     */
    public $sks_klinik;

    /**
     * Returns table name mapped in the model.
     *
     * @return string
     */
    public function getSource()
    {
        return 'ref_akd_mku';
    }

    /**
     * Allows to query a set of records that match the specified conditions
     *
     * @param mixed $parameters
     * @return RefAkdMku[]
     */
    public static function find($parameters = null)
    {
        return parent::find($parameters);
    }

    /**
     * Allows to query the first record that match the specified conditions
     *
     * @param mixed $parameters
     * @return RefAkdMku
     */
    public static function findFirst($parameters = null)
    {
        return parent::findFirst($parameters);
    }

}
