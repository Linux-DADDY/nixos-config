#!/usr/bin/env bash
set -euo pipefail

REPO="$HOME/Documents/nixos-config/"
cd "$REPO"

# Generate branch name: backup-YYYY-MM-DD-HHMM
BRANCH="backup-$(date +%Y-%m-%d-%H%M)"

# Optional: Check if branch already exists (unlikely, but safe)
if git rev-parse --verify "$BRANCH" >/dev/null 2>&1; then
  echo "⚠️ Branch $BRANCH already exists. Appending seconds to avoid collision."
  BRANCH="backup-$(date +%Y-%m-%d-%H%M%S)"
fi

# Stage all changes
echo "📁 Adding all changes..."
git add .

# Check if there are changes to commit
if git diff-index --quiet HEAD --; then
  echo "✅ No changes detected. Skipping commit & push."
  exit 0
fi

# Create new branch from current main
echo "🌿 Creating branch: $BRANCH"
git checkout -b "$BRANCH"

# Commit
echo "📝 Committing changes..."
git commit -m "Auto-backup: $(date)"

# Push branch to GitHub
echo "🚀 Pushing branch $BRANCH to origin..."
git push -u origin "$BRANCH"

# Switch back to main
echo "🔙 Switching back to main..."
git checkout main

echo "✅ Backup complete! Branch: $BRANCH"
