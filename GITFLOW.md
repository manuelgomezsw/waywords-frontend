# GitFlow Strategy - Waywords

This document defines the branching strategy, naming conventions, and merge restrictions for all Waywords repositories.

---

## 📋 Branch Types

### 1. **main** (Production)
- **Purpose:** Production-ready code
- **Protection Rules:**
  - ✅ Require pull request reviews (1 approval minimum)
  - ✅ Require status checks to pass (CI/CD)
  - ✅ Require branches to be up to date before merging
  - ✅ Dismiss stale pull request approvals
  - ✅ Require code owner reviews (if applicable)
  - ❌ Direct pushes not allowed
  - ❌ Force push not allowed
  - ❌ Deletion not allowed

### 2. **develop** (Integration)
- **Purpose:** Development integration branch
- **Protection Rules:**
  - ✅ Require pull request reviews (1 approval minimum)
  - ✅ Require status checks to pass (CI/CD)
  - ✅ Require branches to be up to date before merging
  - ✅ Dismiss stale pull request approvals
  - ❌ Direct pushes not allowed
  - ❌ Force push not allowed
  - ❌ Deletion not allowed
- **Merge from:** `feature/*`, `fix/*`, `release/*`
- **Merge to:** `release/*`, `main` (via release)

### 3. **feature/** (Feature Development)
- **Purpose:** New features (one per branch)
- **Naming:** `feature/short-description` (kebab-case)
- **Examples:**
  - `feature/hybrid-search-ranking`
  - `feature/quote-capture-modal`
  - `feature/markdown-editor`
- **Base branch:** `develop`
- **Merge back to:** `develop` (via PR)
- **Deletion:** Allowed after merge
- **Protection:** None (developer branch)

### 4. **fix/** (Bug Fixes)
- **Purpose:** Bug fixes and hotfixes
- **Naming:** `fix/bug-description` (kebab-case)
- **Examples:**
  - `fix/duplicate-quote-detection`
  - `fix/search-debounce-timing`
  - `fix/auto-save-race-condition`
- **Base branch:** `develop` (or `main` for critical hotfixes)
- **Merge back to:** `develop` (or `main` if hotfix)
- **Deletion:** Allowed after merge
- **Protection:** None (developer branch)

### 5. **release/** (Release Preparation)
- **Purpose:** Release candidates
- **Naming:** `release/v{MAJOR}.{MINOR}.{PATCH}` (semantic versioning)
- **Examples:**
  - `release/v1.0.0`
  - `release/v1.1.0`
- **Base branch:** `develop`
- **Allowed changes:** 
  - ✅ Version bumps
  - ✅ Changelog updates
  - ✅ Release documentation
  - ❌ New features
  - ❌ Major refactors
- **Merge to:** `main` (via PR with release tag)
- **Also merge back to:** `develop`
- **Protection:** Require PR + CI/CD

### 6. **hotfix/** (Critical Production Fixes)
- **Purpose:** Critical bug fixes for production
- **Naming:** `hotfix/v{MAJOR}.{MINOR}.{PATCH}` (semantic versioning)
- **Examples:**
  - `hotfix/v1.0.1`
  - `hotfix/v1.0.2`
- **Base branch:** `main`
- **Allowed changes:** Only critical bug fixes
- **Merge to:** `main` (via PR with hotfix tag)
- **Also merge back to:** `develop`
- **Protection:** Require PR + CI/CD

---

## 🔄 Merge Rules

### Develop → Main (Release)

```
1. Create release/v{version} from develop
2. Update version numbers
3. Create release/v{version} → main PR
4. Require 1 approval + all CI/CD passes
5. Merge with "Squash and merge" strategy
6. Tag main with v{version}
7. Merge release branch back to develop
8. Delete release branch
```

### Feature → Develop

```
1. Create feature/xxx from develop
2. Implement feature with tests
3. Create feature/xxx → develop PR
4. All CI/CD must pass
5. Require 1 approval
6. Merge with "Create a merge commit" strategy
7. Delete feature branch
```

### Hotfix → Main → Develop

```
1. Create hotfix/v{version} from main
2. Fix critical bug
3. Create hotfix/v{version} → main PR
4. All CI/CD must pass
5. Merge to main with "Squash and merge"
6. Tag main with v{version}
7. Create hotfix/v{version} → develop PR
8. Merge back to develop
9. Delete hotfix branch
```

---

## 📝 Commit Message Convention

