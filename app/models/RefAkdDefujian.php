<?php

class RefAkdDefujian extends \Phalcon\Mvc\Model
{

    /**
     *
     * @var integer
     * @Primary
     * @Identity
     * @Column(type="integer", length=11, nullable=false)
     */
    public $id;

    /**
     *
     * @var integer
     * @Primary
     * @Column(type="integer", length=6, nullable=false)
     */
    public $ps_id;

    /**
     *
     * @var string
     * @Primary
     * @Column(type="string", length=4, nullable=false)
     */
    public $thn_akd;

    /**
     *
     * @var string
     * @Primary
     * @Column(type="string", length=3, nullable=false)
     */
    public $session_id;

    /**
     *
     * @var integer
     * @Primary
     * @Column(type="integer", length=4, nullable=false)
     */
    public $ujian_id;

    /**
     *
     * @var string
     * @Column(type="string", nullable=true)
     */
    public $nama_long;

    /**
     *
     * @var string
     * @Column(type="string", nullable=true)
     */
    public $nama_sort;

    /**
     * Returns table name mapped in the model.
     *
     * @return string
     */
    public function getSource()
    {
        return 'ref_akd_defujian';
    }

    /**
     * Allows to query a set of records that match the specified conditions
     *
     * @param mixed $parameters
     * @return RefAkdDefujian[]
     */
    public static function find($parameters = null)
    {
        return parent::find($parameters);
    }

    /**
     * Allows to query the first record that match the specified conditions
     *
     * @param mixed $parameters
     * @return RefAkdDefujian
     */
    public static function findFirst($parameters = null)
    {
        return parent::findFirst($parameters);
    }

}
