<?php

class RefAkdRekapsemester extends \Phalcon\Mvc\Model
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
     * @var string
     * @Primary
     * @Column(type="string", length=25, nullable=false)
     */
    public $nomhs;

    /**
     *
     * @var integer
     * @Primary
     * @Column(type="integer", length=6, nullable=false)
     */
    public $psmhs_id;

    /**
     *
     * @var integer
     * @Column(type="integer", length=5, nullable=false)
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
     * @var double
     * @Column(type="double", length=4, nullable=false)
     */
    public $ipk;

    /**
     *
     * @var double
     * @Column(type="double", length=4, nullable=false)
     */
    public $ips;

    /**
     *
     * @var integer
     * @Column(type="integer", length=6, nullable=false)
     */
    public $skskum;

    /**
     *
     * @var integer
     * @Column(type="integer", length=4, nullable=false)
     */
    public $skssem;

    /**
     *
     * @var integer
     * @Column(type="integer", length=3, nullable=false)
     */
    public $sksriil;

    /**
     * Returns table name mapped in the model.
     *
     * @return string
     */
    public function getSource()
    {
        return 'ref_akd_rekapsemester';
    }

    /**
     * Allows to query a set of records that match the specified conditions
     *
     * @param mixed $parameters
     * @return RefAkdRekapsemester[]
     */
    public static function find($parameters = null)
    {
        return parent::find($parameters);
    }

    /**
     * Allows to query the first record that match the specified conditions
     *
     * @param mixed $parameters
     * @return RefAkdRekapsemester
     */
    public static function findFirst($parameters = null)
    {
        return parent::findFirst($parameters);
    }

}
