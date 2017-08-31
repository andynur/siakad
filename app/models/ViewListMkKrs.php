<?php

class ViewListMkKrs extends \Phalcon\Mvc\Model
{

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
     * @Column(type="string", length=10, nullable=false)
     */
    public $nama_kelas;

    /**
     *
     * @var integer
     * @Column(type="integer", length=6, nullable=true)
     */
    public $ps_id;

    /**
     *
     * @var integer
     * @Column(type="integer", length=6, nullable=false)
     */
    public $ps_allow;

    /**
     *
     * @var string
     * @Column(type="string", length=10, nullable=true)
     */
    public $kode_mk;

    /**
     *
     * @var string
     * @Column(type="string", length=60, nullable=true)
     */
    public $nama;

    /**
     *
     * @var integer
     * @Column(type="integer", length=4, nullable=true)
     */
    public $semester;

    /**
     *
     * @var integer
     * @Column(type="integer", length=4, nullable=true)
     */
    public $sks;

    /**
     *
     * @var string
     * @Column(type="string", length=1, nullable=true)
     */
    public $jenis;

    /**
     *
     * @var string
     * @Column(type="string", length=6, nullable=true)
     */
    public $kelompok;

    /**
     *
     * @var string
     * @Column(type="string", length=6, nullable=true)
     */
    public $thn_kur;

    /**
     *
     * @var string
     * @Column(type="string", length=200, nullable=true)
     */
    public $prasyt;

    /**
     *
     * @var string
     * @Column(type="string", length=230, nullable=true)
     */
    public $ps_mkstatus_prasyt_ang;

    /**
     *
     * @var string
     * @Column(type="string", length=230, nullable=true)
     */
    public $ps_mkkpkl_prasyt_ang;

    /**
     *
     * @var string
     * @Column(type="string", length=80, nullable=true)
     */
    public $st_nonsks_ang;

    /**
     *
     * @var string
     * @Column(type="string", length=80, nullable=true)
     */
    public $st_ambil_ang;

    /**
     *
     * @var string
     * @Column(type="string", nullable=true)
     */
    public $mkstatus_st_nonbatalmk;

    /**
     *
     * @var string
     * @Column(type="string", nullable=true)
     */
    public $mkkpkl_st_nonbatalmk;

    /**
     *
     * @var integer
     * @Column(type="integer", length=5, nullable=true)
     */
    public $kapasitas;

    /**
     *
     * @var integer
     * @Column(type="integer", length=5, nullable=true)
     */
    public $jml_mhs;

    /**
     *
     * @var integer
     * @Column(type="integer", length=4, nullable=true)
     */
    public $id;

    /**
     *
     * @var integer
     * @Column(type="integer", length=3, nullable=true)
     */
    public $hari;
    /**
     *
     * @var integer
     * @Column(type="integer", length=3, nullable=true)
     */
    public $nip_dosen;
    /**
     *
     * @var integer
     * @Column(type="integer", length=3, nullable=true)
     */
    public $nama_dosen;

    /**
     *
     * @var string
     * @Column(type="string", nullable=true)
     */
    public $jam_awal;

    /**
     *
     * @var string
     * @Column(type="string", nullable=true)
     */
    public $jam_akhir;

    /**
     *
     * @var string
     * @Column(type="string", length=20, nullable=true)
     */
    public $nama_ruang;

    /**
     *
     * @var string
     * @Column(type="string", nullable=true)
     */
    public $namadosen1;

    /**
     *
     * @var string
     * @Column(type="string", nullable=true)
     */
    public $namadosen2;

    /**
     *
     * @var string
     * @Column(type="string", nullable=true)
     */
    public $namadosen3;

    /**
     *
     * @var string
     * @Column(type="string", nullable=true)
     */
    public $namadosen4;

    /**
     *
     * @var string
     * @Column(type="string", nullable=true)
     */
    public $namadosen5;

    /**
     *
     * @var string
     * @Column(type="string", nullable=true)
     */
    public $namadosen6;

    /**
     *
     * @var string
     * @Column(type="string", nullable=true)
     */
    public $namadosen7;

    /**
     *
     * @var string
     * @Column(type="string", nullable=true)
     */
    public $namadosen8;

    /**
     *
     * @var string
     * @Column(type="string", nullable=true)
     */
    public $namadosen9;

    /**
     *
     * @var string
     * @Column(type="string", length=80, nullable=true)
     */
    public $limitkap_ang;

    /**
     * Returns table name mapped in the model.
     *
     * @return string
     */
    public function getSource()
    {
        return 'view_list_mk_krs';
    }

    /**
     * Allows to query a set of records that match the specified conditions
     *
     * @param mixed $parameters
     * @return ViewListMkKrs[]
     */
    public static function find($parameters = null)
    {
        return parent::find($parameters);
    }

    /**
     * Allows to query the first record that match the specified conditions
     *
     * @param mixed $parameters
     * @return ViewListMkKrs
     */
    public static function findFirst($parameters = null)
    {
        return parent::findFirst($parameters);
    }

    public function data_piew()
    {
        $cmd = "SELECT * from ViewListMkKrs group by kode_mk";
        return $this->modelsManager->executeQuery($cmd)->toArray();
    }

}
