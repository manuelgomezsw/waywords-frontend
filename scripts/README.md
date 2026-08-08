# Scripts - Waywords Frontend

Utility scripts for development and CI/CD validation.

## Pre-push Hook Setup

Before pushing code, all CI/CD checks will run locally to ensure your changes won't fail in GitHub Actions.

### Installation

Run this once after cloning:

```bash
bash scripts/setup-hooks.sh
```

This will:
1. Create `.git/hooks/pre-push` that runs `scripts/pre-push.sh`
2. Make all scripts executable

### What It Validates

The pre-push hook validates:

✅ **Code Linting** (`npm run lint`)
- ESLint with Angular and TypeScript strict rules
- Currently using placeholder (will implement full checks)

✅ **Code Formatting** (`npm run format:check`)
- Prettier code formatting rules
- Currently using placeholder (will implement full checks)

✅ **Build Success** (`npm run build`)
- Ensures the application compiles with ng build
- Must pass before push

✅ **Unit Tests** (`npm test`)
- Runs tests with code coverage
- Currently using placeholder (will implement full tests)
- Non-blocking for MVP phase

### Usage

**Push normally:**
```bash
git push origin feature/my-feature
```

The hook will run automatically and either:
- ✅ Allow push if all checks pass
- ❌ Block push if build fails
- ⚠️ Warn if optional checks fail

**Skip hook (not recommended):**
```bash
git push --no-verify
```

### Common Issues

**❌ npm install fails**
```bash
# Clean and reinstall
rm -rf node_modules package-lock.json
npm install
```

**❌ Build fails**
```bash
# Try building to see error details
npm run build

# Check for TypeScript errors
npx tsc --noEmit
```

**❌ Linting issues**
```bash
# Once linting is enforced, fix with:
npm run lint -- --fix
```

### Disable Hook Temporarily

If you need to skip temporarily:

```bash
# Push without running pre-push hook
git push --no-verify

# But please fix issues and re-run:
bash scripts/pre-push.sh
```

## Manual Validation

Run validation manually anytime:

```bash
bash scripts/pre-push.sh
```

## Development Workflow

1. Create feature branch: `git checkout -b feature/my-feature`
2. Make changes
3. Install hooks: `bash scripts/setup-hooks.sh` (first time only)
4. Push: `git push -u origin feature/my-feature`
   - Pre-push hook runs automatically
   - Build must succeed
5. Create PR on GitHub

## Contributing

If adding new validation to CI/CD, update `pre-push.sh` to match.
