-- ========================================
-- BANK KEMANDIRIAN - DATABASE MANAGEMENT SYSTEM
-- ========================================
-- Description: Comprehensive banking database system
-- Author: [Your Name]
-- Version: 2.0
-- Last Updated: November 2025
-- ========================================

-- ========================================
-- DATABASE SETUP
-- ========================================
DROP DATABASE IF EXISTS Bank_Kemandirian;
CREATE DATABASE Bank_Kemandirian CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE Bank_Kemandirian;

-- ========================================
-- TABLE: NASABAH (Customer)
-- ========================================
CREATE TABLE Nasabah (
    id_nasabah INT PRIMARY KEY AUTO_INCREMENT,
    nik CHAR(16) UNIQUE NOT NULL COMMENT 'National ID Number',
    nama VARCHAR(100) NOT NULL,
    alamat VARCHAR(255),
    no_telp VARCHAR(15),
    email VARCHAR(100) UNIQUE,
    tanggal_lahir DATE,
    jenis_kelamin ENUM('L','P') COMMENT 'L=Laki-laki, P=Perempuan',
    pekerjaan VARCHAR(100),
    tanggal_daftar DATE DEFAULT (CURRENT_DATE),
    password_nasabah VARCHAR(255) NOT NULL COMMENT 'Should be hashed in production',
    status_nasabah ENUM('Aktif','Nonaktif','Suspended') DEFAULT 'Aktif',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_nik (nik),
    INDEX idx_email (email),
    INDEX idx_status (status_nasabah)
) ENGINE=InnoDB COMMENT='Customer master data';

-- ========================================
-- TABLE: CABANG (Branch)
-- ========================================
CREATE TABLE Cabang (
    id_cabang INT PRIMARY KEY AUTO_INCREMENT,
    kode_cabang VARCHAR(10) UNIQUE NOT NULL,
    nama_cabang VARCHAR(100) NOT NULL,
    alamat_cabang VARCHAR(255),
    kota VARCHAR(100),
    provinsi VARCHAR(100),
    kode_pos VARCHAR(10),
    telepon VARCHAR(15),
    email_cabang VARCHAR(100),
    status_cabang ENUM('Aktif','Nonaktif') DEFAULT 'Aktif',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_kode_cabang (kode_cabang),
    INDEX idx_kota (kota)
) ENGINE=InnoDB COMMENT='Branch information';

-- ========================================
-- TABLE: KARYAWAN (Employee)
-- ========================================
CREATE TABLE Karyawan (
    id_karyawan INT PRIMARY KEY AUTO_INCREMENT,
    id_cabang INT,
    nik_karyawan VARCHAR(20) UNIQUE NOT NULL,
    nama_karyawan VARCHAR(100) NOT NULL,
    jabatan VARCHAR(50),
    departemen VARCHAR(50),
    email_karyawan VARCHAR(100),
    no_telp_karyawan VARCHAR(15),
    tanggal_masuk DATE,
    tanggal_keluar DATE NULL,
    gaji DECIMAL(15,2),
    status_karyawan ENUM('Aktif','Resign','Pensiun') DEFAULT 'Aktif',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (id_cabang) REFERENCES Cabang(id_cabang)
        ON DELETE SET NULL
        ON UPDATE CASCADE,
    INDEX idx_cabang (id_cabang),
    INDEX idx_jabatan (jabatan),
    INDEX idx_status (status_karyawan)
) ENGINE=InnoDB COMMENT='Employee information';

-- ========================================
-- TABLE: REKENING (Account)
-- ========================================
CREATE TABLE Rekening (
    no_rekening BIGINT PRIMARY KEY,
    id_nasabah INT NOT NULL,
    id_cabang INT,
    jenis_rekening ENUM('Tabungan','Giro','Deposito') NOT NULL,
    saldo DECIMAL(20,2) DEFAULT 0 CHECK (saldo >= 0),
    saldo_minimum DECIMAL(20,2) DEFAULT 50000.00,
    biaya_admin DECIMAL(10,2) DEFAULT 0,
    tanggal_buka DATE DEFAULT (CURRENT_DATE),
    tanggal_jatuh_tempo DATE NULL COMMENT 'For Deposito only',
    status_rekening ENUM('Aktif','Nonaktif','Diblokir') DEFAULT 'Aktif',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (id_nasabah) REFERENCES Nasabah(id_nasabah)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (id_cabang) REFERENCES Cabang(id_cabang)
        ON DELETE SET NULL
        ON UPDATE CASCADE,
    INDEX idx_nasabah (id_nasabah),
    INDEX idx_jenis (jenis_rekening),
    INDEX idx_status (status_rekening)
) ENGINE=InnoDB COMMENT='Account information';

