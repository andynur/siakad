<?php

class RefAkdMkkpklDosen extends \Phalcon\Mvc\Model
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
     * @Column(type="integer", length=11, nullable=true)
     */
    public $id_mkkpkl;

    /**
     *
     * @var string
     * @Column(type="string", length=128, nullable=true)
     */
    public $jenis;

    /**
     *
     * @var string
     * @Column(type="string", length=128, nullable=true)
     */
    public $nip;

    /**
     *
     * @var string
     * @Column(type="string", length=128, nullable=true)
     */
    public $sks;

    /**
     *
     * @var string
     * @Column(type="string", nullable=true)
     */
    public $aktif;

    /**
     * Returns table name mapped in the model.
     *
     * @return string
     */
    public function getSource()
    {
        return 'ref_akd_mkkpkl_dosen';
    }

    /**
     * Allows to query a set of records that match the specified conditions
     *
     * @param mixed $parameters
     * @return RefAkdMkkpklDosen[]
     */
    public static function find($parameters = null)
    {
        return parent::find($parameters);
    }

    /**
     * Allows to query the first record that match the specified conditions
     *
     * @param mixed $parameters
     * @return RefAkdMkkpklDosen
     */
    public static function findFirst($parameters = null)
    {
        return parent::findFirst($parameters);
    }

}
