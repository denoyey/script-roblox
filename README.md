<p align="center">
  <img src="https://img.shields.io/badge/⚡_PREMIUM-Script_Hub-blueviolet?style=for-the-badge&labelColor=1a1a2e" alt="Premium Script Hub" />
</p>

<h1 align="center">
  🌌 xnoname008 Script Hub
</h1>

<p align="center">
  <b>The Ultimate All-in-One Modular Script Hub for Roblox</b><br/>
  <i>Powered by Rayfield UI Library • Built for PC & Mobile</i>
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Status-Active-00e676?style=flat-square&logo=statuspage&logoColor=white" />
  <img src="https://img.shields.io/badge/UI-Rayfield_v4-7c4dff?style=flat-square&logo=lua&logoColor=white" />
  <img src="https://img.shields.io/badge/Architecture-Modular-ff6d00?style=flat-square&logo=databricks&logoColor=white" />
  <img src="https://img.shields.io/badge/Platform-PC_|_Mobile-00b0ff?style=flat-square&logo=roblox&logoColor=white" />
  <img src="https://img.shields.io/badge/Games-5+_Supported-e91e63?style=flat-square&logo=gamepad&logoColor=white" />
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Lua-2C2D72?style=flat-square&logo=lua&logoColor=white" />
  <img src="https://img.shields.io/badge/Made_with-❤️-red?style=flat-square" />
</p>

---

<br/>

## ⚡ Quick Start — Satu Baris, Semua Fitur

Salin dan tempel loadstring berikut ke dalam executor kamu:

```lua
loadstring(game:HttpGet("https://raw.githubusercontent.com/denoyey/script-roblox/refs/heads/main/encode/main.lua"))()
```

> **Kompatibel dengan:** Synapse X, Krnl, Fluxus, Wave, Delta, Arceus X, dan executor populer lainnya.

---

<br/>

## 🧬 Arsitektur Hub

```
📦 Script Hub
├── 🧠 main.lua ──────────── Entry Point & Auto-Loader
├── ⚙️ core/universal.lua ── Universal Module (Semua Game)
└── 🎮 games/
    ├── 130342654546662.lua ─ Sambung Kata
    ├── 86111605798689.lua ── Star Fishing
    ├── 21532277.lua ──────── Notoriety
    ├── 79638614256104.lua ── Dig Out Of Jail
    └── 94450914651792.lua ── Volleyball-Ascended
```

Hub ini menggunakan arsitektur **modular** — setiap game memiliki modul terpisah yang di-load otomatis berdasarkan **Place ID / Universe ID** saat ini. Sistem `gameMappings` memastikan game multi-place (seperti Notoriety yang memiliki banyak heist map) tetap terdeteksi dengan sempurna.

---

<br/>

## 🌌 Universal Hub — Fitur yang Tersedia di Semua Game

> *Module ini aktif di game manapun dan memberikan kontrol penuh atas karakter, lingkungan, dan pengalaman bermain kamu.*

<br/>

### 🔫 Weapon & Gun Mods `BARU`

| Fitur | Detail |
|:------|:-------|
| **Inject OP Gun** | Modifikasi senjata yang sedang dipegang secara real-time: **999k Damage**, **Infinite Ammo**, **Instant FireRate**, dan **Zero Reload** |

> 🧠 **Smart 3-Layer Scanning System:** Script ini memindai senjata menggunakan 3 metode sekaligus — *ValueBase scanning*, *ModuleScript config injection*, dan *getgc() memory scanning* — untuk kompatibilitas maksimum di berbagai sistem senjata game.

<br/>

### ⚔️ Combat & Utility

| Fitur | Detail |
|:------|:-------|
| **Hitbox Expander** | Perbesar hitbox pemain lain untuk targeting yang lebih mudah *(Adjustable 5–50)* |
| **Fast Auto-Clicker** | High-speed klik otomatis menggunakan simulasi VirtualUser |
| **Auto-Interact (Proximity Aura)** | Otomatis memicu semua ProximityPrompt di sekitar karakter secara real-time |

<br/>

### 🏃 Pergerakan (Movement)

| Fitur | Detail |
|:------|:-------|
| **WalkSpeed** | Slider pengaturan kecepatan jalan *(16–200)* |
| **JumpPower** | Slider pengaturan kekuatan lompat *(50–500)* |
| **Gravity** | Custom gravitasi dunia *(0–500, default: 196)* |
| **Fly** | Mode terbang smooth mengikuti arah kamera |
| **Noclip** | Tembus semua dinding dan objek |
| **Infinite Jump** | Lompat tanpa batas tanpa cooldown |

