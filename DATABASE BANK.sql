

CREATE DATABASE IF NOT EXISTS Bank_Kemandirian; 
USE Bank_Kemandirian; 


DROP TABLE IF EXISTS Transaksi;
DROP TABLE IF EXISTS Pinjaman;
DROP TABLE IF EXISTS Rekening;
DROP TABLE IF EXISTS Karyawan;
DROP TABLE IF EXISTS Cabang;
DROP TABLE IF EXISTS Nasabah;

-- Tabel utama: Nasabah
CREATE TABLE Nasabah (
    id_nasabah INT PRIMARY KEY AUTO_INCREMENT,
    nik CHAR(16) UNIQUE NOT NULL,
    nama VARCHAR(100) NOT NULL,
    alamat VARCHAR(255),
    no_telp VARCHAR(15),
    email VARCHAR(100),
    tanggal_daftar DATE DEFAULT (CURRENT_DATE)
);

INSERT INTO Nasabah (nik, nama, alamat, no_telp, email) VALUES
('3201019001950001', 'Budi Santoso', 'Jl. Mawar No. 5, Jakarta', '081234567890', 'budi.s@mail.com'), -- 1
('3201021202920002', 'Siti Aminah', 'Jl. Kebun Raya No. 10, Bandung', '087765432101', 'siti.a@mail.com'), -- 2
('3578010505880003', 'Joko Susilo', 'Jl. Pahlawan No. 20, Surabaya', '085612345678', 'joko.s@mail.com'), -- 3
('3173041010990004', 'Dewi Lestari', 'Jl. Anggrek No. 15, Jakarta', '081122334455', 'dewi.l@mail.com'), -- 4
('5171032504900005', 'Made Wira', 'Jl. Sunset Road No. 30, Denpasar', '089900112233', 'made.w@mail.com'), -- 5
('3201030101750006', 'Ahmad Yani', 'Jl. Veteran No. 7, Bandung', '082109876543', 'ahmad.y@mail.com'), -- 6
('3578022003850007', 'Rina Melati', 'Jl. Diponegoro No. 50, Surabaya', '083812121212', 'rina.m@mail.com'), -- 7
('1271011508930008', 'Taufik Hidayat', 'Jl. Setiabudi No. 1, Medan', '081377665544', 'taufik.h@mail.com'), -- 8
('3173050706800009', 'Lina Marlina', 'Jl. Kebon Jeruk No. 8, Jakarta', '081945454545', 'lina.m@mail.com'), -- 9
('5171043012970010', 'Eko Prasetyo', 'Jl. Gajah Mada No. 22, Denpasar', '085200336699', 'eko.p@mail.com'), -- 10
('3374051006910011', 'Galih Akbar', 'Jl. Merapi No. 3, Semarang', '081511223344', 'galih.a@mail.com'), -- 11
('3404060207870012', 'Maya Sari', 'Jl. Pangeran No. 12, Yogyakarta', '087855667788', 'maya.s@mail.com'), -- 12
('7371072209940013', 'Hasan Basri', 'Jl. Sudirman No. 10, Makassar', '082211447700', 'hasan.b@mail.com'), -- 13
('1671080311890014', 'Indah Permata', 'Jl. Kapten A. Rivai No. 5, Palembang', '081700998877', 'indah.p@mail.com'), -- 14
('3201092801960015', 'Kevin Wijaya', 'Jl. Re Soemantadiredja No. 9, Bogor', '085712121212', 'kevin.w@mail.com'), -- 15
('3201100503900016', 'Nia Ramadhani', 'Jl. Gatot Subroto No. 3, Jakarta', '081199887766', 'nia.r@mail.com'), -- 16
('3578111507950017', 'Pandu Dirgantara', 'Jl. Ahmad Yani No. 5, Surabaya', '085600112233', 'pandu.d@mail.com'), -- 17
('3201121012850018', 'Citra Kirana', 'Jl. Dago No. 22, Bandung', '081333445566', 'citra.k@mail.com'), -- 18
('3173132505980019', 'Rizki Akbar', 'Jl. Thamrin No. 1, Jakarta', '087711223344', 'rizki.a@mail.com'), -- 19
('3404140104800020', 'Shinta Dewi', 'Jl. Parangtritis No. 8, Yogyakarta', '081955443322', 'shinta.d@mail.com'); -- 20


