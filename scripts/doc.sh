#!/bin/bash

set -e

echo "📖 Generating documentation..."
swift package --allow-writing-to-directory ./docs \
    generate-documentation --target SNetwork --output-path ./docs \
    --transform-for-static-hosting --hosting-base-path SNetwork

echo "✅ Documentation generated."