-- ========================================
-- TABLE: PINJAMAN (Loan)
-- ========================================
CREATE TABLE Pinjaman (
    id_pinjaman INT PRIMARY KEY AUTO_INCREMENT,
    no_pinjaman VARCHAR(20) UNIQUE NOT NULL,
    id_nasabah INT NOT NULL,
    id_karyawan INT COMMENT 'Loan Officer',
    jenis_pinjaman ENUM('KPR','Multiguna','Modal Usaha','Kendaraan','Pendidikan') NOT NULL,
    jumlah_pinjaman DECIMAL(20,2) NOT NULL CHECK (jumlah_pinjaman > 0),
    bunga DECIMAL(5,2) NOT NULL CHECK (bunga >= 0),
    jangka_waktu INT NOT NULL COMMENT 'in months',
    angsuran_per_bulan DECIMAL(20,2),
    sisa_pinjaman DECIMAL(20,2),
    tanggal_pinjaman DATE DEFAULT (CURRENT_DATE),
    tanggal_jatuh_tempo DATE,
    status_pinjaman ENUM('Diajukan','Disetujui','Ditolak','Berjalan','Lunas','Macet') DEFAULT 'Diajukan',
    keterangan TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (id_nasabah) REFERENCES Nasabah(id_nasabah)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (id_karyawan) REFERENCES Karyawan(id_karyawan)
        ON DELETE SET NULL
        ON UPDATE CASCADE,
    INDEX idx_nasabah (id_nasabah),
    INDEX idx_status (status_pinjaman),
    INDEX idx_jenis (jenis_pinjaman)
) ENGINE=InnoDB COMMENT='Loan information';

-- ========================================
-- TABLE: TRANSAKSI (Transaction)
-- ========================================
CREATE TABLE Transaksi (
    id_transaksi INT PRIMARY KEY AUTO_INCREMENT,
    no_referensi VARCHAR(30) UNIQUE NOT NULL,
    no_rekening BIGINT NOT NULL,
    jenis_transaksi ENUM('Setor','Tarik','Transfer','Pembayaran') NOT NULL,
    nominal DECIMAL(20,2) NOT NULL CHECK (nominal > 0),
    biaya_transaksi DECIMAL(10,2) DEFAULT 0,
    saldo_sebelum DECIMAL(20,2),
    saldo_sesudah DECIMAL(20,2),
    no_rekening_tujuan BIGINT NULL COMMENT 'For Transfer',
    tanggal_transaksi DATETIME DEFAULT CURRENT_TIMESTAMP,
    status_transaksi ENUM('Pending','Berhasil','Gagal') DEFAULT 'Berhasil',
    keterangan VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (no_rekening) REFERENCES Rekening(no_rekening)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    INDEX idx_rekening (no_rekening),
    INDEX idx_tanggal (tanggal_transaksi),
    INDEX idx_jenis (jenis_transaksi),
    INDEX idx_status (status_transaksi)
) ENGINE=InnoDB COMMENT='Transaction records';

-- ========================================
-- TABLE: ANGSURAN (Loan Payment)
-- ========================================
CREATE TABLE Angsuran (
    id_angsuran INT PRIMARY KEY AUTO_INCREMENT,
    id_pinjaman INT NOT NULL,
    angsuran_ke INT NOT NULL,
    jumlah_angsuran DECIMAL(20,2) NOT NULL,
    pokok DECIMAL(20,2) NOT NULL,
    bunga DECIMAL(20,2) NOT NULL,
    denda DECIMAL(20,2) DEFAULT 0,
    tanggal_jatuh_tempo DATE NOT NULL,
    tanggal_bayar DATE NULL,
    status_angsuran ENUM('Belum Bayar','Sudah Bayar','Terlambat') DEFAULT 'Belum Bayar',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (id_pinjaman) REFERENCES Pinjaman(id_pinjaman)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    INDEX idx_pinjaman (id_pinjaman),
    INDEX idx_status (status_angsuran),
    INDEX idx_jatuh_tempo (tanggal_jatuh_tempo)
) ENGINE=InnoDB COMMENT='Loan payment schedule';

-- ========================================
-- TABLE: AUDIT_LOG (Audit Trail)
-- ========================================
CREATE TABLE Audit_Log (
    id_audit INT PRIMARY KEY AUTO_INCREMENT,
    tabel VARCHAR(50) NOT NULL,
    operasi ENUM('INSERT','UPDATE','DELETE') NOT NULL,
    id_record INT,
    user_id INT,
    data_lama TEXT,
    data_baru TEXT,
    ip_address VARCHAR(45),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_tabel (tabel),
    INDEX idx_created (created_at)
) ENGINE=InnoDB COMMENT='Audit trail for all operations';

