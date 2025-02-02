#!/bin/bash

set -e

echo "📖 Generating documentation..."
swift package generate-documentation

echo "✅ Documentation generated in 'docs/' directory."
