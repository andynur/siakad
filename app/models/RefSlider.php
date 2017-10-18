<?php

class RefSlider extends \Phalcon\Mvc\Model
{

    /**
     *
     * @var integer
     * @Primary
     * @Identity
     * @Column(type="integer", length=11, nullable=false)
     */
    public $Id;

    /**
     *
     * @var string
     * @Column(type="string", length=500, nullable=false)
     */
    public $Nama;

    /**
     *
     * @var string
     * @Column(type="string", length=30, nullable=false)
     */
    public $Judul;

    /**
     *
     * @var string
     * @Column(type="string", length=60, nullable=false)
     */
    public $Deskripsi;

    /**
     *
     * @var string
     * @Column(type="string", nullable=false)
     */
    public $Aktif;

    /**
     *
     * @var string
     * @Column(type="string", nullable=false)
     */
    public $Created;

    /**
     * Initialize method for model.
     */
    // public function initialize()
    // {
    //     $this->setSchema("siakad");
    //     $this->setSource("ref_slider");
    // }

    /**
     * Allows to query a set of records that match the specified conditions
     *
     * @param mixed $parameters
     * @return RefSlider[]
     */
    public static function find($parameters = null)
    {
        return parent::find($parameters);
    }

    /**
     * Allows to query the first record that match the specified conditions
     *
     * @param mixed $parameters
     * @return RefSlider
     */
    public static function findFirst($parameters = null)
    {
        return parent::findFirst($parameters);
    }

    /**
     * Returns table name mapped in the model.
     *
     * @return string
     */
    public function getSource()
    {
        return 'ref_slider';
    }

}
