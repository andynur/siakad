<?php

use Phalcon\Validation;
use Phalcon\Validation\Validator\Email as EmailValidator;

class RefAkdMhs extends \Phalcon\Mvc\Model
{

    /**
     *
     * @var integer
     * @Primary
     * @Identity
     * @Column(type="integer", length=20, nullable=false)
     */
    public $Id_mhs;

    /**
     *
     * @var integer
     * @Column(type="integer", length=8, nullable=true)
     */
    public $Id_jenis;

    /**
     *
     * @var string
     * @Column(type="string", length=64, nullable=true)
     */
    public $Nama;

    /**
     *
     * @var integer
     * @Column(type="integer", length=8, nullable=true)
     */
    public $Id_ps;

    /**
     *
     * @var integer
     * @Column(type="integer", length=8, nullable=true)
     */
    public $Ps_kur;

    /**
     *
     * @var integer
     * @Column(type="integer", length=4, nullable=true)
     */
    public $Angkatan;

    /**
     *
     * @var string
     * @Column(type="string", length=64, nullable=true)
     */
    public $Angkatan_id;

    /**
     *
     * @var string
     * @Column(type="string", length=16, nullable=true)
     */
    public $Id_kur;

    /**
     *
     * @var string
     * @Column(type="string", length=64, nullable=true)
     */
    public $Foto;

    /**
     *
     * @var string
     * @Column(type="string", length=8, nullable=true)
     */
    public $Id_status;

    /**
     *
     * @var string
     * @Column(type="string", length=1, nullable=true)
     */
    public $Hitung_nilai;

    /**
     *
     * @var integer
     * @Column(type="integer", length=11, nullable=true)
     */
    public $Id_agama;

    /**
     *
     * @var integer
     * @Column(type="integer", length=11, nullable=false)
     */
    public $Kebutuhan_khusus_id;

    /**
     *
     * @var integer
     * @Column(type="integer", length=11, nullable=false)
     */
    public $Sekolah_id;

    /**
     *
     * @var integer
     * @Column(type="integer", length=11, nullable=false)
     */
    public $Rombel_sekarang;

    /**
     *
     * @var string
     * @Column(type="string", nullable=true)
     */
    public $Gol_darah;

    /**
     *
     * @var string
     * @Column(type="string", nullable=true)
     */
    public $Gender;

    /**
     *
     * @var string
     * @Column(type="string", length=64, nullable=true)
     */
    public $Nik;

    /**
     *
     * @var string
     * @Column(type="string", length=200, nullable=true)
     */
    public $Alamat;

    /**
     *
     * @var integer
     * @Column(type="integer", length=11, nullable=false)
     */
    public $Rt;

    /**
     *
     * @var integer
     * @Column(type="integer", length=11, nullable=false)
     */
    public $Rw;

    /**
     *
     * @var string
     * @Column(type="string", length=50, nullable=false)
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
     * @Column(type="string", length=200, nullable=true)
     */
    public $Kode_kab;

    /**
     *
     * @var string
     * @Column(type="string", length=64, nullable=true)
     */
    public $Kode_prop;

    /**
     *
     * @var string
     * @Column(type="string", length=64, nullable=true)
     */
    public $Kode_pos;

    /**
     *
     * @var string
     * @Column(type="string", length=50, nullable=true)
     */
    public $Telpon;

    /**
     *
     * @var string
     * @Column(type="string", length=20, nullable=false)
     */
    public $Nomor_telepon_seluler;

    /**
     *
     * @var string
     * @Column(type="string", length=20, nullable=false)
     */
    public $Nomor_telepon_seluler_2;

    /**
     *
     * @var integer
     * @Column(type="integer", length=2, nullable=false)
     */
    public $Jenis_tinggal_id;

    /**
     *
     * @var integer
     * @Column(type="integer", length=2, nullable=false)
     */
    public $Alat_transportasi_id;

    /**
     *
     * @var string
     * @Column(type="string", length=50, nullable=false)
     */
    public $Email;

    /**
     *
     * @var integer
     * @Column(type="integer", length=1, nullable=false)
     */
    public $Penerima_kps;

    /**
     *
     * @var string
     * @Column(type="string", length=50, nullable=false)
     */
    public $No_kps;

    /**
     *
     * @var integer
     * @Column(type="integer", length=11, nullable=false)
     */
    public $Status_data;

    /**
     *
     * @var string
     * @Column(type="string", length=200, nullable=true)
     */
    public $Alamat_asal;

    /**
     *
     * @var string
     * @Column(type="string", length=15, nullable=true)
     */
    public $Kdkab_asal;

    /**
     *
     * @var string
     * @Column(type="string", length=15, nullable=true)
     */
    public $Kdprop_asal;

    /**
     *
     * @var string
     * @Column(type="string", length=15, nullable=true)
     */
    public $Kdpos_asal;

