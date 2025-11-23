-- ========================================
-- HOSPITAL MANAGEMENT SYSTEM DATABASE
-- ========================================
-- Description: Comprehensive hospital database system
-- Author: [Your Name]
-- Version: 2.0
-- Last Updated: November 2025
-- ========================================

-- ========================================
-- DATABASE SETUP
-- ========================================
DROP DATABASE IF EXISTS rumah_sakit;
CREATE DATABASE rumah_sakit CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE rumah_sakit;

-- ========================================
-- TABLE: DOKTER (Doctor)
-- ========================================
CREATE TABLE Dokter (
    id_dokter INT PRIMARY KEY AUTO_INCREMENT,
    nik_dokter VARCHAR(20) UNIQUE NOT NULL COMMENT 'National ID',
    nama_dokter VARCHAR(100) NOT NULL,
    spesialisasi VARCHAR(50) NOT NULL,
    sub_spesialisasi VARCHAR(50),
    no_str VARCHAR(30) UNIQUE NOT NULL COMMENT 'Surat Tanda Registrasi',
    no_sip VARCHAR(30) COMMENT 'Surat Izin Praktik',
    nomor_telp VARCHAR(15),
    email VARCHAR(100),
    alamat TEXT,
    tanggal_bergabung DATE DEFAULT (CURRENT_DATE),
    status_dokter ENUM('Aktif','Cuti','Non-Aktif') DEFAULT 'Aktif',
    biaya_konsultasi DECIMAL(10,2) DEFAULT 150000.00,
    rating DECIMAL(3,2) DEFAULT 0.00 COMMENT 'Rating 0-5',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_spesialisasi (spesialisasi),
    INDEX idx_status (status_dokter)
) ENGINE=InnoDB COMMENT='Doctor master data';

-- ========================================
-- TABLE: PASIEN (Patient)
-- ========================================
CREATE TABLE Pasien (
    id_pasien INT PRIMARY KEY AUTO_INCREMENT,
    no_rekam_medis VARCHAR(20) UNIQUE NOT NULL,
    nik VARCHAR(16) UNIQUE COMMENT 'NIK for adult',
    nama_pasien VARCHAR(100) NOT NULL,
    tanggal_lahir DATE NOT NULL,
    tempat_lahir VARCHAR(50),
    jenis_kelamin ENUM('Laki-laki','Perempuan') NOT NULL,
    golongan_darah ENUM('A','B','AB','O','A+','A-','B+','B-','AB+','AB-','O+','O-'),
    rhesus ENUM('+','-'),
    alamat TEXT,
    kota VARCHAR(50),
    provinsi VARCHAR(50),
    kode_pos VARCHAR(10),
    nomor_telp VARCHAR(15),
    email VARCHAR(100),
    pekerjaan VARCHAR(50),
    status_pernikahan ENUM('Belum Menikah','Menikah','Cerai','Janda/Duda'),
    nama_wali VARCHAR(100) COMMENT 'For minors',
    hubungan_wali VARCHAR(30),
    telp_darurat VARCHAR(15) NOT NULL,
    asuransi VARCHAR(50) COMMENT 'BPJS/Private Insurance',
    no_asuransi VARCHAR(50),
    alergi TEXT COMMENT 'Known allergies',
    riwayat_penyakit TEXT COMMENT 'Medical history',
    tanggal_daftar DATE DEFAULT (CURRENT_DATE),
    status_pasien ENUM('Aktif','Meninggal','Pindah') DEFAULT 'Aktif',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_no_rm (no_rekam_medis),
    INDEX idx_nik (nik),
    INDEX idx_nama (nama_pasien),
    INDEX idx_status (status_pasien)
) ENGINE=InnoDB COMMENT='Patient master data';

-- ========================================
-- TABLE: RUANGAN (Room)
-- ========================================
CREATE TABLE Ruangan (
    id_ruangan INT PRIMARY KEY AUTO_INCREMENT,
    kode_ruangan VARCHAR(20) UNIQUE NOT NULL,
    nama_ruangan VARCHAR(100) NOT NULL,
    tipe_ruangan ENUM('VIP','Kelas 1','Kelas 2','Kelas 3','ICU','NICU','IGD') NOT NULL,
    lantai INT,
    gedung VARCHAR(50),
    kapasitas_bed INT DEFAULT 1,
    bed_terisi INT DEFAULT 0,
    fasilitas TEXT,
    tarif_per_hari DECIMAL(10,2),
    status_ruangan ENUM('Tersedia','Terisi','Maintenance') DEFAULT 'Tersedia',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_tipe (tipe_ruangan),
    INDEX idx_status (status_ruangan),
    CHECK (bed_terisi <= kapasitas_bed)
) ENGINE=InnoDB COMMENT='Hospital room management';

-- ========================================
-- TABLE: TINDAKAN (Medical Procedure)
-- ========================================
CREATE TABLE Tindakan (
    id_tindakan INT PRIMARY KEY AUTO_INCREMENT,
    kode_tindakan VARCHAR(20) UNIQUE NOT NULL,
    nama_tindakan VARCHAR(150) NOT NULL,
    kategori_tindakan ENUM('Pemeriksaan','Laboratorium','Radiologi','Operasi','Terapi','Konsultasi') NOT NULL,
    deskripsi TEXT,
    biaya DECIMAL(12,2) NOT NULL,
    durasi_estimasi INT COMMENT 'in minutes',
    perlu_persetujuan BOOLEAN DEFAULT FALSE,
    status_tindakan ENUM('Aktif','Non-Aktif') DEFAULT 'Aktif',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_kategori (kategori_tindakan),
    INDEX idx_kode (kode_tindakan)
) ENGINE=InnoDB COMMENT='Medical procedures and services';

-- ========================================
-- TABLE: OBAT (Medicine)
-- ========================================
CREATE TABLE Obat (
    id_obat INT PRIMARY KEY AUTO_INCREMENT,
    kode_obat VARCHAR(20) UNIQUE NOT NULL,
    nama_obat VARCHAR(100) NOT NULL,
    nama_generik VARCHAR(100),
    kategori_obat VARCHAR(50) NOT NULL,
    bentuk_sediaan ENUM('Tablet','Kapsul','Sirup','Injeksi','Salep','Tetes','Inhaler','Suppositoria') NOT NULL,
    dosis_standar VARCHAR(50),
    satuan VARCHAR(20),
    harga_per_unit DECIMAL(10,2) NOT NULL,
    stok INT DEFAULT 0,
    stok_minimum INT DEFAULT 10,
    tanggal_kadaluarsa DATE NOT NULL,
    produsen VARCHAR(100),
    no_batch VARCHAR(50),
    efek_samping TEXT,
    kontraindikasi TEXT,
    cara_pakai TEXT,
    status_obat ENUM('Tersedia','Habis','Kadaluarsa','Discontinued') DEFAULT 'Tersedia',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_kategori (kategori_obat),
    INDEX idx_status (status_obat),
    INDEX idx_kadaluarsa (tanggal_kadaluarsa)
) ENGINE=InnoDB COMMENT='Pharmacy inventory';

-- ========================================
-- TABLE: RAWAT_JALAN (Outpatient Visit)
-- ========================================
CREATE TABLE Rawat_Jalan (
    id_rawat_jalan INT PRIMARY KEY AUTO_INCREMENT,
    no_registrasi VARCHAR(30) UNIQUE NOT NULL,
    id_pasien INT NOT NULL,
    id_dokter INT NOT NULL,
    tanggal_kunjungan DATE NOT NULL,
    waktu_kunjungan TIME NOT NULL,
    keluhan_utama TEXT NOT NULL,
    tekanan_darah VARCHAR(20),
    suhu_tubuh DECIMAL(4,2),
    nadi INT,
    berat_badan DECIMAL(5,2),
    tinggi_badan DECIMAL(5,2),
    status_kunjungan ENUM('Terdaftar','Sedang Diperiksa','Selesai','Batal') DEFAULT 'Terdaftar',
    tipe_pembayaran ENUM('Tunai','BPJS','Asuransi Swasta','Kartu Kredit') DEFAULT 'Tunai',
    total_biaya DECIMAL(12,2) DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (id_pasien) REFERENCES Pasien(id_pasien) ON DELETE CASCADE,
    FOREIGN KEY (id_dokter) REFERENCES Dokter(id_dokter) ON DELETE CASCADE,
    INDEX idx_pasien (id_pasien),
    INDEX idx_dokter (id_dokter),
    INDEX idx_tanggal (tanggal_kunjungan),
    INDEX idx_status (status_kunjungan)
) ENGINE=InnoDB COMMENT='Outpatient visit records';

