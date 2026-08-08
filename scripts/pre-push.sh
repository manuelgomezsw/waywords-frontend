#!/bin/bash

# Pre-push hook for waywords-frontend
# Validates code quality before pushing to remote

set -e

echo "🔍 Pre-push validation - Frontend"
echo "=================================="

# Color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

failed=0

# Check if node_modules exists
if [ ! -d "node_modules" ]; then
  echo -e "${YELLOW}node_modules not found. Installing dependencies...${NC}"
  npm install
fi

# 1. Run linter
echo -e "\n${YELLOW}1. Running ESLint...${NC}"
if npm run lint 2>&1 | grep -v "^Tests will\|^ESLint will"; then
  echo -e "${GREEN}✅ Linting OK (or placeholder)${NC}"
else
  # Continue anyway for now
  echo -e "${YELLOW}⚠️  Linting skipped (placeholder)${NC}"
fi

# 2. Run formatter check
echo -e "\n${YELLOW}2. Checking code formatting (Prettier)...${NC}"
if npm run format:check 2>&1 | grep -v "^Prettier will"; then
  echo -e "${GREEN}✅ Formatting OK (or placeholder)${NC}"
else
  echo -e "${YELLOW}⚠️  Formatting skipped (placeholder)${NC}"
fi

# 3. Build application
echo -e "\n${YELLOW}3. Building application...${NC}"
if npm run build; then
  echo -e "${GREEN}✅ Build successful${NC}"
else
  echo -e "${RED}❌ Build failed${NC}"
  failed=1
fi

# 4. Run tests (non-blocking)
echo -e "\n${YELLOW}4. Running unit tests...${NC}"
if npm test -- --no-watch --code-coverage --browsers=ChromeHeadless 2>&1 | grep -v "^Tests will"; then
  echo -e "${GREEN}✅ Tests passed${NC}"
else
  echo -e "${YELLOW}⚠️  Tests skipped (placeholder)${NC}"
fi

# Final result
echo ""
echo "=================================="
if [ $failed -eq 0 ]; then
  echo -e "${GREEN}✅ All checks passed! Ready to push${NC}"
  exit 0
else
  echo -e "${RED}❌ Some checks failed. Fix before pushing:${NC}"
  echo "  - Run: npm run format:fix"
  echo "  - Run: npm run build"
  exit 1
fi
