#!/bin/bash

set -e  # Exit on error

echo "🔍 Checking for required tools..."

# Function to check and install missing tools
check_and_install() {
    if ! command -v "$1" &> /dev/null; then
        echo "❌ '$1' is not installed."

        case "$1" in
            llvm-cov)
                if [[ "$OSTYPE" == "darwin"* ]]; then
                    echo "🛠 Installing llvm-cov via Xcode..."
                    xcode-select --install
                else
                    echo "❌ Install llvm-cov manually!"
                    exit 1
                fi
                ;;
            curl)
                echo "🛠 Installing curl..."
                brew install curl || sudo apt-get install -y curl
                ;;
            bash)
                echo "🛠 Installing bash..."
                brew install bash || sudo apt-get install -y bash
                ;;
            *)
                echo "⚠️ Please install '$1' manually."
                exit 1
                ;;
        esac
    else
        echo "✅ '$1' is installed."
    fi
}

# Check & Install Required Tools
check_and_install swift
check_and_install curl
check_and_install bash
check_and_install llvm-cov

echo "✅ All required tools are installed!"
