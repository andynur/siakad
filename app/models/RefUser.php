<?php

class RefUser extends \Phalcon\Mvc\Model
{

    /**
     *
     * @var integer
     * @Primary
     * @Identity
     * @Column(type="integer", length=11, nullable=false)
     */
    public $Id;

    /**
     *
     * @var string
     * @Column(type="string", length=128, nullable=false)
     */
    public $Uid;

    /**
     *
     * @var string
     * @Column(type="string", length=500, nullable=false)
     */
    public $Nip;

    /**
     *
     * @var integer
     * @Column(type="integer", length=11, nullable=false)
     */
    public $Id_jenis;

    /**
     *
     * @var string
     * @Column(type="string", length=500, nullable=true)
     */
    public $Area;

    /**
     *
     * @var string
     * @Column(type="string", length=16, nullable=false)
     */
    public $Usergroup;

    /**
     *
     * @var string
     * @Column(type="string", length=128, nullable=true)
     */
    public $Passwd;

    /**
     *
     * @var string
     * @Column(type="string", length=50, nullable=true)
     */
    public $Nama;

    /**
     *
     * @var string
     * @Column(type="string", length=64, nullable=true)
     */
    public $Email;

    /**
     *
     * @var string
     * @Column(type="string", nullable=false)
     */
    public $Aktif;

    /**
     * Initialize method for model.
     */
    // public function initialize()
    // {
    //     $this->setSchema("sisko");
    //     $this->setSource("ref_user");
    // }

    /**
     * Allows to query a set of records that match the specified conditions
     *
     * @param mixed $parameters
     * @return RefUser[]
     */
    public static function find($parameters = null)
    {
        return parent::find($parameters);
    }

    /**
     * Allows to query the first record that match the specified conditions
     *
     * @param mixed $parameters
     * @return RefUser
     */
    public static function findFirst($parameters = null)
    {
        return parent::findFirst($parameters);
    }

    /**
     * Returns table name mapped in the model.
     *
     * @return string
     */
    public function getSource()
    {
        return 'ref_user';
    }

}
