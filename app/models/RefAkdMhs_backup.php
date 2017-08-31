<?php

class RefAkdMhs extends \Phalcon\Mvc\Model
{

    /**
     *
     * @var string
     * @Primary
     * @Column(type="string", length=32, nullable=false)
     */
    public $id_mhs;

    /**
     *
     * @var integer
     * @Column(type="integer", length=8, nullable=false)
     */
    public $id_jenis;

    /**
     *
     * @var string
     * @Column(type="string", length=64, nullable=false)
     */
    public $nama;

    /**
     *
     * @var integer
     * @Column(type="integer", length=8, nullable=false)
     */
    public $id_ps;

    /**
     *
     * @var integer
     * @Column(type="integer", length=4, nullable=false)
     */
    public $angkatan;

    /**
     *
     * @var string
     * @Column(type="string", length=16, nullable=false)
     */
    public $id_kur;

    /**
     *
     * @var string
     * @Column(type="string", length=64, nullable=false)
     */
    public $foto;

    /**
     *
     * @var integer
     * @Column(type="integer", length=8, nullable=false)
     */
    public $id_status;

    /**
     *
     * @var string
     * @Column(type="string", length=1, nullable=false)
     */
    public $hitung_nilai;

    /**
     *
     * @var integer
     * @Column(type="integer", length=11, nullable=true)
     */
    public $id_agama;

    /**
     *
     * @var string
     * @Column(type="string", nullable=true)
     */
    public $gol_darah;

    /**
     *
     * @var string
     * @Column(type="string", nullable=true)
     */
    public $gender;

    /**
     *
     * @var string
     * @Column(type="string", length=200, nullable=true)
     */
    public $alamat_yk;

    /**
     *
     * @var string
     * @Column(type="string", length=200, nullable=true)
     */
    public $kode_kabyk;

    /**
     *
     * @var string
     * @Column(type="string", length=15, nullable=true)
     */
    public $kode_posyk;

    /**
     *
     * @var string
     * @Column(type="string", length=50, nullable=true)
     */
    public $telpon;

    /**
     *
     * @var string
     * @Column(type="string", length=200, nullable=true)
     */
    public $alamat_asal;

    /**
     *
     * @var string
     * @Column(type="string", length=15, nullable=true)
     */
    public $kdkab_asal;

    /**
     *
     * @var string
     * @Column(type="string", length=15, nullable=true)
     */
    public $kdprop_asal;

    /**
     *
     * @var string
     * @Column(type="string", length=15, nullable=true)
     */
    public $kdpos_asal;

    /**
     *
     * @var string
     * @Column(type="string", length=50, nullable=true)
     */
    public $telpon_asal;

    /**
     *
     * @var string
     * @Column(type="string", length=32, nullable=false)
     */
    public $id_dosen_wali;

    /**
     *
     * @var string
     * @Column(type="string", nullable=false)
     */
    public $tgl_lahir;

    /**
     *
     * @var string
     * @Column(type="string", length=64, nullable=false)
     */
    public $tempat_lahir;

    /**
     *
     * @var string
     * @Column(type="string", nullable=false)
     */
    public $tgl_lulus;

    /**
     *
     * @var string
     * @Column(type="string", length=1, nullable=false)
     */
    public $pmb_ses_id;

    /**
     *
     * @var string
     * @Column(type="string", length=1, nullable=false)
     */
    public $kelompok_cd;

    /**
     *
     * @var string
     * @Column(type="string", length=10, nullable=false)
     */
    public $no_test;

    /**
     *
     * @var string
     * @Column(type="string", length=5, nullable=false)
     */
    public $almt_prokab;

    /**
     *
     * @var string
     * @Column(type="string", length=10, nullable=false)
     */
    public $asal_smu;

    /**
     *
     * @var string
     * @Column(type="string", length=10, nullable=false)
     */
    public $jur_smu;

    /**
     *
     * @var string
     * @Column(type="string", length=50, nullable=false)
     */
    public $no_ijazah;

    /**
     *
     * @var string
     * @Column(type="string", nullable=false)
     */
    public $tgl_ijazah;

    /**
     *
     * @var string
     * @Column(type="string", length=4, nullable=false)
     */
    public $tahun_sttb;

    /**
     *
     * @var string
     * @Column(type="string", length=5, nullable=false)
     */
    public $nilai_ttl_sttb;