-- ========================================
-- TABLE: RAWAT_INAP (Inpatient)
-- ========================================
CREATE TABLE Rawat_Inap (
    id_rawat_inap INT PRIMARY KEY AUTO_INCREMENT,
    no_rawat_inap VARCHAR(30) UNIQUE NOT NULL,
    id_pasien INT NOT NULL,
    id_dokter INT NOT NULL,
    id_ruangan INT NOT NULL,
    tanggal_masuk DATETIME NOT NULL,
    tanggal_keluar DATETIME,
    diagnosis_masuk TEXT NOT NULL,
    alasan_rawat_inap TEXT,
    status_rawat_inap ENUM('Aktif','Keluar','Dirujuk','Meninggal') DEFAULT 'Aktif',
    total_hari INT DEFAULT 0,
    total_biaya DECIMAL(15,2) DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (id_pasien) REFERENCES Pasien(id_pasien) ON DELETE CASCADE,
    FOREIGN KEY (id_dokter) REFERENCES Dokter(id_dokter) ON DELETE CASCADE,
    FOREIGN KEY (id_ruangan) REFERENCES Ruangan(id_ruangan),
    INDEX idx_pasien (id_pasien),
    INDEX idx_status (status_rawat_inap)
) ENGINE=InnoDB COMMENT='Inpatient records';

-- ========================================
-- TABLE: REKAM_MEDIS (Medical Record)
-- ========================================
CREATE TABLE Rekam_Medis (
    id_rekam_medis INT PRIMARY KEY AUTO_INCREMENT,
    id_rawat_jalan INT UNIQUE,
    id_rawat_inap INT,
    anamnesis TEXT COMMENT 'Patient history',
    pemeriksaan_fisik TEXT,
    diagnosis_utama VARCHAR(200) NOT NULL,
    diagnosis_sekunder TEXT,
    kode_icd10 VARCHAR(20) COMMENT 'ICD-10 code',
    prognosis ENUM('Baik','Sedang','Buruk','Dubia ad Bonam','Dubia ad Malam'),
    tindakan_medis TEXT,
    catatan_dokter TEXT,
    rencana_tindak_lanjut TEXT,
    rujukan VARCHAR(200),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (id_rawat_jalan) REFERENCES Rawat_Jalan(id_rawat_jalan) ON DELETE CASCADE,
    FOREIGN KEY (id_rawat_inap) REFERENCES Rawat_Inap(id_rawat_inap),
    INDEX idx_diagnosis (diagnosis_utama)
) ENGINE=InnoDB COMMENT='Electronic medical records';

-- ========================================
-- TABLE: TINDAKAN_REKAM_MEDIS (Procedure Records)
-- ========================================
CREATE TABLE Tindakan_Rekam_Medis (
    id_tindakan_rm INT PRIMARY KEY AUTO_INCREMENT,
    id_tindakan INT NOT NULL,
    id_rekam_medis INT NOT NULL,
    tanggal_tindakan DATETIME DEFAULT CURRENT_TIMESTAMP,
    hasil_tindakan TEXT,
    catatan VARCHAR(255),
    biaya_tindakan DECIMAL(12,2),
    status_pembayaran ENUM('Belum Bayar','Lunas') DEFAULT 'Belum Bayar',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_tindakan) REFERENCES Tindakan(id_tindakan) ON DELETE CASCADE,
    FOREIGN KEY (id_rekam_medis) REFERENCES Rekam_Medis(id_rekam_medis) ON DELETE CASCADE,
    INDEX idx_rekam_medis (id_rekam_medis),
    INDEX idx_tanggal (tanggal_tindakan)
) ENGINE=InnoDB COMMENT='Medical procedure records';

-- ========================================
-- TABLE: RESEP_OBAT (Prescription)
-- ========================================
CREATE TABLE Resep_Obat (
    id_resep INT PRIMARY KEY AUTO_INCREMENT,
    no_resep VARCHAR(30) UNIQUE NOT NULL,
    id_rekam_medis INT NOT NULL,
    id_dokter INT NOT NULL,
    tanggal_resep DATETIME DEFAULT CURRENT_TIMESTAMP,
    status_resep ENUM('Menunggu','Disiapkan','Selesai','Batal') DEFAULT 'Menunggu',
    total_biaya DECIMAL(10,2) DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_rekam_medis) REFERENCES Rekam_Medis(id_rekam_medis) ON DELETE CASCADE,
    FOREIGN KEY (id_dokter) REFERENCES Dokter(id_dokter),
    INDEX idx_status (status_resep)
) ENGINE=InnoDB COMMENT='Prescription records';

-- ========================================
-- TABLE: DETAIL_RESEP (Prescription Details)
-- ========================================
CREATE TABLE Detail_Resep (
    id_detail_resep INT PRIMARY KEY AUTO_INCREMENT,
    id_resep INT NOT NULL,
    id_obat INT NOT NULL,
    jumlah INT NOT NULL,
    dosis VARCHAR(50) NOT NULL,
    frekuensi VARCHAR(50) NOT NULL COMMENT 'e.g., 3x sehari',
    durasi VARCHAR(30) COMMENT 'e.g., 7 hari',
    aturan_pakai TEXT,
    catatan VARCHAR(255),
    harga_satuan DECIMAL(10,2),
    subtotal DECIMAL(10,2),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_resep) REFERENCES Resep_Obat(id_resep) ON DELETE CASCADE,
    FOREIGN KEY (id_obat) REFERENCES Obat(id_obat),
    INDEX idx_resep (id_resep)
) ENGINE=InnoDB COMMENT='Prescription item details';

-- ========================================
-- TABLE: JADWAL_DOKTER (Doctor Schedule)
-- ========================================
CREATE TABLE Jadwal_Dokter (
    id_jadwal INT PRIMARY KEY AUTO_INCREMENT,
    id_dokter INT NOT NULL,
    hari ENUM('Senin','Selasa','Rabu','Kamis','Jumat','Sabtu','Minggu') NOT NULL,
    jam_mulai TIME NOT NULL,
    jam_selesai TIME NOT NULL,
    kuota_pasien INT DEFAULT 20,
    status_jadwal ENUM('Aktif','Libur','Cuti') DEFAULT 'Aktif',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_dokter) REFERENCES Dokter(id_dokter) ON DELETE CASCADE,
    INDEX idx_dokter (id_dokter),
    INDEX idx_hari (hari)
) ENGINE=InnoDB COMMENT='Doctor schedule';

-- ========================================
-- TABLE: APPOINTMENT (Appointment System)
-- ========================================
CREATE TABLE Appointment (
    id_appointment INT PRIMARY KEY AUTO_INCREMENT,
    no_appointment VARCHAR(30) UNIQUE NOT NULL,
    id_pasien INT NOT NULL,
    id_dokter INT NOT NULL,
    tanggal_appointment DATE NOT NULL,
    waktu_appointment TIME NOT NULL,
    keperluan TEXT,
    status_appointment ENUM('Dijadwalkan','Dikonfirmasi','Selesai','Dibatalkan','Tidak Hadir') DEFAULT 'Dijadwalkan',
    catatan VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (id_pasien) REFERENCES Pasien(id_pasien) ON DELETE CASCADE,
    FOREIGN KEY (id_dokter) REFERENCES Dokter(id_dokter),
    INDEX idx_pasien (id_pasien),
    INDEX idx_dokter (id_dokter),
    INDEX idx_tanggal (tanggal_appointment)
) ENGINE=InnoDB COMMENT='Patient appointment system';

-- ========================================
-- TABLE: PEMBAYARAN (Payment)
-- ========================================
CREATE TABLE Pembayaran (
    id_pembayaran INT PRIMARY KEY AUTO_INCREMENT,
    no_invoice VARCHAR(30) UNIQUE NOT NULL,
    id_pasien INT NOT NULL,
    id_rawat_jalan INT,
    id_rawat_inap INT,
    tanggal_pembayaran DATETIME DEFAULT CURRENT_TIMESTAMP,
    total_tagihan DECIMAL(15,2) NOT NULL,
    diskon DECIMAL(10,2) DEFAULT 0,
    pajak DECIMAL(10,2) DEFAULT 0,
    total_bayar DECIMAL(15,2) NOT NULL,
    metode_pembayaran ENUM('Tunai','Debit','Kredit','Transfer','BPJS','Asuransi') NOT NULL,
    status_pembayaran ENUM('Pending','Lunas','Sebagian','Dibatalkan') DEFAULT 'Pending',
    keterangan TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_pasien) REFERENCES Pasien(id_pasien),
    FOREIGN KEY (id_rawat_jalan) REFERENCES Rawat_Jalan(id_rawat_jalan),
    FOREIGN KEY (id_rawat_inap) REFERENCES Rawat_Inap(id_rawat_inap),
    INDEX idx_status (status_pembayaran),
    INDEX idx_tanggal (tanggal_pembayaran)
) ENGINE=InnoDB COMMENT='Payment records';

-- ========================================
-- INSERT SAMPLE DATA
-- ========================================

