#!/bin/bash
# Publishes this folder as a PUBLIC GitHub repo with Pages. Run from inside the folder.
set -e
REPO="peech-flow-rebuild"
OWNER=$(gh api user --jq .login)
echo "This will create a PUBLIC repo $OWNER/$REPO and publish it on GitHub Pages."
read -p "Continue? (y/n) " ok; [ "$ok" = "y" ] || exit 1
git init -q && git branch -M main
git add -A && git commit -qm "Growth Audit — Peech"
gh repo create "$REPO" --public --source=. --push \
  --description "Growth Audit — Peech. Five ranked ideas plus a clickable prototype of their onboarding and paywall, rebuilt in their own design."
gh api -X POST "repos/$OWNER/$REPO/pages" -f "source[branch]=main" -f "source[path]=/" >/dev/null
gh repo edit "$OWNER/$REPO" --homepage "https://$OWNER.github.io/$REPO/"
echo "Done: https://$OWNER.github.io/$REPO/  (Pages takes 1–2 minutes)"
