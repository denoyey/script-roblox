# 🚀 Premium Lua Script Hub | by xnoname008

![Status](https://img.shields.io/badge/Status-Active-brightgreen)
![Library](https://img.shields.io/badge/Library-Rayfield-blueviolet)
![Type](https://img.shields.io/badge/Type-Modular_Hub-orange)
![Platform](https://img.shields.io/badge/Platform-PC_%2F_Mobile-blue)

A powerful, internal script hub built with the **Rayfield UI Library**. Designed as a modular ecosystem featuring a high-performance **Universal Hub** and dedicated modules for specific games. Supports both PC and Mobile executors.

---

## 🌌 Universal Hub Features
*Available in all games to enhance your core character physics and environment.*

### ⚔️ Combat & Utility
*   **Hitbox Expander**: Increase player hitboxes for easier targeting (Adjustable 5 - 50 size).
*   **Fast Auto-Clicker**: High-speed automated clicking using VirtualUser simulation.

### 🏃 Pergerakan (Movement)
*   **Physics Modifiers**: Sliders for **WalkSpeed** (16-200) and **JumpPower** (50-500).
*   **Fly**: Smooth flight mode controlled by camera direction.
*   **Noclip**: Disable all collisions to move through walls and objects.
*   **Infinite Jump**: No jump cooldown or limits.

### 📍 Sistem Waypoint
*   **Save & Delete Position**: Save your current CFrame to memory or remove it.
*   **Teleport Once**: Instantly teleport to any saved waypoint.
*   **Auto-Teleport**: Continuous looping teleport to a selected waypoint with adjustable delay (0.1s - 10s).

### 👁️ Visual & Dunia (Environment)
*   **Walk on Water**: Walk on lakes and oceans as solid ground.
*   **FPS Boost (Low Graphics)**: Strips heavy materials, textures, and effects for maximum performance on low-end PCs.
*   **Player Highlight ESP**: Vibrant outlines to track players through any obstacle.
*   **Freecam**: Free-roaming camera mode for cinematic exploration.
*   **Unlock Max Zoom**: Removes camera distance limits (up to 100,000 range).
*   **FullBright**: Replaces darkness with permanent 100% visibility.
*   **Anti-Void**: Prevents death by creating a safety platform at the map's boundary.

### 🤪 TP & Troll
*   **Teleport to Player**: Instantly teleport to a selected player.
*   **Click TP**: Instant teleportation to cursor (Hotkey: `Ctrl + LClick`).
*   **Targeted Fling**: Launch specific players into the stratosphere (Requires selecting a target).
*   **Spinbot (Beyblade Mode)**: High-velocity Beyblade rotation for character trolling.

### 🕺 Emote System
*   **Play/Stop Emotes**: Execute or force stop equipped Roblox emotes directly from the hub.
*   **Refresh Emotes**: Automatically fetches your currently equipped emotes.

### 🛡️ Sistem & Keamanan
*   **Anti-Chat Logger (Privacy)**: Privacy protection for your in-game communication.
*   **Powerful Anti-AFK**: State-of-the-art prevention against "Disconnected for inactivity".
*   **System Tools**: Kill Character, Rejoin Server, Server Hop, Reset All Settings, and Destroy GUI.

### ⚙️ Config Manager (Sistem Profil)
*   **Save & Load Config**: Simpan pengaturan hub (seperti ESP, Waypoints, Walkspeed, dsb) secara spesifik ke dalam sistem file Executor dan muat kembali kapan saja.
*   **Multi-Profile Support**: Auto-filtering daftar Config menyesuaikan *Place ID* game yang sedang dimainkan dengan opsi untuk menghapus profil usang.
*   **Export & Import JSON**: Memungkinkan sinkronisasi atau bagi-pakai pengaturan antar perangkat dengan format *Clipboard JSON* (*Copy-Paste*).

### 👨‍💻 Dev Tools (Developer Only)
*Exclusive whitelist-only features for game debugging and analysis.*
*   **Load SimpleSpy**: Network remote spy tool to track RemoteEvents and RemoteFunctions.
*   **Execute Cobalt**: Advanced network spy execution.
*   **Load Dark Dex V3**: Bypassed in-game Roblox Studio Explorer.
*   **Load Infinite Yield**: Powerful set of admin commands for advanced testing.

---

## 🎮 Supported Games & Multi-Place System
*Custom tailored automation for specific experiences, armed with an automatic game ID detection mapping system that securely bridges Universe ID to its targeted modules.*

### 🧩 Sambung Kata (Place: 130342654546662)
*   **Auto Answer Bot**: Otomatis menjawab kata dengan cerdas dan cepat.
*   **Bot Settings (Safe Mode)**: Pengaturan mendetail mulai dari *Aggression (%)*, *Min/Max Typing Delay* (meniru delay manusia per huruf), hingga limit *Min/Max Word Length*.
*   **Smart Memory (Lupa Kata)**: Sistem yang secara cerdas mengingat kata yang sudah digunakan agar tidak terkena penalti pengulangan, beserta tombol untuk me-reset histori.
*   **Riwayat Kata**: Tersedia *Dropdown* untuk memonitor history interaksi kata kamu di game.
*   **Wordlist Database**: Secara real-time *fetching* dan terhubung dengan ribuan bank database kata.

### 🎣 Star Fishing (Place: 86111605798689)
*   **Auto Fish**: Completely automated full continuous fishing cycle logic.
*   **Instant Reel/Confirm**: Skip the standard waiting mini-games and automatically confirm items to maximize absolute efficiency and profit.

### 💰 Notoriety (Universe: 16680835 / Place: 21532277)
*   **Infinite Stamina & Damage**: Lari sepuasnya tanpa stamina limit dan boost damage ke titik maksimum untuk *Instant Kill*.
*   **Enhanced ESP (Chams)**: Tampilan visual ber-warna untuk mendeteksi pergerakan *Police* (Merah), *Cameras* (Biru), *Citizens*, *Safe Spots*, *Lootables*, hingga *Brankas/Military Crate*.
*   **Teleports & Automated Items**:
    *   Instantly Teleport karakter ke letak **Keycard** terdekat.
    *   Teleport semua Kantong Barang Jarahan (Bags) menembus langung ke Area Keamanan / Mobil pelarian (Van/Car).
    *   Dapatkan **BodyBags** dan **Cable Ties** secara instan.
*   **System Tools**: Melakukan eksekusi *Force Vote Reset* dengan sekali klik.

---

## 🛠️ Installation & Execution

### 💻 PC Execution
Copy and paste the following loadstring into your executor (Synapse X, Krnl, Fluxus, etc.):
```lua
loadstring(game:HttpGet("https://raw.githubusercontent.com/denoyey/script-roblox/refs/heads/main/encode/main.lua"))()
```

---

## 📜 Credits

Created with ❤️ by **xnoname008**.
Special thanks to the **Sirius Team** for the Rayfield UI Library.

---

> [!WARNING]
> This script is for educational purposes only. Features involving high-velocity movement (Fly/Fling) or automation may carry risks of bans. Use responsibly at your own risk.
