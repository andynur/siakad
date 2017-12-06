<?php

class RefAkdSdm extends \Phalcon\Mvc\Model
{

    /**
     *
     * @var integer
     * @Primary
     * @Identity
     * @Column(type="integer", length=11, nullable=false)
     */
    public $Id_sdm;

    /**
     *
     * @var string
     * @Column(type="string", length=19, nullable=true)
     */
    public $Nip;

    /**
     *
     * @var string
     * @Column(type="string", length=19, nullable=true)
     */
    public $Nip_riil;

    /**
     *
     * @var integer
     * @Column(type="integer", length=11, nullable=true)
     */
    public $Id_ps;

    /**
     *
     * @var string
     * @Column(type="string", length=20, nullable=true)
     */
    public $Jenjang;

    /**
     *
     * @var string
     * @Column(type="string", nullable=true)
     */
    public $Nama;

    /**
     *
     * @var string
     * @Column(type="string", nullable=true)
     */
    public $Gelar;

    /**
     *
     * @var string
     * @Column(type="string", length=10, nullable=true)
     */
    public $Alias0;

    /**
     *
     * @var string
     * @Column(type="string", nullable=true)
     */
    public $E_mail;

    /**
     *
     * @var string
     * @Column(type="string", nullable=true)
     */
    public $Kelamin;

    /**
     *
     * @var string
     * @Column(type="string", nullable=true)
     */
    public $Alamat;

    /**
     *
     * @var string
     * @Column(type="string", length=50, nullable=true)
     */
    public $Kode_kota;

    /**
     *
     * @var string
     * @Column(type="string", length=50, nullable=true)
     */
    public $Kode_prop;

    /**
     *
     * @var string
     * @Column(type="string", length=5, nullable=true)
     */
    public $Kodepos;

    /**
     *
     * @var string
     * @Column(type="string", nullable=true)
     */
    public $Telpon;

    /**
     *
     * @var string
     * @Column(type="string", nullable=true)
     */
    public $Fax;

    /**
     *
     * @var string
     * @Column(type="string", nullable=true)
     */
    public $Tmp_lahir;

    /**
     *
     * @var string
     * @Column(type="string", nullable=true)
     */
    public $Tgl_lahir;

    /**
     *
     * @var string
     * @Column(type="string", nullable=true)
     */
    public $Gol_darah;

    /**
     *
     * @var string
     * @Column(type="string", length=1, nullable=true)
     */
    public $Kode_agama;

    /**
     *
     * @var string
     * @Column(type="string", length=30, nullable=true)
     */
    public $Kelp;

    /**
     *
     * @var string
     * @Column(type="string", length=16, nullable=true)
     */
    public $Nickname;

    /**
     *
     * @var string
     * @Column(type="string", nullable=true)
     */
    public $Gelar_dpn;

    /**
     *
     * @var string
     * @Column(type="string", nullable=true)
     */
    public $Gelar_blk;

    /**
     *
     * @var string
     * @Column(type="string", length=500, nullable=true)
     */
    public $Foto;

    /**
     *
     * @var string
     * @Column(type="string", length=5, nullable=true)
     */
    public $Id_status;

    /**
     *
     * @var string
     * @Column(type="string", nullable=true)
     */
    public $Created;

    /**
     *
     * @var string
     * @Column(type="string", length=16, nullable=true)
     */
    public $Nik;

    /**
     *
     * @var string
     * @Column(type="string", length=30, nullable=true)
     */
    public $Niy_nigk;

    /**
     *
     * @var string
     * @Column(type="string", length=16, nullable=true)
     */
    public $Nuptk;

    /**
     *
     * @var integer
     * @Column(type="integer", length=6, nullable=true)
     */
    public $Status_kepegawaian_id;

    /**
     *
     * @var double
     * @Column(type="double", length=2, nullable=true)
     */
    public $Jenis_ptk_id;

    /**
     *
     * @var integer
     * @Column(type="integer", length=11, nullable=true)
     */
    public $Pengawas_bidang_studi_id;

