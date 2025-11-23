# 🏦 Bank Kemandirian - Database Management System

[![MySQL](https://img.shields.io/badge/MySQL-8.0+-blue.svg)](https://www.mysql.com/)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)
[![Status](https://img.shields.io/badge/Status-Production%20Ready-success.svg)]()

Sistem manajemen database perbankan lengkap yang mencakup manajemen nasabah, rekening, transaksi, pinjaman, dan operasional cabang.

## 📋 Table of Contents

- [Features](#features)
- [Database Schema](#database-schema)
- [Installation](#installation)
- [Usage](#usage)
- [API Documentation](#api-documentation)
- [Security](#security)
- [Contributing](#contributing)
- [License](#license)

## ✨ Features

### Core Banking Functions
- ✅ **Customer Management** - Pengelolaan data nasabah lengkap dengan validasi NIK
- 💰 **Multi-Account Support** - Tabungan, Giro, dan Deposito
- 💸 **Transaction Processing** - Setor, Tarik, Transfer, dan Pembayaran
- 🏦 **Loan Management** - KPR, Multiguna, Modal Usaha, Kendaraan, Pendidikan
- 🏢 **Branch Operations** - Manajemen multi-cabang dan karyawan
- 📊 **Analytics & Reporting** - Business Intelligence views

### Advanced Features
- 🔄 **Stored Procedures** - Transfer otomatis, kalkulasi angsuran
- 🎯 **Triggers** - Auto-update saldo, audit logging
- 📈 **Views** - Portfolio nasabah, NPL analysis, customer segmentation
- 🔐 **Audit Trail** - Complete logging untuk compliance
- ⚡ **Optimized Indexes** - Fast query performance
- 🔒 **Data Validation** - Constraints dan business rules

## 🗄️ Database Schema

### Entity Relationship Diagram

```
Nasabah (Customer)
    ├── Rekening (Account)
    │   └── Transaksi (Transaction)
    └── Pinjaman (Loan)
        └── Angsuran (Installment)

Cabang (Branch)
    ├── Rekening
    └── Karyawan (Employee)
        └── Pinjaman
```

### Main Tables

| Table | Description | Records |
|-------|-------------|---------|
| `Nasabah` | Customer master data | ~15 sample |
| `Cabang` | Branch information | 10 branches |
| `Karyawan` | Employee data | ~10 employees |
| `Rekening` | Account management | ~13 accounts |
| `Pinjaman` | Loan portfolio | ~5 loans |
| `Transaksi` | Transaction records | ~30 transactions |
| `Angsuran` | Loan installments | Generated |
| `Audit_Log` | Audit trail | Auto-generated |

## 🚀 Installation

### Prerequisites

```bash
- MySQL 8.0 or higher
- MySQL Workbench (optional, for GUI)
- Minimum 100MB disk space
```

### Step 1: Clone Repository

```bash
git clone https://github.com/yourusername/bank-kemandirian-db.git
cd bank-kemandirian-db
```

### Step 2: Import Database

#### Using MySQL Command Line:

```bash
mysql -u root -p < bank_kemandirian.sql
```

#### Using MySQL Workbench:

1. Open MySQL Workbench
2. File → Open SQL Script
3. Select `bank_kemandirian.sql`
4. Execute (⚡ icon or Ctrl+Shift+Enter)

### Step 3: Verify Installation

```sql
USE Bank_Kemandirian;
SHOW TABLES;
SELECT * FROM v_portfolio_nasabah LIMIT 5;
```

## 💻 Usage

### Basic Operations

#### 1. Check Customer Portfolio

```sql
SELECT * FROM v_portfolio_nasabah 
WHERE total_saldo > 10000000 
ORDER BY total_saldo DESC;
```

#### 2. Process Transfer

```sql
CALL sp_transfer(
    1000100001,              -- Rekening asal
    2000200002,              -- Rekening tujuan
    500000,                  -- Nominal
    'Transfer dana',         -- Keterangan
    @status,                 -- Output status
    @message                 -- Output message
);

SELECT @status, @message;
```

#### 3. Generate Loan Installments

```sql
CALL sp_generate_angsuran(1);  -- id_pinjaman
SELECT * FROM Angsuran WHERE id_pinjaman = 1;
```

#### 4. Customer Segmentation

```sql
SELECT * FROM v_segmentasi_nasabah;
```

#### 5. NPL Analysis

```sql
SELECT * FROM v_analisis_npl 
ORDER BY npl_ratio_persen DESC;
```

### Advanced Queries

#### Monthly Transaction Trend

```sql
SELECT 
    periode,
    jenis_transaksi,
    jumlah_transaksi,
    FORMAT(total_nilai, 0) AS total_nilai,
    FORMAT(rata_rata_transaksi, 0) AS avg_transaksi
FROM v_summary_transaksi_bulanan
ORDER BY periode DESC, total_nilai DESC;
```

#### Top Performing Employees

```sql
SELECT 
    nama_karyawan,
    jabatan,
    nama_cabang,
    total_pinjaman_diproses,
    FORMAT(total_nilai_pinjaman_approved, 0) AS total_approved,
    masa_kerja_tahun
FROM v_kinerja_karyawan
ORDER BY total_nilai_pinjaman_approved DESC
LIMIT 10;
```

#### Branch Performance

```sql
SELECT 
    nama_cabang,
    jenis_rekening,
    jumlah_rekening,
    FORMAT(total_saldo, 0) AS total_saldo,
    FORMAT(saldo_rata_rata, 0) AS avg_saldo
FROM v_summary_rekening_cabang
ORDER BY total_saldo DESC;
```

## 📖 API Documentation

### Stored Procedures

#### `sp_transfer()`

Melakukan transfer antar rekening dengan validasi saldo dan fee.

**Parameters:**
- `p_no_rekening_asal` (BIGINT) - Nomor rekening pengirim
- `p_no_rekening_tujuan` (BIGINT) - Nomor rekening penerima
- `p_nominal` (DECIMAL) - Jumlah transfer
- `p_keterangan` (VARCHAR) - Keterangan transfer
- `p_status` (OUT VARCHAR) - Status hasil ('BERHASIL'/'GAGAL')
- `p_message` (OUT VARCHAR) - Pesan hasil

**Example:**
```sql
CALL sp_transfer(1000100001, 2000200002, 1000000, 'Bayar supplier', @s, @m);
```

#### `sp_generate_angsuran()`

Generate jadwal angsuran untuk pinjaman.

**Parameters:**
- `p_id_pinjaman` (INT) - ID pinjaman

**Example:**
```sql
CALL sp_generate_angsuran(1);
```

### Views Reference

| View | Description |
|------|-------------|
| `v_portfolio_nasabah` | Complete customer portfolio |
| `v_summary_rekening_cabang` | Account summary per branch |
| `v_analisis_pinjaman` | Loan analysis with flags |
| `v_transaksi_harian` | Daily transaction summary |
| `v_kinerja_karyawan` | Employee performance metrics |
| `v_top_nasabah_by_saldo` | Top 10 customers by balance |
| `v_analisis_npl` | NPL ratio analysis |
| `v_segmentasi_nasabah` | Customer segmentation |

## 🔐 Security

### Best Practices Implemented

1. **Password Hashing**
   - Passwords stored as hashed values (placeholder format)
   - Recommend bcrypt or Argon2 in production

2. **Data Validation**
   - CHECK constraints on critical fields
   - UNIQUE constraints on business keys
   - Foreign key integrity

3. **Audit Trail**
   - Complete logging via `Audit_Log` table
   - Automatic triggers for sensitive operations
   - Timestamp tracking on all tables

4. **Access Control**
   - Implement RBAC (Role-Based Access Control)
   - Separate read/write permissions
   - Stored procedures for controlled operations

### Security Recommendations

```sql
-- Create read-only user
CREATE USER 'readonly'@'localhost' IDENTIFIED BY 'strong_password';
GRANT SELECT ON Bank_Kemandirian.* TO 'readonly'@'localhost';

-- Create application user with limited privileges
CREATE USER 'app_user'@'localhost' IDENTIFIED BY 'strong_password';
GRANT SELECT, INSERT, UPDATE ON Bank_Kemandirian.* TO 'app_user'@'localhost';
GRANT EXECUTE ON Bank_Kemandirian.* TO 'app_user'@'localhost';

-- Revoke dangerous privileges
REVOKE DELETE ON Bank_Kemandirian.* FROM 'app_user'@'localhost';
```

## 🛠️ Maintenance

### Daily Tasks

```bash
# Backup database
mysqldump -u root -p Bank_Kemandirian > backup_$(date +%Y%m%d).sql

# Backup with compression
mysqldump -u root -p Bank_Kemandirian | gzip > backup_$(date +%Y%m%d).sql.gz
```

### Weekly Tasks

```sql
-- Analyze tables for optimization
ANALYZE TABLE Transaksi, Rekening, Pinjaman, Nasabah;

-- Optimize tables
OPTIMIZE TABLE Transaksi;

-- Check table integrity
CHECK TABLE Transaksi, Rekening;
```

### Monthly Tasks

```sql
-- Review slow queries
SELECT * FROM mysql.slow_log ORDER BY query_time DESC LIMIT 10;

-- Archive old transactions (example)
CREATE TABLE Transaksi_Archive_2024 LIKE Transaksi;
INSERT INTO Transaksi_Archive_2024 
SELECT * FROM Transaksi 
WHERE YEAR(tanggal_transaksi) = 2024;
```

## 📊 Performance Optimization

### Indexes Created

- Composite indexes for frequently joined columns
- Date-based indexes for time-series queries
- Status indexes for filtering operations

### Query Optimization Tips

```sql
-- Use EXPLAIN to analyze queries
EXPLAIN SELECT * FROM v_portfolio_nasabah WHERE total_saldo > 10000000;

-- Use covering indexes
SELECT id_nasabah, nama FROM Nasabah WHERE status_nasabah = 'Aktif';

-- Avoid SELECT * in production
SELECT id_transaksi, nominal, tanggal_transaksi FROM Transaksi;
```

## 🧪 Testing

### Unit Tests

```sql
-- Test 1: Transfer validation
CALL sp_transfer(1000100001, 2000200002, 999999999, 'Test', @s, @m);
-- Expected: GAGAL (insufficient balance)

-- Test 2: Customer count
SELECT COUNT(*) FROM Nasabah WHERE status_nasabah = 'Aktif';
-- Expected: >= 15

-- Test 3: Account balance integrity
SELECT SUM(saldo) FROM Rekening WHERE status_rekening = 'Aktif';
-- Expected: > 0
```

## 📈 Reporting Examples

### Executive Dashboard Query

```sql
SELECT 
    'Total Nasabah' AS metric, COUNT(*) AS value FROM Nasabah
UNION ALL
SELECT 'Total Rekening Aktif', COUNT(*) FROM Rekening WHERE status_rekening = 'Aktif'
UNION ALL
SELECT 'Total Dana Kelola', SUM(saldo) FROM Rekening WHERE status_rekening = 'Aktif'
UNION ALL
SELECT 'Total Pinjaman Berjalan', COUNT(*) FROM Pinjaman WHERE status_pinjaman = 'Berjalan'
UNION ALL
SELECT 'Outstanding Pinjaman', SUM(sisa_pinjaman) FROM Pinjaman WHERE status_pinjaman = 'Berjalan';
```

## 🤝 Contributing

Contributions are welcome! Please follow these steps:

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

### Coding Standards

- Follow MySQL naming conventions
- Add comments for complex queries
- Include sample data for new tables
- Update documentation for new features

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 👥 Authors

- **Your Name** - *Initial work* - [YourGitHub](https://github.com/yourusername)

## 🙏 Acknowledgments

- Inspired by real banking systems
- Built for educational and portfolio purposes
- Sample data is fictional

## 📞 Support

For support, email your.email@example.com or open an issue in the repository.

## 🗺️ Roadmap

- [ ] Add API REST endpoints
- [ ] Implement real-time notifications
- [ ] Add mobile banking features
- [ ] Integration with payment gateways
- [ ] Machine learning for fraud detection
- [ ] Docker containerization
- [ ] GraphQL API support

## 📚 Additional Resources

- [MySQL Documentation](https://dev.mysql.com/doc/)
- [Database Design Best Practices](https://www.ibm.com/topics/database-design)
- [Banking System Architecture](https://martinfowler.com/articles/patterns-of-distributed-systems/)

---

⭐ **Star this repository if you find it helpful!**

Made with ❤️ for the developer community
