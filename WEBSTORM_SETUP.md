# 🚀 WebStorm Setup Guide - SIERRA 97 SX

Kompletní návod jak rozjet projekt ve WebStorm IDE.

---

## 📋 Předpoklady

Před začátkem si nainstaluj:

1. **WebStorm** (2023.3 nebo novější)
2. **Node.js** 18+ (ověř: `node --version`)
3. **Yarn** (ověř: `yarn --version`)
4. **Python** 3.9+ (ověř: `python --version`)
5. **MongoDB** (lokální nebo cloud)

---

## 🎯 Krok za krokem

### 1️⃣ Otevři projekt ve WebStorm

1. Spusť **WebStorm**
2. `File → Open`
3. Vyber složku `s97` (celý projekt)
4. Klikni `OK`

WebStorm automaticky detekuje projekt.

---

### 2️⃣ Nainstaluj Backend Dependencies

#### Možnost A: Přes WebStorm Terminal

1. Otevři Terminal ve WebStorm: `View → Tool Windows → Terminal`
2. Přejdi do backend složky:
   ```bash
   cd backend
   ```

3. **(Doporučeno)** Vytvoř Python virtual environment:
   ```bash
   python -m venv venv
   ```

4. Aktivuj virtual environment:
   ```bash
   # Mac/Linux
   source venv/bin/activate
   
   # Windows
   venv\Scripts\activate
   ```

5. Instaluj dependencies:
   ```bash
   pip install -r requirements.txt
   ```

#### Možnost B: Přes WebStorm Python Interpreter

1. `File → Settings` (Windows/Linux) nebo `WebStorm → Preferences` (Mac)
2. `Project: s97 → Python Interpreter`
3. Klikni na ⚙️ → `Add...`
4. Vyber `Virtualenv Environment → New`
5. WebStorm automaticky nainstaluje packages z `requirements.txt`

---

### 3️⃣ Nainstaluj Frontend Dependencies

V **WebStorm Terminal**:

```bash
cd frontend
yarn install
```

Yarn nainstaluje všechny Node.js packages (~5 minut).

---

### 4️⃣ Nastav Environment Variables

#### Backend Environment Variables

1. Vytvoř soubor: `/backend/.env`
2. Zkopíruj tuto konfiguraci:

```env
MONGO_URL=mongodb://localhost:27017
DB_NAME=sierra_shop
STRIPE_API_KEY=sk_test_emergent
CORS_ORIGINS=*
```

#### Frontend Environment Variables

1. Vytvoř soubor: `/frontend/.env`
2. Zkopíruj tuto konfiguraci:

```env
EXPO_PUBLIC_BACKEND_URL=http://localhost:8001
```

**💡 Tip**: Ve WebStorm můžeš kliknout pravým na složku → `New → File` → název `.env`

---

### 5️⃣ Spusť MongoDB

MongoDB musí běžet předtím, než spustíš backend.

#### Mac (Homebrew):
```bash
brew services start mongodb-community
```

#### Windows:
```bash
net start MongoDB
```

#### Linux:
```bash
sudo systemctl start mongod
```

#### Docker (všechny platformy):
```bash
docker run -d -p 27017:27017 --name mongodb mongo:latest
```

**Ověř, že běží**:
```bash
mongosh --eval "db.version()"
```

---

### 6️⃣ Vytvoř Run Configurations

WebStorm umožňuje spustit Backend a Frontend jedním kliknutím.

#### 🔹 Backend Run Configuration

1. Klikni na `Run → Edit Configurations...`
2. Klikni `+` → `Python`
3. Nastav:
   - **Name**: `Backend`
   - **Script path**: `/cesta/k/projektu/s97/backend/server.py`
   - **Parameters**: (nech prázdné)
   - **Python interpreter**: vyber venv interpreter
   - **Working directory**: `/cesta/k/projektu/s97/backend`
   - **Environment variables**: Klikni na 📁 a přidej:
     ```
     MONGO_URL=mongodb://localhost:27017
     DB_NAME=sierra_shop
     STRIPE_API_KEY=sk_test_emergent
     ```

