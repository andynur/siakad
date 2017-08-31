<?php

class RefPresensi extends \Phalcon\Mvc\Model
{

    /**
     *
     * @var integer
     * @Primary
     * @Identity
     * @Column(type="integer", length=11, nullable=false)
     */
    public $Presensi_id;

    /**
     *
     * @var integer
     * @Column(type="integer", length=11, nullable=false)
     */
    public $Rombel_history_id;

    /**
     *
     * @var string
     * @Column(type="string", nullable=false)
     */
    public $Tanggal;

    /**
     *
     * @var string
     * @Column(type="string", nullable=false)
     */
    public $Waktu;

    /**
     *
     * @var string
     * @Column(type="string", nullable=false)
     */
    public $Tipe;

    /**
     *
     * @var integer
     * @Column(type="integer", length=11, nullable=false)
     */
    public $Peserta_didik_id;

    /**
     *
     * @var string
     * @Column(type="string", nullable=false)
     */
    public $Status_email;

    /**
     *
     * @var integer
     * @Column(type="integer", length=11, nullable=false)
     */
    public $Created_by;

    /**
     *
     * @var string
     * @Column(type="string", nullable=false)
     */
    public $Created_date;

    /**
     * Initialize method for model.
     */
    public function initialize()
    {
        $this->setSchema("siakad");
        $this->setSource("ref_presensi");
    }

    /**
     * Returns table name mapped in the model.
     *
     * @return string
     */
    public function getSource()
    {
        return 'ref_presensi';
    }

    /**
     * Allows to query a set of records that match the specified conditions
     *
     * @param mixed $parameters
     * @return RefPresensi[]|RefPresensi|\Phalcon\Mvc\Model\ResultSetInterface
     */
    public static function find($parameters = null)
    {
        return parent::find($parameters);
    }

    /**
     * Allows to query the first record that match the specified conditions
     *
     * @param mixed $parameters
     * @return RefPresensi|\Phalcon\Mvc\Model\ResultInterface
     */
    public static function findFirst($parameters = null)
    {
        return parent::findFirst($parameters);
    }

}