<br/>

### 📍 Sistem Waypoint (Custom Save & Teleport)

| Fitur | Detail |
|:------|:-------|
| **Save Posisi** | Simpan lokasi CFrame saat ini dengan nama kustom |
| **Delete Posisi** | Hapus waypoint yang tidak dibutuhkan |
| **Teleport Sekali** | Pindah instan ke waypoint terpilih |
| **Shortcut Teleport** | Keybind `G` untuk teleport cepat |
| **Auto-Teleport** | Teleport berulang otomatis ke waypoint dengan delay yang bisa diatur *(0.1s – 10s)* |

<br/>

### 👁️ Visual & Dunia (Environment)

| Fitur | Detail |
|:------|:-------|
| **Field of View (FOV)** | Atur sudut pandang kamera secara real-time *(10–120, default: 70)* |
| **Walk on Water** | Berjalan di atas air seperti permukaan padat menggunakan Raycast system |
| **FPS Boost (Low Graphics)** | Hapus material berat, tekstur, particle, trail, dan shadow untuk performa maksimal |
| **Player Highlight ESP** | Outline berwarna untuk melacak pemain menembus dinding *(warna bisa dikustomisasi via Color Picker)* |
| **Freecam** | Mode kamera bebas untuk eksplorasi sinematik *(Kontrol WASD)* |
| **Unlock Max Zoom** | Hapus batas zoom kamera *(hingga 100.000 range)* |
| **FullBright** | Terangi seluruh map — hapus kegelapan dan fog |
| **Anti-Void** | Cegah kematian akibat jatuh ke void dengan safety platform otomatis |

<br/>

### 🤪 TP & Troll

| Fitur | Detail |
|:------|:-------|
| **Teleport ke Pemain** | Dropdown daftar pemain yang auto-update saat join/leave |
| **Click TP** | Teleport instan ke posisi kursor `Ctrl + Left Click` |
| **Targeted Fling** | Lempar pemain tertentu ke angkasa dengan velocity 10.000 |
| **Spinbot (Beyblade Mode)** | Rotasi karakter super cepat 60° per frame |

<br/>

### 🕺 Emote System

| Fitur | Detail |
|:------|:-------|
| **Play Emote** | Jalankan emote yang sedang di-equip langsung dari hub |
| **Stop Emote** | Hentikan emote secara paksa |
| **Refresh Daftar** | Scan ulang semua emote yang sedang di-equip (auto-refresh saat respawn) |

<br/>

### 🛡️ Sistem & Keamanan

| Fitur | Detail |
|:------|:-------|
| **Anti-Chat Logger** | Proteksi privasi komunikasi in-game |
| **Powerful Anti-AFK** | 3-layer anti-idle: *VirtualUser simulation*, *connection disabling*, dan *prompt auto-dismiss* |
| **Kill Character** | Bunuh karakter sendiri secara instan |
| **Rejoin Server** | Masuk ulang ke server yang sama |
| **Server Hop** | Pindah ke server lain yang belum penuh secara otomatis |

<br/>

### ⚙️ Config Manager (Sistem Profil) `BARU`

> 💾 *Simpan seluruh pengaturan hub ke dalam file system executor dan muat kembali kapan saja.*

| Fitur | Detail |
|:------|:-------|
| **Save Config** | Simpan semua settingan ke profil bernama (termasuk Waypoints, Toggle, Slider, dll) |
| **Load Config** | Muat kembali config terpilih dan terapkan semua settingan secara otomatis |
| **Delete Config** | Hapus profil config yang tidak dibutuhkan |
| **Multi-Profile** | Auto-filtering config berdasarkan Place ID game yang sedang dimainkan |
| **Export JSON** | Salin config ke clipboard sebagai JSON untuk sharing |
| **Import JSON** | Tempel JSON config dari clipboard, langsung auto-save & auto-apply |

<br/>

### 🎛️ Control Menu

| Fitur | Detail |
|:------|:-------|
| **Reset All Settings** | Kembalikan semua toggle, slider, dan koneksi ke default |
| **Destroy GUI** | Hapus seluruh UI hub dan bersihkan semua koneksi |

<br/>

### 👨‍💻 Dev Tools *(Whitelist Only)*

> *Fitur eksklusif untuk developer — hanya bisa diakses oleh User ID yang terdaftar.*

