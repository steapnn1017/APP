# 🤝 Contributing to SIERRA 97 SX

Děkujeme za zájem přispět k projektu! Tento dokument obsahuje guidelines pro přispěvatele.

## 📋 Před začátkem

1. Forkni repozitář
2. Naklonuj svůj fork lokálně
3. Vytvoř novou branch pro svou feature: `git checkout -b feature/amazing-feature`
4. Proveď změny
5. Commitni změny: `git commit -m 'Add amazing feature'`
6. Pushni do branch: `git push origin feature/amazing-feature`
7. Otevři Pull Request

## 🎯 Coding Guidelines

### Python (Backend)

- Používej **type hints** všude kde je to možné
- Dodržuj **PEP 8** style guide
- Používej **async/await** pro async operations
- Dokumentuj funkce pomocí docstrings

```python
async def get_product(product_id: str) -> Optional[Product]:
    """
    Get product by ID from database.
    
    Args:
        product_id: Unique product identifier
        
    Returns:
        Product object or None if not found
    """
    pass
```

### TypeScript/JavaScript (Frontend)

- Používej **TypeScript** pro type safety
- Používej **functional components** a **hooks**
- Pojmenování: `PascalCase` pro komponenty, `camelCase` pro funkce
- Vždy používej **data-testid** pro testovatelné elementy

```typescript
interface ProductCardProps {
  product: Product;
  onPress: () => void;
}

export const ProductCard: React.FC<ProductCardProps> = ({ product, onPress }) => {
  return (
    <TouchableOpacity data-testid="product-card" onPress={onPress}>
      {/* ... */}
    </TouchableOpacity>
  );
};
```

## 🧪 Testing

Před submitnutím PR:

1. **Backend**: Ujisti se, že všechny endpointy fungují
   ```bash
   # Test API
   curl http://localhost:8001/api/
   ```

2. **Frontend**: Zkontroluj, že aplikace běží bez chyb
   ```bash
   npx expo start --web
   ```

3. **Linting**: Zkontroluj code quality
   ```bash
   # Backend
   flake8 backend/
   
   # Frontend
   cd frontend && yarn lint
   ```

## 📝 Commit Messages

Používej [Conventional Commits](https://www.conventionalcommits.org/):

- `feat:` nová feature
- `fix:` oprava bugu
- `docs:` změny v dokumentaci
- `style:` formátování, chybějící středníky, atd.
- `refactor:` refactoring kódu
- `test:` přidání testů
- `chore:` build, dependencies, atd.

**Příklady:**
```
feat: add discount code validation
fix: resolve image sizing issue on product page
docs: update WebStorm setup guide
```

## 🐛 Reporting Bugs

Při hlášení bugu prosím zahrň:

1. **Popis** problému
2. **Kroky k reprodukci**
3. **Očekávané chování**
4. **Aktuální chování**
5. **Screenshots** (pokud je to relevantní)
6. **Environment**: OS, Node.js verze, Python verze

## 💡 Suggesting Features

Pro návrh nové feature:

1. Otevři Issue s tagem `enhancement`
2. Popiš feature a use case
3. Vysvětli proč by to bylo užitečné
4. Pokud možno, navrhni implementaci

## 🔍 Code Review Process

1. Maintainer přezkoumá tvůj PR
2. Pokud jsou potřeba změny, dostaneš feedback
3. Po approval bude PR mergnutý
4. Tvoje jméno bude přidáno do contributors!

## 📚 Resources

- [FastAPI Documentation](https://fastapi.tiangolo.com)
- [Expo Documentation](https://docs.expo.dev)
- [React Native](https://reactnative.dev)
- [MongoDB Documentation](https://www.mongodb.com/docs)

## ❓ Questions?

Pokud máš otázky, neváhej:
- Otevřít Discussion na GitHubu
- Kontaktovat maintainera
- Zeptat se v Issues

---

**Děkujeme za tvůj příspěvek! 🙏**
