#!/usr/bin/env bash
set -euo pipefail

REPO="$HOME/Documents/nixos-config"
cd "$REPO"

# Get all backup branches and sort them by date (newest first)
LATEST_BACKUP=$(git branch -a | grep 'backup-' | sed 's/^[* ] //' | sed 's/remotes\/origin\///' | sort -r | head -n 1)

if [ -z "$LATEST_BACKUP" ]; then
  echo "❌ No backup branches found!"
  exit 1
fi

# Switch to the latest backup branch
echo "🔄 Switching to latest backup branch: $LATEST_BACKUP"
git checkout "$LATEST_BACKUP"

echo "✅ Now using latest backup: $LATEST_BACKUP"
echo "📁 Your files are now synced with the most recent configuration"
