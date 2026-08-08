#!/bin/bash

# Setup pre-push hook for waywords-frontend

HOOK_DIR=".git/hooks"
HOOK_FILE="$HOOK_DIR/pre-push"
SCRIPT_FILE="scripts/pre-push.sh"

# Make script executable
chmod +x "$SCRIPT_FILE"

# Create hook if it doesn't exist
if [ ! -f "$HOOK_FILE" ]; then
  # Create the hook that calls our script
  cat > "$HOOK_FILE" << 'HOOK'
#!/bin/bash
# Auto-generated pre-push hook
exec bash scripts/pre-push.sh
HOOK
  chmod +x "$HOOK_FILE"
  echo "✅ Pre-push hook installed"
else
  echo "⚠️  Pre-push hook already exists"
fi

echo "✅ Frontend hooks setup complete"
echo ""
echo "Next time you push, the following will be validated:"
echo "  1. ESLint (code style)"
echo "  2. Prettier (formatting)"
echo "  3. Build success"
echo "  4. Unit tests (non-blocking)"
