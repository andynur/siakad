<?php

class RefAkdMkkpkl extends \Phalcon\Mvc\Model
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
     * @Column(type="string", length=10, nullable=false)
     */
    public $nama_kelas;

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
     * @var integer
     * @Column(type="integer", length=5, nullable=false)
     */
    public $kapasitas;

    /**
     *
     * @var integer
     * @Column(type="integer", length=5, nullable=false)
     */
    public $jml_mhs;

    /**
     *
     * @var integer
     * @Column(type="integer", length=5, nullable=false)
     */
    public $st_gab;

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
    public $st_nonbatalmk;

    /**
     *
     * @var integer
     * @Column(type="integer", length=4, nullable=false)
     */
    public $jmlkuliah;

    /**
     *
     * @var string
     * @Column(type="string", nullable=false)
     */
    public $inputnilai0;

    /**
     *
     * @var string
     * @Column(type="string", nullable=false)
     */
    public $inputnilai1;

    /**
     *
     * @var integer
     * @Column(type="integer", length=6, nullable=false)
     */
    public $fid;

    /**
     *
     * @var integer
     * @Column(type="integer", length=6, nullable=false)
     */
    public $orgfid;

    /**
     * Returns table name mapped in the model.
     *
     * @return string
     */
    public function getSource()
    {
        return 'ref_akd_mkkpkl';
    }

    /**
     * Allows to query a set of records that match the specified conditions
     *
     * @param mixed $parameters
     * @return RefAkdMkkpkl[]
     */
    public static function find($parameters = null)
    {
        return parent::find($parameters);
    }

    /**
     * Allows to query the first record that match the specified conditions
     *
     * @param mixed $parameters
     * @return RefAkdMkkpkl
     */
    public static function findFirst($parameters = null)
    {
        return parent::findFirst($parameters);
    }

}