-- Tabel Cabang Bank
CREATE TABLE Cabang (
    id_cabang INT PRIMARY KEY AUTO_INCREMENT,
    nama_cabang VARCHAR(100) NOT NULL,
    alamat_cabang VARCHAR(255),
    kota VARCHAR(100),
    telepon VARCHAR(15)
);

INSERT INTO Cabang (nama_cabang, alamat_cabang, kota, telepon) VALUES
('Kantor Pusat Jakarta', 'Jl. Sudirman No. 12', 'Jakarta Pusat', '021-12345678'), -- 1
('Cabang Bandung', 'Jl. Asia Afrika No. 45', 'Bandung', '022-98765432'), -- 2
('Cabang Surabaya', 'Jl. Darmo No. 100', 'Surabaya', '031-11223344'), -- 3
('Cabang Medan', 'Jl. Merdeka No. 5', 'Medan', '061-55667788'), -- 4
('Cabang Denpasar', 'Jl. Raya Kuta No. 88', 'Denpasar', '0361-99887766'), -- 5
('Cabang Semarang', 'Jl. Pemuda No. 1', 'Semarang', '024-55443322'), -- 6
('Cabang Yogyakarta', 'Jl. Malioboro No. 10', 'Yogyakarta', '0274-12121212'), -- 7
('Cabang Makassar', 'Jl. Ahmad Yani No. 50', 'Makassar', '0411-88776655'), -- 8
('Cabang Palembang', 'Jl. Jenderal Sudirman No. 20', 'Palembang', '0711-33221100'), 
('Cabang Bogor', 'Jl. Pajajaran No. 7', 'Bogor', '0251-40404040'); 

-- Tabel Karyawan
CREATE TABLE Karyawan (
    id_karyawan INT PRIMARY KEY AUTO_INCREMENT,
    id_cabang INT,
    nama_karyawan VARCHAR(100) NOT NULL,
    jabatan VARCHAR(50),
    tanggal_masuk DATE,
    gaji DECIMAL(15,2),
    FOREIGN KEY (id_cabang) REFERENCES Cabang(id_cabang)
        ON DELETE SET NULL
        ON UPDATE CASCADE
);

INSERT INTO Karyawan (id_cabang, nama_karyawan, jabatan, tanggal_masuk, gaji) VALUES
(1, 'Agus Salim', 'Branch Manager', '2015-01-10', 15000000.00), -- 1 (Jakarta Pusat)
(1, 'Fani Herliana', 'Customer Service', '2018-05-20', 8000000.00), -- 2 (Jakarta Pusat)
(2, 'Yoga Pratama', 'Teller', '2019-11-01', 6500000.00), -- 3 (Bandung)
(2, 'Ratih Kumala', 'Loan Officer', '2016-07-15', 9500000.00), -- 4 (Bandung)
(3, 'Dian Permata', 'Branch Manager', '2014-03-25', 14000000.00), -- 5 (Surabaya)
(3, 'Galih Satria', 'Customer Service', '2020-02-14', 7800000.00), -- 6 (Surabaya)
(4, 'Putri Anjani', 'Teller', '2021-09-01', 6200000.00), -- 7 (Medan)
(5, 'Sinta Dewi', 'Loan Officer', '2017-12-05', 10000000.00), -- 8 (Denpasar)
(5, 'Kevin Sanjaya', 'Customer Service', '2022-01-10', 7500000.00), -- 9 (Denpasar)
(6, 'Rizky Fadilah', 'Branch Manager', '2023-04-12', 12000000.00), -- 10 (Semarang)
(7, 'Maya Fitri', 'Teller', '2020-08-20', 6000000.00), -- 11 (Yogyakarta)
(8, 'Hendra Laksana', 'Loan Officer', '2018-03-01', 9800000.00), -- 12 (Makassar)
(9, 'Lia Maharani', 'Customer Service', '2021-05-15', 7700000.00), -- 13 (Palembang)
(10, 'Joko Anwar', 'Teller', '2022-11-05', 6300000.00), -- 14 (Bogor)
(1, 'Nina Kirana', 'Loan Officer', '2019-06-18', 9200000.00), -- 15 (Jakarta Pusat)
(2, 'Bambang Irawan', 'Customer Service', '2023-01-25', 7500000.00), -- 16 (Bandung)
(3, 'Susi Susanti', 'Teller', '2024-03-10', 6100000.00), -- 17 (Surabaya)
(4, 'Tono Suparman', 'Customer Service', '2021-10-10', 7600000.00), -- 18 (Medan)
(6, 'Wulan Guritno', 'Teller', '2020-04-04', 6400000.00), -- 19 (Semarang)
(7, 'Dimas Tri', 'Loan Officer', '2017-02-02', 10500000.00); -- 20 (Yogyakarta)

