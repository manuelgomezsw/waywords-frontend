# Branch Protection Rules Configuration

This document specifies the branch protection rules that must be configured in GitHub for each repository.

**Note:** These rules must be configured manually in GitHub Settings → Branches (as of now, GitHub doesn't fully support configuration-as-code for branch protection).

---

## 🔒 Rules for `main` branch

### Requirements
- ✅ **Require a pull request before merging**
  - Approval count: **0** (single developer, self-approval OK)
  - Dismiss stale pull request approvals when new commits are pushed

- ✅ **Require status checks to pass before merging**
  - Require branches to be up to date before merging
  - Status checks required:
    - `CI - Backend / Build & Test` (backend repo)
    - `CI - Frontend / Build & Test` (frontend repo)
    - `CI - Specs / Markdown Lint` (specs repo)

- ✅ **Include administrators**
  - Enforce all above rules for administrators

### Restrictions
- ❌ **Allow force pushes**: Disabled for everyone
- ❌ **Allow deletions**: Disabled for everyone
- ❌ **Bypass pull request requirements**: Disabled for everyone

---

## 🔒 Rules for `develop` branch

### Requirements
- ✅ **Require a pull request before merging**
  - Approval count: **0** (single developer, self-approval OK)
  - Dismiss stale pull request approvals when new commits are pushed

- ✅ **Require status checks to pass before merging**
  - Require branches to be up to date before merging
  - Status checks required:
    - `CI - Backend / Build & Test` (backend repo)
    - `CI - Frontend / Build & Test` (frontend repo)
    - `CI - Specs / Markdown Lint` (specs repo)

### Restrictions
- ❌ **Allow force pushes**: Disabled for everyone
- ❌ **Allow deletions**: Disabled (but you can delete after merge)
- ❌ **Bypass pull request requirements**: Disabled for everyone

---

## ✅ No Protection for `feature/*`, `fix/*`, `hotfix/*`, `release/*`

These branches allow direct commits and force pushes (developer branches).

---

## 🚀 Setup Instructions

### Via GitHub Web UI

For each repository:

1. Go to **Settings** → **Branches**
2. Click **Add rule** for `main`
3. Enter branch name pattern: `main`
4. Configure as specified above
5. Click **Create** to save
6. Repeat for `develop` with develop-specific settings

### Required for CI/CD Integration

Each repo must have these workflows (already configured in `.github/workflows/`):

- **Backend:** `.github/workflows/ci.yml` (Go build + test)
- **Frontend:** `.github/workflows/ci.yml` (npm build + test)
- **Specs:** `.github/workflows/ci.yml` (Markdown linting)

---

## 📋 Checklist

### For `waywords-specs`
- [ ] Configure `main` branch protection
  - [ ] Require PR (no approval needed)
  - [ ] Require CI/CD pass (Markdown Lint, validation)
  - [ ] Require up-to-date before merge
  - [ ] Dismiss stale reviews
  - [ ] Include admins
- [ ] Configure `develop` branch protection (same as main)
- [ ] Prevent `main` force push
- [ ] Prevent `main` deletion

### For `waywords-backend`
- [ ] Configure `main` branch protection
  - [ ] Require PR (no approval needed)
  - [ ] Require CI/CD pass (Go build + test)
  - [ ] Require up-to-date before merge
  - [ ] Dismiss stale reviews
  - [ ] Include admins
- [ ] Configure `develop` branch protection (same as main)
- [ ] Prevent `main` force push
- [ ] Prevent `main` deletion

### For `waywords-frontend`
- [ ] Configure `main` branch protection
  - [ ] Require PR (no approval needed)
  - [ ] Require CI/CD pass (npm build + test)
  - [ ] Require up-to-date before merge
  - [ ] Dismiss stale reviews
  - [ ] Include admins
- [ ] Configure `develop` branch protection (same as main)
- [ ] Prevent `main` force push
- [ ] Prevent `main` deletion

---

## 🔄 GitHub Actions Status Checks

These must pass before merging to `main` or `develop`:

### Backend Workflow
```yaml
jobs:
  - build (Go build + tests)
  - security (Gosec scan)
  - analysis (SonarCloud)
```

### Frontend Workflow
```yaml
jobs:
  - build (npm install + build + test)
  - e2e (Cypress tests)
  - accessibility (axe checks)
  - security (npm audit)
```

### Specs Workflow
```yaml
jobs:
  - markdown-lint
  - markdown-validation
  - spell-check
```

---

## 📞 Troubleshooting

**Q: PR blocked because "CI not yet configured"**
A: Wait for all workflow jobs to complete or check Actions tab for failures

**Q: Admin needs to bypass protection rules**
A: Temporarily disable protection, make change, re-enable protection (not recommended)

**Q: Branch protection rules not applying to my branch**
A: Check branch naming pattern matches (e.g., `feature/xxx` won't trigger rules)

---

**Last updated:** August 8, 2026
**Version:** 1.0