    /**
     *
     * @var integer
     * @Column(type="integer", length=3, nullable=false)
     */
    public $jml_mapel_sttb;

    /**
     *
     * @var string
     * @Column(type="string", length=5, nullable=false)
     */
    public $nem;

    /**
     *
     * @var integer
     * @Column(type="integer", length=3, nullable=false)
     */
    public $jml_mapel_nem;

    /**
     *
     * @var string
     * @Column(type="string", length=5, nullable=false)
     */
    public $lahir_prokab;

    /**
     *
     * @var integer
     * @Column(type="integer", length=3, nullable=false)
     */
    public $warganegara;

    /**
     *
     * @var integer
     * @Column(type="integer", length=3, nullable=false)
     */
    public $educlvl_ayah;

    /**
     *
     * @var integer
     * @Column(type="integer", length=3, nullable=false)
     */
    public $educlvl_ibu;

    /**
     *
     * @var integer
     * @Column(type="integer", length=3, nullable=false)
     */
    public $educlvl_wali;

    /**
     *
     * @var integer
     * @Column(type="integer", length=3, nullable=false)
     */
    public $job_ayah;

    /**
     *
     * @var integer
     * @Column(type="integer", length=3, nullable=false)
     */
    public $job_ibu;

    /**
     *
     * @var integer
     * @Column(type="integer", length=3, nullable=false)
     */
    public $job_wali;

    /**
     *
     * @var integer
     * @Column(type="integer", length=3, nullable=false)
     */
    public $job_cmhs;

    /**
     *
     * @var string
     * @Column(type="string", length=10, nullable=false)
     */
    public $hobi;

    /**
     *
     * @var string
     * @Column(type="string", length=10, nullable=false)
     */
    public $golongan_cd;

    /**
     *
     * @var string
     * @Column(type="string", length=10, nullable=false)
     */
    public $ps_id1;

    /**
     *
     * @var string
     * @Column(type="string", length=10, nullable=false)
     */
    public $ps_id2;

    /**
     *
     * @var string
     * @Column(type="string", length=10, nullable=false)
     */
    public $ps_id3;

    /**
     *
     * @var string
     * @Column(type="string", length=10, nullable=false)
     */
    public $ps_id_lls;

    /**
     *
     * @var string
     * @Column(type="string", length=10, nullable=false)
     */
    public $status_lls;

    /**
     *
     * @var integer
     * @Column(type="integer", length=3, nullable=false)
     */
    public $pilihanke;

    /**
     *
     * @var integer
     * @Column(type="integer", length=10, nullable=false)
     */
    public $dana_ps1;

    /**
     *
     * @var integer
     * @Column(type="integer", length=10, nullable=false)
     */
    public $dana_ps2;

    /**
     *
     * @var integer
     * @Column(type="integer", length=10, nullable=false)
     */
    public $dana_ps3;

    /**
     *
     * @var double
     * @Column(type="double", length=10, nullable=false)
     */
    public $jml_uang;

    /**
     *
     * @var string
     * @Column(type="string", length=200, nullable=false)
     */
    public $bank_kota;

    /**
     *
     * @var string
     * @Column(type="string", length=10, nullable=false)
     */
    public $no_test_riil;

    /**
     *
     * @var string
     * @Column(type="string", length=25, nullable=false)
     */
    public $nomor_test;

    /**
     *
     * @var string
     * @Column(type="string", length=64, nullable=false)
     */
    public $nama_wali;

    /**
     *
     * @var string
     * @Column(type="string", nullable=false)
     */
    public $alamat_wali;

    /**
     *
     * @var string
     * @Column(type="string", length=50, nullable=true)
     */
    public $nama_ayah;

    /**
     *
     * @var string
     * @Column(type="string", length=50, nullable=true)
     */
    public $nama_ibu;

    /**
     *
     * @var string
     * @Column(type="string", nullable=false)
     */
    public $tgl_masuk;

    /**
     *
     * @var string
     * @Column(type="string", nullable=true)
     */
    public $tgl_daftar;

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
     * @return RefAkdMhs[]
     */
    public static function find($parameters = null)
    {
        return parent::find($parameters);
    }

    /**
     * Allows to query the first record that match the specified conditions
     *
     * @param mixed $parameters
     * @return RefAkdMhs
     */
    public static function findFirst($parameters = null)
    {
        return parent::findFirst($parameters);
    }

}
