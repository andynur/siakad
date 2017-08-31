<?php

class RefSysFakultas extends \Phalcon\Mvc\Model
{

    /**
     *
     * @var integer
     * @Primary
     * @Column(type="integer", length=11, nullable=false)
     */
    public $id_fakultas;

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
        return 'ref_sys_fakultas';
    }

    /**
     * Allows to query a set of records that match the specified conditions
     *
     * @param mixed $parameters
     * @return RefSysFakultas[]
     */
    public static function find($parameters = null)
    {
        return parent::find($parameters);
    }

    /**
     * Allows to query the first record that match the specified conditions
     *
     * @param mixed $parameters
     * @return RefSysFakultas
     */
    public static function findFirst($parameters = null)
    {
        return parent::findFirst($parameters);
    }

}
