-- =====================================================
-             -- DATABASE RUMAH SAKIT --
-- =====================================================

CREATE DATABASE IF NOT EXISTS rumah_sakit;
USE rumah_sakit;


DROP TABLE IF EXISTS TINDAKAN_REKAM_MEDIS;
DROP TABLE IF EXISTS Rekam_Medis;
DROP TABLE IF EXISTS RAWAT_JALAN;
DROP TABLE IF EXISTS DETAIL_PASIEN;
DROP TABLE IF EXISTS TINDAKAN;
DROP TABLE IF EXISTS DOKTER;
DROP TABLE IF EXISTS PASIEN;
DROP TABLE IF EXISTS OBAT;

-- =====================================================
-- 1. TABEL DOKTER
-- =====================================================
CREATE TABLE DOKTER (
    id_dokter INT PRIMARY KEY AUTO_INCREMENT,
    nama_dokter VARCHAR(100) NOT NULL,
    spesialisasi VARCHAR(50),
    nomor_telp VARCHAR(15)
);

-- UPDATE 
UPDATE DOKTER
SET nama_dokter = 'Dr. Islam jaidi'
WHERE id_dokter = 1;

-- INSERT
INSERT INTO DOKTER (nama_dokter, spesialisasi, nomor_telp) 
VALUES
('Dr. Ahmad Kurniawan', 'Jantung', '081211110001'),
('Dr. Bunga Sari', 'Anak', '081211110002'),
('Dr. Chandra Wijaya', 'Saraf', '081211110003'),
('Dr. Dian Fitriani', 'Mata', '081211110004'),
('Dr. Eko Prasetyo', 'THT', '081211110005'),
('Dr. Fany Indah', 'Gigi', '081211110006'),
('Dr. Guntur Wibowo', 'Bedah Umum', '081211110007'),
('Dr. Hilda Kartika', 'Kulit & Kelamin', '081211110008'),
('Dr. Iwan Susanto', 'Penyakit Dalam', '081211110009'),
('Dr. Julia Permata', 'Onkologi', '081211110010'),
('Dr. Kevin Liem', 'Radiologi', '081211110011'),
('Dr. Lani Puspita', 'Psikiater', '081211110012'),
('Dr. Mega Utami', 'Gizi Klinis', '081211110013'),
('Dr. Niko Saputra', 'Kardiologi', '081211110014'),
('Dr. Olivia Wijaya', 'Gastroenterologi', '081211110015'),
('Dr. Panca Setiawan', 'Pulmonologi', '081211110016'),
('Dr. Qiqi Zahra', 'Rehabilitasi Medis', '081211110017'),
('Dr. Rahmat Hidayat', 'Urologi', '081211110018'),
('Dr. Sari Dewi', 'Neurologi', '081211110019'),
('Dr. Taufik Akbar', 'Bedah Ortopedi', '081211110020'),
('Dr. Umi Kalsum', 'Hematologi', '081211110021'),
('Dr. Victor Tanuwijaya', 'Anestesiologi', '081211110022'),
('Dr. Wulan Permatasari', 'Endokrinologi', '081211110023'),
('Dr. Xena Putri', 'Imunologi', '081211110024'),
('Dr. Yogi Pamungkas', 'Bedah Plastik', '081211110025'),
('Dr. Zian Alamsyah', 'Patologi Klinik', '081211110026'),
('Dr. Agnes Monica', 'Mata', '081211110027'),
('Dr. Bobby Chandra', 'Gigi', '081211110028'),
('Dr. Cici Mariana', 'Anak', '081211110029'),
('Dr. Deddy Corbuzier', 'Bedah Umum', '081211110030'),
('Dr. Elsa Wijaya', 'Penyakit Dalam', '081211110031'),
('Dr. Fajar Rahadi', 'Saraf', '081211110032'),
('Dr. Gita Gutawa', 'Gizi Klinis', '081211110033'),
('Dr. Hari Subagyo', 'Jantung', '081211110034'),
('Dr. Intan Nuraini', 'THT', '081211110035'),
('Dr. Joni Iskandar', 'Kulit & Kelamin', '081211110036'),
('Dr. Karina Salim', 'Onkologi', '081211110037'),
('Dr. Lutfi Hakim', 'Radiologi', '081211110038'),
('Dr. Maya Dewi', 'Psikiater', '081211110039'),
('Dr. Nasution', 'Kardiologi', '081211110040'),
('Dr. Prabu Angkasa', 'Gastroenterologi', '081211110041'),
('Dr. Riana Sari', 'Pulmonologi', '081211110042'),
('Dr. Surya Wijaya', 'Rehabilitasi Medis', '081211110043'),
('Dr. Tina Amelia', 'Urologi', '081211110044'),
('Dr. Umar Bakri', 'Neurologi', '081211110045'),
('Dr. Vera Susanti', 'Bedah Ortopedi', '081211110046'),
('Dr. Wahyu Aditama', 'Hematologi', '081211110047'),
('Dr. Yuni Shara', 'Anestesiologi', '081211110048'),
('Dr. Zacky Anwar', 'Endokrinologi', '081211110049'),
('Dr. Cindy Claudia', 'Bedah Plastik', '081211110050');

