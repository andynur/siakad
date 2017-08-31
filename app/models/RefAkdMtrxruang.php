<?php

class RefAkdMtrxruang extends \Phalcon\Mvc\Model
{

    /**
     *
     * @var integer
     * @Primary
     * @Column(type="integer", length=6, nullable=false)
     */
    public $ps_id;

    /**
     *
     * @var integer
     * @Primary
     * @Column(type="integer", length=5, nullable=false)
     */
    public $ruang_id;

    /**
     *
     * @var integer
     * @Primary
     * @Column(type="integer", length=5, nullable=false)
     */
    public $conf_id;

    /**
     *
     * @var integer
     * @Primary
     * @Column(type="integer", length=5, nullable=false)
     */
    public $no_kursi;

    /**
     *
     * @var integer
     * @Column(type="integer", length=5, nullable=false)
     */
    public $x;

    /**
     *
     * @var integer
     * @Column(type="integer", length=5, nullable=false)
     */
    public $y;

    /**
     *
     * @var string
     * @Column(type="string", length=10, nullable=false)
     */
    public $nama_kursi;

    /**
     * Returns table name mapped in the model.
     *
     * @return string
     */
    public function getSource()
    {
        return 'ref_akd_mtrxruang';
    }

    /**
     * Allows to query a set of records that match the specified conditions
     *
     * @param mixed $parameters
     * @return RefAkdMtrxruang[]
     */
    public static function find($parameters = null)
    {
        return parent::find($parameters);
    }

    /**
     * Allows to query the first record that match the specified conditions
     *
     * @param mixed $parameters
     * @return RefAkdMtrxruang
     */
    public static function findFirst($parameters = null)
    {
        return parent::findFirst($parameters);
    }

}
