# 🏥 Hospital Management System - Database

[![MySQL](https://img.shields.io/badge/MySQL-8.0+-blue.svg)](https://www.mysql.com/)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)
[![Status](https://img.shields.io/badge/Status-Production%20Ready-success.svg)]()

Sistem manajemen database rumah sakit lengkap yang mencakup manajemen pasien, dokter, rawat jalan, rawat inap, rekam medis elektronik, farmasi, dan sistem pembayaran terintegrasi.

## 📋 Table of Contents

- [Features](#features)
- [Database Schema](#database-schema)
- [Installation](#installation)
- [Usage](#usage)
- [API Documentation](#api-documentation)
- [Views & Analytics](#views--analytics)
- [Security](#security)
- [Contributing](#contributing)

## ✨ Features

### Core Hospital Functions
- 👥 **Patient Management** - Complete patient records dengan NIK, asuransi, dan riwayat medis
- 👨‍⚕️ **Doctor Management** - Profil dokter lengkap dengan spesialisasi, jadwal praktik, dan rating
- 🏥 **Outpatient Care (Rawat Jalan)** - Sistem registrasi dan pemeriksaan pasien
- 🛏️ **Inpatient Care (Rawat Inap)** - Manajemen ruangan dan pasien rawat inap
- 📋 **Electronic Medical Records** - Rekam medis elektronik lengkap dengan diagnosis ICD-10
- 💊 **Pharmacy Management** - Inventory obat, resep elektronik, dan tracking stok
- 📅 **Appointment System** - Sistem perjanjian pasien dengan dokter
- 💰 **Billing & Payment** - Sistem pembayaran terintegrasi (Tunai, BPJS, Asuransi)

### Advanced Features
- 🔄 **Stored Procedures** - Registrasi otomatis, kalkulasi biaya
- 🎯 **Triggers** - Auto-update stok obat, biaya total, status ruangan
- 📊 **Analytics Views** - Dashboard, kinerja dokter, laporan keuangan
- 🔐 **Audit Trail** - Complete logging untuk compliance
- ⚡ **Optimized Indexes** - Fast query performance
- 📈 **Business Intelligence** - Top diagnosis, obat populer, occupancy rate

## 🗄️ Database Schema

### Entity Relationship Overview

```
Pasien (Patient)
    ├── Rawat_Jalan (Outpatient)
    │   ├── Rekam_Medis (Medical Record)
    │   │   ├── Tindakan_Rekam_Medis (Procedures)
    │   │   └── Resep_Obat (Prescription)
    │   │       └── Detail_Resep (Prescription Items)
    │   └── Pembayaran (Payment)
    └── Rawat_Inap (Inpatient)
        └── Pembayaran

Dokter (Doctor)
    ├── Rawat_Jalan
    ├── Jadwal_Dokter (Schedule)
    └── Appointment

Ruangan (Room)
    └── Rawat_Inap

Tindakan (Procedure)
    └── Tindakan_Rekam_Medis

Obat (Medicine)
    └── Detail_Resep
```

### Main Tables

| Table | Description | Sample Records |
|-------|-------------|----------------|
| `Pasien` | Patient master data with NIK & insurance | 10 patients |
| `Dokter` | Doctor with specialization & STR | 10 doctors |
| `Ruangan` | Hospital rooms (VIP, Class 1-3, ICU) | 10 rooms |
| `Tindakan` | Medical procedures & lab tests | 30 procedures |
| `Obat` | Pharmacy inventory | 25 medicines |
| `Rawat_Jalan` | Outpatient visit records | 10 visits |
| `Rawat_Inap` | Inpatient records | Sample ready |
| `Rekam_Medis` | Electronic medical records | 10 records |
| `Resep_Obat` | Prescription records | 10 prescriptions |
| `Jadwal_Dokter` | Doctor schedules | 13 schedules |
| `Appointment` | Patient appointments | Ready |
| `Pembayaran` | Payment transactions | Ready |

## 🚀 Installation

### Prerequisites

```bash
- MySQL 8.0 or higher
- MySQL Workbench (recommended)
- Minimum 200MB disk space
```

### Step 1: Clone Repository

```bash
git clone https://github.com/yourusername/hospital-management-db.git
cd hospital-management-db
```

### Step 2: Import Database

#### Using MySQL Command Line:

```bash
mysql -u root -p < hospital_management_system.sql
```

#### Using MySQL Workbench:

1. Open MySQL Workbench
2. File → Open SQL Script
3. Select `hospital_management_system.sql`
4. Execute (⚡ icon or Ctrl+Shift+Enter)

### Step 3: Verify Installation

```sql
USE rumah_sakit;
SHOW TABLES;
SELECT * FROM v_dashboard_pasien LIMIT 5;
```

## 💻 Usage

### Basic Operations

#### 1. Register New Outpatient

```sql
CALL sp_registrasi_rawat_jalan(
    1,                           -- id_pasien
    1,                           -- id_dokter
    '2024-11-25',               -- tanggal
    '09:00:00',                 -- waktu
    'Kontrol jantung rutin',    -- keluhan
    @no_reg,                    -- OUTPUT: nomor registrasi
    @status,                    -- OUTPUT: status
    @msg                        -- OUTPUT: message
);

SELECT @no_reg AS no_registrasi, @status, @msg AS pesan;
```

#### 2. Calculate Total Bill

```sql
CALL sp_hitung_biaya_rawat_jalan(1, @total);
SELECT FORMAT(@total, 0) AS total_biaya;
```

#### 3. View Patient Dashboard

```sql
SELECT 
    no_rekam_medis,
    nama_pasien,
    usia,
    golongan_darah,
    total_kunjungan,
    kunjungan_terakhir
FROM v_dashboard_pasien
ORDER BY kunjungan_terakhir DESC;
```

#### 4. Check Doctor Performance

```sql
SELECT 
    nama_dokter,
    spesialisasi,
    rating,
    total_pasien_ditangani,
    FORMAT(total_pendapatan, 0) AS pendapatan
FROM v_kinerja_dokter
ORDER BY total_pasien_ditangani DESC
LIMIT 10;
```

#### 5. Critical Stock Medicine

```sql
SELECT 
    nama_obat,
    kategori_obat,
    stok,
    stok_minimum,
    status_stok,
    hari_sampai_kadaluarsa
FROM v_stok_obat_kritis
WHERE status_stok IN ('KRITIS', 'PERLU RESTOCK')
ORDER BY stok ASC;
```

### Advanced Queries

#### Daily Visit Report

```sql
SELECT 
    tanggal,
    jumlah_kunjungan,
    jumlah_pasien_unik,
    FORMAT(total_pendapatan, 0) AS pendapatan,
    FORMAT(rata_rata_biaya, 0) AS rata_rata
FROM v_kunjungan_harian
WHERE tanggal >= DATE_SUB(CURDATE(), INTERVAL 30 DAY)
ORDER BY tanggal DESC;
```

#### Top 10 Diagnosis

```sql
SELECT 
    diagnosis_utama,
    kode_icd10,
    jumlah_kasus,
    jumlah_pasien
FROM v_top_diagnosis;
```

#### Room Occupancy Rate

```sql
SELECT 
    nama_ruangan,
    tipe_ruangan,
    CONCAT(bed_terisi, '/', kapasitas_bed) AS bed_usage,
    CONCAT(occupancy_rate, '%') AS tingkat_hunian,
    status_ruangan
FROM v_occupancy_ruangan
ORDER BY occupancy_rate DESC;
```

#### Revenue by Payment Type

```sql
SELECT 
    tipe_pembayaran,
    jumlah_transaksi,
    FORMAT(total_pendapatan, 0) AS total_pendapatan,
    FORMAT(rata_rata_transaksi, 0) AS rata_rata
FROM v_pendapatan_pembayaran
ORDER BY total_pendapatan DESC;
```

#### Most Prescribed Medicines

```sql
SELECT 
    nama_obat,
    kategori_obat,
    jumlah_resep,
    total_unit_terjual,
    FORMAT(total_penjualan, 0) AS penjualan
FROM v_obat_populer
LIMIT 10;
```

## 📖 API Documentation

### Stored Procedures

#### `sp_registrasi_rawat_jalan()`

Register new outpatient visit with quota validation.

**Parameters:**
- `p_id_pasien` (INT) - Patient ID
- `p_id_dokter` (INT) - Doctor ID
- `p_tanggal` (DATE) - Visit date
- `p_waktu` (TIME) - Visit time
- `p_keluhan` (TEXT) - Chief complaint
- `p_no_registrasi` (OUT VARCHAR) - Registration number
- `p_status` (OUT VARCHAR) - Status result
- `p_message` (OUT VARCHAR) - Message result

**Example:**
```sql
CALL sp_registrasi_rawat_jalan(
    5, 2, '2024-11-26', '10:30:00', 
    'Demam dan batuk', 
    @no, @status, @msg
);
```

#### `sp_hitung_biaya_rawat_jalan()`

Calculate total cost for outpatient visit (consultation + procedures + medicines).

**Parameters:**
- `p_id_rawat_jalan` (INT) - Outpatient visit ID
- `p_total_biaya` (OUT DECIMAL) - Total cost output

**Example:**
```sql
CALL sp_hitung_biaya_rawat_jalan(5, @total);
SELECT @total;
```

### Views Reference

| View | Description |
|------|-------------|
| `v_dashboard_pasien` | Complete patient portfolio with visit statistics |
| `v_kinerja_dokter` | Doctor performance metrics |
| `v_kunjungan_harian` | Daily visit summary and revenue |
| `v_top_diagnosis` | Top 10 most common diagnoses |
| `v_stok_obat_kritis` | Critical stock medicines alert |
| `v_occupancy_ruangan` | Room occupancy rate |
| `v_pendapatan_pembayaran` | Revenue by payment method |
| `v_obat_populer` | Most prescribed medicines |

## 🔐 Security

### Best Practices Implemented

1. **Data Validation**
   - CHECK constraints on critical fields
   - UNIQUE constraints on business keys (NIK, STR, SIP)
   - Foreign key integrity
   - ENUM for standardized values

2. **Medical Data Protection**
   - Separate sensitive data in detail tables
   - Audit trail ready structure
   - Encryption recommended for passwords/personal data

3. **Access Control Recommendations**

```sql
-- Create read-only user for reports
CREATE USER 'hospital_report'@'localhost' IDENTIFIED BY 'strong_password';
GRANT SELECT ON rumah_sakit.* TO 'hospital_report'@'localhost';

-- Create user for application with limited access
CREATE USER 'hospital_app'@'localhost' IDENTIFIED BY 'strong_password';
GRANT SELECT, INSERT, UPDATE ON rumah_sakit.* TO 'hospital_app'@'localhost';
GRANT EXECUTE ON rumah_sakit.* TO 'hospital_app'@'localhost';
REVOKE DELETE ON rumah_sakit.* FROM 'hospital_app'@'localhost';

-- Create admin user
CREATE USER 'hospital_admin'@'localhost' IDENTIFIED BY 'very_strong_password';
GRANT ALL PRIVILEGES ON rumah_sakit.* TO 'hospital_admin'@'localhost';
```

## 🛠️ Maintenance

### Daily Tasks

```bash
# Backup database
mysqldump -u root -p rumah_sakit > backup_hospital_$(date +%Y%m%d).sql

# Backup with compression
mysqldump -u root -p rumah_sakit | gzip > backup_hospital_$(date +%Y%m%d).sql.gz
```

### Weekly Tasks

```sql
-- Analyze and optimize tables
ANALYZE TABLE Rawat_Jalan, Rekam_Medis, Resep_Obat;
OPTIMIZE TABLE Rawat_Jalan;

-- Check expired medicines
SELECT * FROM v_stok_obat_kritis 
WHERE hari_sampai_kadaluarsa < 30;

-- Update doctor ratings (if feedback system exists)
-- UPDATE Dokter SET rating = (calculate average from feedback);
```

### Monthly Tasks

```sql
-- Archive old records (example: > 2 years)
CREATE TABLE Rekam_Medis_Archive_2024 LIKE Rekam_Medis;
INSERT INTO Rekam_Medis_Archive_2024 
SELECT rm.* FROM Rekam_Medis rm
JOIN Rawat_Jalan rj ON rm.id_rawat_jalan = rj.id_rawat_jalan
WHERE YEAR(rj.tanggal_kunjungan) = 2024;

-- Generate monthly reports
SELECT 
    MONTH(tanggal) AS bulan,
    SUM(jumlah_kunjungan) AS total_kunjungan,
    SUM(total_pendapatan) AS total_pendapatan
FROM v_kunjungan_harian
WHERE YEAR(tanggal) = YEAR(CURDATE())
GROUP BY MONTH(tanggal);
```

## 📊 Reporting Examples

### Executive Dashboard Query

```sql
SELECT 
    'Total Pasien Aktif' AS metric, 
    COUNT(*) AS value 
FROM Pasien WHERE status_pasien = 'Aktif'
UNION ALL
SELECT 'Total Dokter Aktif', 
    COUNT(*) 
FROM Dokter WHERE status_dokter = 'Aktif'
UNION ALL
SELECT 'Kunjungan Bulan Ini', 
    COUNT(*) 
FROM Rawat_Jalan 
WHERE MONTH(tanggal_kunjungan) = MONTH(CURDATE())
UNION ALL
SELECT 'Pendapatan Bulan Ini', 
    SUM(total_biaya) 
FROM Rawat_Jalan 
WHERE MONTH(tanggal_kunjungan) = MONTH(CURDATE())
    AND status_kunjungan = 'Selesai';
```

### Patient Demographics

```sql
SELECT 
    jenis_kelamin,
    CASE 
        WHEN TIMESTAMPDIFF(YEAR, tanggal_lahir, CURDATE()) < 18 THEN 'Anak (<18)'
        WHEN TIMESTAMPDIFF(YEAR, tanggal_lahir, CURDATE()) BETWEEN 18 AND 40 THEN 'Dewasa (18-40)'
        WHEN TIMESTAMPDIFF(YEAR, tanggal_lahir, CURDATE()) BETWEEN 41 AND 60 THEN 'Dewasa Tua (41-60)'
        ELSE 'Lansia (>60)'
    END AS kategori_usia,
    COUNT(*) AS jumlah_pasien
FROM Pasien
WHERE status_pasien = 'Aktif'
GROUP BY jenis_kelamin, kategori_usia
ORDER BY jenis_kelamin, kategori_usia;
```

## 🧪 Testing

### Sample Test Scenarios

```sql
-- Test 1: Register patient when doctor not available
CALL sp_registrasi_rawat_jalan(1, 1, '2024-11-24', '09:00:00', 'Test', @no, @status, @msg);
-- Expected: Check if Sunday (Minggu) is in doctor's schedule

-- Test 2: Check stock alert
SELECT COUNT(*) AS obat_kritis 
FROM v_stok_obat_kritis 
WHERE status_stok = 'KRITIS';
-- Expected: Any medicines below minimum stock

-- Test 3: Occupancy calculation
SELECT SUM(bed_terisi) / SUM(kapasitas_bed) * 100 AS avg_occupancy
FROM Ruangan;
-- Expected: < 100%
```

## 🤝 Contributing

Contributions are welcome! Please follow these guidelines:

1. Fork the repository
2. Create feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit changes (`git commit -m 'Add AmazingFeature'`)
4. Push to branch (`git push origin feature/AmazingFeature`)
5. Open Pull Request

### Coding Standards

- Use consistent naming conventions (snake_case for tables/columns)
- Add comments for complex queries
- Include sample data for new tables
- Update documentation for new features

## 📝 License

This project is licensed under the MIT License - see [LICENSE](LICENSE) file for details.

## 👥 Authors

- **Your Name** - *Initial work* - [YourGitHub](https://github.com/yourusername)

## 🙏 Acknowledgments

- Designed based on real hospital information systems
- ICD-10 coding standards
- HIPAA compliance considerations
- Sample data is completely fictional

## 📞 Support

For support:
- Email: your.email@example.com
- Issues: [GitHub Issues](https://github.com/yourusername/hospital-management-db/issues)

## 🗺️ Roadmap

- [ ] Add laboratory result management
- [ ] Implement radiology PACS integration
- [ ] Add emergency room (IGD) module
- [ ] Surgery scheduling system
- [ ] Integration with BPJS API
- [ ] Mobile app API endpoints
- [ ] Telemedicine features
- [ ] Patient portal for viewing medical records
- [ ] Doctor mobile app for quick access

## 📚 Additional Resources

- [MySQL Documentation](https://dev.mysql.com/doc/)
- [HL7 FHIR Standards](https://www.hl7.org/fhir/)
- [ICD-10 Codes](https://www.who.int/standards/classifications/classification-of-diseases)
- [Hospital Information Systems](https://en.wikipedia.org/wiki/Hospital_information_system)

---

⭐ **Star this repository if you find it helpful!**

Made with ❤️ for healthcare innovation
