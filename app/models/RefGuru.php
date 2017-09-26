<?php

use Phalcon\Validation;
use Phalcon\Validation\Validator\Email as EmailValidator;

class RefGuru extends \Phalcon\Mvc\Model
{

    /**
     *
     * @var integer
     * @Primary
     * @Identity
     * @Column(type="integer", length=11, nullable=false)
     */
    public $Ptk_id;

    /**
     *
     * @var string
     * @Column(type="string", length=60, nullable=false)
     */
    public $Nama;

    /**
     *
     * @var string
     * @Column(type="string", length=18, nullable=true)
     */
    public $Nip;

    /**
     *
     * @var string
     * @Column(type="string", length=1, nullable=false)
     */
    public $Jenis_kelamin;

    /**
     *
     * @var string
     * @Column(type="string", length=32, nullable=false)
     */
    public $Tempat_lahir;

    /**
     *
     * @var string
     * @Column(type="string", nullable=false)
     */
    public $Tanggal_lahir;

    /**
     *
     * @var string
     * @Column(type="string", length=16, nullable=false)
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
     * @Column(type="integer", length=4, nullable=false)
     */
    public $Status_kepegawaian_id;

    /**
     *
     * @var integer
     * @Column(type="integer", length=11, nullable=false)
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
     * @var integer
     * @Column(type="integer", length=4, nullable=false)
     */
    public $Agama_id;

    /**
     *
     * @var string
     * @Column(type="string", length=80, nullable=false)
     */
    public $Alamat_jalan;

    /**
     *
     * @var integer
     * @Column(type="integer", length=11, nullable=true)
     */
    public $Rt;

    /**
     *
     * @var integer
     * @Column(type="integer", length=11, nullable=true)
     */
    public $Rw;

    /**
     *
     * @var string
     * @Column(type="string", length=50, nullable=true)
     */
    public $Nama_dusun;

    /**
     *
     * @var string
     * @Column(type="string", length=50, nullable=false)
     */
    public $Desa_kelurahan;

    /**
     *
     * @var string
     * @Column(type="string", length=8, nullable=false)
     */
    public $Kode_wilayah;

    /**
     *
     * @var string
     * @Column(type="string", length=5, nullable=true)
     */
    public $Kode_pos;

    /**
     *
     * @var string
     * @Column(type="string", length=20, nullable=true)
     */
    public $No_telepon_rumah;

    /**
     *
     * @var string
     * @Column(type="string", length=20, nullable=true)
     */
    public $No_hp;

    /**
     *
     * @var string
     * @Column(type="string", length=50, nullable=true)
     */
    public $Email;

    /**
     *
     * @var integer
     * @Column(type="integer", length=11, nullable=false)
     */
    public $Entry_sekolah_id;

    /**
     *
     * @var integer
     * @Column(type="integer", length=11, nullable=false)
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
     * @var integer
     * @Column(type="integer", length=11, nullable=false)
     */
    public $Lembaga_pengangkat_id;

    /**
     *
     * @var integer
     * @Column(type="integer", length=11, nullable=true)
     */
    public $Pangkat_golongan_id;

    /**
     *
     * @var integer
     * @Column(type="integer", length=4, nullable=true)
     */
    public $Keahlian_laboratorium_id;

    /**
     *
     * @var integer
     * @Column(type="integer", length=11, nullable=false)
     */
    public $Sumber_gaji_id;

    /**
     *
     * @var string
     * @Column(type="string", length=60, nullable=false)
     */
    public $Nama_ibu_kandung;

    /**
     *
     * @var integer
     * @Column(type="integer", length=11, nullable=false)
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
     * @Column(type="integer", length=11, nullable=false)
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
     * @var integer
     * @Column(type="integer", length=11, nullable=false)
     */
    public $Sudah_lisensi_kepala_sekolah;

    /**
     *
     * @var integer
     * @Column(type="integer", length=4, nullable=true)
     */
    public $Jumlah_sekolah_binaan;

    /**
     *
     * @var integer
     * @Column(type="integer", length=11, nullable=false)
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
     * @Column(type="integer", length=11, nullable=false)
     */
    public $Mampu_handle_kk;

    /**
     *
     * @var integer
     * @Column(type="integer", length=11, nullable=true)
     */
    public $Keahlian_braille;

    /**
     *
     * @var integer
     * @Column(type="integer", length=11, nullable=true)
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
     * @Column(type="string", length=2, nullable=false)
     */
    public $Kewarganegaraan;

    /**
     *
     * @var string
     * @Column(type="string", length=40, nullable=false)
     */
    public $Foto;

    /**
     *
     * @var string
     * @Column(type="string", nullable=false)
     */
    public $Last_update;

    /**
     *
     * @var integer
     * @Column(type="integer", length=11, nullable=false)
     */
    public $Soft_delete;

    /**
     *
     * @var string
     * @Column(type="string", nullable=false)
     */
    public $Last_sync;

    /**
     *
     * @var integer
     * @Column(type="integer", length=11, nullable=false)
     */
    public $Updater_id;

    /**
     * Validations and business logic
     *
     * @return boolean
     */
    public function validation()
    {
        $validator = new Validation();

        $validator->add(
            'Email',
            new EmailValidator(
                [
                    'model'   => $this,
                    'message' => 'Please enter a correct email address',
                ]
            )
        );

        return $this->validate($validator);
    }

    /**
     * Initialize method for model.
     */
    // public function initialize()
    // {
    //     $this->setSchema("siakad");
    //     $this->setSource("ref_guru");
    // }

    /**
     * Returns table name mapped in the model.
     *
     * @return string
     */
    public function getSource()
    {
        return 'ref_guru';
    }

    /**
     * Allows to query a set of records that match the specified conditions
     *
     * @param mixed $parameters
     * @return RefGuru[]|RefGuru|\Phalcon\Mvc\Model\ResultSetInterface
     */
    public static function find($parameters = null)
    {
        return parent::find($parameters);
    }

    /**
     * Allows to query the first record that match the specified conditions
     *
     * @param mixed $parameters
     * @return RefGuru|\Phalcon\Mvc\Model\ResultInterface
     */
    public static function findFirst($parameters = null)
    {
        return parent::findFirst($parameters);
    }

}
