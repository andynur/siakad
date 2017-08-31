<?php

class RefAkdConfruang extends \Phalcon\Mvc\Model
{

    /**
     *
     * @var integer
     * @Primary
     * @Identity
     * @Column(type="integer", length=11, nullable=false)
     */
    public $conf_id;

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
     * @Column(type="integer", length=6, nullable=false)
     */
    public $ruang_id;

    /**
     *
     * @var string
     * @Column(type="string", length=100, nullable=false)
     */
    public $nama_conf;

    /**
     *
     * @var integer
     * @Column(type="integer", length=5, nullable=false)
     */
    public $volume;

    /**
     * Returns table name mapped in the model.
     *
     * @return string
     */
    public function getSource()
    {
        return 'ref_akd_confruang';
    }

    /**
     * Allows to query a set of records that match the specified conditions
     *
     * @param mixed $parameters
     * @return RefAkdConfruang[]
     */
    public static function find($parameters = null)
    {
        return parent::find($parameters);
    }

    /**
     * Allows to query the first record that match the specified conditions
     *
     * @param mixed $parameters
     * @return RefAkdConfruang
     */
    public static function findFirst($parameters = null)
    {
        return parent::findFirst($parameters);
    }

}
