<?php

class ViewUser extends \Phalcon\Mvc\Model
{

    /**
     *
     * @var integer
     * @Column(type="integer", length=11, nullable=false)
     */
    public $id_jenis;

    /**
     *
     * @var string
     * @Column(type="string", length=128, nullable=false)
     */
    public $login;

    /**
     *
     * @var string
     * @Column(type="string", length=32, nullable=true)
     */
    public $nip;

    /**
     *
     * @var string
     * @Column(type="string", nullable=true)
     */
    public $nama;

    /**
     *
     * @var string
     * @Column(type="string", length=500, nullable=true)
     */
    public $foto;

    /**
     *
     * @var string
     * @Column(type="string", length=11, nullable=true)
     */
    public $id_ps;

    /**
     *
     * @var string
     * @Column(type="string", length=11, nullable=true)
     */
    public $id_status;

    /**
     * Returns table name mapped in the model.
     *
     * @return string
     */
    public function getSource()
    {
        return 'view_user';
    }

    /**
     * Allows to query a set of records that match the specified conditions
     *
     * @param mixed $parameters
     * @return ViewUser[]
     */
    public static function find($parameters = null)
    {
        return parent::find($parameters);
    }

    /**
     * Allows to query the first record that match the specified conditions
     *
     * @param mixed $parameters
     * @return ViewUser
     */
    public static function findFirst($parameters = null)
    {
        return parent::findFirst($parameters);
    }

}