-- ========================================
-- INSERT SAMPLE DATA: CABANG
-- ========================================
INSERT INTO Cabang (kode_cabang, nama_cabang, alamat_cabang, kota, provinsi, kode_pos, telepon, email_cabang) VALUES
('KCP-JKT01', 'Kantor Pusat Jakarta', 'Jl. Sudirman No. 12', 'Jakarta Pusat', 'DKI Jakarta', '10220', '021-12345678', 'jakarta@bankkemandirian.co.id'),
('KC-BDG01', 'Cabang Bandung', 'Jl. Asia Afrika No. 45', 'Bandung', 'Jawa Barat', '40111', '022-98765432', 'bandung@bankkemandirian.co.id'),
('KC-SBY01', 'Cabang Surabaya', 'Jl. Darmo No. 100', 'Surabaya', 'Jawa Timur', '60241', '031-11223344', 'surabaya@bankkemandirian.co.id'),
('KC-MDN01', 'Cabang Medan', 'Jl. Merdeka No. 5', 'Medan', 'Sumatera Utara', '20112', '061-55667788', 'medan@bankkemandirian.co.id'),
('KC-DPS01', 'Cabang Denpasar', 'Jl. Raya Kuta No. 88', 'Denpasar', 'Bali', '80361', '0361-99887766', 'denpasar@bankkemandirian.co.id'),
('KC-SMG01', 'Cabang Semarang', 'Jl. Pemuda No. 1', 'Semarang', 'Jawa Tengah', '50132', '024-55443322', 'semarang@bankkemandirian.co.id'),
('KC-YGY01', 'Cabang Yogyakarta', 'Jl. Malioboro No. 10', 'Yogyakarta', 'DI Yogyakarta', '55271', '0274-12121212', 'yogyakarta@bankkemandirian.co.id'),
('KC-MKS01', 'Cabang Makassar', 'Jl. Ahmad Yani No. 50', 'Makassar', 'Sulawesi Selatan', '90174', '0411-88776655', 'makassar@bankkemandirian.co.id'),
('KC-PLG01', 'Cabang Palembang', 'Jl. Jenderal Sudirman No. 20', 'Palembang', 'Sumatera Selatan', '30126', '0711-33221100', 'palembang@bankkemandirian.co.id'),
('KC-BGR01', 'Cabang Bogor', 'Jl. Pajajaran No. 7', 'Bogor', 'Jawa Barat', '16143', '0251-40404040', 'bogor@bankkemandirian.co.id');

-- ========================================
-- INSERT SAMPLE DATA: NASABAH
-- ========================================
INSERT INTO Nasabah (nik, nama, alamat, no_telp, email, tanggal_lahir, jenis_kelamin, pekerjaan, password_nasabah) VALUES
('3201019001950001', 'Budi Santoso', 'Jl. Mawar No. 5, Jakarta', '081234567890', 'budi.s@mail.com', '1995-01-10', 'L', 'Karyawan Swasta', '$2y$10$hashedpassword1'),
('3201021202920002', 'Siti Aminah', 'Jl. Kebun Raya No. 10, Bandung', '087765432101', 'siti.a@mail.com', '1992-02-12', 'P', 'Guru', '$2y$10$hashedpassword2'),
('3578010505880003', 'Joko Susilo', 'Jl. Pahlawan No. 20, Surabaya', '085612345678', 'joko.s@mail.com', '1988-05-05', 'L', 'Wiraswasta', '$2y$10$hashedpassword3'),
('3173041010990004', 'Dewi Lestari', 'Jl. Anggrek No. 15, Jakarta', '081122334455', 'dewi.l@mail.com', '1999-10-10', 'P', 'Designer', '$2y$10$hashedpassword4'),
('5171032504900005', 'Made Wira', 'Jl. Sunset Road No. 30, Denpasar', '089900112233', 'made.w@mail.com', '1990-04-25', 'L', 'Pengusaha', '$2y$10$hashedpassword5'),
('3201030101750006', 'Ahmad Yani', 'Jl. Veteran No. 7, Bandung', '082109876543', 'ahmad.y@mail.com', '1975-01-01', 'L', 'PNS', '$2y$10$hashedpassword6'),
('3578022003850007', 'Rina Melati', 'Jl. Diponegoro No. 50, Surabaya', '083812121212', 'rina.m@mail.com', '1985-03-20', 'P', 'Dokter', '$2y$10$hashedpassword7'),
('1271011508930008', 'Taufik Hidayat', 'Jl. Setiabudi No. 1, Medan', '081377665544', 'taufik.h@mail.com', '1993-08-15', 'L', 'Engineer', '$2y$10$hashedpassword8'),
('3173050706800009', 'Lina Marlina', 'Jl. Kebon Jeruk No. 8, Jakarta', '081945454545', 'lina.m@mail.com', '1980-06-07', 'P', 'Marketing', '$2y$10$hashedpassword9'),
('5171043012970010', 'Eko Prasetyo', 'Jl. Gajah Mada No. 22, Denpasar', '085200336699', 'eko.p@mail.com', '1997-12-30', 'L', 'Programmer', '$2y$10$hashedpassword10'),
('3374051006910011', 'Galih Akbar', 'Jl. Merapi No. 3, Semarang', '081511223344', 'galih.a@mail.com', '1991-06-10', 'L', 'Arsitek', '$2y$10$hashedpassword11'),
('3404060207870012', 'Maya Sari', 'Jl. Pangeran No. 12, Yogyakarta', '087855667788', 'maya.s@mail.com', '1987-07-02', 'P', 'Dosen', '$2y$10$hashedpassword12'),
('7371072209940013', 'Hasan Basri', 'Jl. Sudirman No. 10, Makassar', '082211447700', 'hasan.b@mail.com', '1994-09-22', 'L', 'Trader', '$2y$10$hashedpassword13'),
('1671080311890014', 'Indah Permata', 'Jl. Kapten A. Rivai No. 5, Palembang', '081700998877', 'indah.p@mail.com', '1989-11-03', 'P', 'Akuntan', '$2y$10$hashedpassword14'),
('3201092801960015', 'Kevin Wijaya', 'Jl. Re Soemantadiredja No. 9, Bogor', '085712121212', 'kevin.w@mail.com', '1996-01-28', 'L', 'Content Creator', '$2y$10$hashedpassword15');

