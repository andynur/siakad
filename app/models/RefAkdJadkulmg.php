<?php

class RefAkdJadkulmg extends \Phalcon\Mvc\Model
{

    /**
     *
     * @var integer
     * @Primary
     * @Identity
     * @Column(type="integer", length=11, nullable=false)
     */
    public $jadkul_id;

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
     * @Column(type="string", length=8, nullable=false)
     */
    public $thn_kur;

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
    public $nama_kelas;

    /**
     *
     * @var integer
     * @Primary
     * @Column(type="integer", length=4, nullable=false)
     */
    public $id;

    /**
     *
     * @var integer
     * @Column(type="integer", length=3, nullable=false)
     */
    public $hari;

    /**
     *
     * @var string
     * @Column(type="string", nullable=false)
     */
    public $jam_awal;

    /**
     *
     * @var string
     * @Column(type="string", nullable=false)
     */
    public $jam_akhir;

    /**
     *
     * @var string
     * @Column(type="string", length=4, nullable=false)
     */
    public $ruang_id;

    /**
     *
     * @var string
     * @Column(type="string", length=1, nullable=false)
     */
    public $st_drop;

    /**
     *
     * @var string
     * @Column(type="string", nullable=false)
     */
    public $st_gabung;

    /**
     *
     * @var string
     * @Column(type="string", length=64, nullable=false)
     */
    public $nip_dosen;

    /**
     * Returns table name mapped in the model.
     *
     * @return string
     */
    public function getSource()
    {
        return 'ref_akd_jadkulmg';
    }

    /**
     * Allows to query a set of records that match the specified conditions
     *
     * @param mixed $parameters
     * @return RefAkdJadkulmg[]
     */
    public static function find($parameters = null)
    {
        return parent::find($parameters);
    }

    /**
     * Allows to query the first record that match the specified conditions
     *
     * @param mixed $parameters
     * @return RefAkdJadkulmg
     */
    public static function findFirst($parameters = null)
    {
        return parent::findFirst($parameters);
    }

}
