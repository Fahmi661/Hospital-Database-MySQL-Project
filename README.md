<div align="center">

# ⚡ ZetFour Modern Calculator

<img src="https://img.shields.io/badge/React-19.2.3-61DAFB?style=for-the-badge&logo=react&logoColor=white" alt="React" />
<img src="https://img.shields.io/badge/TypeScript-5.8.3-3178C6?style=for-the-badge&logo=typescript&logoColor=white" alt="TypeScript" />
<img src="https://img.shields.io/badge/Vite-6.4.1-646CFF?style=for-the-badge&logo=vite&logoColor=white" alt="Vite" />
<img src="https://img.shields.io/badge/Tailwind-3.x-06B6D4?style=for-the-badge&logo=tailwindcss&logoColor=white" alt="Tailwind CSS" />

**Kalkulator modern yang elegan dengan desain futuristik, tracking history, dan dukungan keyboard lengkap**

[Demo](https://ai.studio/apps/drive/1GrAf0PmQrVePgS0CeNynWHMZ76GpDbK3) · [Laporkan Bug](https://github.com/yourusername/zetfour-calculator/issues) · [Request Fitur](https://github.com/yourusername/zetfour-calculator/issues)

</div>

---

## ✨ Fitur Utama

🎨 **Desain Modern & Futuristik**
- UI glassmorphism dengan efek ambient glow
- Animasi smooth dan responsive
- Dark mode dengan gradien dinamis

⌨️ **Dukungan Keyboard Penuh**
- Operasi matematika standar (0-9, +, -, *, /)
- Enter untuk hasil, Backspace untuk delete
- Escape untuk clear

📜 **History Tracking**
- Simpan semua kalkulasi sebelumnya
- Timestamp untuk setiap perhitungan
- Hapus history dengan mudah

🎯 **Operasi Matematika Lengkap**
- Penjumlahan, Pengurangan, Perkalian, Pembagian
- Persen (%)
- Toggle positif/negatif (+/-)
- Desimal

---

## 🚀 Quick Start

### Prerequisites

Pastikan Anda sudah menginstal:
- **Node.js** (v18.0.0 atau lebih tinggi)
- **npm** atau **yarn**

### Instalasi

1. **Clone repository**
```bash
git clone https://github.com/yourusername/zetfour-calculator.git
cd zetfour-calculator
```

2. **Install dependencies**
```bash
npm install
```

3. **Jalankan development server**
```bash
npm run dev
```

4. **Buka browser**
```
http://localhost:3000
```

---

## 📦 Build untuk Production

```bash
npm run build
```

File production akan tersimpan di folder `dist/`.

Preview build production:
```bash
npm run preview
```

---

## 🛠️ Tech Stack

| Teknologi | Deskripsi |
|-----------|-----------|
| **React 19** | Library UI terbaru dengan performa optimal |
| **TypeScript** | Type-safe development |
| **Vite** | Build tool yang sangat cepat |
| **Tailwind CSS** | Utility-first CSS framework |
| **Lucide React** | Icon library modern |

---

## 📂 Struktur Proyek

```
zetfour-calculator/
├── components/
│   └── Calculator.tsx      # Komponen kalkulator utama
├── App.tsx                 # Root component
├── index.tsx              # Entry point
├── types.ts               # TypeScript type definitions
├── index.html             # HTML template
├── vite.config.ts         # Vite configuration
├── tsconfig.json          # TypeScript configuration
└── package.json           # Project dependencies
```

---

## 🎮 Cara Penggunaan

### Mouse/Touch
- Klik tombol angka dan operator untuk melakukan perhitungan
- Klik `=` untuk mendapatkan hasil
- Klik `AC` untuk clear semua
- Klik `DEL` untuk hapus digit terakhir

### Keyboard
| Tombol | Fungsi |
|--------|--------|
| `0-9` | Input angka |
| `+` `-` `*` `/` | Operator matematika |
| `.` | Desimal |
| `Enter` | Hitung hasil (=) |
| `Backspace` | Hapus digit terakhir |
| `Escape` | Clear semua |
| `%` | Persen |

---

## 🎨 Customization

### Mengubah Warna Brand

Edit file `index.html` pada bagian Tailwind config:

```javascript
colors: {
  brand: {
    dark: '#0B0C10',    // Background gelap
    panel: '#1F2833',   // Panel calculator
    teal: '#66FCF1',    // Accent color
    gray: '#C5C6C7'     // Text secondary
  }
}
```

### Mengubah Font

Edit pada `<head>` di `index.html`:

```html
<link href="https://fonts.googleapis.com/css2?family=YourFont&display=swap" rel="stylesheet">
```

---

## 🤝 Contributing

Kontribusi sangat diterima! Berikut langkah-langkahnya:

1. Fork repository ini
2. Buat branch fitur (`git checkout -b feature/AmazingFeature`)
3. Commit perubahan (`git commit -m 'Add some AmazingFeature'`)
4. Push ke branch (`git push origin feature/AmazingFeature`)
5. Buka Pull Request

---

## 📝 License

Distributed under the MIT License. See `LICENSE` for more information.

---

## 👨‍💻 Author

**ZetFour Technologies**

- Website: [zetfour.com](https://zetfour.com)
- GitHub: [@zetfour](https://github.com/zetfour)

---

## 🙏 Acknowledgments

- [React](https://react.dev/)
- [Vite](https://vitejs.dev/)
- [Tailwind CSS](https://tailwindcss.com/)
- [Lucide Icons](https://lucide.dev/)

---

<div align="center">

**Dibuat dengan ❤️ oleh ZetFour Technologies**

⭐ Star repo ini jika bermanfaat!

</div>
