<?php

class RefSysNilai extends \Phalcon\Mvc\Model
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
     * @Column(type="string", length=10, nullable=false)
     */
    public $nilai;

    /**
     *
     * @var string
     * @Column(type="string", length=11, nullable=false)
     */
    public $nilai_angka;

    /**
     * Returns table name mapped in the model.
     *
     * @return string
     */
    public function getSource()
    {
        return 'ref_sys_nilai';
    }

    /**
     * Allows to query a set of records that match the specified conditions
     *
     * @param mixed $parameters
     * @return RefSysNilai[]
     */
    public static function find($parameters = null)
    {
        return parent::find($parameters);
    }

    /**
     * Allows to query the first record that match the specified conditions
     *
     * @param mixed $parameters
     * @return RefSysNilai
     */
    public static function findFirst($parameters = null)
    {
        return parent::findFirst($parameters);
    }

}
