<?php

class RefUserJenis extends \Phalcon\Mvc\Model
{

    /**
     *
     * @var integer
     * @Primary
     * @Column(type="integer", length=8, nullable=false)
     */
    public $Id_jenis;

    /**
     *
     * @var string
     * @Column(type="string", length=64, nullable=false)
     */
    public $Nama;

    /**
     *
     * @var string
     * @Column(type="string", length=1, nullable=false)
     */
    public $Id_aktif;

    /**
     * Initialize method for model.
     */
    public function initialize()
    {
        $this->setSchema("siakad");
        $this->setSource("ref_user_jenis");
    }

    /**
     * Returns table name mapped in the model.
     *
     * @return string
     */
    public function getSource()
    {
        return 'ref_user_jenis';
    }

    /**
     * Allows to query a set of records that match the specified conditions
     *
     * @param mixed $parameters
     * @return RefUserJenis[]|RefUserJenis|\Phalcon\Mvc\Model\ResultSetInterface
     */
    public static function find($parameters = null)
    {
        return parent::find($parameters);
    }

    /**
     * Allows to query the first record that match the specified conditions
     *
     * @param mixed $parameters
     * @return RefUserJenis|\Phalcon\Mvc\Model\ResultInterface
     */
    public static function findFirst($parameters = null)
    {
        return parent::findFirst($parameters);
    }

}
