<?php

class RefKurikulum extends \Phalcon\Mvc\Model
{

    /**
     *
     * @var integer
     * @Primary
     * @Identity
     * @Column(type="integer", length=2, nullable=false)
     */
    public $Kurikulum_id;

    /**
     *
     * @var string
     * @Column(type="string", length=120, nullable=false)
     */
    public $Nama_kurikulum;

    /**
     *
     * @var string
     * @Column(type="string", nullable=false)
     */
    public $Mulai_berlaku;

    /**
     *
     * @var integer
     * @Column(type="integer", length=11, nullable=false)
     */
    public $Sistem_sks;

    /**
     *
     * @var integer
     * @Column(type="integer", length=11, nullable=false)
     */
    public $Total_sks;

    /**
     *
     * @var integer
     * @Column(type="integer", length=11, nullable=false)
     */
    public $Jenjang_pendidikan_id;

    /**
     *
     * @var string
     * @Column(type="string", length=25, nullable=true)
     */
    public $Jurusan_id;

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
    //     $this->setSource("ref_kurikulum");
    // }

    /**
     * Returns table name mapped in the model.
     *
     * @return string
     */
    public function getSource()
    {
        return 'ref_kurikulum';
    }

    /**
     * Allows to query a set of records that match the specified conditions
     *
     * @param mixed $parameters
     * @return RefKurikulum[]|RefKurikulum|\Phalcon\Mvc\Model\ResultSetInterface
     */
    public static function find($parameters = null)
    {
        return parent::find($parameters);
    }

    /**
     * Allows to query the first record that match the specified conditions
     *
     * @param mixed $parameters
     * @return RefKurikulum|\Phalcon\Mvc\Model\ResultInterface
     */
    public static function findFirst($parameters = null)
    {
        return parent::findFirst($parameters);
    }

}
