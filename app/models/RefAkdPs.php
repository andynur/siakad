<?php

class RefAkdPs extends \Phalcon\Mvc\Model
{

    /**
     *
     * @var integer
     * @Primary
     * @Column(type="integer", length=8, nullable=false)
     */
    public $id_ps;

    /**
     *
     * @var integer
     * @Column(type="integer", length=8, nullable=false)
     */
    public $id_area;

    /**
     *
     * @var string
     * @Column(type="string", length=64, nullable=false)
     */
    public $nama;

    /**
     *
     * @var string
     * @Column(type="string", length=64, nullable=false)
     */
    public $nama_en;

    /**
     *
     * @var integer
     * @Column(type="integer", length=8, nullable=false)
     */
    public $id_jenjang;

    /**
     *
     * @var integer
     * @Column(type="integer", length=8, nullable=false)
     */
    public $id_jurusan;

    /**
     *
     * @var integer
     * @Column(type="integer", length=8, nullable=false)
     */
    public $id_fakultas;

    /**
     *
     * @var string
     * @Column(type="string", length=1, nullable=false)
     */
    public $id_aktif;

    /**
     *
     * @var string
     * @Column(type="string", length=5, nullable=false)
     */
    public $ext;

    /**
     *
     * @var string
     * @Column(type="string", length=16, nullable=false)
     */
    public $status;

    /**
     *
     * @var string
     * @Column(type="string", length=1, nullable=false)
     */
    public $grade_status;

    /**
     * Returns table name mapped in the model.
     *
     * @return string
     */
    public function getSource()
    {
        return 'ref_akd_ps';
    }

    /**
     * Allows to query a set of records that match the specified conditions
     *
     * @param mixed $parameters
     * @return RefAkdPs[]
     */
    public static function find($parameters = null)
    {
        return parent::find($parameters);
    }

    /**
     * Allows to query the first record that match the specified conditions
     *
     * @param mixed $parameters
     * @return RefAkdPs
     */
    public static function findFirst($parameters = null)
    {
        return parent::findFirst($parameters);
    }

}
