<?php

class RefAkdStatus extends \Phalcon\Mvc\Model
{

    /**
     *
     * @var integer
     * @Primary
     * @Column(type="integer", length=8, nullable=false)
     */
    public $id_status;

    /**
     *
     * @var string
     * @Column(type="string", length=64, nullable=false)
     */
    public $nama;

    /**
     *
     * @var string
     * @Column(type="string", length=1, nullable=false)
     */
    public $aktif;

    /**
     *
     * @var string
     * @Column(type="string", length=1, nullable=false)
     */
    public $id_aktif;

    /**
     *
     * @var string
     * @Column(type="string", length=4, nullable=true)
     */
    public $id_status_keu;

    /**
     * Initialize method for model.
     */
    // public function initialize()
    // {
    //     $this->setSchema("siakad");
    // }

    /**
     * Returns table name mapped in the model.
     *
     * @return string
     */
    public function getSource()
    {
        return 'ref_akd_status';
    }

    /**
     * Allows to query a set of records that match the specified conditions
     *
     * @param mixed $parameters
     * @return RefAkdMhsStatus[]|RefAkdMhsStatus
     */
    public static function find($parameters = null)
    {
        return parent::find($parameters);
    }

    /**
     * Allows to query the first record that match the specified conditions
     *
     * @param mixed $parameters
     * @return RefAkdMhsStatus
     */
    public static function findFirst($parameters = null)
    {
        return parent::findFirst($parameters);
    }

}