| Fitur | Detail |
|:------|:-------|
| **SimpleSpy** | Remote spy untuk melacak RemoteEvent & RemoteFunction |
| **Cobalt** | Advanced network spy execution |
| **Dark Dex V3** | Bypassed Roblox Studio Explorer dalam game |
| **Infinite Yield** | Admin commands suite untuk testing tingkat lanjut |

---

<br/>

## 🎮 Game-Specific Modules

> *Modul khusus yang di-load otomatis berdasarkan deteksi game. Setiap modul dirancang spesifik untuk memanfaatkan mekanisme unik game tersebut.*

<br/>

---

### 🧩 Sambung Kata
> **Place ID:** `130342654546662`

Bot otomatis yang cerdas untuk memenangkan permainan sambung kata.

| Fitur | Detail |
|:------|:-------|
| **Auto Answer Bot** | Menjawab kata secara otomatis dengan kecerdasan tinggi |
| **Aggression Control** | Atur persentase keagresifan bot |
| **Human-like Typing** | Delay per-huruf yang meniru kecepatan mengetik manusia *(Min/Max Typing Delay)* |
| **Word Length Filter** | Batasi panjang kata minimum dan maksimum |
| **Smart Memory** | Mengingat kata yang sudah dipakai untuk menghindari penalti + tombol reset |
| **Riwayat Kata** | Monitor history interaksi kata via dropdown |
| **Wordlist Database** | Real-time fetching dari ribuan bank kata online |
| **Safe Mode** | Pengaturan mendetail untuk menghindari deteksi |
| **Config Simpan/Muat** | Simpan dan muat konfigurasi bot per game |

<br/>

---

### 🎣 Star Fishing
> **Place ID:** `86111605798689`

Modul fishing automation yang komprehensif dengan fitur toko, teleport, dan penjualan otomatis.

<details>
<summary>🎒 <b>Equipment Management</b></summary>
<br/>

| Fitur | Detail |
|:------|:-------|
| **Equip Rod** | Pilih dan equip fishing rod dari dropdown (dengan search filter) |
| **Equip Bobber** | Pilih dan equip bobber dari dropdown |
| **Auto-Equip** | Otomatis equip rod dari inventaris saat fishing |
</details>

<details>
<summary>🛒 <b>Rod & Bobber Shop</b></summary>
<br/>

| Fitur | Detail |
|:------|:-------|
| **Buy Rod** | Beli fishing rod dari daftar yang tersedia di map |
| **Buy Bobber** | Beli bobber dari daftar yang tersedia di map |
| **Searchable Dropdown** | Filter pencarian item untuk kemudahan |
</details>

<details>
<summary>✨ <b>Magic Shop (Premium)</b></summary>
<br/>

| Fitur | Detail |
|:------|:-------|
| **Buy Magic Items** | Beli item premium (potion, dll) dengan jumlah kustom |
| **Use Item (Consume)** | Gunakan potion langsung dari hub |
| **Bulk Purchase** | Beli banyak item sekaligus dengan input jumlah |
</details>

<details>
<summary>🎣 <b>Farming & Auto-Sell</b></summary>
<br/>

| Fitur | Detail |
|:------|:-------|
| **Auto Fish** | Siklus memancing otomatis penuh — cast, reel, dan confirm item |
| **Instant Confirm** | Skip mini-game dan langsung konfirmasi item |
| **Shortcut Toggle** | Keybind `C` untuk toggle Auto Fish cepat |
| **Auto Sell Stars** | Jual otomatis ke NPC Star Merchant dengan delay kustom |
| **Sell All (Manual)** | Teleport ke NPC → Jual semua → Kembali ke lokasi fishing |
| **Sell Shortcut** | Keybind `V` untuk sell instan |
</details>

<details>
<summary>📍 <b>Teleport & Travel System</b></summary>
<br/>

| Fitur | Detail |
|:------|:-------|
| **Teleport to NPC** | Teleport ke NPC manapun dengan posisi berhadapan (face-to-face) |
| **Teleport to Galaxy** | Pindah ke lokasi Galaxy manapun di map |
| **Teleport to Totem** | Teleport ke Fast Travel Totem |
| **Teleport to Beam Target** | Teleport ke Beam Target yang tersebar di map |
| **Smart NPC Height** | Override tinggi untuk NPC tertentu (DaVinky, Librarian, dll) |
</details>

<details>
<summary>⚙️ <b>System & Data</b></summary>
<br/>

| Fitur | Detail |
|:------|:-------|
| **Refresh Data (Map Scan)** | Scan ulang semua data di map — Rods, Bobbers, NPCs, Galaxies, Totems, Stars, Magic Items, Beam Targets |
</details>

<br/>

---