-- select
select * from DOKTER;


-- =====================================================
-- 2. TABEL PASIEN
-- =====================================================
CREATE TABLE PASIEN (
    id_pasien INT PRIMARY KEY AUTO_INCREMENT,
    nama_pasien VARCHAR(100) NOT NULL,
    tgl_lahir DATE,
    jenis_kelamin ENUM('Laki-laki', 'Perempuan')
);

UPDATE PASIEN
SET nama_pasien = 'Ahmad Fahmi Fadillah'
WHERE id_pasien = 1;


INSERT INTO PASIEN (nama_pasien, tgl_lahir, jenis_kelamin)
VALUES
('Bima Sakti', '1995-05-10', 'Laki-laki'),
('Dewi Anggraeni', '1988-11-25', 'Perempuan'),
('Cahyo Utomo', '2001-03-01', 'Laki-laki'),
('Elsa Putri', '1975-07-19', 'Perempuan'),
('Faisal Ramadhan', '2010-01-05', 'Laki-laki'),
('Gita Laksmi', '1999-09-12', 'Perempuan'),
('Hadi Santoso', '1965-04-22', 'Laki-laki'),
('Indah Permata', '2005-12-30', 'Perempuan'),
('Joko Widodo', '1982-08-17', 'Laki-laki'),
('Kartika Sari', '1990-02-14', 'Perempuan'),
('Lukman Hakim', '2008-06-03', 'Laki-laki'),
('Maya Kusuma', '1970-10-11', 'Perempuan'),
('Naufal Arief', '1993-01-20', 'Laki-laki'),
('Oktavia Dewi', '2015-04-04', 'Perempuan'),
('Pratama Yoga', '1980-09-09', 'Laki-laki'),
('Risa Amelia', '2003-11-08', 'Perempuan'),
('Slamet Riyadi', '1960-02-28', 'Laki-laki'),
('Tanti Melati', '1997-07-07', 'Perempuan'),
('Umar Faruq', '2012-03-15', 'Laki-laki'),
('Vina Marissa', '1985-05-01', 'Perempuan'),
('Wahyudi Eka', '1978-08-21', 'Laki-laki'),
('Yulia Rahma', '2000-06-16', 'Perempuan'),
('Zaky Maulana', '1998-04-02', 'Laki-laki'),
('Ani Susanti', '1991-03-29', 'Perempuan'),
('Bambang Setyawan', '1968-12-12', 'Laki-laki'),
('Cici Paramida', '2007-01-27', 'Perempuan'),
('Dito Prasetyo', '1984-10-06', 'Laki-laki'),
('Erlina Wati', '1973-05-18', 'Perempuan'),
('Gunawan Putra', '2004-09-23', 'Laki-laki'),
('Hesti Maharani', '1962-08-05', 'Perempuan');

