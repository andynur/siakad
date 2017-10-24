<?php

class RefIklan extends \Phalcon\Mvc\Model
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
     * @Column(type="string", length=100, nullable=false)
     */
    public $Line1;

    /**
     *
     * @var string
     * @Column(type="string", length=100, nullable=false)
     */
    public $Line2;

    /**
     *
     * @var string
     * @Column(type="string", nullable=false)
     */
    public $Aktif;

    /**
     *
     * @var string
     * @Column(type="string", nullable=false)
     */
    public $Created_at;

    /**
     * Initialize method for model.
     */
    // public function initialize()
    // {
    //     $this->setSchema("sisko");
    //     $this->setSource("ref_iklan");
    // }

    /**
     * Allows to query a set of records that match the specified conditions
     *
     * @param mixed $parameters
     * @return RefIklan[]|RefIklan|\Phalcon\Mvc\Model\ResultSetInterface
     */
    public static function find($parameters = null)
    {
        return parent::find($parameters);
    }

    /**
     * Allows to query the first record that match the specified conditions
     *
     * @param mixed $parameters
     * @return RefIklan|\Phalcon\Mvc\Model\ResultInterface
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
        return 'ref_iklan';
    }

}