4. ❗ **DŮLEŽITÉ**: Místo běžného Python spuštění použij:
   - V **Before launch** sekci klikni `+` → `Run External tool`
   - Klikni `+` vytvoř nový tool:
     - **Name**: `Uvicorn`
     - **Program**: `python` (nebo cesta k venv python)
     - **Arguments**: `-m uvicorn server:app --host 0.0.0.0 --port 8001 --reload`
     - **Working directory**: `$ProjectFileDir$/backend`

5. Klikni `OK`

**🎯 Nebo jednodušší způsob:**

Vytvoř jako **Shell Script**:
1. `Run → Edit Configurations... → + → Shell Script`
2. **Name**: `Backend`
3. **Script text**:
   ```bash
   cd backend
   source venv/bin/activate  # Na Windows: venv\Scripts\activate
   python -m uvicorn server:app --host 0.0.0.0 --port 8001 --reload
   ```
4. Klikni `OK`

#### 🔹 Frontend Run Configuration

1. Klikni na `Run → Edit Configurations...`
2. Klikni `+` → `npm`
3. Nastav:
   - **Name**: `Frontend`
   - **package.json**: `/cesta/k/projektu/s97/frontend/package.json`
   - **Command**: `run`
   - **Scripts**: `start` (nebo napiš custom: `expo start --web`)
   - **Node interpreter**: vyber Node.js
   - **Package manager**: `yarn`

4. Klikni `OK`

---

### 7️⃣ Spusť projekt! 🎉

#### Možnost A: Spusť oba servery najednou

1. `Run → Run...`
2. Vyber `Backend` → Backend se spustí na `http://localhost:8001`
3. `Run → Run...`
4. Vyber `Frontend` → Frontend se spustí na `http://localhost:3000`

#### Možnost B: Přes Terminal (tradiční způsob)

**Terminal 1 - Backend:**
```bash
cd backend
source venv/bin/activate  # Windows: venv\Scripts\activate
python -m uvicorn server:app --host 0.0.0.0 --port 8001 --reload
```

**Terminal 2 - Frontend:**
```bash
cd frontend
npx expo start --web
```

---

### 8️⃣ Seeduj databázi (První spuštění)

Po spuštění backendu, naplň databázi testovacími produkty:

```bash
curl -X POST http://localhost:8001/api/seed
```

Nebo otevři v prohlížeči:
```
http://localhost:8001/api/seed
```

---

## ✅ Ověření, že vše funguje

### Backend Health Check

Otevři v prohlížeči nebo použij curl:

```bash
curl http://localhost:8001/api/
```

**Měl bys vidět:**
```json
{
  "message": "SIERRA 97 SX API",
  "status": "running"
}
```

### Frontend Check

Otevři: `http://localhost:3000`

Měl bys vidět homepage SIERRA 97 SX.

---

## 🔧 WebStorm užitečné funkce

### 1. Debugging

#### Backend Debugging:
1. Nastav breakpoint v `server.py` (klikni vedle čísla řádku)
2. Klikni na 🐞 vedle Run Configuration
3. Spusť požadavek z frontendu
4. WebStorm zastaví na breakpointu

#### Frontend Debugging:
1. Použij WebStorm integrovaný JavaScript debugger
2. Nebo Chrome DevTools v prohlížeči

### 2. Git integrace

WebStorm má built-in Git:

- **Commit**: `Ctrl+K` (Cmd+K na Mac)
- **Push**: `Ctrl+Shift+K`
- **Pull**: `Ctrl+T`
- **Git Log**: `Alt+9`

### 3. Database Tools

WebStorm má integrovaný MongoDB viewer:

1. `View → Tool Windows → Database`
2. Klikni `+` → `Data Source → MongoDB`
3. Nastav:
   - **Host**: `localhost`
   - **Port**: `27017`
   - **Database**: `sierra_shop`
