<?php

class RefPengumuman extends \Phalcon\Mvc\Model
{

    /**
     *
     * @var integer
     * @Primary
     * @Identity
     * @Column(type="integer", length=11, nullable=false)
     */
    public $Pengumuman_id;

    /**
     *
     * @var string
     * @Column(type="string", length=100, nullable=false)
     */
    public $Judul;

    /**
     *
     * @var string
     * @Column(type="string", nullable=false)
     */
    public $Isi;

    /**
     *
     * @var string
     * @Column(type="string", nullable=false)
     */
    public $Tanggal;

    /**
     *
     * @var string
     * @Column(type="string", length=128, nullable=false)
     */
    public $Pengirim_uid;

    /**
     *
     * @var string
     * @Column(type="string", length=150, nullable=false)
     */
    public $Tujuan;

    /**
     *
     * @var string
     * @Column(type="string", nullable=false)
     */
    public $Status;

    /**
     *
     * @var string
     * @Column(type="string", nullable=false)
     */
    public $Created_at;

    /**
     * Initialize method for model.
     */
    public function initialize()
    {
        $this->setSchema("siakad");
        $this->setSource("ref_pengumuman");
    }

    /**
     * Returns table name mapped in the model.
     *
     * @return string
     */
    public function getSource()
    {
        return 'ref_pengumuman';
    }

    /**
     * Allows to query a set of records that match the specified conditions
     *
     * @param mixed $parameters
     * @return RefPengumuman[]|RefPengumuman|\Phalcon\Mvc\Model\ResultSetInterface
     */
    public static function find($parameters = null)
    {
        return parent::find($parameters);
    }

    /**
     * Allows to query the first record that match the specified conditions
     *
     * @param mixed $parameters
     * @return RefPengumuman|\Phalcon\Mvc\Model\ResultInterface
     */
    public static function findFirst($parameters = null)
    {
        return parent::findFirst($parameters);
    }

}