-- Insert Dokter
INSERT INTO Dokter (nik_dokter, nama_dokter, spesialisasi, sub_spesialisasi, no_str, no_sip, nomor_telp, email, biaya_konsultasi, rating) VALUES
('3201011975010001', 'Dr. Ahmad Kurniawan, Sp.JP', 'Kardiologi', 'Interventional Cardiology', 'STR-001-2015', 'SIP-JKT-001', '081211110001', 'ahmad.k@rshospital.co.id', 300000, 4.8),
('3201021980050002', 'Dr. Bunga Sari, Sp.A', 'Anak', 'Pediatric Intensive Care', 'STR-002-2016', 'SIP-JKT-002', '081211110002', 'bunga.s@rshospital.co.id', 250000, 4.9),
('3201031978030003', 'Dr. Chandra Wijaya, Sp.S', 'Neurologi', 'Stroke Specialist', 'STR-003-2014', 'SIP-JKT-003', '081211110003', 'chandra.w@rshospital.co.id', 350000, 4.7),
('3201041982070004', 'Dr. Dian Fitriani, Sp.M', 'Mata', 'Retina Specialist', 'STR-004-2017', 'SIP-JKT-004', '081211110004', 'dian.f@rshospital.co.id', 200000, 4.6),
('3201051985110005', 'Dr. Eko Prasetyo, Sp.THT-KL', 'THT', 'Head & Neck Surgery', 'STR-005-2018', 'SIP-JKT-005', '081211110005', 'eko.p@rshospital.co.id', 220000, 4.5),
('3201061979040006', 'Dr. Fany Indah, Sp.KG', 'Gigi', 'Orthodontics', 'STR-006-2013', 'SIP-JKT-006', '081211110006', 'fany.i@rshospital.co.id', 180000, 4.8),
('3201071983090007', 'Dr. Guntur Wibowo, Sp.B', 'Bedah Umum', 'Laparoscopic Surgery', 'STR-007-2019', 'SIP-JKT-007', '081211110007', 'guntur.w@rshospital.co.id', 400000, 4.9),
('3201081981060008', 'Dr. Hilda Kartika, Sp.KK', 'Kulit & Kelamin', 'Cosmetic Dermatology', 'STR-008-2015', 'SIP-JKT-008', '081211110008', 'hilda.k@rshospital.co.id', 250000, 4.7),
('3201091977120009', 'Dr. Iwan Susanto, Sp.PD', 'Penyakit Dalam', 'Endocrinology', 'STR-009-2012', 'SIP-JKT-009', '081211110009', 'iwan.s@rshospital.co.id', 280000, 4.8),
('3201101984020010', 'Dr. Julia Permata, Sp.Onk', 'Onkologi', 'Medical Oncology', 'STR-010-2020', 'SIP-JKT-010', '081211110010', 'julia.p@rshospital.co.id', 500000, 4.9);

-- Insert Pasien
INSERT INTO Pasien (no_rekam_medis, nik, nama_pasien, tanggal_lahir, tempat_lahir, jenis_kelamin, golongan_darah, alamat, kota, provinsi, nomor_telp, email, pekerjaan, status_pernikahan, telp_darurat, asuransi, alergi) VALUES
('RM-2024-0001', '3201019501010001', 'Bima Sakti Pratama', '1995-05-10', 'Jakarta', 'Laki-laki', 'A+', 'Jl. Merdeka No. 10, Menteng', 'Jakarta Pusat', 'DKI Jakarta', '081234567001', 'bima.sakti@email.com', 'Karyawan Swasta', 'Belum Menikah', '081999888001', 'BPJS Kesehatan', 'Tidak ada'),
('RM-2024-0002', '3201021988112502', 'Dewi Anggraeni', '1988-11-25', 'Bandung', 'Perempuan', 'B+', 'Jl. Sudirman No. 25, Kebayoran', 'Jakarta Selatan', 'DKI Jakarta', '081234567002', 'dewi.ang@email.com', 'Guru SD', 'Menikah', '081999888002', 'Prudential', 'Penisilin'),
('RM-2024-0003', '3201030103010003', 'Cahyo Utomo', '2001-03-01', 'Surabaya', 'Laki-laki', 'O+', 'Jl. Gatot Subroto No. 15', 'Bandung', 'Jawa Barat', '081234567003', 'cahyo.u@email.com', 'Mahasiswa', 'Belum Menikah', '081999888003', 'BPJS Kesehatan', 'Tidak ada'),
('RM-2024-0004', '3201041975071904', 'Elsa Putri Maharani', '1975-07-19', 'Medan', 'Perempuan', 'AB+', 'Jl. Ahmad Yani No. 5', 'Surabaya', 'Jawa Timur', '081234567004', 'elsa.putri@email.com', 'Wiraswasta', 'Menikah', '081999888004', 'Allianz', 'Seafood'),
('RM-2024-0005', '3201052010010505', 'Faisal Ramadhan', '2010-01-05', 'Jakarta', 'Laki-laki', 'A-', 'Jl. Diponegoro No. 30', 'Semarang', 'Jawa Tengah', '081234567005', NULL, 'Pelajar', 'Belum Menikah', '081999888005', 'BPJS Kesehatan', 'Susu sapi'),
('RM-2024-0006', '3201061999091206', 'Gita Laksmi', '1999-09-12', 'Yogyakarta', 'Perempuan', 'B-', 'Jl. Pemuda No. 12', 'Yogyakarta', 'DI Yogyakarta', '081234567006', 'gita.laksmi@email.com', 'Mahasiswa', 'Belum Menikah', '081999888006', 'BPJS Kesehatan', 'Tidak ada'),
('RM-2024-0007', '3201071965042207', 'Hadi Santoso', '1965-04-22', 'Solo', 'Laki-laki', 'O-', 'Jl. Pahlawan No. 8', 'Malang', 'Jawa Timur', '081234567007', 'hadi.santoso@email.com', 'Pensiunan PNS', 'Menikah', '081999888007', 'BPJS Kesehatan', 'Tidak ada'),
('RM-2024-0008', '3201082005123008', 'Indah Permata Sari', '2005-12-30', 'Palembang', 'Perempuan', 'A+', 'Jl. Veteran No. 20', 'Solo', 'Jawa Tengah', '081234567008', NULL, 'Pelajar SMA', 'Belum Menikah', '081999888008', 'BPJS Kesehatan', 'Tidak ada'),
('RM-2024-0009', '3201091982081709', 'Joko Widodo', '1982-08-17', 'Medan', 'Laki-laki', 'B+', 'Jl. Gajah Mada No. 18', 'Medan', 'Sumatera Utara', '081234567009', 'joko.w@email.com', 'PNS', 'Menikah', '081999888009', 'Askes', 'Tidak ada'),
('RM-2024-0010', '3201101990021410', 'Kartika Sari Dewi', '1990-02-14', 'Jakarta', 'Perempuan', 'AB-', 'Jl. Thamrin No. 45', 'Jakarta Pusat', 'DKI Jakarta', '081234567010', 'kartika.sari@email.com', 'Marketing Manager', 'Menikah', '081999888010', 'Manulife', 'Tidak ada');

-- Insert Ruangan
INSERT INTO Ruangan (kode_ruangan, nama_ruangan, tipe_ruangan, lantai, gedung, kapasitas_bed, tarif_per_hari, fasilitas) VALUES
('VIP-301', 'Ruang VIP 301', 'VIP', 3, 'Gedung A', 1, 2000000, 'AC, TV LED 42", Kulkas, Sofa, Kamar mandi dalam, WiFi'),
('VIP-302', 'Ruang VIP 302', 'VIP', 3, 'Gedung A', 1, 2000000, 'AC, TV LED 42", Kulkas, Sofa, Kamar mandi dalam, WiFi'),
('K1-201', 'Ruang Kelas 1 - 201', 'Kelas 1', 2, 'Gedung A', 2, 800000, 'AC, TV, Lemari, Kamar mandi dalam'),
('K1-202', 'Ruang Kelas 1 - 202', 'Kelas 1', 2, 'Gedung A', 2, 800000, 'AC, TV, Lemari, Kamar mandi dalam'),
('K2-101', 'Ruang Kelas 2 - 101', 'Kelas 2', 1, 'Gedung B', 4, 400000, 'AC, TV, Kamar mandi bersama'),
('K2-102', 'Ruang Kelas 2 - 102', 'Kelas 2', 1, 'Gedung B', 4, 400000, 'AC, TV, Kamar mandi bersama'),
('K3-001', 'Ruang Kelas 3 - 001', 'Kelas 3', 1, 'Gedung C', 6, 200000, 'Kipas angin, Kamar mandi bersama'),
('ICU-401', 'ICU 401', 'ICU', 4, 'Gedung A', 1, 3000000, 'Ventilator, Monitor jantung, Peralatan ICU lengkap'),
('ICU-402', 'ICU 402', 'ICU', 4, 'Gedung A', 1, 3000000, 'Ventilator, Monitor jantung, Peralatan ICU lengkap'),
('NICU-403', 'NICU 403', 'NICU', 4, 'Gedung A', 1, 2500000, 'Inkubator bayi, Monitor khusus neonatus');