-- ========================================
-- INSERT SAMPLE DATA: KARYAWAN
-- ========================================
INSERT INTO Karyawan (id_cabang, nik_karyawan, nama_karyawan, jabatan, departemen, email_karyawan, no_telp_karyawan, tanggal_masuk, gaji) VALUES
(1, 'EMP-001', 'Agus Salim', 'Branch Manager', 'Management', 'agus.salim@bankkemandirian.co.id', '081234000001', '2015-01-10', 15000000.00),
(1, 'EMP-002', 'Fani Herliana', 'Customer Service', 'Operations', 'fani.h@bankkemandirian.co.id', '081234000002', '2018-05-20', 8000000.00),
(1, 'EMP-015', 'Nina Kirana', 'Loan Officer', 'Credit', 'nina.k@bankkemandirian.co.id', '081234000015', '2019-06-18', 9200000.00),
(2, 'EMP-003', 'Yoga Pratama', 'Teller', 'Operations', 'yoga.p@bankkemandirian.co.id', '081234000003', '2019-11-01', 6500000.00),
(2, 'EMP-004', 'Ratih Kumala', 'Loan Officer', 'Credit', 'ratih.k@bankkemandirian.co.id', '081234000004', '2016-07-15', 9500000.00),
(3, 'EMP-005', 'Dian Permata', 'Branch Manager', 'Management', 'dian.p@bankkemandirian.co.id', '081234000005', '2014-03-25', 14000000.00),
(3, 'EMP-006', 'Galih Satria', 'Customer Service', 'Operations', 'galih.s@bankkemandirian.co.id', '081234000006', '2020-02-14', 7800000.00),
(4, 'EMP-007', 'Putri Anjani', 'Teller', 'Operations', 'putri.a@bankkemandirian.co.id', '081234000007', '2021-09-01', 6200000.00),
(5, 'EMP-008', 'Sinta Dewi', 'Loan Officer', 'Credit', 'sinta.d@bankkemandirian.co.id', '081234000008', '2017-12-05', 10000000.00),
(5, 'EMP-009', 'Kevin Sanjaya', 'Customer Service', 'Operations', 'kevin.s@bankkemandirian.co.id', '081234000009', '2022-01-10', 7500000.00);

-- ========================================
-- INSERT SAMPLE DATA: REKENING
-- ========================================
INSERT INTO Rekening (no_rekening, id_nasabah, id_cabang, jenis_rekening, saldo, biaya_admin, tanggal_buka) VALUES
(1000100001, 1, 1, 'Tabungan', 5500000.00, 10000.00, '2022-01-01'),
(1002100021, 1, 1, 'Giro', 15000000.00, 25000.00, '2024-01-15'),
(2000200002, 2, 2, 'Tabungan', 12000000.00, 10000.00, '2021-05-15'),
(2002200022, 2, 2, 'Deposito', 50000000.00, 0, '2022-09-09'),
(3000300003, 3, 3, 'Giro', 50000000.00, 25000.00, '2020-03-10'),
(1000400004, 4, 1, 'Deposito', 75000000.00, 0, '2023-08-20'),
(5000500005, 5, 5, 'Tabungan', 3500000.00, 10000.00, '2022-11-11'),
(5002300023, 5, 5, 'Deposito', 30000000.00, 0, '2023-06-06'),
(2000600006, 6, 2, 'Tabungan', 1500000.00, 10000.00, '2023-01-01'),
(3000700007, 7, 3, 'Giro', 22000000.00, 25000.00, '2021-10-25'),
(4000800008, 8, 4, 'Tabungan', 800000.00, 10000.00, '2023-05-05'),
(1000900009, 9, 1, 'Tabungan', 1000000.00, 10000.00, '2024-02-01'),
(5001000010, 10, 5, 'Deposito', 150000000.00, 0, '2021-07-07');

-- ========================================
-- INSERT SAMPLE DATA: PINJAMAN
-- ========================================
INSERT INTO Pinjaman (no_pinjaman, id_nasabah, id_karyawan, jenis_pinjaman, jumlah_pinjaman, bunga, jangka_waktu, angsuran_per_bulan, sisa_pinjaman, tanggal_pinjaman, status_pinjaman) VALUES
('LN-2023-0001', 1, 4, 'Multiguna', 15000000.00, 10.50, 12, 1324812.50, 15000000.00, '2023-03-01', 'Berjalan'),
('LN-2022-0002', 3, 8, 'KPR', 200000000.00, 8.00, 36, 6266928.00, 150000000.00, '2022-01-20', 'Berjalan'),
('LN-2024-0003', 5, 4, 'Kendaraan', 5000000.00, 12.00, 6, 857792.00, 0, '2024-01-10', 'Lunas'),
('LN-2023-0004', 6, 4, 'Modal Usaha', 50000000.00, 9.50, 24, 2283375.00, 40000000.00, '2023-09-01', 'Berjalan'),
('LN-2023-0005', 8, 7, 'Pendidikan', 10000000.00, 11.00, 12, 879157.00, 8000000.00, '2023-10-15', 'Berjalan');

