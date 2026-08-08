# Waywords Frontend

Angular 19 web application for Waywords platform.

**Part of:** [Waywords](https://github.com/manuelgomezsw/waywords-specs)

---

## 📚 Documentation

All specifications and architecture decisions are in the **[waywords-specs](https://github.com/manuelgomezsw/waywords-specs)** repository.

**Start here:**
- [FUNCTIONAL_SPECS_INDEX.md](https://github.com/manuelgomezsw/waywords-specs/blob/main/docs/specs/FUNCTIONAL_SPECS_INDEX.md) — Complete product overview
- [BRAND_IDENTITY.md](https://github.com/manuelgomezsw/waywords-specs/blob/main/docs/specs/BRAND_IDENTITY.md) — Design system & visual identity
- [QUALITY_ATTRIBUTES.md](https://github.com/manuelgomezsw/waywords-specs/blob/main/docs/specs/QUALITY_ATTRIBUTES.md) — Architecture drivers & performance targets

---

## 🚀 Quick Start

### Prerequisites
- Node.js 20+
- npm 10+ (or yarn/pnpm)
- Angular CLI 19

### Setup

```bash
cd waywords-frontend

# Install dependencies
npm install

# Start dev server
npm start

# Open http://localhost:4200
```

---

## 📐 Project Structure

```
src/
  ├─ app/
  │  ├─ features/
  │  │  ├─ memorizar/         # Quote capture feature
  │  │  ├─ buscar/            # Intelligent search
  │  │  ├─ reflexiones/       # Markdown reflections
  │  │  └─ palabras/          # Personal vocabulary
  │  ├─ shared/               # Shared components & services
  │  ├─ core/                 # Singleton services (auth, api)
  │  └─ app.component.ts      # Root component
  ├─ main.ts                  # Bootstrap
  └─ index.html
  
angular.json                   # Angular config
tailwind.config.js            # Tailwind CSS config
package.json
```

---

## 🛠️ Tech Stack

- **Framework:** Angular 19 (standalone components, signals)
- **Language:** TypeScript 5.5+
- **Styling:** Tailwind CSS 4.x
- **HTTP:** HttpClient + RxJS
- **UI Components:** Radix Angular (headless)
- **Testing:** Vitest + Cypress

---

## 🎨 Design System

**Color Palette (Índigo Profundo):**
```css
--primary: #4F46E5    /* Índigo Profundo */
--primary-light: #818CF8
--text-dark: #1F2937
--text-light: #F8F9FA
```

**Typography:**
- Headers: Inter Bold 28-32px
- Body: Inter Regular 14-16px
- UI: Inter Medium 14-16px

**See:** [BRAND_IDENTITY.md](https://github.com/manuelgomezsw/waywords-specs/blob/main/docs/specs/BRAND_IDENTITY.md)

---

## 🎯 Core Features (Implemented Per Specs)

### 1. Memorizar (Quote Capture)
- Quick-capture form
- Optional context modal
- Toast feedback
- Target: < 30s end-to-end

**Component:** `features/memorizar/`

### 2. Buscar (Intelligent Search)
- Mood emoji selector
- Live search input (debounce 300ms)
- Hybrid search results
- Expandable metadata cards

**Component:** `features/buscar/`

### 3. Reflexiones (Reflections)
- Markdown editor
- Split view (editor + preview)
- Auto-save indicator
- Draft/Published toggle

**Component:** `features/reflexiones/`

### 4. Palabras (Vocabulary)
- Flashcard display
- Expandable cards (truncated → full)
- Search & category filter
- Add/edit/delete actions

**Component:** `features/palabras/`

---

## 📝 Development Guidelines

### Language
- **All code in English** (comments, variable names, commits)

### Code Style
- Follow [Angular Style Guide](https://angular.io/guide/styleguide)
- Use ESLint + Prettier
- Standalone components (no modules)
- Reactive forms with signals

### Component Pattern
```typescript
// Feature component (standalone)
import { Component, signal } from '@angular/core';

@Component({
  selector: 'app-feature',
  standalone: true,
  imports: [CommonModule, ReactiveFormsModule],
  template: `...`
})
export class FeatureComponent {
  state = signal({ /* initial state */ });
}
```

### Branching
- `main` → Production
- `develop` → Development
- `feature/*` → Features
- `fix/*` → Bug fixes

### Commits
Use [Conventional Commits](https://www.conventionalcommits.org/):
```
feat: add mood emoji selector for search
fix: improve debounce on live search
style: adjust card spacing (8px grid)
```

---

## 🧪 Testing

```bash
# Unit tests
npm test

# E2E tests
npm run e2e

# Coverage
npm test -- --coverage
```

---

## ⚡ Performance Targets

Per [QUALITY_ATTRIBUTES.md](https://github.com/manuelgomezsw/waywords-specs/blob/main/docs/specs/QUALITY_ATTRIBUTES.md):

| Metric | Target |
|--------|--------|
| Capture flow (E2E) | < 30 seconds |
| Search results | < 1 second |
| Card rendering (100 items) | < 500ms |
| Word search | < 300ms |

**Optimizations:**
- Change detection: `OnPush` strategy
- Signals for reactive state
- Lazy loading by feature
- Image optimization
- CSS-in-JS minimized (use Tailwind)

---

## 🔐 Authentication & Authorization

- JWT token stored (secure httpOnly cookie preferred)
- Row-level security enforced by backend
- Refresh token rotation
- Logout clears state

**See:** Core service to be implemented in SDD

---

## 🌐 API Integration

```typescript
// Example HTTP service
export class QuoteService {
  constructor(private http: HttpClient) {}

  getQuotes(): Observable<Quote[]> {
    return this.http.get<Quote[]>('/api/quotes');
  }

  searchQuotes(query: string): Observable<Quote[]> {
    return this.http.get<Quote[]>('/api/quotes/search', {
      params: { q: query }
    });
  }
}
```

**Backend API:** [waywords-backend](https://github.com/manuelgomezsw/waywords-backend)

---

## 📋 Environment Setup

Create `environment.ts`:

```typescript
export const environment = {
  production: false,
  apiUrl: 'http://localhost:8080/api',
  // other config
};
```

---

## 🚀 Building for Production

```bash
npm run build

# Outputs to dist/
```

---

## 📞 Links

- **Specs:** https://github.com/manuelgomezsw/waywords-specs
- **Backend:** https://github.com/manuelgomezsw/waywords-backend
- **Organization:** https://github.com/manuelgomezsw

---

**Status:** 🚧 Under Development

Last updated: August 8, 2026