4. Klikni `Test Connection` → `OK`

Teď můžeš prohlížet kolekce přímo ve WebStorm!

### 4. REST Client

WebStorm má built-in REST client pro testování API:

1. Vytvoř soubor `api-test.http` v root složce
2. Napiš:

```http
### Health Check
GET http://localhost:8001/api/

### Get Products
GET http://localhost:8001/api/products

### Validate Discount
POST http://localhost:8001/api/validate-discount?code=WELCOME10

### Get Shipping Methods
GET http://localhost:8001/api/shipping-methods
```

3. Klikni na ▶️ vedle každého requestu pro spuštění

---

## 🛠️ Řešení problémů

### ❌ "Module not found" při spuštění backendu

**Řešení:**
```bash
cd backend
source venv/bin/activate
pip install -r requirements.txt
```

### ❌ "expo: not found" při spuštění frontendu

**Řešení:**
```bash
cd frontend
rm -rf node_modules
yarn install
```

### ❌ Port 8001 nebo 3000 už je používán

**Najdi a zabij proces:**

Mac/Linux:
```bash
lsof -i :8001  # nebo :3000
kill -9 <PID>
```

Windows:
```powershell
netstat -ano | findstr :8001
taskkill /PID <PID> /F
```

### ❌ MongoDB connection error

**Ujisti se, že MongoDB běží:**

```bash
# Status check
brew services list | grep mongodb  # Mac
sc query MongoDB  # Windows
systemctl status mongod  # Linux

# Restart
brew services restart mongodb-community  # Mac
net stop MongoDB && net start MongoDB  # Windows
sudo systemctl restart mongod  # Linux
```

### ❌ WebStorm nenajde Python interpreter

1. `File → Settings → Project → Python Interpreter`
2. Klikni ⚙️ → `Show All...`
3. Klikni `+` → `Add Local Interpreter`
4. Vyber `backend/venv/bin/python` (nebo `venv\Scripts\python.exe` na Windows)

---

## 📝 Hot Reload

Oba servery podporují hot reload:

- **Backend**: Automaticky restartuje při změně `.py` souborů
- **Frontend**: Automaticky reloaduje při změně `.tsx`/`.jsx` souborů

**💡 Nemusíš nic restartovat po změnách v kódu!**

Výjimky (vyžadují restart):
- Změny v `.env` souborech
- Nová instalace packages
- Změny v `package.json` nebo `requirements.txt`

---

## 🎨 WebStorm Extensions (doporučené)

Ve WebStorm jdi do `Settings → Plugins` a nainstaluj:

1. **Rainbow Brackets** - barevné závorky
2. **Material Theme UI** - lepší vzhled
3. **GitToolBox** - rozšířená Git podpora
4. **.env files support** - syntax highlighting pro .env
5. **Mongo Plugin** - lepší MongoDB integrace

---

## 📚 Další zdroje

- **FastAPI Docs**: https://fastapi.tiangolo.com
- **Expo Docs**: https://docs.expo.dev
- **MongoDB Docs**: https://www.mongodb.com/docs
- **Stripe Docs**: https://stripe.com/docs

---

## ✅ Checklist před pushnutím na GitHub

- [ ] `.env` soubory jsou v `.gitignore` ✅
- [ ] `node_modules/` je v `.gitignore` ✅
- [ ] `venv/` je v `.gitignore` ✅
- [ ] `README.md` je aktuální ✅
- [ ] Všechny dependencies jsou v `requirements.txt` a `package.json` ✅
- [ ] Projekt běží lokálně bez chyb ✅
- [ ] API endpointy fungují ✅

---

**🎉 Hotovo! Projekt je připravený k použití ve WebStorm.**

Pokud máš jakékoliv problémy, zkontroluj [README.md](./README.md) nebo otevři Issue na GitHubu.
