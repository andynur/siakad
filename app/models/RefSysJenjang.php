<?php

class RefSysJenjang extends \Phalcon\Mvc\Model
{

    /**
     *
     * @var integer
     * @Primary
     * @Identity
     * @Column(type="integer", length=11, nullable=false)
     */
    public $id_jenjang;

    /**
     *
     * @var string
     * @Column(type="string", length=64, nullable=false)
     */
    public $nama;

    /**
     *
     * @var string
     * @Column(type="string", length=64, nullable=true)
     */
    public $nama_en;

    /**
     *
     * @var string
     * @Column(type="string", nullable=false)
     */
    public $aktif;

    /**
     * Returns table name mapped in the model.
     *
     * @return string
     */
    public function getSource()
    {
        return 'ref_sys_jenjang';
    }

    /**
     * Allows to query a set of records that match the specified conditions
     *
     * @param mixed $parameters
     * @return RefSysJenjang[]
     */
    public static function find($parameters = null)
    {
        return parent::find($parameters);
    }

    /**
     * Allows to query the first record that match the specified conditions
     *
     * @param mixed $parameters
     * @return RefSysJenjang
     */
    public static function findFirst($parameters = null)
    {
        return parent::findFirst($parameters);
    }

}