-- ========================================
-- INSERT SAMPLE DATA: TRANSAKSI
-- ========================================
INSERT INTO Transaksi (no_referensi, no_rekening, jenis_transaksi, nominal, biaya_transaksi, saldo_sebelum, saldo_sesudah, keterangan) VALUES
('TRX-2024-0001', 1000100001, 'Setor', 1000000.00, 0, 4500000.00, 5500000.00, 'Setoran tunai awal bulan'),
('TRX-2024-0002', 1000100001, 'Tarik', 500000.00, 5000.00, 5500000.00, 4995000.00, 'Penarikan ATM'),
('TRX-2024-0003', 2000200002, 'Transfer', 2000000.00, 6500.00, 14000000.00, 11993500.00, 'Transfer ke rekening lain'),
('TRX-2024-0004', 3000300003, 'Setor', 10000000.00, 0, 40000000.00, 50000000.00, 'Setoran giro perusahaan'),
('TRX-2024-0005', 5000500005, 'Tarik', 1000000.00, 5000.00, 4500000.00, 3495000.00, 'Penarikan tunai'),
('TRX-2024-0006', 1000100001, 'Pembayaran', 250000.00, 2500.00, 4995000.00, 4742500.00, 'Bayar listrik'),
('TRX-2024-0007', 2000200002, 'Tarik', 5000000.00, 5000.00, 11993500.00, 6988500.00, 'Tarik dana usaha');

-- ========================================
-- STORED PROCEDURES
-- ========================================

-- Procedure: Transfer antar rekening
DELIMITER //
CREATE PROCEDURE sp_transfer(
    IN p_no_rekening_asal BIGINT,
    IN p_no_rekening_tujuan BIGINT,
    IN p_nominal DECIMAL(20,2),
    IN p_keterangan VARCHAR(255),
    OUT p_status VARCHAR(50),
    OUT p_message VARCHAR(255)
)
BEGIN
    DECLARE v_saldo_asal DECIMAL(20,2);
    DECLARE v_biaya DECIMAL(10,2) DEFAULT 6500.00;
    DECLARE v_no_ref VARCHAR(30);
    
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SET p_status = 'GAGAL';
        SET p_message = 'Terjadi kesalahan sistem';
    END;
    
    START TRANSACTION;
    
    -- Generate nomor referensi
    SET v_no_ref = CONCAT('TRX-', DATE_FORMAT(NOW(), '%Y%m%d'), '-', LPAD(FLOOR(RAND() * 999999), 6, '0'));
    
    -- Cek saldo
    SELECT saldo INTO v_saldo_asal FROM Rekening WHERE no_rekening = p_no_rekening_asal FOR UPDATE;
    
    IF v_saldo_asal < (p_nominal + v_biaya) THEN
        SET p_status = 'GAGAL';
        SET p_message = 'Saldo tidak mencukupi';
        ROLLBACK;
    ELSE
        -- Kurangi saldo asal
        UPDATE Rekening SET saldo = saldo - p_nominal - v_biaya WHERE no_rekening = p_no_rekening_asal;
        
        -- Tambah saldo tujuan
        UPDATE Rekening SET saldo = saldo + p_nominal WHERE no_rekening = p_no_rekening_tujuan;
        
        -- Catat transaksi
        INSERT INTO Transaksi (no_referensi, no_rekening, jenis_transaksi, nominal, biaya_transaksi, no_rekening_tujuan, keterangan)
        VALUES (v_no_ref, p_no_rekening_asal, 'Transfer', p_nominal, v_biaya, p_no_rekening_tujuan, p_keterangan);
        
        SET p_status = 'BERHASIL';
        SET p_message = CONCAT('Transfer berhasil. No Ref: ', v_no_ref);
        COMMIT;
    END IF;
END //
DELIMITER ;

-- Procedure: Hitung angsuran pinjaman
DELIMITER //
CREATE PROCEDURE sp_generate_angsuran(IN p_id_pinjaman INT)
BEGIN
    DECLARE v_jumlah DECIMAL(20,2);
    DECLARE v_bunga DECIMAL(5,2);
    DECLARE v_jangka INT;
    DECLARE v_tanggal DATE;
    DECLARE v_angsuran DECIMAL(20,2);
    DECLARE v_pokok DECIMAL(20,2);
    DECLARE v_bunga_bulanan DECIMAL(20,2);
    DECLARE i INT DEFAULT 1;
    
    SELECT jumlah_pinjaman, bunga, jangka_waktu, tanggal_pinjaman
    INTO v_jumlah, v_bunga, v_jangka, v_tanggal
    FROM Pinjaman WHERE id_pinjaman = p_id_pinjaman;
    
    SET v_angsuran = v_jumlah * (v_bunga/100/12 * POWER(1 + v_bunga/100/12, v_jangka)) / (POWER(1 + v_bunga/100/12, v_jangka) - 1);
    
    -- Update angsuran per bulan
    UPDATE Pinjaman SET angsuran_per_bulan = v_angsuran, sisa_pinjaman = v_jumlah WHERE id_pinjaman = p_id_pinjaman;
    
    WHILE i <= v_jangka DO
        SET v_bunga_bulanan = v_jumlah * (v_bunga/100/12);
        SET v_pokok = v_angsuran - v_bunga_bulanan;
        
        INSERT INTO Angsuran (id_pinjaman, angsuran_ke, jumlah_angsuran, pokok, bunga, tanggal_jatuh_tempo)
        VALUES (p_id_pinjaman, i, v_angsuran, v_pokok, v_bunga_bulanan, DATE_ADD(v_tanggal, INTERVAL i MONTH));
        
        SET v_jumlah = v_jumlah - v_pokok;
        SET i = i + 1;
    END WHILE;
