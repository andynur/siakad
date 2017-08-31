<?php

class RefAkdRuang extends \Phalcon\Mvc\Model
{

    /**
     *
     * @var integer
     * @Column(type="integer", length=6, nullable=false)
     */
    public $ps_id;

    /**
     *
     * @var integer
     * @Primary
     * @Identity
     * @Column(type="integer", length=5, nullable=false)
     */
    public $ruang_id;

    /**
     *
     * @var string
     * @Column(type="string", length=20, nullable=false)
     */
    public $nama_ruang;

    /**
     *
     * @var string
     * @Column(type="string", nullable=false)
     */
    public $publik;

    /**
     *
     * @var integer
     * @Column(type="integer", length=10, nullable=true)
     */
    public $shareps_id;

    /**
     *
     * @var integer
     * @Column(type="integer", length=10, nullable=true)
     */
    public $shareruang_id;

    /**
     *
     * @var string
     * @Column(type="string", length=100, nullable=false)
     */
    public $sharedb;

    /**
     * Returns table name mapped in the model.
     *
     * @return string
     */
    public function getSource()
    {
        return 'ref_akd_ruang';
    }

    /**
     * Allows to query a set of records that match the specified conditions
     *
     * @param mixed $parameters
     * @return RefAkdRuang[]
     */
    public static function find($parameters = null)
    {
        return parent::find($parameters);
    }

    /**
     * Allows to query the first record that match the specified conditions
     *
     * @param mixed $parameters
     * @return RefAkdRuang
     */
    public static function findFirst($parameters = null)
    {
        return parent::findFirst($parameters);
    }

}
