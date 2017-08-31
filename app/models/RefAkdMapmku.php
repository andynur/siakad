<?php

class RefAkdMapmku extends \Phalcon\Mvc\Model
{

    /**
     *
     * @var integer
     * @Primary
     * @Identity
     * @Column(type="integer", length=11, nullable=false)
     */
    public $map_id;

    /**
     *
     * @var integer
     * @Column(type="integer", length=6, nullable=false)
     */
    public $ps_idA;

    /**
     *
     * @var integer
     * @Column(type="integer", length=6, nullable=false)
     */
    public $ps_idB;

    /**
     *
     * @var string
     * @Column(type="string", length=8, nullable=false)
     */
    public $kurA;

    /**
     *
     * @var string
     * @Column(type="string", length=8, nullable=false)
     */
    public $kurB;

    /**
     *
     * @var string
     * @Column(type="string", length=10, nullable=true)
     */
    public $mkA0;

    /**
     *
     * @var string
     * @Column(type="string", length=10, nullable=true)
     */
    public $mkA1;

    /**
     *
     * @var string
     * @Column(type="string", length=10, nullable=true)
     */
    public $mkA2;

    /**
     *
     * @var string
     * @Column(type="string", length=10, nullable=true)
     */
    public $mkB0;

    /**
     *
     * @var string
     * @Column(type="string", length=10, nullable=true)
     */
    public $mkB1;

    /**
     *
     * @var string
     * @Column(type="string", length=10, nullable=true)
     */
    public $mkB2;

    /**
     *
     * @var string
     * @Column(type="string", nullable=true)
     */
    public $catatan;

    /**
     * Returns table name mapped in the model.
     *
     * @return string
     */
    public function getSource()
    {
        return 'ref_akd_mapmku';
    }

    /**
     * Allows to query a set of records that match the specified conditions
     *
     * @param mixed $parameters
     * @return RefAkdMapmku[]
     */
    public static function find($parameters = null)
    {
        return parent::find($parameters);
    }

    /**
     * Allows to query the first record that match the specified conditions
     *
     * @param mixed $parameters
     * @return RefAkdMapmku
     */
    public static function findFirst($parameters = null)
    {
        return parent::findFirst($parameters);
    }

}