-- Insert Tindakan
INSERT INTO Tindakan (kode_tindakan, nama_tindakan, kategori_tindakan, deskripsi, biaya, durasi_estimasi) VALUES
('CONS-001', 'Konsultasi Dokter Umum', 'Konsultasi', 'Pemeriksaan dan konsultasi dengan dokter umum', 150000, 15),
('CONS-002', 'Konsultasi Dokter Spesialis', 'Konsultasi', 'Pemeriksaan dan konsultasi dengan dokter spesialis', 300000, 20),
('LAB-001', 'Pemeriksaan Darah Lengkap', 'Laboratorium', 'Hematologi lengkap, leukosit, eritrosit, trombosit', 250000, 30),
('LAB-002', 'Pemeriksaan Gula Darah Puasa', 'Laboratorium', 'Cek kadar gula darah puasa', 50000, 15),
('LAB-003', 'Pemeriksaan Kolesterol Total', 'Laboratorium', 'Cek kadar kolesterol total', 70000, 15),
('LAB-004', 'Pemeriksaan Asam Urat', 'Laboratorium', 'Cek kadar asam urat dalam darah', 60000, 15),
('LAB-005', 'Pemeriksaan Fungsi Ginjal', 'Laboratorium', 'Ureum, kreatinin, BUN', 200000, 30),
('LAB-006', 'Pemeriksaan Fungsi Hati', 'Laboratorium', 'SGOT, SGPT, Bilirubin', 250000, 30),
('RAD-001', 'Rontgen Thorax', 'Radiologi', 'Foto rontgen dada untuk melihat paru-paru dan jantung', 300000, 20),
('RAD-002', 'USG Abdomen', 'Radiologi', 'USG organ perut lengkap', 400000, 30),
('RAD-003', 'USG Kehamilan', 'Radiologi', 'USG untuk pemeriksaan kehamilan', 350000, 30),
('RAD-004', 'CT Scan Kepala', 'Radiologi', 'CT Scan otak tanpa kontras', 1500000, 45),
('RAD-005', 'MRI Brain', 'Radiologi', 'MRI otak dengan atau tanpa kontras', 3000000, 60),
('CARD-001', 'EKG (Elektrokardiogram)', 'Pemeriksaan', 'Pemeriksaan aktivitas listrik jantung', 200000, 15),
('CARD-002', 'Echocardiography', 'Pemeriksaan', 'USG jantung untuk melihat struktur dan fungsi', 800000, 45),
('CARD-003', 'Treadmill Test', 'Pemeriksaan', 'Tes jantung dengan aktivitas fisik', 500000, 30),
('TERA-001', 'Nebulizer', 'Terapi', 'Terapi uap untuk pernapasan', 100000, 20),
('TERA-002', 'Infus Cairan', 'Terapi', 'Pemberian cairan intravena', 120000, 60),
('TERA-003', 'Oksigen Terapi', 'Terapi', 'Pemberian oksigen dengan nasal kanul', 150000, 60),
('SURG-001', 'Jahit Luka Ringan', 'Operasi', 'Penjahitan luka kecil dengan anestesi lokal', 300000, 30),
('SURG-002', 'Appendectomy', 'Operasi', 'Operasi pengangkatan usus buntu', 15000000, 120),
('SURG-003', 'Operasi Cesar', 'Operasi', 'Operasi bedah sesar', 20000000, 90),
('ENT-001', 'Ekstraksi Serumen (Kotoran Telinga)', 'Pemeriksaan', 'Pembersihan kotoran telinga', 150000, 15),
('DENT-001', 'Scaling Gigi', 'Pemeriksaan', 'Pembersihan karang gigi', 200000, 30),
('DENT-002', 'Cabut Gigi', 'Operasi', 'Pencabutan gigi dengan anestesi lokal', 250000, 20),
('DENT-003', 'Tambal Gigi', 'Pemeriksaan', 'Penambalan gigi berlubang', 300000, 30),
('OPHTH-001', 'Pemeriksaan Mata Lengkap', 'Pemeriksaan', 'Visus, refraksi, tekanan bola mata', 250000, 30),
('PHYSIO-001', 'Fisioterapi (per sesi)', 'Terapi', 'Terapi fisik rehabilitasi', 200000, 45),
('ENDO-001', 'Endoskopi', 'Pemeriksaan', 'Pemeriksaan saluran cerna dengan endoskop', 2000000, 60),
('COLON-001', 'Kolonoskopi', 'Pemeriksaan', 'Pemeriksaan usus besar dengan kolonoskop', 2500000, 90);

-- Insert Obat
INSERT INTO Obat (kode_obat, nama_obat, nama_generik, kategori_obat, bentuk_sediaan, dosis_standar, satuan, harga_per_unit, stok, tanggal_kadaluarsa, produsen) VALUES
('OBT-001', 'Paracetamol 500mg', 'Paracetamol', 'Analgesik/Antipiretik', 'Tablet', '500mg', 'Tablet', 1500, 5000, '2026-12-31', 'Kimia Farma'),
('OBT-002', 'Amoxicillin 500mg', 'Amoxicillin', 'Antibiotik', 'Kapsul', '500mg', 'Kapsul', 3000, 3000, '2025-08-15', 'Sanbe Farma'),
('OBT-003', 'OBH Combi Batuk Flu', 'Dextromethorphan', 'Antitusif', 'Sirup', '60ml', 'Botol', 18000, 500, '2025-11-30', 'OBH Combi'),
('OBT-004', 'Antasida DOEN', 'Aluminum Hydroxide', 'Antasida', 'Tablet', '200mg', 'Tablet', 2000, 2000, '2026-03-20', 'Dankos'),
('OBT-005', 'Ibuprofen 400mg', 'Ibuprofen', 'NSAID', 'Tablet', '400mg', 'Tablet', 2500, 4000, '2026-06-25', 'Kalbe Farma'),
('OBT-006', 'Cetirizine 10mg', 'Cetirizine', 'Antihistamin', 'Tablet', '10mg', 'Tablet', 2000, 3500, '2025-09-10', 'Dexa Medica'),
('OBT-007', 'Ambroxol 30mg', 'Ambroxol', 'Mukolitik', 'Tablet', '30mg', 'Tablet', 2500, 2500, '2026-01-15', 'Sanbe Farma'),
('OBT-008', 'Lansoprazole 30mg', 'Lansoprazole', 'PPI', 'Kapsul', '30mg', 'Kapsul', 5000, 1500, '2025-12-05', 'Dexa Medica'),
('OBT-009', 'Metformin 500mg', 'Metformin', 'Antidiabetik', 'Tablet', '500mg', 'Tablet', 1000, 8000, '2026-07-18', 'Indofarma'),
('OBT-010', 'Amlodipine 5mg', 'Amlodipine', 'Antihipertensi', 'Tablet', '5mg', 'Tablet', 1500, 6000, '2026-04-22', 'Kalbe Farma'),
('OBT-011', 'Captopril 25mg', 'Captopril', 'ACE Inhibitor', 'Tablet', '25mg', 'Tablet', 1200, 5000, '2025-10-30', 'Kimia Farma'),
('OBT-012', 'Simvastatin 20mg', 'Simvastatin', 'Statin', 'Tablet', '20mg', 'Tablet', 3500, 3000, '2026-08-14', 'Dexa Medica'),
('OBT-013', 'Dexamethasone 0.5mg', 'Dexamethasone', 'Kortikosteroid', 'Tablet', '0.5mg', 'Tablet', 2000, 2000, '2025-07-25', 'Indofarma'),
('OBT-014', 'Omeprazole 20mg', 'Omeprazole', 'PPI', 'Kapsul', '20mg', 'Kapsul', 4000, 2500, '2026-02-28', 'Kalbe Farma'),
('OBT-015', 'Ciprofloxacin 500mg', 'Ciprofloxacin', 'Antibiotik', 'Tablet', '500mg', 'Tablet', 4500, 1500, '2025-12-20', 'Sanbe Farma'),
('OBT-016', 'Salbutamol Inhaler', 'Salbutamol', 'Bronkodilator', 'Inhaler', '100mcg', 'Inhaler', 85000, 300, '2026-05-10', 'GlaxoSmithKline'),
('OBT-017', 'Vitamin B Complex', 'B Complex', 'Vitamin', 'Tablet', '1 tablet', 'Tablet', 1500, 5000, '2027-01-31', 'Kalbe Farma'),
('OBT-018', 'Asam Mefenamat 500mg', 'Mefenamic Acid', 'NSAID', 'Kapsul', '500mg', 'Kapsul', 3000, 3000, '2025-11-08', 'Dexa Medica'),
('OBT-019', 'Betadine Solution 1%', 'Povidone Iodine', 'Antiseptik', 'Cairan', '100ml', 'Botol', 45000, 800, '2026-09-15', 'Mundipharma'),
('OBT-020', 'Ranitidine 150mg', 'Ranitidine', 'H2 Blocker', 'Tablet', '150mg', 'Tablet', 2500, 4000, '2025-06-30', 'Kimia Farma'),
('OBT-021', 'Loratadine 10mg', 'Loratadine', 'Antihistamin', 'Tablet', '10mg', 'Tablet', 2200, 3000, '2026-03-15', 'Dexa Medica'),
('OBT-022', 'Azithromycin 500mg', 'Azithromycin', 'Antibiotik', 'Tablet', '500mg', 'Tablet', 8000, 1000, '2025-10-20', 'Pfizer'),
('OBT-023', 'Loperamide 2mg', 'Loperamide', 'Antidiare', 'Kapsul', '2mg', 'Kapsul', 2000, 2500, '2026-01-10', 'Sanbe Farma'),
('OBT-024', 'Domperidone 10mg', 'Domperidone', 'Antiemetik', 'Tablet', '10mg', 'Tablet', 2500, 3000, '2025-12-12', 'Kalbe Farma'),
('OBT-025', 'Cefadroxil 500mg', 'Cefadroxil', 'Antibiotik', 'Kapsul', '500mg', 'Kapsul', 5000, 2000, '2025-09-18', 'Indofarma');

