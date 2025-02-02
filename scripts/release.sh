#!/bin/bash

set -e  # Exit on any error

# Detect branch
BRANCH=${TRAVIS_BRANCH:-$(git rev-parse --abbrev-ref HEAD)}

# Check if this script is running in CI and skip if it's a tag-triggered build
if [[ "$TRAVIS_EVENT_TYPE" == "push" && "$TRAVIS_TAG" != "" ]]; then
    echo "❌ Skipping release script on tag push to avoid loops."
    exit 0
fi

# Fetch the latest tag version (e.g., v1.0.0)
LATEST_TAG=$(git describe --tags --abbrev=0 || echo "v0.0.0")
echo "Latest tag: $LATEST_TAG"

# Calculate the next version number (increment the patch version)
NEXT_VERSION=$(echo $LATEST_TAG | awk -F. -v OFS=. '{$NF++;print}')
TAG_SUFFIX=""

# Set suffix for branches
if [[ "$BRANCH" == "main" ]]; then
    TAG_SUFFIX=""  # Stable release tag for main
elif [[ "$BRANCH" == "develop" ]]; then
    TAG_SUFFIX="-rc"  # RC tag for develop
else
    echo "❌ Unsupported branch for release: $BRANCH"
    exit 1
fi

NEW_TAG="v$NEXT_VERSION$TAG_SUFFIX"
echo "🎯 Creating new tag: $NEW_TAG"

# Create a new tag for the version
git tag -a "$NEW_TAG" -m "Release version $NEW_TAG"

# Push the tag to the remote repository
git push origin "$NEW_TAG"

echo "✅ Tag $NEW_TAG created and pushed to remote."
