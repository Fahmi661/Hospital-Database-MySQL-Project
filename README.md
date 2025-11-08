# 🏥 Proyek Database: Sistem Manajemen Rawat Jalan MySQL

## Pendahuluan
Proyek ini adalah implementasi database **MySQL** yang dirancang untuk mengelola data operasional utama pada layanan **Rawat Jalan** (Outpatient Services) di sebuah rumah sakit.

Database ini dirancang dan diimplementasikan menggunakan prinsip **Normalisasi Database (3NF)** untuk memastikan integritas data (melalui Foreign Key Constraints) dan meminimalkan redundansi.

### Teknologi
- **Database Engine:** MySQL
- **Bahasa:** SQL (DDL, DML)
- **Alat:** MySQL Workbench

---

## 📐 Desain Skema (Entity Relationship Diagram - ERD)



Database terdiri dari 7 tabel yang saling berelasi:

| Tabel | Keterangan | Relasi Kunci |
| :--- | :--- | :--- |
| **DOKTER** | Data informasi dokter dan spesialisasi. | **1:M** dengan `RAWAT_JALAN` |
| **PASIEN** | Data informasi dasar pasien (Nama, Tgl Lahir, Jenis Kelamin). | **1:1** dengan `DETAIL_PASIEN` |
| **DETAIL_PASIEN** | Data lanjutan pasien (Alamat, Pekerjaan, Akun Pengguna). | **1:1** dengan `PASIEN` (Primary Key adalah Foreign Key) |
| **RAWAT_JALAN** | Mencatat setiap kunjungan/pertemuan pasien dengan dokter. | **M:1** dengan `DOKTER` & `PASIEN` |
| **REKAM_MEDIS** | Mencatat diagnosis yang ditetapkan setelah kunjungan. | **1:1** dengan `RAWAT_JALAN` |
| **TINDAKAN** | Daftar master tindakan medis yang dapat dilakukan. | **M:M** dengan `REKAM_MEDIS` |
| **TINDAKAN_REKAM_MEDIS** | Tabel penghubung (M:M) yang mencatat tindakan apa saja yang dilakukan untuk suatu diagnosis. | **Composite PK** dari `id_tindakan` dan `id_rekam_medis` |

---

## 🛠️ Cara Menjalankan Proyek

Kode sumber dibagi menjadi dua file utama:

1.  **`01_skema_ddl.sql`**: Berisi semua perintah DDL (`CREATE TABLE`, `DROP TABLE`, `ALTER TABLE`) untuk membangun struktur.
2.  **`02_data_dml.sql`**: Berisi semua perintah DML (`INSERT INTO`) untuk mengisi data awal.

**Langkah Eksekusi:**

1.  Buka MySQL Workbench atau *client* SQL pilihan Anda.
2.  Jalankan perintah untuk membuat database: `CREATE DATABASE IF NOT EXISTS rumah_sakit;`
3.  Jalankan file **`01_skema_ddl.sql`** secara keseluruhan.
4.  Jalankan file **`02_data_dml.sql`** secara keseluruhan untuk mengisi data.

---

## 📈 Query Portofolio & Analisis Data (DML Lanjutan)

Bagian ini menampilkan kemampuan untuk menganalisis dan menggabungkan data dari berbagai tabel (lihat *file* **`03_query_analisis.sql`**).

### 1. Daftar Kunjungan Lengkap (Menggunakan JOIN)

Menampilkan detail lengkap riwayat kunjungan pasien: Nama Pasien, Dokter yang menangani, Spesialisasi Dokter, Keluhan, dan Diagnosis yang ditetapkan.

```sql
SELECT
    P.nama_pasien,
    D.nama_dokter,
    D.spesialisasi,
    RJ.tgl_kunjungan,
    RJ.keluhan,
    RM.diagnosis
FROM
    RAWAT_JALAN RJ
JOIN PASIEN P ON RJ.id_pasien = P.id_pasien
JOIN DOKTER D ON RJ.id_dokter = D.id_dokter
LEFT JOIN REKAM_MEDIS RM ON RJ.id_rawat_jalan = RM.id_rawat_jalan;