-- Insert Rawat Jalan
INSERT INTO Rawat_Jalan (no_registrasi, id_pasien, id_dokter, tanggal_kunjungan, waktu_kunjungan, keluhan_utama, tekanan_darah, suhu_tubuh, nadi, berat_badan, tinggi_badan, status_kunjungan, tipe_pembayaran, total_biaya) VALUES
('RJ-2024110001', 1, 1, '2024-11-01', '09:00:00', 'Nyeri dada dan sesak napas sejak 2 hari', '140/90', 37.2, 88, 72.5, 170, 'Selesai', 'BPJS', 650000),
('RJ-2024110002', 2, 2, '2024-11-02', '10:30:00', 'Demam tinggi pada anak, batuk pilek', '110/70', 38.5, 110, 25.0, 120, 'Selesai', 'Asuransi Swasta', 550000),
('RJ-2024110003', 3, 3, '2024-11-03', '14:00:00', 'Sakit kepala berkepanjangan, mual muntah', '120/80', 36.8, 76, 65.0, 168, 'Selesai', 'BPJS', 1850000),
('RJ-2024110004', 4, 4, '2024-11-04', '11:00:00', 'Penglihatan kabur dan mata merah', '130/85', 36.5, 72, 58.0, 160, 'Selesai', 'Asuransi Swasta', 450000),
('RJ-2024110005', 6, 6, '2024-11-05', '13:30:00', 'Sakit gigi berlubang sangat nyeri', '115/75', 36.9, 78, 45.0, 155, 'Selesai', 'BPJS', 480000),
('RJ-2024110006', 7, 7, '2024-11-06', '08:30:00', 'Luka sayat di tangan kanan akibat kecelakaan', '135/88', 37.0, 80, 68.0, 165, 'Selesai', 'BPJS', 750000),
('RJ-2024110007', 8, 2, '2024-11-07', '15:00:00', 'Batuk pilek sudah 1 minggu tidak sembuh', '105/65', 37.8, 92, 48.0, 158, 'Selesai', 'BPJS', 470000),
('RJ-2024110008', 9, 9, '2024-11-08', '09:30:00', 'Maag kambuh, mual dan nyeri ulu hati', '125/82', 36.7, 74, 70.0, 172, 'Selesai', 'Askes', 520000),
('RJ-2024110009', 1, 1, '2024-11-11', '10:00:00', 'Kontrol jantung rutin setelah perawatan', '135/85', 36.8, 78, 72.0, 170, 'Selesai', 'BPJS', 500000),
('RJ-2024110010', 10, 10, '2024-11-12', '11:30:00', 'Konsultasi hasil pemeriksaan laboratorium', '120/80', 36.5, 70, 55.0, 162, 'Selesai', 'Manulife', 800000);

-- Insert Rekam Medis
INSERT INTO Rekam_Medis (id_rawat_jalan, anamnesis, pemeriksaan_fisik, diagnosis_utama, diagnosis_sekunder, kode_icd10, prognosis, tindakan_medis, catatan_dokter, rencana_tindak_lanjut) VALUES
(1, 'Pasien mengeluh nyeri dada seperti tertimpa beban berat, sesak napas terutama saat aktivitas, keringat dingin. Riwayat hipertensi 3 tahun tidak terkontrol.', 'TD: 140/90 mmHg, N: 88x/menit, RR: 24x/menit, T: 37.2°C. Jantung: BJ I-II reguler, murmur (-), gallop (-). Paru: vesikuler (+/+), rhonki (-/-), wheezing (-/-)', 'Angina Pectoris Tidak Stabil', 'Hipertensi Stage 2', 'I20.0', 'Dubia ad Bonam', 'EKG, Pemeriksaan Enzim Jantung, Echocardiography', 'Pasien memerlukan observasi ketat. Pertimbangkan rawat inap jika keluhan memberat. Edukasi gaya hidup sehat.', 'Kontrol 1 minggu, rujuk ke kardiolog jika perlu'),
(2, 'Anak usia 14 tahun demam tinggi 3 hari, batuk berdahak, pilek, nafsu makan menurun. Tidak ada riwayat kejang.', 'TD: 110/70 mmHg, N: 110x/menit, RR: 28x/menit, T: 38.5°C. Faring hiperemis (+), tonsil T2-T2 hiperemis. Paru: ronkhi (+/+) minimal', 'ISPA (Infeksi Saluran Pernapasan Atas)', 'Faringitis Akut', 'J06.9', 'Baik', 'Pemeriksaan fisik lengkap, Nebulizer', 'Anak responsif, tidak ada tanda bahaya. Berikan antibiotik jika tidak membaik dalam 3 hari.', 'Kontrol 3 hari atau segera jika demam tidak turun'),
(3, 'Pasien mengeluh sakit kepala berdenyut sebelah kiri sejak 1 minggu, disertai mual muntah, sensitif terhadap cahaya. Riwayat migrain sejak SMA.', 'TD: 120/80 mmHg, N: 76x/menit, T: 36.8°C. Status neurologis: GCS 15, pupil isokor, refleks fisiologis +/+, refleks patologis -/-', 'Migrain dengan Aura', 'Tidak ada', 'G43.1', 'Baik', 'CT Scan kepala untuk menyingkirkan SOL', 'CT Scan dalam batas normal. Edukasi trigger migrain dan manajemen nyeri.', 'Kontrol 2 minggu, konsultasi neurologi jika sering kambuh'),
(4, 'Pasien usia 49 tahun mengeluh penglihatan kabur sejak 6 bulan, terutama untuk melihat jauh. Mata sering lelah saat bekerja.', 'Visus OD: 6/20, OS: 6/24. Pemeriksaan segmen anterior: konjungtiva anemis (-), kornea jernih. Funduskopi: papil bulat, CDR 0.3, retina flat', 'Miopia Ringan dengan Astigmatisme', 'Presbiopia dini', 'H52.1', 'Baik', 'Pemeriksaan refraksi lengkap, pemeriksaan tekanan bola mata', 'Dianjurkan memakai kacamata. Evaluasi rutin 6 bulan sekali.', 'Kontrol 6 bulan atau jika ada keluhan'),
(5, 'Pasien anak usia 14 tahun mengeluh sakit gigi kanan bawah sangat nyeri sejak 3 hari, tidak bisa makan. Gigi sudah berlubang lama.', 'Pemeriksaan intraoral: karies profunda pada gigi 46, perkusi (+), palpasi (-), mobilitas (-). OH buruk, kalkulus (+)', 'Pulpitis Irreversibel gigi 46', 'Gingivitis marginalis', 'K04.0', 'Baik', 'Ekstraksi gigi 46, Scaling gigi', 'Gigi sudah tidak bisa dipertahankan. Post ekstraksi kontrol luka. Edukasi oral hygiene.', 'Kontrol 3 hari post ekstraksi, evaluasi pemasangan gigi tiruan'),
(6, 'Pasien usia 59 tahun terjatuh dari sepeda motor, luka sayat di tangan kanan sepanjang 8 cm, perdarahan aktif. Tidak ada fraktur.', 'Vulnus laceratum regio antebrachii dextra, panjang 8 cm, kedalaman mencapai jaringan subkutis, perdarahan aktif', 'Vulnus Laceratum Antebrachii Dextra', 'Tidak ada', 'S51.8', 'Baik', 'Debridement luka, Jahit luka 12 jahitan, Injeksi ATS', 'Luka dijahit primer dengan baik. Berikan antibiotik profilaksis. Rawat luka teratur.', 'Kontrol 3 hari, angkat jahitan hari ke-10'),
(7, 'Pasien anak usia 19 tahun batuk berdahak putih kental sejak 1 minggu, sesak napas terutama malam hari, riwayat asma (+).', 'TD: 105/65 mmHg, N: 92x/menit, RR: 26x/menit, T: 37.8°C. Thorax: wheezing (+/+), ekspirasi memanjang', 'Bronkitis Akut ec Asma Bronkial', 'Asma persisten ringan', 'J45.0', 'Baik', 'Nebulizer dengan Salbutamol, Pemeriksaan Spirometri', 'Respon terhadap bronkodilator baik. Edukasi penggunaan inhaler yang benar.', 'Kontrol 1 minggu, pakai inhaler rutin'),
(8, 'Pasien usia 42 tahun nyeri ulu hati seperti terbakar, mual, kembung setelah makan. Riwayat sering makan tidak teratur dan pedas.', 'TD: 125/82 mmHg, N: 74x/menit, T: 36.7°C. Abdomen: supel, nyeri tekan epigastrium (+), BU (+) normal', 'Gastritis Akut', 'Dispepsia fungsional', 'K29.1', 'Baik', 'Pemeriksaan fisik abdomen lengkap', 'Diagnosis klinis gastritis. Jika tidak membaik pertimbangkan endoskopi. Edukasi pola makan teratur.', 'Kontrol 1 minggu, hindari makanan pedas dan asam'),
(9, 'Pasien kontrol rutin pasca perawatan angina. Keluhan nyeri dada sudah berkurang, aktivitas sehari-hari dapat dilakukan.', 'TD: 135/85 mmHg, N: 78x/menit, T: 36.8°C. Kondisi umum baik, tidak ada keluhan aktif', 'Penyakit Jantung Koroner Stabil', 'Hipertensi terkontrol', 'I25.1', 'Baik', 'EKG kontrol, Pemeriksaan lab lipid profil', 'Kondisi pasien stabil. Lanjutkan obat antiplatelet dan statin. Edukasi diet rendah lemak.', 'Kontrol rutin 1 bulan sekali'),
(10, 'Pasien wanita 34 tahun konsultasi hasil lab, ada keluhan mudah lelah, pusing berputar. Riwayat menstruasi banyak.', 'TD: 120/80 mmHg, N: 70x/menit, T: 36.5°C. Konjungtiva anemis (+/+), pemeriksaan fisik lain dalam batas normal', 'Anemia Defisiensi Besi', 'Tidak ada', 'D50.9', 'Baik', 'Konsultasi hasil lab (Hb 9.2 g/dL, MCV rendah)', 'Anemia ringan-sedang. Berikan suplemen besi dan asam folat. Evaluasi sumber perdarahan jika perlu.', 'Kontrol 1 bulan dengan lab control Hb');

