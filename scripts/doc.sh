#!/bin/bash
set -e

echo "📖 Generating documentation..."
mkdir -p ./docs  # Ensure directory exists

swift package --allow-writing-to-directory ./docs \
    generate-documentation --target SNetwork --output-path ./docs \
    --transform-for-static-hosting --hosting-base-path SNetwork

echo "🔍 Verifying documentation output..."
ls -la ./docs  # Debugging step

if [ -z "$(ls -A ./docs)" ]; then
  echo "❌ Error: Documentation directory is empty. Aborting deployment."
  exit 1
fi

echo "🚀 Preparing gh-pages branch..."
git fetch origin gh-pages || git checkout -b gh-pages
git checkout gh-pages

# Remove everything except the docs directory
find . -mindepth 1 -maxdepth 1 ! -name 'docs' ! -name '.git' -exec rm -rf {} +

# Move the docs content to the root
mv docs/* .

# Prevent Jekyll processing issues
touch .nojekyll

# Commit and push changes
git add .
git commit -m "Update documentation"
git push origin gh-pages --force

echo "✅ Documentation successfully deployed!"
