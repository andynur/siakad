<?php

class RefLembagaPengangkat extends \Phalcon\Mvc\Model
{

    /**
     *
     * @var integer
     * @Primary
     * @Identity
     * @Column(type="integer", length=2, nullable=false)
     */
    public $Lembaga_pengangkat_id;

    /**
     *
     * @var string
     * @Column(type="string", length=80, nullable=false)
     */
    public $Nama;

    /**
     *
     * @var string
     * @Column(type="string", nullable=false)
     */
    public $Create_date;

    /**
     *
     * @var string
     * @Column(type="string", nullable=false)
     */
    public $Last_update;

    /**
     *
     * @var string
     * @Column(type="string", nullable=false)
     */
    public $Expired_date;

    /**
     *
     * @var string
     * @Column(type="string", nullable=false)
     */
    public $Last_sync;

    /**
     * Initialize method for model.
     */
    // public function initialize()
    // {
    //     $this->setSchema("siakad");
    //     $this->setSource("ref_lembaga_pengangkat");
    // }

    /**
     * Returns table name mapped in the model.
     *
     * @return string
     */
    public function getSource()
    {
        return 'ref_lembaga_pengangkat';
    }

    /**
     * Allows to query a set of records that match the specified conditions
     *
     * @param mixed $parameters
     * @return RefLembagaPengangkat[]|RefLembagaPengangkat|\Phalcon\Mvc\Model\ResultSetInterface
     */
    public static function find($parameters = null)
    {
        return parent::find($parameters);
    }

    /**
     * Allows to query the first record that match the specified conditions
     *
     * @param mixed $parameters
     * @return RefLembagaPengangkat|\Phalcon\Mvc\Model\ResultInterface
     */
    public static function findFirst($parameters = null)
    {
        return parent::findFirst($parameters);
    }

}
