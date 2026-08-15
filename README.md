# सोनपुर सेवा समिति (Sonpur Sewa Samiti) Mobile App

A full-stack, offline-first Flutter mobile application built for **Sonpur Sewa Samiti** (सोनपुर सेवा समिति) — a modern agricultural co-operative society in Bihar/Eastern India. The app provides AI-powered plant pathology diagnosis, interactive stage-by-stage crop timelines, scientific NPK fertilizer calculation, an integrated subsidized agri-input store, and an executive administration console.

---

## 🌟 Key Features

### 1. 🔍 Tab 1: AI Scan & Diagnose (रोग जांच)
- **Live AI Viewfinder Simulator**: Interactive scanning grid, macro camera switcher, and flash toggle.
- **Pathology Diagnostic Engine**: Detects crop diseases (e.g. Wheat Yellow Rust, Potato Late Blight, Mustard Aphids, Healthy Paddy) with confidence metrics (e.g., 94% precision).
- **Dual Advisory**: Chemical treatment recommendations (active ingredient & dosage) and Organic/Jaivik remedies (Cow urine, Neem oil, Trichoderma).
- **Offline History**: Persisted diagnosis history for past field records.

### 2. 📅 Tab 2: My Crop Calendar (फसल कैलेंडर)
- **Interactive Milestone Progress**: Visual progress from Sowing $\rightarrow$ Tillering $\rightarrow$ Flowering $\rightarrow$ Harvest.
- **Task Checklist**: Interactive checkboxes for scheduling irrigation, urea top dressing, and weed control.
- **Custom Crop Setup**: Add new crops with presets for Wheat, Paddy, Mustard, Potato, Sugarcane, and Maize.
- **Regional Agro-Weather Advisory**: Real-time Sonpur block temperature, humidity, and wind guidelines.

### 3. 🧪 Tab 3: Store & Fertilizer Calc (खाद कैलकुलेटर व दुकान)
- **Scientific Fertilizer Calculator**:
  - Converts Acre, Bigha (0.625 Acre), Hectare, and Kattha.
  - Generates exact 50kg bags of Urea (46% N), DAP (18:46:0), MOP (60% K), and Zinc Sulphate.
  - Prescribes a 3-stage split application schedule (Basal, 1st Top Dressing, 2nd Top Dressing).
  - **1-Tap Direct to Cart**: Injects calculated inputs directly into the store cart.
- **Kisan Seva Kendra Store**:
  - Subsidized fertilizer, seeds, and bio-organic input catalog with real-time stock counters.
  - Shopping cart with calculated cooperative subsidy savings in ₹ and token booking.

### 4. 🏢 Tab 4: Admin Panel (समिति प्रबंधन)
- **Co-operative Executive Dashboard**: Real-time KPIs for registered farmers (1,420), urea bags in stock, and distributed subsidy.
- **Broadcast Notice System**: Send urgent weather warnings, stock arrival alerts, and subsidy announcements to farmers in Hindi & English.
- **Agronomy Support Tickets**: Review farmer problem queries and publish expert agronomy advice.
- **Quick Inventory Stock Adjuster**: Instant +50 / -50 bag inventory updates.

---

## 🌐 Bilingual Localization (Hindi & English)

- **Real-Time Language Switcher**: Tap the `हिंदी / English` chip in the top AppBar to toggle the UI language instantly without restarting the app.
- **Persistent Preferences**: Language selection is saved to Hive local storage.

---

## 🎨 Agricultural Green Theme

- **Palette**:
  - Primary Green: `#2E7D32` (Lush Forest Green)
  - Deep Forest: `#1B5E20`
  - Golden Harvest Accent: `#F57F17` (Wheat Golden Amber)
  - Soft Soil Wash: `#E8F5E9`
- Full **Material 3 Light and Dark Mode** support.

---

## 💾 Offline Local Storage & Firebase Architecture

- **Local Storage (Hive)**:
  - `crops_box`: Active crop milestones and schedules
  - `scans_box`: Pathology scan records and remedies
  - `products_box`: Co-op catalog and live stock counts
  - `notices_box`: Broadcast society advisories
  - `settings_box`: Theme and language preferences
- **Firebase Service Layer**:
  - `FirebaseAuthService`: Farmer phone authentication & role management
  - `FirebaseFirestoreService`: Cloud synchronizer for offline mutation queue
  - `FirebaseStorageService`: Crop leaf photo cloud uploads

---

## 🚀 Running the Project

1. Navigate to the project directory:
   ```bash
   cd C:\Users\Gaura\.gemini\antigravity\scratch\sonpur_sewa_samiti
   ```

2. Fetch dependencies:
   ```bash
   flutter pub get
   ```

3. Run the automated test suite:
   ```bash
   flutter test
   ```

4. Launch the application:
   ```bash
   flutter run
   ```
