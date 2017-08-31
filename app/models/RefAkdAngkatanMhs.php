<?php

class RefAkdAngkatanMhs extends \Phalcon\Mvc\Model
{

    /**
     *
     * @var integer
     * @Primary
     * @Column(type="integer", length=5, nullable=false)
     */
    public $psmhs_id;

    /**
     *
     * @var integer
     * @Primary
     * @Column(type="integer", length=10, nullable=false)
     */
    public $angkatan_id;

    /**
     *
     * @var string
     * @Column(type="string", length=30, nullable=false)
     */
    public $angkatan_nm;

    /**
     *
     * @var string
     * @Column(type="string", nullable=false)
     */
    public $tgl_masuk;

    /**
     * Returns table name mapped in the model.
     *
     * @return string
     */
    public function getSource()
    {
        return 'ref_akd_angkatan_mhs';
    }

    /**
     * Allows to query a set of records that match the specified conditions
     *
     * @param mixed $parameters
     * @return RefAkdAngkatanMhs[]
     */
    public static function find($parameters = null)
    {
        return parent::find($parameters);
    }

    /**
     * Allows to query the first record that match the specified conditions
     *
     * @param mixed $parameters
     * @return RefAkdAngkatanMhs
     */
    public static function findFirst($parameters = null)
    {
        return parent::findFirst($parameters);
    }

}