-- Tabel Rekening
CREATE TABLE Rekening (
    no_rekening BIGINT PRIMARY KEY,
    id_nasabah INT,
    id_cabang INT,
    jenis_rekening ENUM('Tabungan','Giro','Deposito'),
    saldo DECIMAL(20,2) DEFAULT 0,
    tanggal_buka DATE DEFAULT (CURRENT_DATE),
    status_rekening ENUM('Aktif','Nonaktif') DEFAULT 'Aktif',
    FOREIGN KEY (id_nasabah) REFERENCES Nasabah(id_nasabah)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (id_cabang) REFERENCES Cabang(id_cabang)
        ON DELETE SET NULL
        ON UPDATE CASCADE
);

INSERT INTO Rekening (no_rekening, id_nasabah, id_cabang, jenis_rekening, saldo, tanggal_buka) VALUES
(1000100001, 1, 1, 'Tabungan', 5500000.00, '2022-01-01'), -- Budi S (Jkt)
(2000200002, 2, 2, 'Tabungan', 12000000.00, '2021-05-15'), -- Siti A (Bdg)
(3000300003, 3, 3, 'Giro', 50000000.00, '2020-03-10'), -- Joko S (Sby)
(1000400004, 4, 1, 'Deposito', 75000000.00, '2023-08-20'), -- Dewi L (Jkt)
(5000500005, 5, 5, 'Tabungan', 3500000.00, '2022-11-11'), -- Made W (Dps)
(2000600006, 6, 2, 'Tabungan', 1500000.00, '2023-01-01'), -- Ahmad Y (Bdg)
(3000700007, 7, 3, 'Giro', 22000000.00, '2021-10-25'), -- Rina M (Sby)
(4000800008, 8, 4, 'Tabungan', 800000.00, '2023-05-05'), -- Taufik H (Mdn)
(1000900009, 9, 1, 'Tabungan', 1000000.00, '2024-02-01'), -- Lina M (Jkt)
(5001000010, 10, 5, 'Deposito', 150000000.00, '2021-07-07'), -- Eko P (Dps)
(6001100011, 11, 6, 'Tabungan', 4500000.00, '2022-06-01'), -- Galih A (Smg)
(7001200012, 12, 7, 'Tabungan', 8000000.00, '2023-02-15'), -- Maya S (Yog)
(8001300013, 13, 8, 'Giro', 30000000.00, '2021-11-20'), -- Hasan B (Mks)
(9001400014, 14, 9, 'Tabungan', 7000000.00, '2022-08-18'), -- Indah P (Plb)
(1001500015, 15, 10, 'Tabungan', 2500000.00, '2024-04-01'), -- Kevin W (Bgr)
(1001600016, 16, 1, 'Tabungan', 6000000.00, '2023-07-10'), -- Nia R (Jkt)
(3001700017, 17, 3, 'Giro', 40000000.00, '2020-12-05'), -- Pandu D (Sby)
(2001800018, 18, 2, 'Tabungan', 100000.00, '2024-01-15'), -- Citra K (Bdg)
(1001900019, 19, 1, 'Deposito', 120000000.00, '2022-03-01'), -- Rizki A (Jkt)
(7002000020, 20, 7, 'Tabungan', 1200000.00, '2023-04-04'), -- Shinta D (Yog)
(1002100021, 1, 1, 'Giro', 15000000.00, '2024-01-15'), -- Budi S (Rekening ke-2)
(2002200022, 2, 2, 'Deposito', 50000000.00, '2022-09-09'), -- Siti A (Rekening ke-2)
(5002300023, 5, 5, 'Deposito', 30000000.00, '2023-06-06'), -- Made W (Rekening ke-2)
(6002400024, 11, 6, 'Giro', 18000000.00, '2024-02-20'), -- Galih A (Rekening ke-2)
(9002500025, 14, 9, 'Deposito', 45000000.00, '2021-12-12'); -- Indah P (Rekening ke-2)



