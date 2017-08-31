<?php

class RefBerita extends \Phalcon\Mvc\Model
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
     * @Column(type="string", length=256, nullable=true)
     */
    public $judul;

    /**
     *
     * @var string
     * @Column(type="string", nullable=false)
     */
    public $berita;

    /**
     *
     * @var string
     * @Column(type="string", nullable=true)
     */
    public $jenis;

    /**
     *
     * @var string
     * @Column(type="string", nullable=false)
     */
    public $tampil;

    /**
     *
     * @var string
     * @Column(type="string", nullable=false)
     */
    public $created;

    /**
     * Returns table name mapped in the model.
     *
     * @return string
     */
    public function getSource()
    {
        return 'ref_berita';
    }

    /**
     * Allows to query a set of records that match the specified conditions
     *
     * @param mixed $parameters
     * @return RefBerita[]
     */
    public static function find($parameters = null)
    {
        return parent::find($parameters);
    }

    /**
     * Allows to query the first record that match the specified conditions
     *
     * @param mixed $parameters
     * @return RefBerita
     */
    public static function findFirst($parameters = null)
    {
        return parent::findFirst($parameters);
    }

}