END //
DELIMITER ;

-- ========================================
-- VIEWS - REPORTING & ANALYTICS
-- ========================================

-- View: Portfolio nasabah lengkap
CREATE VIEW v_portfolio_nasabah AS
SELECT 
    n.id_nasabah,
    n.nik,
    n.nama,
    n.email,
    n.no_telp,
    COUNT(DISTINCT r.no_rekening) AS total_rekening,
    SUM(r.saldo) AS total_saldo,
    COUNT(DISTINCT p.id_pinjaman) AS total_pinjaman,
    SUM(CASE WHEN p.status_pinjaman = 'Berjalan' THEN p.sisa_pinjaman ELSE 0 END) AS total_outstanding_pinjaman,
    n.tanggal_daftar,
    n.status_nasabah
FROM Nasabah n
LEFT JOIN Rekening r ON n.id_nasabah = r.id_nasabah
LEFT JOIN Pinjaman p ON n.id_nasabah = p.id_nasabah
GROUP BY n.id_nasabah, n.nik, n.nama, n.email, n.no_telp, n.tanggal_daftar, n.status_nasabah;

-- View: Summary rekening per cabang
CREATE VIEW v_summary_rekening_cabang AS
SELECT 
    c.id_cabang,
    c.kode_cabang,
    c.nama_cabang,
    c.kota,
    r.jenis_rekening,
    COUNT(r.no_rekening) AS jumlah_rekening,
    MIN(r.saldo) AS saldo_minimum,
    MAX(r.saldo) AS saldo_maksimum,
    AVG(r.saldo) AS saldo_rata_rata,
    SUM(r.saldo) AS total_saldo
FROM Cabang c
LEFT JOIN Rekening r ON c.id_cabang = r.id_cabang
WHERE r.status_rekening = 'Aktif'
GROUP BY c.id_cabang, c.kode_cabang, c.nama_cabang, c.kota, r.jenis_rekening;

-- View: Analisis pinjaman
CREATE VIEW v_analisis_pinjaman AS
SELECT 
    p.id_pinjaman,
    p.no_pinjaman,
    n.nama AS nama_nasabah,
    n.nik,
    k.nama_karyawan AS loan_officer,
    c.nama_cabang,
    p.jenis_pinjaman,
    p.jumlah_pinjaman,
    p.bunga,
    p.jangka_waktu,
    p.angsuran_per_bulan,
    p.sisa_pinjaman,
    p.tanggal_pinjaman,
    p.tanggal_jatuh_tempo,
    p.status_pinjaman,
    DATEDIFF(NOW(), p.tanggal_pinjaman) AS hari_berjalan,
    CASE 
        WHEN p.status_pinjaman = 'Berjalan' AND p.tanggal_jatuh_tempo < NOW() THEN 'Perlu Perhatian'
        WHEN p.status_pinjaman = 'Macet' THEN 'Bermasalah'
        ELSE 'Normal'
    END AS flag_status
FROM Pinjaman p
JOIN Nasabah n ON p.id_nasabah = n.id_nasabah
LEFT JOIN Karyawan k ON p.id_karyawan = k.id_karyawan
LEFT JOIN Rekening r ON n.id_nasabah = r.id_nasabah
LEFT JOIN Cabang c ON r.id_cabang = c.id_cabang
GROUP BY p.id_pinjaman;

-- View: Top transaksi harian
CREATE VIEW v_transaksi_harian AS
SELECT 
    DATE(t.tanggal_transaksi) AS tanggal,
    t.jenis_transaksi,
    COUNT(*) AS jumlah_transaksi,
    SUM(t.nominal) AS total_nominal,
    AVG(t.nominal) AS rata_rata_nominal,
    MIN(t.nominal) AS nominal_terkecil,
    MAX(t.nominal) AS nominal_terbesar
FROM Transaksi t
WHERE t.status_transaksi = 'Berhasil'
GROUP BY DATE(t.tanggal_transaksi), t.jenis_transaksi;

-- View: Kinerja karyawan
CREATE VIEW v_kinerja_karyawan AS
SELECT 
    k.id_karyawan,
    k.nik_karyawan,
    k.nama_karyawan,
    k.jabatan,
    k.departemen,
    c.nama_cabang,
    COUNT(DISTINCT p.id_pinjaman) AS total_pinjaman_diproses,
    SUM(CASE WHEN p.status_pinjaman = 'Disetujui' OR p.status_pinjaman = 'Berjalan' THEN p.jumlah_pinjaman ELSE 0 END) AS total_nilai_pinjaman_approved,
    SUM(CASE WHEN p.status_pinjaman = 'Lunas' THEN 1 ELSE 0 END) AS total_pinjaman_lunas,
    SUM(CASE WHEN p.status_pinjaman = 'Macet' THEN 1 ELSE 0 END) AS total_pinjaman_macet,
    k.gaji,
    k.tanggal_masuk,
    TIMESTAMPDIFF(YEAR, k.tanggal_masuk, NOW()) AS masa_kerja_tahun
