<?php

class ViewNipMkkpkl extends \Phalcon\Mvc\Model
{

    /**
     *
     * @var string
     * @Column(type="string", length=4, nullable=false)
     */
    public $thn_akd;

    /**
     *
     * @var string
     * @Column(type="string", length=3, nullable=false)
     */
    public $session_id;

    /**
     *
     * @var string
     * @Column(type="string", length=10, nullable=false)
     */
    public $kode_mk;

    /**
     *
     * @var string
     * @Column(type="string", length=10, nullable=false)
     */
    public $nama_kelas;

    /**
     *
     * @var integer
     * @Column(type="integer", length=6, nullable=false)
     */
    public $ps_id;

    /**
     *
     * @var string
     * @Column(type="string", length=128, nullable=true)
     */
    public $nip1;

    /**
     *
     * @var string
     * @Column(type="string", length=128, nullable=true)
     */
    public $nip2;

    /**
     *
     * @var string
     * @Column(type="string", length=128, nullable=true)
     */
    public $nip3;

    /**
     *
     * @var string
     * @Column(type="string", length=128, nullable=true)
     */
    public $nip4;

    /**
     *
     * @var string
     * @Column(type="string", length=128, nullable=true)
     */
    public $nip5;

    /**
     *
     * @var string
     * @Column(type="string", length=128, nullable=true)
     */
    public $nip6;

    /**
     *
     * @var string
     * @Column(type="string", length=128, nullable=true)
     */
    public $nip7;

    /**
     *
     * @var string
     * @Column(type="string", length=128, nullable=true)
     */
    public $nip8;

    /**
     *
     * @var string
     * @Column(type="string", length=128, nullable=true)
     */
    public $nip9;

    /**
     *
     * @var string
     * @Column(type="string", nullable=true)
     */
    public $namadosen1;

    /**
     *
     * @var string
     * @Column(type="string", nullable=true)
     */
    public $namadosen2;

    /**
     *
     * @var string
     * @Column(type="string", nullable=true)
     */
    public $namadosen3;

    /**
     *
     * @var string
     * @Column(type="string", nullable=true)
     */
    public $namadosen4;

    /**
     *
     * @var string
     * @Column(type="string", nullable=true)
     */
    public $namadosen5;

    /**
     *
     * @var string
     * @Column(type="string", nullable=true)
     */
    public $namadosen6;

    /**
     *
     * @var string
     * @Column(type="string", nullable=true)
     */
    public $namadosen7;

    /**
     *
     * @var string
     * @Column(type="string", nullable=true)
     */
    public $namadosen8;

    /**
     *
     * @var string
     * @Column(type="string", nullable=true)
     */
    public $namadosen9;

    /**
     * Returns table name mapped in the model.
     *
     * @return string
     */
    public function getSource()
    {
        return 'view_nip_mkkpkl';
    }

    /**
     * Allows to query a set of records that match the specified conditions
     *
     * @param mixed $parameters
     * @return ViewNipMkkpkl[]
     */
    public static function find($parameters = null)
    {
        return parent::find($parameters);
    }

    /**
     * Allows to query the first record that match the specified conditions
     *
     * @param mixed $parameters
     * @return ViewNipMkkpkl
     */
    public static function findFirst($parameters = null)
    {
        return parent::findFirst($parameters);
    }

}