Use [Conventional Commits](https://www.conventionalcommits.org/):

```
<type>(<scope>): <subject>

<body>

<footer>
```

### Types
- `feat:` — New feature
- `fix:` — Bug fix
- `docs:` — Documentation
- `style:` — Code style (formatting, missing semicolons, etc.)
- `refactor:` — Code refactoring
- `perf:` — Performance improvement
- `test:` — Test additions or fixes
- `chore:` — Build, dependency, or setup changes
- `ci:` — CI/CD pipeline changes

### Examples

```
feat(search): add hybrid ranking algorithm
fix(capture): prevent quote duplicates
docs(specs): update API endpoint documentation
refactor(backend): improve repository layer
test(search): add unit tests for ranking
```

### PR Title Format

PR titles should follow the same convention:

```
feat(memorizar): add context modal for quote capture
fix(buscar): fix debounce timing on search input
docs: update contributing guidelines
```

---

## 🔒 Branch Protection Rules Summary

| Rule | main | develop | feature/* | fix/* | release/* |
|------|------|---------|-----------|-------|-----------|
| Require PR | ✅ | ✅ | ❌ | ❌ | ✅ |
| Min approvals | 1 | 1 | — | — | 1 |
| Require CI/CD | ✅ | ✅ | ❌ | ❌ | ✅ |
| Up to date | ✅ | ✅ | ❌ | ❌ | ✅ |
| Dismiss stale | ✅ | ✅ | — | — | ✅ |
| Allow force push | ❌ | ❌ | ✅ | ✅ | ❌ |
| Allow deletion | ❌ | ❌ | ✅ | ✅ | ✅ |

---

## 🚀 Workflow Example: New Feature

```
1. Developer clones repo
   git clone https://github.com/manuelgomezsw/waywords-backend.git

2. Update develop locally
   git checkout develop
   git pull origin develop

3. Create feature branch
   git checkout -b feature/hybrid-search-ranking

4. Make commits (conventional format)
   git commit -m "feat(search): implement hybrid ranking algorithm"
   git commit -m "test(search): add ranking unit tests"

5. Push to origin
   git push -u origin feature/hybrid-search-ranking

6. Create PR on GitHub
   - Title: "feat(search): implement hybrid ranking algorithm"
   - Link to spec: [SPEC_02_BUSCAR.md](link)
   - Describe changes
   - Reference any issues

7. Wait for CI/CD to pass (build, tests, linting)

8. Request review from team

9. Address feedback if needed

10. Maintainer approves

11. Merge to develop
    - Strategy: "Create a merge commit"

12. Delete branch after merge
    - Automatic cleanup enabled

13. Done! Feature in develop, awaiting release
```

---

## 🔄 Workflow Example: Hotfix

```
1. Critical bug found in production

2. Create hotfix from main
   git checkout main
   git pull origin main
   git checkout -b hotfix/v1.0.1

3. Fix bug
   git commit -m "fix(search): critical ranking bug in production"

4. Push and create PR to main
   git push -u origin hotfix/v1.0.1

5. Create PR: hotfix/v1.0.1 → main
   - CI/CD must pass
   - Get approval

6. Merge to main with squash
   - Tag: v1.0.1

7. Create PR: hotfix/v1.0.1 → develop
   - Merge back so fix is in next release

8. Delete hotfix branch

9. Deploy v1.0.1 to production
```

---

## 📊 Release Cadence

- **MVP Phase:** Weekly releases (v0.1.0 → v0.5.0)
- **Stable Phase:** Bi-weekly releases (v1.0.0+)
- **Hotfixes:** ASAP when critical bugs found

---

## 🛠️ Tools & Automation

### GitHub Actions
- ✅ Automatic CI/CD on PR (build, test, lint)
- ✅ Require passing status checks
- ✅ Auto-label PRs by type (feat, fix, docs, etc.)
- ✅ Auto-delete branches after merge

### Recommended Git Aliases

Add to `.gitconfig`:

```bash
[alias]
  feature = checkout -b feature/
  fix = checkout -b fix/
  release = checkout -b release/
  hotfix = checkout -b hotfix/
  pr-dev = "!git push -u origin && gh pr create --base develop"
  pr-main = "!git push -u origin && gh pr create --base main"
```

Usage:
```bash
git feature my-feature          # Creates feature/my-feature
git commit -m "feat: ..."
git pr-dev                      # Push and create PR to develop
```

---

## ✅ Implementation Checklist

### Per Repository (main, develop, feature/*, fix/*, release/*)

- [ ] Enable branch protection on `main`
- [ ] Enable branch protection on `develop`
- [ ] Require status checks (CI/CD workflows)
- [ ] Require PR reviews (1 minimum)
- [ ] Dismiss stale reviews
- [ ] Auto-delete head branches
- [ ] Set merge strategy (create merge commit, squash for release)

### GitHub Actions Setup

- [ ] Configure build workflow for each repo
- [ ] Configure test workflow for each repo
- [ ] Configure lint workflow for each repo
- [ ] Set required status checks in branch protection

---

## 📞 Questions?

Refer to:
- [Git Flow Cheat Sheet](https://danielkummer.github.io/git-flow-cheatsheet/)
- [Conventional Commits](https://www.conventionalcommits.org/)
- [GitHub Flow Documentation](https://guides.github.com/introduction/flow/)

---

**Last updated:** August 8, 2026
**Version:** 1.0
**Status:** Active