SELECT * FROM PASIEN;
-- =====================================================
-- 3. TABEL DETAIL_PASIEN (FIXED: Hapus AUTO_INCREMENT)
-- =====================================================
CREATE TABLE DETAIL_PASIEN(
    id_pasien INT PRIMARY KEY,
    nama_pasien VARCHAR(100),
    alamat VARCHAR(100),
    pekerjaan VARCHAR(40) NOT NULL,
    FOREIGN KEY (id_pasien) REFERENCES PASIEN(id_pasien) ON DELETE CASCADE
);

SELECT * FROM DETAIL_PASIEN;
UPDATE DETAIL_PASIEN
SET pekerjaan = 'TRADER FOREX'
WHERE id_pasien = 2;

ALTER TABLE DETAIL_PASIEN
ADD nama_pengguna VARCHAR(50) UNIQUE;


INSERT INTO DETAIL_PASIEN (id_pasien, alamat, pekerjaan, nama_pengguna) 
VALUES
(1, 'Jl. Merdeka No. 10, Jakarta Pusat', 'Wiraswasta', 'marwan'),
(2, 'Jl. Sudirman No. 25, Jakarta Selatan', 'Guru', 'guru_sudirman'),
(3, 'Jl. Gatot Subroto No. 15, Bandung', 'Pegawai Swasta', 'gatot_pws'),
(4, 'Jl. Ahmad Yani No. 5, Surabaya', 'Pensiunan', 'pensiunan_yani'),
(5, 'Jl. Diponegoro No. 30, Semarang', 'Pelajar', 'pelajar_dipo'),
(6, 'Jl. Pemuda No. 12, Yogyakarta', 'Mahasiswa', 'mhs_pemuda'),
(7, 'Jl. Pahlawan No. 8, Malang', 'Petani', 'petani_pahlawan'),
(8, 'Jl. Veteran No. 20, Solo', 'Pelajar', 'pelajar_veteran'),
(9, 'Jl. Gajah Mada No. 18, Medan', 'PNS', 'pns_medan'),
(11, 'Jl. Hayam Wuruk No. 22, Palembang', 'Pelajar', 'pelajar_wuruk'),
(12, 'Jl. Thamrin No. 45, Jakarta Pusat', 'Pensiunan', 'pensiun_thamrin'),
(13, 'Jl. Asia Afrika No. 7, Bandung', 'Wiraswasta', 'wiraswasta_aa'),
(14, 'Jl. Basuki Rahmat No. 33, Surabaya', 'Pelajar', 'pelajar_basuki'),
(15, 'Jl. Pandanaran No. 11, Semarang', 'Pegawai Swasta', 'pegawai_pandan'),
(16, 'Jl. Malioboro No. 50, Yogyakarta', 'Pegawai Swasta', 'pws_malioboro'),
(17, 'Jl. Ijen No. 9, Malang', 'Pensiunan', 'pensiun_ijen'),
(18, 'Jl. Slamet Riyadi No. 28, Solo', 'Guru', 'guru_riyadi'),
(19, 'Jl. Sisingamangaraja No. 16, Medan', 'Pelajar', 'pelajar_sisinga'),
(20, 'Jl. Sudirman No. 40, Palembang', 'Pegawai Swasta', 'pws_sudirman'),
(21, 'Jl. Tunjungan No. 55, Surabaya', 'Pegawai Swasta', 'pws_tunjungan'),
(22, 'Jl. Veteran No. 33, Semarang', 'Mahasiswa', 'mhs_veteran'),
(23, 'Jl. Malioboro No. 77, Yogyakarta', 'Wiraswasta', 'wiraswasta_m77'),
(24, 'Jl. Diponegoro No. 88, Bandung', 'Guru', 'guru_dipo88'),
(25, 'Jl. Ahmad Yani No. 99, Surabaya', 'Pensiunan', 'pensiunan_yani99'),
(26, 'Jl. Merdeka No. 101, Jakarta', 'Pelajar', 'pelajar_merdeka'),
(27, 'Jl. Sudirman No. 202, Solo', 'Pegawai Swasta', 'pws_sudirman202'),
(28, 'Jl. Pemuda No. 303, Malang', 'Pensiunan', 'pensiun_pemuda303'),
(29, 'Jl. Pahlawan No. 404, Medan', 'Pelajar', 'pelajar_pahlawan404'),
(30, 'Jl. Gajah Mada No. 505, Palembang', 'Pensiunan', 'pensiun_gajah505');



