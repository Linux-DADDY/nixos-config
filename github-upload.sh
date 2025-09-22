#!/usr/bin/env bash
set -euo pipefail

REPO="$HOME/Documents/nixos-config/"
cd "$REPO"

# Store current branch name
CURRENT_BRANCH=$(git branch --show-current)

# Generate backup branch name: backup-YYYY-MM-DD-HHMM
BRANCH="backup-$(date +%Y-%m-%d-%H%M)"

# Check if branch already exists
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

# Create new backup branch from current state
echo "🌿 Creating backup branch: $BRANCH"
git checkout -b "$BRANCH"

# Commit
echo "📝 Committing changes..."
git commit -m "Auto-backup: $(date)"

# Push branch to GitHub
echo "🚀 Pushing branch $BRANCH to origin..."
git push -u origin "$BRANCH"

# IMPORTANT: Return to original working branch
echo "🔙 Returning to original branch: $CURRENT_BRANCH"
git checkout "$CURRENT_BRANCH"

echo "✅ Backup complete! Branch: $BRANCH"
echo "💡 You are back on your working branch: $CURRENT_BRANCH"
