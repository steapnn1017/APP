# 🚀 GitHub Push Guide

Tento návod ti ukáže jak pushnutout celý projekt na GitHub a jak ho pak naklonovat a spustit.

---

## 📤 Push na GitHub (poprvé)

### 1. Vytvoř nový repozitář na GitHubu

1. Jdi na [github.com](https://github.com)
2. Klikni na **+** → **New repository**
3. Zadej:
   - **Repository name**: `sierra-97-sx` (nebo jiný název)
   - **Description**: `Full-stack e-commerce platform with React Native & FastAPI`
   - **Visibility**: Public nebo Private
   - ❌ **NEINICIALIZUJ** s README, .gitignore nebo license (máme už vlastní)
4. Klikni **Create repository**

### 2. Připoj lokální projekt k GitHubu

V terminalu v root složce projektu (`/app/`):

```bash
# Inicializuj Git (pokud ještě není)
git init

# Přidej všechny soubory
git add .

# První commit
git commit -m "Initial commit: Complete SIERRA 97 SX e-commerce platform"

# Přidej remote (nahraď USERNAME a REPO_NAME)
git remote add origin https://github.com/USERNAME/REPO_NAME.git

# Pushni na GitHub
git branch -M main
git push -u origin main
```

### 3. Ověř na GitHubu

Otevři svůj repozitář na GitHubu a měl bys vidět všechny soubory.

---

## 📥 Naklonování projektu (nový počítač)

### 1. Klonuj repozitář

```bash
git clone https://github.com/USERNAME/REPO_NAME.git
cd REPO_NAME
```

### 2. Spusť setup script

**Mac/Linux:**
```bash
chmod +x setup.sh
./setup.sh
```

**Windows:**
```bash
setup.bat
```

### 3. Vytvoř .env soubory

Setup script vytvoří šablony, ale musíš vyplnit své údaje:

**Backend (.env):**
```bash
cd backend
nano .env  # nebo otevři v editoru
```

Vyplň:
```env
MONGO_URL=mongodb://localhost:27017
DB_NAME=sierra_shop
STRIPE_API_KEY=sk_test_your_key_here
```

**Frontend (.env):**
```bash
cd frontend
nano .env
```

Vyplň:
```env
EXPO_PUBLIC_BACKEND_URL=http://localhost:8001
```

### 4. Spusť projekt

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

**Terminal 3 - Seed database (první spuštění):**
```bash
curl -X POST http://localhost:8001/api/seed
```

---

## 🔄 Workflow pro změny

### Stáhni nejnovější změny

```bash
git pull origin main
```

### Proveď změny a commitni

```bash
# Přidej změněné soubory
git add .

# Nebo přidej specifické soubory
git add backend/server.py frontend/app/shop.tsx

# Commitni s popisnou zprávou
git commit -m "feat: add discount code feature"

# Pushni na GitHub
git push origin main
```

### Používej branches pro nové features

```bash
# Vytvoř novou branch
git checkout -b feature/new-payment-method

# Proveď změny...
git add .
git commit -m "feat: add PayPal integration"

# Pushni branch
git push origin feature/new-payment-method

# Na GitHubu vytvoř Pull Request
```

---

## ⚠️ Co NIKDY nepushovat

Tyto soubory jsou automaticky ignorovány díky `.gitignore`:

- ❌ `.env` soubory (obsahují API klíče!)
- ❌ `node_modules/` (frontend dependencies)
- ❌ `venv/` (Python virtual environment)
- ❌ `__pycache__/` (Python cache)
- ❌ `.DS_Store` (Mac systémové soubory)

### Kontrola před pushnutím:

```bash
# Zobraz co bude commitnuto
git status

# Zkontroluj, že .env není v seznamu!
```

---

## 🔐 Secrets v GitHubu (pro CI/CD)

Pokud chceš použít GitHub Actions pro automatické deployování:

1. Jdi do repozitáře na GitHubu
2. **Settings → Secrets and variables → Actions**
3. Klikni **New repository secret**
4. Přidej:
   - `MONGO_URL`
   - `STRIPE_API_KEY`
   - `DB_NAME`

---

## 📝 Doporučené commit messages

Používej [Conventional Commits](https://www.conventionalcommits.org/):

```bash
# Nová feature
git commit -m "feat: add wishlist functionality"

# Oprava bugu
git commit -m "fix: resolve image loading issue on product page"

# Dokumentace
git commit -m "docs: update setup instructions"

# Refactoring
git commit -m "refactor: optimize database queries"

# Style changes
git commit -m "style: format code with prettier"

# Tests
git commit -m "test: add unit tests for cart store"
```

---

## 🏷️ Vytvoř release (verze)

Pro označení stabilní verze:

```bash
# Tag verzi
git tag -a v1.0.0 -m "Version 1.0.0 - Initial release"

# Pushni tag
git push origin v1.0.0

# Nebo pushni všechny tagy
git push origin --tags
```

Na GitHubu pak vytvoř Release z tagu.

---

## 🔧 WebStorm Git integrace

### Commitování ve WebStorm:

1. **Ctrl+K** (Cmd+K na Mac) - otevře commit dialog
2. Vyber soubory k commitnutí
3. Napiš commit message
4. Klikni **Commit** nebo **Commit and Push**

### Pushování:

1. **Ctrl+Shift+K** - push dialog
2. Zkontroluj změny
3. Klikni **Push**

### Pull/Update:

1. **Ctrl+T** - update dialog
2. Vyber branch
3. Klikni **OK**

### Git Log:

1. **Alt+9** - otevře Git tool window
2. Vidíš historii commitů
3. Můžeš procházet změny, branche, atd.

---

## 🐛 Troubleshooting

### "Permission denied" při pushnutí

Nastav Git credentials:

```bash
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"

# Použij Personal Access Token místo hesla
# Vytvoř na: https://github.com/settings/tokens
```

### Merge konflikty

```bash
# Stáhni nejnovější změny
git pull origin main

# Vyřeš konflikty v souborech (WebStorm ti pomůže)
# Pak:
git add .
git commit -m "resolve merge conflicts"
git push origin main
```

### Vrátit změny (nepushnuté)

```bash
# Vrať všechny změny
git reset --hard HEAD

# Vrať specifický soubor
git checkout -- filename.py
```

### Vrátit commit (už pushnutý)

```bash
# Vytvoř nový commit, který vrátí změny
git revert HEAD
git push origin main
```

---

## ✅ Checklist před pushnutím

- [ ] Projekt běží lokálně bez chyb
- [ ] `.env` soubory nejsou v git
- [ ] `node_modules/` a `venv/` nejsou v git
- [ ] Commit message je popisná
- [ ] Kód je naformátován
- [ ] README je aktuální
- [ ] Žádné console.log nebo debug printy v production kódu

---

## 📚 Další zdroje

- [Git Documentation](https://git-scm.com/doc)
- [GitHub Guides](https://guides.github.com/)
- [WebStorm Git Tutorial](https://www.jetbrains.com/help/webstorm/using-git-integration.html)

---

**🎉 Hotovo! Tvůj projekt je na GitHubu a kdokoliv ho může naklonovat a spustit.**
