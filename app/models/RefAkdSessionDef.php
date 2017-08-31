<?php

class RefAkdSessionDef extends \Phalcon\Mvc\Model
{

    /**
     *
     * @var string
     * @Primary
     * @Column(type="string", length=3, nullable=false)
     */
    public $session_cd;

    /**
     *
     * @var string
     * @Column(type="string", nullable=false)
     */
    public $nama_session;

    /**
     *
     * @var string
     * @Column(type="string", length=4, nullable=false)
     */
    public $urut;

    /**
     * Returns table name mapped in the model.
     *
     * @return string
     */
    public function getSource()
    {
        return 'ref_akd_session_def';
    }

    /**
     * Allows to query a set of records that match the specified conditions
     *
     * @param mixed $parameters
     * @return RefAkdSessionDef[]
     */
    public static function find($parameters = null)
    {
        return parent::find($parameters);
    }

    /**
     * Allows to query the first record that match the specified conditions
     *
     * @param mixed $parameters
     * @return RefAkdSessionDef
     */
    public static function findFirst($parameters = null)
    {
        return parent::findFirst($parameters);
    }

}