-- Insert Tindakan Rekam Medis
INSERT INTO Tindakan_Rekam_Medis (id_tindakan, id_rekam_medis, tanggal_tindakan, hasil_tindakan, catatan, biaya_tindakan, status_pembayaran) VALUES
(2, 1, '2024-11-01 09:15:00', 'Konsultasi lengkap dengan anamnesis dan pemeriksaan fisik', 'Pasien kooperatif', 300000, 'Lunas'),
(14, 1, '2024-11-01 09:30:00', 'EKG menunjukkan ST depression di lead II, III, aVF', 'Perlu evaluasi lebih lanjut', 200000, 'Lunas'),
(15, 1, '2024-11-01 10:00:00', 'Echo: EF 55%, LV hipertrofi ringan, katup normal', 'Fungsi jantung masih baik', 800000, 'Lunas'),
(2, 2, '2024-11-02 10:45:00', 'Pemeriksaan anak lengkap', 'Anak kooperatif', 250000, 'Lunas'),
(17, 2, '2024-11-02 11:00:00', 'Nebulizer dengan Salbutamol, respon baik', 'Sesak berkurang', 100000, 'Lunas'),
(3, 2, '2024-11-02 11:15:00', 'Hb: 12.5, Leukosit: 15.200, LED: 20', 'Leukositosis ringan', 250000, 'Lunas'),
(2, 3, '2024-11-03 14:15:00', 'Konsultasi neurologi lengkap', 'Pemeriksaan neurologis normal', 350000, 'Lunas'),
(12, 3, '2024-11-03 15:00:00', 'CT Scan kepala tanpa kontras: tidak tampak SOL, perdarahan, atau infark', 'Hasil dalam batas normal', 1500000, 'Lunas'),
(2, 4, '2024-11-04 11:20:00', 'Konsultasi spesialis mata', 'Pemeriksaan lengkap', 200000, 'Lunas'),
(27, 4, '2024-11-04 11:40:00', 'Visus OD: 6/20 → 6/6 (S-1.25 C-0.50), OS: 6/24 → 6/6 (S-1.50 C-0.75)', 'Koreksi optimal', 250000, 'Lunas'),
(2, 5, '2024-11-05 13:45:00', 'Konsultasi gigi', 'Pemeriksaan intraoral lengkap', 180000, 'Lunas'),
(25, 5, '2024-11-05 14:00:00', 'Ekstraksi gigi 46 dengan anestesi lokal, perdarahan terkontrol', 'Post ekstraksi baik', 300000, 'Lunas'),
(2, 6, '2024-11-06 08:45:00', 'Konsultasi bedah', 'Evaluasi luka', 400000, 'Lunas'),
(20, 6, '2024-11-06 09:00:00', 'Debridement dan jahit luka 12 jahitan dengan anestesi lokal', 'Luka dijahit rapi', 350000, 'Lunas'),
(2, 7, '2024-11-07 15:15:00', 'Konsultasi anak', 'Pemeriksaan lengkap', 250000, 'Lunas'),
(17, 7, '2024-11-07 15:30:00', 'Nebulizer salbutamol, respon baik', 'Wheezing berkurang', 100000, 'Lunas'),
(15, 7, '2024-11-07 16:00:00', 'Spirometri: FEV1 65% predicted, FEV1/FVC 68%', 'Obstruksi ringan', 350000, 'Lunas'),
(2, 8, '2024-11-08 09:45:00', 'Konsultasi penyakit dalam', 'Pemeriksaan abdomen lengkap', 280000, 'Lunas'),
(2, 9, '2024-11-11 10:15:00', 'Konsultasi kardiologi kontrol', 'Kondisi stabil', 300000, 'Lunas'),
(14, 9, '2024-11-11 10:30:00', 'EKG: Sinus rhythm, HR 78, dalam batas normal', 'Tidak ada kelainan akut', 200000, 'Lunas'),
(2, 10, '2024-11-12 11:45:00', 'Konsultasi onkologi', 'Evaluasi hasil lab', 500000, 'Lunas'),
(3, 10, '2024-11-12 12:00:00', 'Hb: 9.2, MCV: 68, MCH: 24, Ferritin rendah', 'Anemia mikrositik hipokrom', 300000, 'Lunas');

-- Insert Resep Obat
INSERT INTO Resep_Obat (no_resep, id_rekam_medis, id_dokter, tanggal_resep, status_resep, total_biaya) VALUES
('RO-2024110001', 1, 1, '2024-11-01 10:30:00', 'Selesai', 147000),
('RO-2024110002', 2, 2, '2024-11-02 11:30:00', 'Selesai', 94000),
('RO-2024110003', 3, 3, '2024-11-03 15:30:00', 'Selesai', 48000),
('RO-2024110004', 4, 4, '2024-11-04 12:00:00', 'Selesai', 10000),
('RO-2024110005', 5, 6, '2024-11-05 14:30:00', 'Selesai', 106000),
('RO-2024110006', 6, 7, '2024-11-06 09:30:00', 'Selesai', 103000),
('RO-2024110007', 7, 2, '2024-11-07 16:30:00', 'Selesai', 109500),
('RO-2024110008', 8, 9, '2024-11-08 10:15:00', 'Selesai', 83000),
('RO-2024110009', 9, 1, '2024-11-11 11:00:00', 'Selesai', 152000),
('RO-2024110010', 10, 10, '2024-11-12 12:30:00', 'Selesai', 67500);