FROM Karyawan k
LEFT JOIN Cabang c ON k.id_cabang = c.id_cabang
LEFT JOIN Pinjaman p ON k.id_karyawan = p.id_karyawan
WHERE k.status_karyawan = 'Aktif'
GROUP BY k.id_karyawan, k.nik_karyawan, k.nama_karyawan, k.jabatan, k.departemen, c.nama_cabang, k.gaji, k.tanggal_masuk;

-- ========================================
-- TRIGGERS - BUSINESS LOGIC AUTOMATION
-- ========================================

-- Trigger: Auto update saldo setelah transaksi
DELIMITER //
CREATE TRIGGER trg_after_transaksi_insert
AFTER INSERT ON Transaksi
FOR EACH ROW
BEGIN
    IF NEW.jenis_transaksi = 'Setor' THEN
        UPDATE Rekening 
        SET saldo = saldo + NEW.nominal 
        WHERE no_rekening = NEW.no_rekening;
    ELSEIF NEW.jenis_transaksi = 'Tarik' THEN
        UPDATE Rekening 
        SET saldo = saldo - (NEW.nominal + NEW.biaya_transaksi) 
        WHERE no_rekening = NEW.no_rekening;
    END IF;
END //
DELIMITER ;

-- Trigger: Audit log untuk perubahan data nasabah
DELIMITER //
CREATE TRIGGER trg_audit_nasabah_update
AFTER UPDATE ON Nasabah
FOR EACH ROW
BEGIN
    INSERT INTO Audit_Log (tabel, operasi, id_record, data_lama, data_baru)
    VALUES (
        'Nasabah',
        'UPDATE',
        NEW.id_nasabah,
        JSON_OBJECT('nama', OLD.nama, 'email', OLD.email, 'status', OLD.status_nasabah),
        JSON_OBJECT('nama', NEW.nama, 'email', NEW.email, 'status', NEW.status_nasabah)
    );
END //
DELIMITER ;

-- Trigger: Validasi saldo minimum
DELIMITER //
CREATE TRIGGER trg_before_rekening_update
BEFORE UPDATE ON Rekening
FOR EACH ROW
BEGIN
    IF NEW.saldo < 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Saldo tidak boleh kurang dari 0';
    END IF;
END //
DELIMITER ;

-- ========================================
-- ANALYTICAL QUERIES - BUSINESS INTELLIGENCE
-- ========================================

-- Query 1: Top 10 nasabah berdasarkan total saldo
CREATE VIEW v_top_nasabah_by_saldo AS
SELECT 
    n.id_nasabah,
    n.nama,
    n.email,
    COUNT(r.no_rekening) AS jumlah_rekening,
    SUM(r.saldo) AS total_saldo,
    GROUP_CONCAT(DISTINCT r.jenis_rekening ORDER BY r.jenis_rekening) AS jenis_rekening
FROM Nasabah n
JOIN Rekening r ON n.id_nasabah = r.id_nasabah
WHERE r.status_rekening = 'Aktif'
GROUP BY n.id_nasabah, n.nama, n.email
ORDER BY total_saldo DESC
LIMIT 10;

-- Query 2: Pertumbuhan nasabah per bulan
CREATE VIEW v_pertumbuhan_nasabah AS
SELECT 
    DATE_FORMAT(tanggal_daftar, '%Y-%m') AS bulan,
    COUNT(*) AS nasabah_baru,
    SUM(COUNT(*)) OVER (ORDER BY DATE_FORMAT(tanggal_daftar, '%Y-%m')) AS total_kumulatif
FROM Nasabah
GROUP BY DATE_FORMAT(tanggal_daftar, '%Y-%m')
ORDER BY bulan;

-- Query 3: Analisis NPL (Non Performing Loan)
CREATE VIEW v_analisis_npl AS
SELECT 
    c.nama_cabang,
    COUNT(p.id_pinjaman) AS total_pinjaman,
    SUM(CASE WHEN p.status_pinjaman = 'Berjalan' THEN 1 ELSE 0 END) AS pinjaman_berjalan,
    SUM(CASE WHEN p.status_pinjaman = 'Macet' THEN 1 ELSE 0 END) AS pinjaman_macet,
    SUM(CASE WHEN p.status_pinjaman = 'Lunas' THEN 1 ELSE 0 END) AS pinjaman_lunas,
    SUM(p.jumlah_pinjaman) AS total_nilai_pinjaman,
    SUM(CASE WHEN p.status_pinjaman = 'Macet' THEN p.sisa_pinjaman ELSE 0 END) AS nilai_npl,
    ROUND(
        (SUM(CASE WHEN p.status_pinjaman = 'Macet' THEN p.sisa_pinjaman ELSE 0 END) / 
        NULLIF(SUM(p.jumlah_pinjaman), 0) * 100), 2
    ) AS npl_ratio_persen