    /**
     *
     * @var string
     * @Column(type="string", length=20, nullable=true)
     */
    public $No_hp;

    /**
     *
     * @var integer
     * @Column(type="integer", length=11, nullable=true)
     */
    public $Entry_sekolah_id;

    /**
     *
     * @var double
     * @Column(type="double", length=2, nullable=true)
     */
    public $Status_keaktifan_id;

    /**
     *
     * @var string
     * @Column(type="string", length=50, nullable=true)
     */
    public $Sk_cpns;

    /**
     *
     * @var string
     * @Column(type="string", nullable=true)
     */
    public $Tgl_cpns;

    /**
     *
     * @var string
     * @Column(type="string", length=50, nullable=true)
     */
    public $Sk_pengangkatan;

    /**
     *
     * @var string
     * @Column(type="string", nullable=true)
     */
    public $Tmt_pengangkatan;

    /**
     *
     * @var double
     * @Column(type="double", length=2, nullable=true)
     */
    public $Lembaga_pengangkat_id;

    /**
     *
     * @var double
     * @Column(type="double", length=2, nullable=true)
     */
    public $Pangkat_golongan_id;

    /**
     *
     * @var integer
     * @Column(type="integer", length=6, nullable=true)
     */
    public $Keahlian_laboratorium_id;

    /**
     *
     * @var double
     * @Column(type="double", length=2, nullable=true)
     */
    public $Sumber_gaji_id;

    /**
     *
     * @var string
     * @Column(type="string", length=60, nullable=true)
     */
    public $Nama_ibu_kandung;

    /**
     *
     * @var double
     * @Column(type="double", length=1, nullable=true)
     */
    public $Status_perkawinan;

    /**
     *
     * @var string
     * @Column(type="string", length=60, nullable=true)
     */
    public $Nama_suami_istri;

    /**
     *
     * @var string
     * @Column(type="string", length=18, nullable=true)
     */
    public $Nip_suami_istri;

    /**
     *
     * @var integer
     * @Column(type="integer", length=11, nullable=true)
     */
    public $Pekerjaan_suami_istri;

    /**
     *
     * @var string
     * @Column(type="string", nullable=true)
     */
    public $Tmt_pns;

    /**
     *
     * @var double
     * @Column(type="double", length=1, nullable=true)
     */
    public $Sudah_lisensi_kepala_sekolah;

    /**
     *
     * @var integer
     * @Column(type="integer", length=6, nullable=true)
     */
    public $Jumlah_sekolah_binaan;

    /**
     *
     * @var double
     * @Column(type="double", length=1, nullable=true)
     */
    public $Pernah_diklat_kepengawasan;

    /**
     *
     * @var integer
     * @Column(type="integer", length=11, nullable=true)
     */
    public $Status_data;

    /**
     *
     * @var integer
     * @Column(type="integer", length=11, nullable=true)
     */
    public $Mampu_handle_kk;

    /**
     *
     * @var double
     * @Column(type="double", length=1, nullable=true)
     */
    public $Keahlian_braille;

    /**
     *
     * @var double
     * @Column(type="double", length=1, nullable=true)
     */
    public $Keahlian_bhs_isyarat;

    /**
     *
     * @var string
     * @Column(type="string", length=15, nullable=true)
     */
    public $Npwp;

    /**
     *
     * @var string
     * @Column(type="string", length=2, nullable=true)
     */
    public $Kewarganegaraan;

    /**
     * Initialize method for model.
     */
    // public function initialize()
    // {
    //     $this->setSchema("sisko");
    //     $this->setSource("ref_akd_sdm");
    // }

    /**
     * Allows to query a set of records that match the specified conditions
     *
     * @param mixed $parameters
     * @return RefAkdSdm[]
     */
    public static function find($parameters = null)
    {
        return parent::find($parameters);
    }

    /**
     * Allows to query the first record that match the specified conditions
     *
     * @param mixed $parameters
     * @return RefAkdSdm
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
        return 'ref_akd_sdm';
    }

}