-- Insert Detail Resep
INSERT INTO Detail_Resep (id_resep, id_obat, jumlah, dosis, frekuensi, durasi, aturan_pakai, harga_satuan, subtotal) VALUES
-- Resep 1: Angina Pectoris
(1, 10, 30, '5mg', '1x1', '30 hari', 'Diminum 1 tablet setiap pagi setelah makan', 1500, 45000),
(1, 11, 60, '25mg', '2x1', '30 hari', 'Diminum 2x sehari pagi dan sore', 1200, 72000),
(1, 12, 30, '20mg', '1x1', '30 hari', 'Diminum malam hari sebelum tidur', 3500, 105000),
-- Resep 2: ISPA Anak
(2, 2, 15, '500mg', '3x1', '5 hari', 'Diminum 3x sehari sesudah makan', 3000, 45000),
(2, 7, 15, '30mg', '3x1', '5 hari', 'Diminum 3x sehari', 2500, 37500),
(2, 1, 10, '500mg', '3x1', '3 hari', 'Diminum jika demam', 1500, 15000),
-- Resep 3: Migrain
(3, 5, 10, '400mg', 'prn', '10 hari', 'Diminum saat nyeri kepala maksimal 3x sehari', 2500, 25000),
(3, 24, 10, '10mg', '3x1', '3 hari', 'Diminum jika mual', 2500, 25000),
-- Resep 4: Miopia (tetes mata)
(4, 1, 10, '500mg', 'prn', 'bila perlu', 'Diminum jika nyeri mata', 1500, 15000),
-- Resep 5: Post Ekstraksi Gigi
(5, 18, 15, '500mg', '3x1', '5 hari', 'Diminum 3x sehari sesudah makan', 3000, 45000),
(5, 2, 15, '500mg', '3x1', '5 hari', 'Antibiotik diminum sampai habis', 3000, 45000),
(5, 19, 1, '100ml', '2x sehari', '7 hari', 'Kumur-kumur setelah makan', 45000, 45000),
-- Resep 6: Post Jahit Luka
(6, 2, 15, '500mg', '3x1', '5 hari', 'Antibiotik diminum sampai habis', 3000, 45000),
(6, 1, 15, '500mg', '3x1', '5 hari', 'Diminum jika nyeri', 1500, 22500),
(6, 19, 1, '100ml', '2x sehari', '7 hari', 'Untuk membersihkan luka', 45000, 45000),
-- Resep 7: Bronkitis/Asma
(7, 16, 1, '100mcg', '2 puff 3x sehari', '30 hari', 'Semprot 2x jika sesak napas', 85000, 85000),
(7, 7, 10, '30mg', '3x1', '3 hari', 'Diminum untuk mengencerkan dahak', 2500, 25000),
-- Resep 8: Gastritis
(8, 8, 14, '30mg', '1x1', '14 hari', 'Diminum pagi hari sebelum makan', 5000, 70000),
(8, 4, 20, '200mg', '3x1', '7 hari', 'Diminum jika nyeri ulu hati', 2000, 40000),
-- Resep 9: PJK Stabil (kontrol)
(9, 10, 30, '5mg', '1x1', '30 hari', 'Diminum rutin setiap pagi', 1500, 45000),
(9, 11, 60, '25mg', '2x1', '30 hari', 'Diminum 2x sehari', 1200, 72000),
(9, 12, 30, '20mg', '1x1', '30 hari', 'Diminum malam hari', 3500, 105000),
-- Resep 10: Anemia
(10, 17, 30, '1 tablet', '1x1', '30 hari', 'Vitamin B Complex diminum pagi hari', 1500, 45000),
(10, 1, 15, '500mg', '3x1', '5 hari', 'Diminum jika pusing', 1500, 22500);

-- Insert Jadwal Dokter
INSERT INTO Jadwal_Dokter (id_dokter, hari, jam_mulai, jam_selesai, kuota_pasien, status_jadwal) VALUES
(1, 'Senin', '08:00:00', '12:00:00', 20, 'Aktif'),
(1, 'Rabu', '08:00:00', '12:00:00', 20, 'Aktif'),
(1, 'Jumat', '13:00:00', '17:00:00', 15, 'Aktif'),
(2, 'Senin', '10:00:00', '14:00:00', 25, 'Aktif'),
(2, 'Selasa', '10:00:00', '14:00:00', 25, 'Aktif'),
(2, 'Kamis', '10:00:00', '14:00:00', 25, 'Aktif'),
(3, 'Selasa', '14:00:00', '18:00:00', 15, 'Aktif'),
(3, 'Kamis', '14:00:00', '18:00:00', 15, 'Aktif'),
(4, 'Senin', '09:00:00', '13:00:00', 20, 'Aktif'),
(4, 'Rabu', '09:00:00', '13:00:00', 20, 'Aktif'),
(4, 'Jumat', '09:00:00', '13:00:00', 20, 'Aktif'),
(5, 'Selasa', '08:00:00', '12:00:00', 18, 'Aktif'),
(5, 'Kamis', '13:00:00', '17:00:00', 18, 'Aktif');

-- ========================================
-- VIEWS - REPORTING & ANALYTICS
-- ========================================

-- View: Dashboard Pasien
CREATE VIEW v_dashboard_pasien AS
SELECT 
    p.id_pasien,
    p.no_rekam_medis,
    p.nama_pasien,
    p.jenis_kelamin,
    TIMESTAMPDIFF(YEAR, p.tanggal_lahir, CURDATE()) AS usia,
    p.golongan_darah,
    p.nomor_telp,
    p.asuransi,
    COUNT(DISTINCT rj.id_rawat_jalan) AS total_kunjungan,
    MAX(rj.tanggal_kunjungan) AS kunjungan_terakhir,
    p.status_pasien
FROM Pasien p
LEFT JOIN Rawat_Jalan rj ON p.id_pasien = rj.id_pasien
GROUP BY p.id_pasien, p.no_rekam_medis, p.nama_pasien, p.jenis_kelamin, p.tanggal_lahir, 
         p.golongan_darah, p.nomor_telp, p.asuransi, p.status_pasien;

-- View: Kinerja Dokter
CREATE VIEW v_kinerja_dokter AS
SELECT 
    d.id_dokter,
    d.nama_dokter,
    d.spesialisasi,
    d.rating,
    COUNT(DISTINCT rj.id_rawat_jalan) AS total_pasien_ditangani,
    COUNT(DISTINCT ro.id_resep) AS total_resep,
    SUM(rj.total_biaya) AS total_pendapatan,
    AVG(rj.total_biaya) AS rata_rata_biaya_kunjungan,
    d.status_dokter
FROM Dokter d
LEFT JOIN Rawat_Jalan rj ON d.id_dokter = rj.id_dokter
LEFT JOIN Resep_Obat ro ON d.id_dokter = ro.id_dokter
WHERE rj.status_kunjungan = 'Selesai'
GROUP BY d.id_dokter, d.nama_dokter, d.spesialisasi, d.rating, d.status_dokter;

-- View: Laporan Kunjungan Harian
CREATE VIEW v_kunjungan_harian AS
SELECT 
    DATE(rj.tanggal_kunjungan) AS tanggal,
    COUNT(rj.id_rawat_jalan) AS jumlah_kunjungan,
    COUNT(DISTINCT rj.id_pasien) AS jumlah_pasien_unik,
    COUNT(DISTINCT rj.id_dokter) AS jumlah_dokter_praktik,
    SUM(rj.total_biaya) AS total_pendapatan,
    AVG(rj.total_biaya) AS rata_rata_biaya
FROM Rawat_Jalan rj
WHERE rj.status_kunjungan = 'Selesai'
GROUP BY DATE(rj.tanggal_kunjungan)
ORDER BY tanggal DESC;

-- View: Top 10 Diagnosis
CREATE VIEW v_top_diagnosis AS
SELECT 
    rm.diagnosis_utama,
    rm.kode_icd10,
    COUNT(*) AS jumlah_kasus,
    COUNT(DISTINCT rm.id_rawat_jalan) AS jumlah_pasien
FROM Rekam_Medis rm
GROUP BY rm.diagnosis_utama, rm.kode_icd10
ORDER BY jumlah_kasus DESC
LIMIT 10;

-- View: Stok Obat Kritis
CREATE VIEW v_stok_obat_kritis AS
SELECT 
    o.id_obat,
    o.kode_obat,
    o.nama_obat,
    o.kategori_obat,
    o.stok,
    o.stok_minimum,
    (o.stok - o.stok_minimum) AS selisih,
    o.tanggal_kadaluarsa,
    DATEDIFF(o.tanggal_kadaluarsa, CURDATE()) AS hari_sampai_kadaluarsa,
    CASE 
        WHEN o.stok <= o.stok_minimum THEN 'KRITIS'
        WHEN o.stok <= (o.stok_minimum * 1.5) THEN 'PERLU RESTOCK'
        ELSE 'AMAN'
    END AS status_stok
FROM Obat o
WHERE o.status_obat = 'Tersedia'
ORDER BY selisih ASC;

-- View: Occupancy Rate Ruangan
CREATE VIEW v_occupancy_ruangan AS
SELECT 
    r.id_ruangan,
    r.kode_ruangan,
    r.nama_ruangan,
    r.tipe_ruangan,
    r.kapasitas_bed,
    r.bed_terisi,
    ROUND((r.bed_terisi / r.kapasitas_bed * 100), 2) AS occupancy_rate,
    r.status_ruangan
FROM Ruangan r
ORDER BY occupancy_rate DESC;

-- View: Pendapatan Per Tipe Pembayaran
CREATE VIEW v_pendapatan_pembayaran AS
SELECT 
    rj.tipe_pembayaran,
    COUNT(rj.id_rawat_jalan) AS jumlah_transaksi,
    SUM(rj.total_biaya) AS total_pendapatan,
    AVG(rj.total_biaya) AS rata_rata_transaksi,
    MIN(rj.total_biaya) AS transaksi_terkecil,
    MAX(rj.total_biaya) AS transaksi_terbesar
FROM Rawat_Jalan rj
WHERE rj.status_kunjungan = 'Selesai'
GROUP BY rj.tipe_pembayaran
ORDER BY total_pendapatan DESC;

-- View: Obat Paling Banyak Diresepkan
CREATE VIEW v_obat_populer AS
SELECT 
    o.id_obat,
    o.nama_obat,
    o.kategori_obat,
    COUNT(dr.id_detail_resep) AS jumlah_resep,
    SUM(dr.jumlah) AS total_unit_terjual,
    SUM(dr.subtotal) AS total_penjualan