-- =====================================================
-- 4. TABEL TINDAKAN
-- =====================================================
CREATE TABLE TINDAKAN(
    id_tindakan INT PRIMARY KEY AUTO_INCREMENT,
    nama_tindakan VARCHAR(100) NOT NULL,
    biaya DECIMAL(10,2)
);

SELECT * FROM TINDAKAN;

DELETE FROM TINDAKAN
WHERE id_tindakan = 11;

UPDATE TINDAKAN
SET biaya = '10000000'
WHERE id_tindakan = 13;

ALTER TABLE TINDAKAN
ADD jam_tidakan TIME;


INSERT INTO TINDAKAN (nama_tindakan, biaya) 
VALUES
('Pemeriksaan Umum', 150000.00),
('Pemeriksaan Laboratorium Darah Lengkap', 250000.00),
('Rontgen Thorax', 300000.00),
('USG Abdomen', 400000.00),
('EKG (Elektrokardiogram)', 200000.00),
('Jahit Luka Ringan', 150000.00),
('Nebulizer', 100000.00),
('Infus', 120000.00),
('Suntik Vitamin', 80000.00),
('CT Scan', 1500000.00),
('MRI', 3000000.00),
('Endoskopi', 2000000.00),
('Kolonoskopi', 2500000.00),
('Spirometri', 350000.00),
('Audiometri', 250000.00),
('Treadmill Test', 500000.00),
('Echocardiography', 800000.00),
('Pemeriksaan Gula Darah', 50000.00),
('Pemeriksaan Asam Urat', 60000.00),
('Pemeriksaan Kolesterol', 70000.00);



-- =====================================================
-- 5. TABEL RAWAT_JALAN
-- =====================================================
CREATE TABLE RAWAT_JALAN (
    id_rawat_jalan INT PRIMARY KEY AUTO_INCREMENT,
    id_pasien INT,
    id_dokter INT,
    tgl_kunjungan DATE NOT NULL,
    keluhan VARCHAR(255),
    FOREIGN KEY (id_pasien) REFERENCES PASIEN(id_pasien) ON DELETE CASCADE,
    FOREIGN KEY (id_dokter) REFERENCES DOKTER(id_dokter) ON DELETE CASCADE
);


SELECT * FROM RAWAT_JALAN;
DELETE FROM RAWAT_JALAN
WHERE id_rawat_jalan = 20;
UPDATE RAWAT_JALAN
SET keluhan = 'Bau Ketek Pasiennya'
WHERE id_rawat_jalan = 1;

