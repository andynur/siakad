<?php

class RefTingkatPendidikan extends \Phalcon\Mvc\Model
{

    /**
     *
     * @var integer
     * @Primary
     * @Identity
     * @Column(type="integer", length=11, nullable=false)
     */
    public $Tingkat_pendidikan_id;

    /**
     *
     * @var integer
     * @Column(type="integer", length=11, nullable=false)
     */
    public $Jenjang_pendidikan_id;

    /**
     *
     * @var string
     * @Column(type="string", length=5, nullable=false)
     */
    public $Kode;

    /**
     *
     * @var string
     * @Column(type="string", length=20, nullable=false)
     */
    public $Nama;

    /**
     *
     * @var string
     * @Column(type="string", length=6, nullable=false)
     */
    public $Create_date;

    /**
     *
     * @var string
     * @Column(type="string", length=6, nullable=false)
     */
    public $Last_update;

    /**
     *
     * @var string
     * @Column(type="string", length=6, nullable=false)
     */
    public $Expired_date;

    /**
     *
     * @var string
     * @Column(type="string", length=6, nullable=false)
     */
    public $Last_sync;

    /**
     * Initialize method for model.
     */
    // public function initialize()
    // {
    //     $this->setSchema("siakad");
    //     $this->setSource("ref_tingkat_pendidikan");
    // }

    /**
     * Returns table name mapped in the model.
     *
     * @return string
     */
    public function getSource()
    {
        return 'ref_tingkat_pendidikan';
    }

    /**
     * Allows to query a set of records that match the specified conditions
     *
     * @param mixed $parameters
     * @return RefTingkatPendidikan[]|RefTingkatPendidikan|\Phalcon\Mvc\Model\ResultSetInterface
     */
    public static function find($parameters = null)
    {
        return parent::find($parameters);
    }

    /**
     * Allows to query the first record that match the specified conditions
     *
     * @param mixed $parameters
     * @return RefTingkatPendidikan|\Phalcon\Mvc\Model\ResultInterface
     */
    public static function findFirst($parameters = null)
    {
        return parent::findFirst($parameters);
    }

}
