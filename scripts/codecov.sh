#!/bin/bash

set -e

LLVM_COV_CMD="llvm-cov"
if [[ "$OSTYPE" == "darwin"* ]]; then
    LLVM_COV_CMD="xcrun llvm-cov"
fi

# Ensure coverage files exist
if [[ ! -f "$PROFDATA_FILE" || ! -d "$TEST_EXECUTABLE" ]]; then
    echo "❌ Error: Coverage data not found."
    exit 1
fi

echo "📊 Exporting coverage data to LCOV format..."
$LLVM_COV_CMD export -format="lcov" "$TEST_EXECUTABLE" -instr-profile "$PROFDATA_FILE" > "$LCOV_OUTPUT"

echo "📡 Uploading coverage to Codecov..."
bash <(curl -s https://codecov.io/bash) || { echo "❌ Codecov upload failed."; exit 1; }

echo "🎉 Code coverage successfully uploaded."