INSERT INTO RAWAT_JALAN (id_pasien, id_dokter, tgl_kunjungan, keluhan) 
VALUES
(1, 1, '2024-11-01', 'Nyeri dada dan sesak napas'),
(2, 2, '2024-11-02', 'Demam tinggi pada anak'),
(3, 3, '2024-11-03', 'Sakit kepala berkepanjangan'),
(4, 4, '2024-11-04', 'Penglihatan kabur'),
(6, 6, '2024-11-05', 'Sakit gigi berlubang'),
(7, 7, '2024-11-06', 'Luka sayat di tangan'),
(8, 2, '2024-11-07', 'Batuk pilek'),
(9, 9, '2024-11-08', 'Maag dan mual'),
(11, 11, '2024-11-09', 'Konsultasi hasil rontgen'),
(12, 12, '2024-11-10', 'Gangguan tidur dan cemas'),
(13, 1, '2024-11-11', 'Kontrol jantung rutin'),
(14, 14, '2024-11-12', 'Nyeri dada saat aktivitas'),
(15, 15, '2024-11-13', 'Gangguan pencernaan'),
(16, 16, '2024-11-14', 'Sesak napas'),
(17, 17, '2024-11-15', 'Terapi fisik pasca kecelakaan'),
(18, 18, '2024-11-16', 'Infeksi saluran kemih'),
(19, 19, '2024-11-17', 'Tremor tangan'),
(20, 20, '2024-11-18', 'Nyeri lutut'),
(21, 9, '2024-11-19', 'Demam berdarah'),
(22, 2, '2024-11-20', 'Imunisasi anak');




-- =====================================================
-- 6. TABEL REKAM_MEDIS
-- =====================================================
CREATE TABLE Rekam_Medis(
    id_rekam_medis INT PRIMARY KEY AUTO_INCREMENT,
    id_rawat_jalan INT UNIQUE,
    diagnosis TEXT NOT NULL,
    FOREIGN KEY (id_rawat_jalan) REFERENCES RAWAT_JALAN(id_rawat_jalan) ON DELETE CASCADE
);


SELECT * FROM REKAM_MEDIS;
DELETE FROM REKAM_MEDIS
WHERE id_rekam_medis IN (16, 17);

INSERT INTO Rekam_Medis (id_rawat_jalan, diagnosis) 
VALUES
(1, 'Angina Pectoris - Nyeri dada akibat kurangnya aliran darah ke jantung'),
(2, 'ISPA (Infeksi Saluran Pernapasan Atas) pada anak'),
(3, 'Migrain kronik dengan aura'),
(4, 'Miopia (rabun jauh) dengan astigmatisme ringan'),
(6, 'Karies dentis profunda pada gigi molar'),
(7, 'Vulnus laceratum (luka sayat) pada tangan kanan'),
(8, 'Bronkitis akut'),
(9, 'Gastritis akut dengan dispepsia'),
(11, 'Hasil rontgen thorax dalam batas normal'),
(12, 'Gangguan anxietas menyeluruh (GAD)'),
(13, 'Penyakit jantung koroner stabil'),
(14, 'Angina tidak stabil, perlu pemeriksaan lanjutan'),
(15, 'GERD (Gastroesophageal Reflux Disease)'),
(16, 'Asma bronkial eksaserbasi akut'),
(17, 'Fraktur femur kanan pasca kecelakaan (dalam pemulihan)'),
(18, 'Infeksi saluran kemih (ISK) tanpa komplikasi'),
(19, 'Parkinson disease tahap awal'),
(20, 'Osteoarthritis genu bilateral');



-- =====================================================
-- 7. TABEL TINDAKAN_REKAM_MEDIS 
-- =====================================================
CREATE TABLE TINDAKAN_REKAM_MEDIS(
    id_tindakan INT,
    id_rekam_medis INT,
    Catatan VARCHAR(100),
    PRIMARY KEY (id_tindakan, id_rekam_medis),
    FOREIGN KEY (id_tindakan) REFERENCES TINDAKAN(id_tindakan) ON DELETE CASCADE,
    FOREIGN KEY (id_rekam_medis) REFERENCES Rekam_Medis(id_rekam_medis) ON DELETE CASCADE
);


SELECT * FROM TINDAKAN_REKAM_MEDIS;
DELETE FROM TINDAKAN_REKAM_MEDIS
WHERE id_tindakan = 16;
UPDATE TINDAKAN_REKAM_MEDIS
SET Catatan = 'Jahit luka 200 jahitan'
WHERE id_tindakan = 6;