-- Tabel Pinjaman
CREATE TABLE Pinjaman (
    id_pinjaman INT PRIMARY KEY AUTO_INCREMENT,
    id_nasabah INT,
    id_karyawan INT,
    jumlah_pinjaman DECIMAL(20,2),
    bunga DECIMAL(5,2),
    jangka_waktu INT,
    tanggal_pinjaman DATE DEFAULT (CURRENT_DATE),
    status_pinjaman ENUM('Berjalan','Lunas','Macet') DEFAULT 'Berjalan',
    FOREIGN KEY (id_nasabah) REFERENCES Nasabah(id_nasabah)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (id_karyawan) REFERENCES Karyawan(id_karyawan)
        ON DELETE SET NULL
        ON UPDATE CASCADE
);

INSERT INTO Pinjaman (id_nasabah, id_karyawan, jumlah_pinjaman, bunga, jangka_waktu, tanggal_pinjaman, status_pinjaman) VALUES
(1, 4, 15000000.00, 10.50, 12, '2023-03-01', 'Berjalan'), -- Budi S
(3, 8, 200000000.00, 8.00, 36, '2022-01-20', 'Berjalan'), -- Joko S
(5, 4, 5000000.00, 12.00, 6, '2024-01-10', 'Lunas'), -- Made W
(6, 4, 50000000.00, 9.50, 24, '2023-09-01', 'Berjalan'), -- Ahmad Y
(8, 7, 10000000.00, 11.00, 12, '2023-10-15', 'Berjalan'), -- Taufik H
(9, 2, 25000000.00, 10.00, 18, '2024-03-20', 'Berjalan'), -- Lina M
(1, 4, 5000000.00, 9.00, 6, '2024-05-01', 'Berjalan'), -- Budi S (Pinj. ke-2)
(7, 5, 100000000.00, 7.50, 48, '2022-05-01', 'Macet'), -- Rina M
(11, 10, 30000000.00, 10.25, 24, '2023-11-15', 'Berjalan'), -- Galih A
(12, 11, 8000000.00, 11.50, 12, '2024-02-28', 'Berjalan'), -- Maya S
(13, 12, 150000000.00, 8.50, 60, '2021-04-10', 'Berjalan'), -- Hasan B
(14, 13, 40000000.00, 9.00, 36, '2022-07-01', 'Lunas'), -- Indah P
(15, 14, 15000000.00, 10.75, 18, '2023-12-01', 'Berjalan'), -- Kevin W
(16, 15, 75000000.00, 9.75, 48, '2022-10-10', 'Berjalan'), -- Nia R
(17, 16, 12000000.00, 11.00, 12, '2024-04-15', 'Berjalan'), -- Pandu D
(18, 17, 20000000.00, 10.00, 24, '2023-06-01', 'Berjalan'), -- Citra K
(19, 15, 2000000.00, 12.50, 6, '2024-05-05', 'Berjalan'), -- Rizki A
(20, 20, 60000000.00, 8.75, 36, '2022-11-01', 'Berjalan'), -- Shinta D
(11, 10, 5000000.00, 13.00, 12, '2024-01-20', 'Lunas'), -- Galih A (Pinj. ke-2)
(13, 12, 10000000.00, 10.00, 12, '2024-03-01', 'Berjalan'); -- Hasan B (Pinj. ke-2)



