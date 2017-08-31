<?php

class RefAkdMhsJatahMk extends \Phalcon\Mvc\Model
{

    /**
     *
     * @var integer
     * @Primary
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
     * @Column(type="integer", length=6, nullable=false)
     */
    public $ol_id;

    /**
     *
     * @var integer
     * @Primary
     * @Column(type="integer", length=6, nullable=false)
     */
    public $psmhs_id;

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
     * @Column(type="integer", length=4, nullable=false)
     */
    public $mkmax;

    /**
     *
     * @var integer
     * @Column(type="integer", length=4, nullable=false)
     */
    public $mkbarumax;

    /**
     *
     * @var integer
     * @Column(type="integer", length=4, nullable=false)
     */
    public $mkulangmax;

    /**
     *
     * @var integer
     * @Column(type="integer", length=4, nullable=false)
     */
    public $sksmax;

    /**
     *
     * @var integer
     * @Column(type="integer", length=4, nullable=false)
     */
    public $sksbarumax;

    /**
     *
     * @var integer
     * @Column(type="integer", length=4, nullable=false)
     */
    public $sksulangmax;

    /**
     *
     * @var integer
     * @Column(type="integer", length=4, nullable=false)
     */
    public $mkpenalti;

    /**
     *
     * @var integer
     * @Column(type="integer", length=4, nullable=false)
     */
    public $skspenalti;

    /**
     *
     * @var string
     * @Column(type="string", nullable=false)
     */
    public $tglol1;

    /**
     * Returns table name mapped in the model.
     *
     * @return string
     */
    public function getSource()
    {
        return 'ref_akd_mhs_jatah_mk';
    }

    /**
     * Allows to query a set of records that match the specified conditions
     *
     * @param mixed $parameters
     * @return RefAkdMhsJatahMk[]
     */
    public static function find($parameters = null)
    {
        return parent::find($parameters);
    }

    /**
     * Allows to query the first record that match the specified conditions
     *
     * @param mixed $parameters
     * @return RefAkdMhsJatahMk
     */
    public static function findFirst($parameters = null)
    {
        return parent::findFirst($parameters);
    }

}