    /**
     *
     * @var string
     * @Column(type="string", length=50, nullable=true)
     */
    public $Telpon_asal;

    /**
     *
     * @var string
     * @Column(type="string", length=32, nullable=true)
     */
    public $Id_dosen_wali;

    /**
     *
     * @var string
     * @Column(type="string", nullable=true)
     */
    public $Tgl_lahir;

    /**
     *
     * @var string
     * @Column(type="string", length=64, nullable=true)
     */
    public $Tempat_lahir;

    /**
     *
     * @var string
     * @Column(type="string", nullable=true)
     */
    public $Tgl_lulus;

    /**
     *
     * @var string
     * @Column(type="string", length=1, nullable=true)
     */
    public $Pmb_ses_id;

    /**
     *
     * @var string
     * @Column(type="string", length=1, nullable=true)
     */
    public $Kelompok_cd;

    /**
     *
     * @var string
     * @Column(type="string", length=10, nullable=true)
     */
    public $No_test;

    /**
     *
     * @var string
     * @Column(type="string", length=5, nullable=true)
     */
    public $Smu_prokab;

    /**
     *
     * @var string
     * @Column(type="string", length=64, nullable=true)
     */
    public $Asal_smu;

    /**
     *
     * @var string
     * @Column(type="string", nullable=true)
     */
    public $Alamat_sekolah;

    /**
     *
     * @var string
     * @Column(type="string", length=10, nullable=false)
     */
    public $Nis;

    /**
     *
     * @var string
     * @Column(type="string", length=10, nullable=true)
     */
    public $Nisn;

    /**
     *
     * @var string
     * @Column(type="string", length=64, nullable=true)
     */
    public $Judul_skripsi;

    /**
     *
     * @var string
     * @Column(type="string", length=10, nullable=true)
     */
    public $Jur_smu;

    /**
     *
     * @var string
     * @Column(type="string", length=50, nullable=true)
     */
    public $No_ijazah;

    /**
     *
     * @var string
     * @Column(type="string", nullable=true)
     */
    public $Tgl_ijazah;

    /**
     *
     * @var string
     * @Column(type="string", length=4, nullable=true)
     */
    public $Tahun_sttb;

    /**
     *
     * @var string
     * @Column(type="string", length=5, nullable=true)
     */
    public $Nilai_ttl_sttb;

    /**
     *
     * @var integer
     * @Column(type="integer", length=3, nullable=true)
     */
    public $Jml_mapel_sttb;

    /**
     *
     * @var string
     * @Column(type="string", length=5, nullable=true)
     */
    public $Nem;

    /**
     *
     * @var integer
     * @Column(type="integer", length=3, nullable=true)
     */
    public $Jml_mapel_nem;

    /**
     *
     * @var string
     * @Column(type="string", length=5, nullable=true)
     */
    public $Lahir_prokab;

    /**
     *
     * @var integer
     * @Column(type="integer", length=3, nullable=true)
     */
    public $Warganegara;

    /**
     *
     * @var string
     * @Column(type="string", length=255, nullable=true)
     */
    public $Edu_ayah;

    /**
     *
     * @var string
     * @Column(type="string", length=255, nullable=true)
     */
    public $Edu_ibu;

    /**
     *
     * @var string
     * @Column(type="string", length=255, nullable=true)
     */
    public $Job_ayah;

    /**
     *
     * @var string
     * @Column(type="string", length=255, nullable=true)
     */
    public $Job_ibu;

    /**
     *
     * @var string
     * @Column(type="string", length=10, nullable=true)
     */
    public $Golongan_cd;

    /**
     *
     * @var string
     * @Column(type="string", length=10, nullable=true)
     */
    public $Ps_id1;

    /**
     *
     * @var string
     * @Column(type="string", length=10, nullable=true)
     */
    public $Ps_id2;

    /**
     *
     * @var string
     * @Column(type="string", length=10, nullable=true)
     */
    public $Ps_id3;

    /**
     *
     * @var string
     * @Column(type="string", length=10, nullable=true)
     */
    public $Ps_id_lls;

    /**
     *
     * @var string
     * @Column(type="string", length=10, nullable=true)
     */
    public $Status_lls;

    /**
     *
     * @var integer
     * @Column(type="integer", length=3, nullable=true)
     */
    public $Pilihanke;

    /**
     *
     * @var integer
     * @Column(type="integer", length=10, nullable=true)
     */
    public $Dana_ps1;

    /**
     *
     * @var integer
     * @Column(type="integer", length=10, nullable=true)
     */
    public $Dana_ps2;

    /**
     *
     * @var integer
     * @Column(type="integer", length=10, nullable=true)
     */
    public $Dana_ps3;

    /**
     *
     * @var double
     * @Column(type="double", length=10, nullable=true)
     */
    public $Jml_uang;