INSERT INTO TINDAKAN_REKAM_MEDIS (id_tindakan, id_rekam_medis, Catatan) 
VALUES
(1, 1, 'Pemeriksaan fisik jantung'),
(5, 1, 'EKG menunjukkan ST depression'),
(1, 2, 'Pemeriksaan fisik anak'),
(2, 2, 'Lab: Leukosit 15.000/uL'),
(1, 3, 'Pemeriksaan neurologis'),
(1, 4, 'Pemeriksaan mata lengkap'),
(1, 6, 'Pemeriksaan gigi'),
(6, 7, 'Jahit luka 8 jahitan'),
(1, 8, 'Auskultasi paru wheezing (+)'),
(7, 8, 'Nebulizer dengan salbutamol'),
(1, 9, 'Palpasi abdomen nyeri epigastrium'),
(1, 11, 'Konsultasi hasil radiologi'),
(1, 12, 'Asesmen psikiatri'),
(1, 13, 'Kontrol rutin jantung'),
(5, 13, 'EKG normal'),
(1, 14, 'Pemeriksaan jantung menyeluruh'),
(16, 14, 'Treadmill test positif'),
(1, 15, 'Endoskopi dijadwalkan'),
(1, 16, 'Pemeriksaan paru'),
(14, 16, 'Spirometri FEV1 60%');



-- =====================================================
-- 8. OBAT
-- =====================================================

CREATE TABLE OBAT (
id_obat INT PRIMARY KEY AUTO_INCREMENT,
nama_obat VARCHAR(100) NOT NULL,
jenis_obat VARCHAR(50),
Tanggal_kadaluarsa DATE
);

-- =====================================================
-- TABEL OBAT - 
-- =====================================================


CREATE TABLE OBAT (
    id_obat INT PRIMARY KEY AUTO_INCREMENT,
    nama_obat VARCHAR(100) NOT NULL,
    jenis_obat VARCHAR(50),
    Tanggal_kadaluarsa DATE
);

SELECT * FROM OBAT;
UPDATE OBAT
SET jenis_obat = 'Nuklir'
WHERE id_obat = 20;

INSERT INTO OBAT (nama_obat, jenis_obat, Tanggal_kadaluarsa) 
VALUES
('Paracetamol 500mg', 'Tablet', '2026-12-31'),
('Amoxicillin 500mg', 'Kapsul', '2025-08-15'),
('OBH Combi Batuk Flu', 'Sirup', '2025-11-30'),
('Antasida DOEN', 'Tablet', '2026-03-20'),
('Ibuprofen 400mg', 'Tablet', '2026-06-25'),
('Cetirizine 10mg', 'Tablet', '2025-09-10'),
('Ambroxol 30mg', 'Tablet', '2026-01-15'),
('Lansoprazole 30mg', 'Kapsul', '2025-12-05'),
('Metformin 500mg', 'Tablet', '2026-07-18'),
('Amlodipine 5mg', 'Tablet', '2026-04-22'),
('Captopril 25mg', 'Tablet', '2025-10-30'),
('Simvastatin 20mg', 'Tablet', '2026-08-14'),
('Dexamethasone 0.5mg', 'Tablet', '2025-07-25'),
('Omeprazole 20mg', 'Kapsul', '2026-02-28'),
('Ciprofloxacin 500mg', 'Tablet', '2025-12-20'),
('Salbutamol Inhaler', 'Inhaler', '2026-05-10'),
('Vitamin B Complex', 'Tablet', '2027-01-31'),
('Asam Mefenamat 500mg', 'Kapsul', '2025-11-08'),
('Betadine Solution 1%', 'Cairan', '2026-09-15'),
('Ranitidine 150mg', 'Tablet', '2025-06-30');