### 💰 Notoriety
> **Universe ID:** `16680835` → **Place ID:** `21532277`

Modul heist dengan ESP tingkat lanjut dan utilitas game.

| Fitur | Detail |
|:------|:-------|
| **Infinite Stamina** | Lari tanpa batas — stamina tidak pernah habis |
| **Max Damage** | Boost damage ke titik maksimum → Instant Kill |
| **Police ESP (Merah)** | Highlight pergerakan polisi berwarna merah |
| **Camera ESP (Biru)** | Deteksi kamera CCTV berwarna biru |
| **Citizens / Safe Spots / Lootables ESP** | Visual untuk objek penting lainnya |
| **Brankas / Military Crate ESP** | Deteksi brankas dan peti militer |
| **Teleport ke Keycard** | Instantly teleport ke Keycard terdekat |
| **Teleport Bags ke Van/Car** | Pindahkan kantong jarahan ke area escape |
| **Instant BodyBags & Cable Ties** | Dapatkan item secara instan |
| **Force Vote Reset** | Reset voting dengan satu klik |

<br/>

---

### ⛏️ Dig Out Of Jail
> **Place ID:** `79638614256104`

Auto farm dengan sistem seleksi kelangkaan dan penjualan otomatis.

| Fitur | Detail |
|:------|:-------|
| **Auto Farm (Get & Sell)** | Siklus otomatis looting + teleport jual ke NPC |
| **Pickup All Items** | Ambil paksa seluruh item di area map secara instan |
| **Rarity Selector** | Pilih kelangkaan: *Common, Uncommon, Rare, Epic, atau Legendary* |
| **One-Click Sell** | Teleport instan ke Seller NPC dan trigger Proximity Prompt |

<br/>

---

### 🏐 Volleyball-Ascended
> **Place ID:** `94450914651792`

Kontrol presisi untuk pemain volleyball kompetitif.

| Fitur | Detail |
|:------|:-------|
| **Spike Control (Air Movement)** | Berputar mengikuti mouse menggunakan BodyGyro saat di udara (freefall) |
| **Move in Air** | Toggle pergerakan berjalan bebas di udara |
| **Walk Speed Modifier** | Slider kustomisasi kecepatan jalan |
| **Jump Height Multiplier** | Slider peningkat ketinggian lompatan |
| **Smart Dive Handling** | Pengaman otomatis yang mematikan WalkSpeed saat animasi Dive/Slide |

---

<br/>

## 🔐 Sistem Keamanan Hub

| Layer | Proteksi |
|:------|:---------|
| **🔒 Obfuscation** | Source code di-encode sebelum di-push ke repository |
| **🛡️ pcall() Wrapping** | Setiap fitur dibungkus `pcall()` untuk anti-crash |
| **🔑 Dev Tools Whitelist** | Akses tools developer dibatasi oleh User ID yang terdaftar |
| **🗺️ Game Mapping** | Universe ID → Place ID mapping untuk kompatibilitas multi-place |
| **📂 Config Isolation** | File config tersimpan per-Place ID untuk mencegah konflik |

---

<br/>

## 📊 Statistik Hub

<p align="center">

| Metrik | Nilai |
|:-------|:------|
| **Total Fitur Universal** | 30+ toggle, slider, dan tools |
| **Total Game Modules** | 5 game spesifik |
| **Total Lines of Code** | 4000+ baris Lua |
| **UI Library** | Rayfield v4 by Sirius Team |
| **Arsitektur** | Modular (Core + Game Modules) |
| **Config System** | JSON-based with Export/Import |

</p>

---

<br/>

## 📜 Credits

<p align="center">
  Created with ❤️ by <b>xnoname008</b><br/>
  Special thanks to the <b>Sirius Team</b> for the <a href="https://sirius.menu/rayfield">Rayfield UI Library</a>
</p>

---

<br/>

> [!WARNING]
> **Disclaimer**: Script ini dibuat untuk tujuan edukasi dan eksperimen. Fitur-fitur yang melibatkan modifikasi physics (Fly, Fling, Speed), automation, atau eksploitasi mekanisme game dapat membawa risiko ban. **Gunakan dengan bijak dan tanggung jawab sendiri.**

> [!NOTE]
> Script ini merupakan proyek internal dan tidak untuk distribusi komersial. Jika kamu menemukan bug atau memiliki saran fitur, silakan buat Issue di repository ini.

<p align="center">
  <img src="https://img.shields.io/badge/Last_Updated-March_2026-1a1a2e?style=flat-square&labelColor=7c4dff&color=e0e0e0" />
</p>