    /**
     *
     * @var string
     * @Column(type="string", length=200, nullable=true)
     */
    public $Bank_kota;

    /**
     *
     * @var string
     * @Column(type="string", length=10, nullable=true)
     */
    public $No_test_riil;

    /**
     *
     * @var string
     * @Column(type="string", length=25, nullable=true)
     */
    public $Nomor_test;

    /**
     *
     * @var string
     * @Column(type="string", length=64, nullable=true)
     */
    public $Kota_ortu;

    /**
     *
     * @var string
     * @Column(type="string", nullable=true)
     */
    public $Alamat_ortu;

    /**
     *
     * @var string
     * @Column(type="string", length=64, nullable=true)
     */
    public $Kode_pos_ortu;

    /**
     *
     * @var string
     * @Column(type="string", length=50, nullable=true)
     */
    public $Nama_ayah;

    /**
     *
     * @var string
     * @Column(type="string", length=50, nullable=true)
     */
    public $Nama_ibu;

    /**
     *
     * @var string
     * @Column(type="string", length=255, nullable=true)
     */
    public $Nik_ayah;

    /**
     *
     * @var string
     * @Column(type="string", length=255, nullable=true)
     */
    public $Nik_ibu;

    /**
     *
     * @var string
     * @Column(type="string", length=255, nullable=true)
     */
    public $Agama_ayah;

    /**
     *
     * @var string
     * @Column(type="string", length=255, nullable=true)
     */
    public $Agama_ibu;

    /**
     *
     * @var string
     * @Column(type="string", length=255, nullable=true)
     */
    public $Penghasilan_ortu;

    /**
     *
     * @var integer
     * @Column(type="integer", length=11, nullable=false)
     */
    public $Penghasilan_id_ibu;

    /**
     *
     * @var integer
     * @Column(type="integer", length=4, nullable=false)
     */
    public $Tahun_lahir_ayah;

    /**
     *
     * @var integer
     * @Column(type="integer", length=4, nullable=false)
     */
    public $Tahun_lahir_ibu;

    /**
     *
     * @var integer
     * @Column(type="integer", length=11, nullable=false)
     */
    public $Kebutuhan_khusus_id_ayah;

    /**
     *
     * @var integer
     * @Column(type="integer", length=11, nullable=false)
     */
    public $Kebutuhan_khusus_id_ibu;

    /**
     *
     * @var string
     * @Column(type="string", nullable=true)
     */
    public $Tgl_masuk;

    /**
     *
     * @var string
     * @Column(type="string", nullable=true)
     */
    public $Tgl_daftar;

    /**
     *
     * @var string
     * @Column(type="string", length=30, nullable=false)
     */
    public $Nama_wali;

    /**
     *
     * @var integer
     * @Column(type="integer", length=4, nullable=true)
     */
    public $Tahun_lahir_wali;

    /**
     *
     * @var integer
     * @Column(type="integer", length=2, nullable=true)
     */
    public $Jenjang_pendidikan_wali;

    /**
     *
     * @var integer
     * @Column(type="integer", length=11, nullable=true)
     */
    public $Pekerjaan_id_wali;

    /**
     *
     * @var integer
     * @Column(type="integer", length=11, nullable=true)
     */
    public $Penghasilan_id_wali;

    /**
     *
     * @var string
     * @Column(type="string", length=2, nullable=false)
     */
    public $Kewarganegaraan;

    /**
     *
     * @var string
     * @Column(type="string", nullable=false)
     */
    public $Last_update;

    /**
     *
     * @var integer
     * @Column(type="integer", length=1, nullable=false)
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
    // public function validation()
    // {
    //     $validator = new Validation();

    //     $validator->add(
    //         'Email',
    //         new EmailValidator(
    //             [
    //                 'model'   => $this,
    //                 'message' => 'Please enter a correct email address',
    //             ]
    //         )
    //     );

    //     return $this->validate($validator);
    // }

    /**
     * Initialize method for model.
     */
    public function initialize()
    {
        $this->setSchema("siakad");
        $this->setSource("ref_akd_mhs");
    }

    /**
     * Returns table name mapped in the model.
     *
     * @return string
     */
    public function getSource()
    {
        return 'ref_akd_mhs';
    }

    /**
     * Allows to query a set of records that match the specified conditions
     *
     * @param mixed $parameters
     * @return RefAkdMhs[]|RefAkdMhs|\Phalcon\Mvc\Model\ResultSetInterface
     */
    public static function find($parameters = null)
    {
        return parent::find($parameters);
    }

    /**
     * Allows to query the first record that match the specified conditions
     *
     * @param mixed $parameters
     * @return RefAkdMhs|\Phalcon\Mvc\Model\ResultInterface
     */
    public static function findFirst($parameters = null)
    {
        return parent::findFirst($parameters);
    }

}
