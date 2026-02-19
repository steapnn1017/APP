# 🛍️ SIERRA 97 SX - E-commerce Platform

Plně funkční e-commerce aplikace s React Native (Expo), FastAPI backendem, MongoDB databází a Stripe platební integrací.

## 📋 Obsah

- [Funkce](#funkce)
- [Technologie](#technologie)
- [Rychlý start](#rychlý-start)
- [Setup pro WebStorm](#setup-pro-webstorm)
- [Konfigurace](#konfigurace)
- [API Dokumentace](#api-dokumentace)
- [Testování](#testování)

---

## ✨ Funkce

### E-commerce
- ✅ Katalog produktů s kategoriemi
- ✅ Responzivní galerie produktů
- ✅ Detail produktu s swipeable obrázky
- ✅ Nákupní košík s úpravou množství
- ✅ Výběr velikosti a barvy produktu

### Checkout & Platby
- ✅ Kompletní checkout proces
- ✅ Slevové kódy (`WELCOME10`, `SAVE20`, `FREE50`)
- ✅ Výběr dopravy (Standard, Express, Overnight)
- ✅ Stripe platební integrace
- ✅ Generování čísla objednávky
- ✅ Email notifikace (připraveno)

### Uživatelské funkce
- ✅ Historie objednávek ("My Orders")
- ✅ Vícejazyčná podpora (EN, CS, ES, DE)
- ✅ Admin panel pro správu produktů
- ✅ Session-based nákupní košík

---

## 🛠️ Technologie

### Frontend
- **React Native** (19.1.0) s **Expo** (54.0.33)
- **Expo Router** pro navigaci
- **Zustand** pro state management
- **TypeScript** pro type safety
- **React Native Web** pro web podporu

### Backend
- **FastAPI** (Python 3.x)
- **MongoDB** s Motor async driver
- **Stripe** (emergentintegrations)
- **Pydantic** pro validaci

### Database
- **MongoDB** (NoSQL)

---

## 🚀 Rychlý start

### Předpoklady

- Node.js 18+ a Yarn
- Python 3.9+
- MongoDB (local nebo cloud)
- Stripe Account (pro platby)

### 1. Klonuj repozitář

```bash
git clone https://github.com/steapnn1017/s97.git
cd s97
```

### 2. Setup Backend

```bash
cd backend

# Vytvoř virtuální prostředí (volitelné, ale doporučené)
python -m venv venv
source venv/bin/activate  # Na Windows: venv\Scripts\activate

# Instaluj dependencies
pip install -r requirements.txt

# Vytvoř .env soubor
cat > .env << EOF
MONGO_URL=mongodb://localhost:27017
DB_NAME=sierra_shop
STRIPE_API_KEY=sk_test_emergent
EOF

# Spusť backend
python -m uvicorn server:app --host 0.0.0.0 --port 8001 --reload
```

Backend běží na: `http://localhost:8001`

### 3. Setup Frontend

```bash
cd frontend

# Instaluj dependencies
yarn install

# Vytvoř .env soubor
cat > .env << EOF
EXPO_PUBLIC_BACKEND_URL=http://localhost:8001
EOF

# Spusť frontend (web)
npx expo start --web
```

Frontend běží na: `http://localhost:3000`

### 4. Seedování databáze (první spuštění)

```bash
curl -X POST http://localhost:8001/api/seed
```

---

## 💻 Setup pro WebStorm

Detailní návod je v [WEBSTORM_SETUP.md](./WEBSTORM_SETUP.md)

### Rychlý přehled:

1. **Otevři projekt**: `File → Open` → vyber složku `s97`
2. **Nainstaluj dependencies**:
   - Backend: Použij WebStorm Terminal → `cd backend && pip install -r requirements.txt`
   - Frontend: `cd frontend && yarn install`
3. **Nastav Run Configurations**:
   - Backend: Python → `server.py` s uvicorn
   - Frontend: npm → `expo start --web`
4. **Spusť oba servery** pomocí Run Configurations

Kompletní návod s obrázky a detaily najdeš v dokumentaci.

---

## ⚙️ Konfigurace

### Environment Variables

#### Backend (`/backend/.env`)

```env
# MongoDB
MONGO_URL=mongodb://localhost:27017
DB_NAME=sierra_shop

# Stripe (použij svůj klíč nebo test klíč)
STRIPE_API_KEY=sk_test_emergent

# Optional
CORS_ORIGINS=*
```

#### Frontend (`/frontend/.env`)

```env
# Backend URL
EXPO_PUBLIC_BACKEND_URL=http://localhost:8001
```

### Důležité porty

- **Frontend**: 3000
- **Backend**: 8001
- **MongoDB**: 27017

---

## 📚 API Dokumentace

Backend poskytuje OpenAPI dokumentaci:

- **Swagger UI**: http://localhost:8001/docs
- **ReDoc**: http://localhost:8001/redoc

### Hlavní endpointy

#### Products
- `GET /api/products` - Seznam produktů
- `GET /api/products/{id}` - Detail produktu
- `POST /api/products` - Vytvoř produkt (Admin)
- `PUT /api/products/{id}` - Uprav produkt (Admin)
- `DELETE /api/products/{id}` - Smaž produkt (Admin)

#### Cart
- `GET /api/cart/{session_id}` - Získej košík
- `POST /api/cart/{session_id}` - Uprav košík
- `DELETE /api/cart/{session_id}` - Vyčisti košík

#### Checkout & Orders
- `POST /api/checkout/create-session` - Vytvoř Stripe session
- `GET /api/checkout/status/{stripe_session_id}` - Status platby
- `GET /api/orders/session/{session_id}` - Objednávky uživatele
- `GET /api/orders/{order_id}` - Detail objednávky

#### Discount & Shipping
- `POST /api/validate-discount?code=CODE` - Validuj slevový kód
- `GET /api/shipping-methods` - Způsoby dopravy

---

## 🧪 Testování

### Test Stripe platby

Použij tyto testovací údaje na checkout:

- **Karta**: `4242 4242 4242 4242`
- **Datum**: Jakékoliv budoucí datum
- **CVC**: Jakékoliv 3 číslice (např. 123)

### Slevové kódy

- `WELCOME10` - 10% sleva
- `SAVE20` - 20% sleva
- `FREE50` - $50 sleva

### Test API endpointy

```bash
# Health check
curl http://localhost:8001/api/

# Získej produkty
curl http://localhost:8001/api/products

# Validuj discount
curl -X POST "http://localhost:8001/api/validate-discount?code=WELCOME10"

# Způsoby dopravy
curl http://localhost:8001/api/shipping-methods
```

---

## 📱 Struktura projektu

```
s97/
├── backend/
│   ├── server.py           # FastAPI main
│   ├── requirements.txt    # Python dependencies
│   └── .env               # Environment variables
│
├── frontend/
│   ├── app/               # Expo Router pages
│   │   ├── index.tsx      # Home page
│   │   ├── shop.tsx       # Shop listing
│   │   ├── cart.tsx       # Shopping cart
│   │   ├── checkout.tsx   # Checkout process
│   │   ├── orders.tsx     # Order history
│   │   └── product/
│   │       └── [id].tsx   # Product detail
│   ├── src/
│   │   ├── components/    # Reusable components
│   │   ├── store/        # Zustand stores
│   │   └── i18n/         # Translations
│   ├── package.json
│   └── .env
│
├── README.md              # This file
└── WEBSTORM_SETUP.md     # WebStorm setup guide
```

---

## 🔧 Běžné problémy a řešení

### Frontend se nespustí

```bash
cd frontend
rm -rf node_modules
yarn install
npx expo start --web
```

### Backend hlásí chybu databáze

Ujisti se, že MongoDB běží:

```bash
# Mac/Linux
brew services start mongodb-community

# Windows
net start MongoDB

# Docker
docker run -d -p 27017:27017 mongo:latest
```

### Port už je používán

```bash
# Najdi proces na portu 8001
lsof -i :8001

# Zabij proces
kill -9 <PID>
```

---

## 📄 Licence

MIT License - volně použitelné pro komerční i nekomerční účely.

---

## 🤝 Kontakt & Podpora

Pro otázky a podporu:
- GitHub Issues: https://github.com/steapnn1017/s97/issues
- Email: info@sierra97sx.com (příklad)

---

## 🎯 Roadmap

- [ ] Email notifikace po objednávce
- [ ] Wishlist funkce
- [ ] Product reviews & ratings
- [ ] Advanced admin dashboard
- [ ] Inventory management
- [ ] Multiple currency support
- [ ] Mobile apps (iOS & Android)

---

**Vytvořeno s ❤️ pomocí Emergent AI**
