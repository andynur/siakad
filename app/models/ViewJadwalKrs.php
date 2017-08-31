<?php

class ViewJadwalKrs extends \Phalcon\Mvc\Model
{

    /**
     *
     * @var integer
     * @Column(type="integer", length=6, nullable=false)
     */
    public $ps_id;

    /**
     *
     * @var string
     * @Column(type="string", length=10, nullable=false)
     */
    public $nama_kelas;

    /**
     *
     * @var string
     * @Column(type="string", length=10, nullable=false)
     */
    public $kode_mk;

    /**
     *
     * @var string
     * @Column(type="string", length=8, nullable=false)
     */
    public $thn_kur;

    /**
     *
     * @var string
     * @Column(type="string", length=4, nullable=false)
     */
    public $thn_akd;

    /**
     *
     * @var string
     * @Column(type="string", length=3, nullable=false)
     */
    public $session_id;

    /**
     *
     * @var integer
     * @Column(type="integer", length=5, nullable=true)
     */
    public $jml_mhs;

    /**
     *
     * @var integer
     * @Column(type="integer", length=5, nullable=true)
     */
    public $kapasitas;

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
     * @Column(type="string", length=64, nullable=true)
     */
    public $nip_dosen;

    /**
     *
     * @var string
     * @Column(type="string", length=4, nullable=true)
     */
    public $ruang_id;

    /**
     *
     * @var string
     * @Column(type="string", length=230, nullable=true)
     */
    public $prasyt_ang;

    /**
     * Returns table name mapped in the model.
     *
     * @return string
     */
    public function getSource()
    {
        return 'view_jadwal_krs';
    }

    /**
     * Allows to query a set of records that match the specified conditions
     *
     * @param mixed $parameters
     * @return ViewJadwalKrs[]
     */
    public static function find($parameters = null)
    {
        return parent::find($parameters);
    }

    /**
     * Allows to query the first record that match the specified conditions
     *
     * @param mixed $parameters
     * @return ViewJadwalKrs
     */
    public static function findFirst($parameters = null)
    {
        return parent::findFirst($parameters);
    }

}