FROM Obat o
JOIN Detail_Resep dr ON o.id_obat = dr.id_obat
JOIN Resep_Obat ro ON dr.id_resep = ro.id_resep
WHERE ro.status_resep = 'Selesai'
GROUP BY o.id_obat, o.nama_obat, o.kategori_obat
ORDER BY jumlah_resep DESC
LIMIT 20;

-- ========================================
-- STORED PROCEDURES
-- ========================================

-- Procedure: Registrasi Rawat Jalan
DELIMITER //
CREATE PROCEDURE sp_registrasi_rawat_jalan(
    IN p_id_pasien INT,
    IN p_id_dokter INT,
    IN p_tanggal DATE,
    IN p_waktu TIME,
    IN p_keluhan TEXT,
    OUT p_no_registrasi VARCHAR(30),
    OUT p_status VARCHAR(50),
    OUT p_message VARCHAR(255)
)
BEGIN
    DECLARE v_count INT;
    DECLARE v_kuota INT;
    DECLARE v_hari VARCHAR(10);
    
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SET p_status = 'GAGAL';
        SET p_message = 'Terjadi kesalahan sistem';
    END;
    
    START TRANSACTION;
    
    -- Generate nomor registrasi
    SET p_no_registrasi = CONCAT('RJ-', DATE_FORMAT(NOW(), '%Y%m%d'), 
                                 LPAD(FLOOR(RAND() * 9999), 4, '0'));
    
    -- Cek hari
    SET v_hari = DAYNAME(p_tanggal);
    SET v_hari = CASE v_hari
        WHEN 'Monday' THEN 'Senin'
        WHEN 'Tuesday' THEN 'Selasa'
        WHEN 'Wednesday' THEN 'Rabu'
        WHEN 'Thursday' THEN 'Kamis'
        WHEN 'Friday' THEN 'Jumat'
        WHEN 'Saturday' THEN 'Sabtu'
        WHEN 'Sunday' THEN 'Minggu'
    END;
    
    -- Cek kuota dokter
    SELECT kuota_pasien INTO v_kuota
    FROM Jadwal_Dokter
    WHERE id_dokter = p_id_dokter 
    AND hari = v_hari
    AND status_jadwal = 'Aktif'
    LIMIT 1;
    
    IF v_kuota IS NULL THEN
        SET p_status = 'GAGAL';
        SET p_message = 'Dokter tidak praktik di hari tersebut';
        ROLLBACK;
    ELSE
        -- Cek jumlah pasien hari itu
        SELECT COUNT(*) INTO v_count
        FROM Rawat_Jalan
        WHERE id_dokter = p_id_dokter 
        AND tanggal_kunjungan = p_tanggal;
        
        IF v_count >= v_kuota THEN
            SET p_status = 'GAGAL';
            SET p_message = 'Kuota dokter sudah penuh';
            ROLLBACK;
        ELSE
            INSERT INTO Rawat_Jalan (no_registrasi, id_pasien, id_dokter, tanggal_kunjungan, 
                                     waktu_kunjungan, keluhan_utama, status_kunjungan)
            VALUES (p_no_registrasi, p_id_pasien, p_id_dokter, p_tanggal, p_waktu, 
                    p_keluhan, 'Terdaftar');
            
            SET p_status = 'BERHASIL';
            SET p_message = CONCAT('Registrasi berhasil. No: ', p_no_registrasi);
            COMMIT;
        END IF;
    END IF;
END //
DELIMITER ;

-- Procedure: Hitung Total Biaya Rawat Jalan
DELIMITER //
CREATE PROCEDURE sp_hitung_biaya_rawat_jalan(
    IN p_id_rawat_jalan INT,
    OUT p_total_biaya DECIMAL(12,2)
)
BEGIN
    DECLARE v_biaya_konsultasi DECIMAL(10,2);
    DECLARE v_biaya_tindakan DECIMAL(12,2);
    DECLARE v_biaya_resep DECIMAL(10,2);
    
    -- Ambil biaya konsultasi
    SELECT d.biaya_konsultasi INTO v_biaya_konsultasi
    FROM Rawat_Jalan rj
    JOIN Dokter d ON rj.id_dokter = d.id_dokter
    WHERE rj.id_rawat_jalan = p_id_rawat_jalan;
    
    -- Hitung biaya tindakan
    SELECT COALESCE(SUM(trm.biaya_tindakan), 0) INTO v_biaya_tindakan
    FROM Tindakan_Rekam_Medis trm
    JOIN Rekam_Medis rm ON trm.id_rekam_medis = rm.id_rekam_medis
    WHERE rm.id_rawat_jalan = p_id_rawat_jalan;
    
    -- Hitung biaya resep
    SELECT COALESCE(SUM(ro.total_biaya), 0) INTO v_biaya_resep
    FROM Resep_Obat ro
    JOIN Rekam_Medis rm ON ro.id_rekam_medis = rm.id_rekam_medis
    WHERE rm.id_rawat_jalan = p_id_rawat_jalan;
    
    SET p_total_biaya = COALESCE(v_biaya_konsultasi, 0) + v_biaya_tindakan + v_biaya_resep;
    
    -- Update total biaya di rawat jalan
    UPDATE Rawat_Jalan 
    SET total_biaya = p_total_biaya
    WHERE id_rawat_jalan = p_id_rawat_jalan;
END //
DELIMITER ;

-- ========================================
-- TRIGGERS
-- ========================================

-- Trigger: Update total biaya resep
DELIMITER //
CREATE TRIGGER trg_after_detail_resep_insert
AFTER INSERT ON Detail_Resep
FOR EACH ROW
BEGIN
    UPDATE Resep_Obat
    SET total_biaya = (
        SELECT SUM(subtotal)
        FROM Detail_Resep
        WHERE id_resep = NEW.id_resep
    )
    WHERE id_resep = NEW.id_resep;
END //
DELIMITER ;

-- Trigger: Kurangi stok obat setelah resep selesai
DELIMITER //
CREATE TRIGGER trg_after_resep_selesai
AFTER UPDATE ON Resep_Obat
FOR EACH ROW
BEGIN
    IF NEW.status_resep = 'Selesai' AND OLD.status_resep != 'Selesai' THEN
        UPDATE Obat o
        JOIN Detail_Resep dr ON o.id_obat = dr.id_obat
        SET o.stok = o.stok - dr.jumlah
        WHERE dr.id_resep = NEW.id_resep;
    END IF;
END //
DELIMITER ;

-- Trigger: Update status ruangan
DELIMITER //
CREATE TRIGGER trg_after_rawat_inap_insert
AFTER INSERT ON Rawat_Inap
FOR EACH ROW
BEGIN
    UPDATE Ruangan
    SET bed_terisi = bed_terisi + 1,
        status_ruangan = CASE 
            WHEN bed_terisi + 1 >= kapasitas_bed THEN 'Terisi'
            ELSE 'Tersedia'
        END
    WHERE id_ruangan = NEW.id_ruangan;
END //
DELIMITER ;

-- ========================================
-- SAMPLE USAGE QUERIES
-- ========================================

-- Test 1: Lihat dashboard pasien
-- SELECT * FROM v_dashboard_pasien LIMIT 10;

-- Test 2: Kinerja dokter terbaik
-- SELECT * FROM v_kinerja_dokter ORDER BY total_pasien_ditangani DESC LIMIT 5;

-- Test 3: Stok obat yang perlu di-restock
-- SELECT * FROM v_stok_obat_kritis WHERE status_stok IN ('KRITIS', 'PERLU RESTOCK');

-- Test 4: Registrasi pasien baru
-- CALL sp_registrasi_rawat_jalan(1, 1, '2024-11-25', '09:00:00', 'Kontrol rutin', @no, @status, @msg);
-- SELECT @no, @status, @msg;

-- Test 5: Hitung total biaya
-- CALL sp_hitung_biaya_rawat_jalan(1, @total);
-- SELECT @total AS total_biaya;

-- ========================================
-- INDEXES FOR OPTIMIZATION
-- ========================================
CREATE INDEX idx_rawat_jalan_composite ON Rawat_Jalan(id_pasien, tanggal_kunjungan, status_kunjungan);
CREATE INDEX idx_rekam_medis_diagnosis ON Rekam_Medis(diagnosis_utama, kode_icd10);
CREATE INDEX idx_resep_tanggal ON Resep_Obat(tanggal_resep, status_resep);
CREATE INDEX idx_obat_kategori_stok ON Obat(kategori_obat, stok, status_obat);

-- ========================================
-- END OF DATABASE SCRIPT
-- ========================================

SELECT 
    'Database Rumah Sakit berhasil dibuat!' AS Status,
    COUNT(DISTINCT table_name) AS Total_Tables,
    'Professional hospital management system ready!' AS Message
FROM information_schema.tables 
WHERE table_schema = 'rumah_sakit';