FROM Pinjaman p
JOIN Nasabah n ON p.id_nasabah = n.id_nasabah
JOIN Rekening r ON n.id_nasabah = r.id_nasabah
JOIN Cabang c ON r.id_cabang = c.id_cabang
GROUP BY c.nama_cabang;

-- Query 4: Analisis transaksi per channel
CREATE VIEW v_summary_transaksi_bulanan AS
SELECT 
    DATE_FORMAT(tanggal_transaksi, '%Y-%m') AS periode,
    jenis_transaksi,
    COUNT(*) AS jumlah_transaksi,
    SUM(nominal) AS total_nilai,
    SUM(biaya_transaksi) AS total_fee,
    AVG(nominal) AS rata_rata_transaksi
FROM Transaksi
WHERE status_transaksi = 'Berhasil'
GROUP BY DATE_FORMAT(tanggal_transaksi, '%Y-%m'), jenis_transaksi
ORDER BY periode DESC, jenis_transaksi;

-- Query 5: Customer segmentation berdasarkan saldo
CREATE VIEW v_segmentasi_nasabah AS
SELECT 
    CASE 
        WHEN total_saldo >= 100000000 THEN 'Platinum'
        WHEN total_saldo >= 50000000 THEN 'Gold'
        WHEN total_saldo >= 10000000 THEN 'Silver'
        ELSE 'Regular'
    END AS segmen,
    COUNT(*) AS jumlah_nasabah,
    MIN(total_saldo) AS saldo_minimum,
    MAX(total_saldo) AS saldo_maksimum,
    AVG(total_saldo) AS saldo_rata_rata,
    SUM(total_saldo) AS total_dana_kelola
FROM (
    SELECT 
        n.id_nasabah,
        SUM(r.saldo) AS total_saldo
    FROM Nasabah n
    JOIN Rekening r ON n.id_nasabah = r.id_nasabah
    WHERE r.status_rekening = 'Aktif'
    GROUP BY n.id_nasabah
) AS customer_balance
GROUP BY segmen
ORDER BY FIELD(segmen, 'Platinum', 'Gold', 'Silver', 'Regular');

-- ========================================
-- INDEXES FOR PERFORMANCE OPTIMIZATION
-- ========================================

-- Additional indexes untuk query optimization
CREATE INDEX idx_transaksi_tanggal ON Transaksi(tanggal_transaksi DESC);
CREATE INDEX idx_transaksi_composite ON Transaksi(no_rekening, tanggal_transaksi);
CREATE INDEX idx_pinjaman_status ON Pinjaman(status_pinjaman, tanggal_pinjaman);
CREATE INDEX idx_rekening_composite ON Rekening(id_nasabah, status_rekening);
CREATE INDEX idx_nasabah_tanggal ON Nasabah(tanggal_daftar);

-- ========================================
-- SAMPLE USAGE & TESTING QUERIES
-- ========================================

-- Test 1: Cek portfolio nasabah
-- SELECT * FROM v_portfolio_nasabah WHERE total_saldo > 10000000 ORDER BY total_saldo DESC;

-- Test 2: Analisis cabang terbaik
-- SELECT * FROM v_summary_rekening_cabang ORDER BY total_saldo DESC;

-- Test 3: Monitoring pinjaman bermasalah
-- SELECT * FROM v_analisis_pinjaman WHERE flag_status IN ('Perlu Perhatian', 'Bermasalah');

-- Test 4: Performance karyawan
-- SELECT * FROM v_kinerja_karyawan ORDER BY total_nilai_pinjaman_approved DESC LIMIT 10;

-- Test 5: Execute transfer
-- CALL sp_transfer(1000100001, 2000200002, 500000, 'Transfer test', @status, @message);
-- SELECT @status, @message;

-- Test 6: Segmentasi nasabah
-- SELECT * FROM v_segmentasi_nasabah;

-- Test 7: Trend NPL
-- SELECT * FROM v_analisis_npl ORDER BY npl_ratio_persen DESC;

-- ========================================
-- MAINTENANCE & BACKUP RECOMMENDATIONS
-- ========================================

/*
RECOMMENDED MAINTENANCE SCHEDULE:
1. Daily: Backup database (mysqldump)
2. Weekly: Analyze and optimize tables
   - ANALYZE TABLE Transaksi, Rekening, Pinjaman;
   - OPTIMIZE TABLE Transaksi;
3. Monthly: Review slow queries and indexes
4. Quarterly: Archive old transaction data

BACKUP COMMAND EXAMPLE:
mysqldump -u root -p Bank_Kemandirian > backup_$(date +%Y%m%d).sql

SECURITY RECOMMENDATIONS:
1. Use strong password hashing (bcrypt/argon2)
2. Implement role-based access control (RBAC)
3. Enable SSL for database connections
4. Regular security audits via Audit_Log table
5. Implement rate limiting for sensitive operations
6. Use prepared statements to prevent SQL injection
*/

-- ========================================
-- END OF DATABASE SCRIPT
-- ========================================

-- Success message
SELECT 
    'Database Bank_Kemandirian berhasil dibuat!' AS Status,
    COUNT(DISTINCT table_name) AS Total_Tables,
    'Professional banking system ready!' AS Message
FROM information_schema.tables 
WHERE table_schema = 'Bank_Kemandirian';
