#!/bin/bash

set -e


PACKAGE_NAME="SNetwork"
TEST_POSTFIX="PackageTests"
LCOV_OUTPUT="cov/info.lcov"
PROFDATA_FILE=".build/debug/codecov/default.profdata"
TEST_EXECUTABLE=".build/debug/$PACKAGE_NAME$TEST_POSTFIX.xctest/Contents/MacOS/$PACKAGE_NAME$TEST_POSTFIX"
CODE_COV_TOKEN=b6cbea33-dffc-4a61-81d4-2ef57950030f

LLVM_COV_CMD="llvm-cov"
if [[ "$OSTYPE" == "darwin"* ]]; then
    LLVM_COV_CMD="xcrun llvm-cov"
fi

ls -la ".build/debug"
ls -la ".build/debug/codecov"
ls -la ".build/debug/$PACKAGE_NAME$TEST_POSTFIX.xctest"
# Ensure coverage files exist
if [[ ! -f "$PROFDATA_FILE" || ! -f "$TEST_EXECUTABLE" ]]; then
    echo "❌ Error: Coverage data not found."
    exit 1
fi

echo "📊 Exporting coverage data to LCOV format..."
$LLVM_COV_CMD export -format="lcov" "$TEST_EXECUTABLE" -instr-profile "$PROFDATA_FILE" > "$LCOV_OUTPUT"

echo "📡 Uploading coverage to Codecov..."
bash <(curl -s https://codecov.io/bash) -t $CODE_COV_TOKEN || { echo "❌ Codecov upload failed."; exit 1; }

rm -rf *.coverage.txt

echo "🎉 Code coverage successfully uploaded."
