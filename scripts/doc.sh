#!/bin/bash
set -e

echo "📖 Generating documentation..."
swift package --allow-writing-to-directory ./docs \
    generate-documentation --target SNetwork --output-path ./docs \
    --transform-for-static-hosting --hosting-base-path SNetwork

echo "🚀 Deploying documentation to gh-pages branch..."
git fetch origin gh-pages || git checkout --orphan gh-pages
git rm -rf .
mv docs/* .
touch .nojekyll  # Ensures proper rendering on GitHub Pages

echo "✅ Documentation ready for deployment"