-- Tabel Transaksi
CREATE TABLE Transaksi (
    id_transaksi INT PRIMARY KEY AUTO_INCREMENT,
    no_rekening BIGINT,
    jenis_transaksi ENUM('Setor','Tarik','Transfer','Pembayaran'),
    nominal DECIMAL(20,2) NOT NULL,
    tanggal_transaksi DATETIME DEFAULT CURRENT_TIMESTAMP,
    keterangan VARCHAR(255),
    FOREIGN KEY (no_rekening) REFERENCES Rekening(no_rekening)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

INSERT INTO Transaksi (no_rekening, jenis_transaksi, nominal, keterangan) VALUES
(1000100001, 'Setor', 1000000.00, 'Setoran tunai awal bulan'), -- 1
(1000100001, 'Tarik', 500000.00, 'Penarikan ATM'), -- 2
(2000200002, 'Transfer', 2000000.00, 'Transfer ke rekening lain'), -- 3
(3000300003, 'Setor', 10000000.00, 'Setoran giro perusahaan'), -- 4
(5000500005, 'Tarik', 1000000.00, 'Penarikan tunai'), -- 5
(2000600006, 'Setor', 500000.00, 'Setoran dari gaji'), -- 6
(3000700007, 'Transfer', 5000000.00, 'Transfer ke supplier'), -- 7
(4000800008, 'Tarik', 200000.00, 'Bayar kebutuhan sehari-hari'), -- 8
(1000900009, 'Setor', 50000.00, 'Setor uang saku'), -- 9
(1000100001, 'Pembayaran', 250000.00, 'Bayar listrik'), -- 10
(6001100011, 'Setor', 2000000.00, 'Setoran tunai'), -- 11
(7001200012, 'Tarik', 500000.00, 'Penarikan di kantor cabang'), -- 12
(8001300013, 'Transfer', 10000000.00, 'Transfer modal kerja'), -- 13
(9001400014, 'Setor', 1500000.00, 'Setoran komisi'), -- 14
(1001500015, 'Tarik', 200000.00, 'Penarikan harian'), -- 15
(1001600016, 'Transfer', 1000000.00, 'Transfer ke rekening anak'), -- 16
(3001700017, 'Setor', 5000000.00, 'Setoran giro bulan ini'), -- 17
(2001800018, 'Tarik', 50000.00, 'Penarikan dana darurat'), -- 18
(1001900019, 'Pembayaran', 500000.00, 'Bayar angsuran'), -- 19
(7002000020, 'Setor', 300000.00, 'Setoran tunai'), -- 20
(2000200002, 'Tarik', 5000000.00, 'Tarik dana usaha'), -- 21
(3000300003, 'Transfer', 25000000.00, 'Transfer besar'), -- 22
(5000500005, 'Setor', 500000.00, 'Setoran tambahan'), -- 23
(6001100011, 'Tarik', 100000.00, 'Penarikan kecil'), -- 24
(9001400014, 'Transfer', 500000.00, 'Transfer ke orang tua'), -- 25
(1001600016, 'Pembayaran', 150000.00, 'Bayar pulsa'), -- 26
(7001200012, 'Setor', 1000000.00, 'Setoran rutin'), -- 27
(8001300013, 'Tarik', 5000000.00, 'Penarikan dana investasi'), -- 28
(1000100001, 'Setor', 500000.00, 'Setoran akhir pekan'), -- 29
(2000600006, 'Tarik', 100000.00, 'Tarik jajan');


SELECT * FROM Cabang;
SELECT * FROM Nasabah;
SELECT * FROM Karyawan;
SELECT * FROM Transaksi;
SELECT * FROM Pinjaman;
SELECT * FROM Rekening;

UPDATE Rekening
SET status_rekening = 'Nonaktif'
WHERE id_nasabah = 15;

INSERT INTO Rekening (no_rekening, id_nasabah, id_cabang, jenis_rekening, saldo, tanggal_buka) VALUES
(1000100005, 1, 1, 'Obligasi', 7700000.00, '2022-01-01');
