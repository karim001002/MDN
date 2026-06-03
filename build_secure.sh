#!/bin/bash

# This script demonstrates how to build the app with Flutter Obfuscation
# Run this from the root of the project

echo "Building Flutter APK with Obfuscation..."

# --obfuscate: Enables obfuscation
# --split-debug-info: Required for obfuscation to store symbol maps
flutter build apk --release --obfuscate --split-debug-info=build/app/outputs/symbols

echo "Build complete. Symbols are stored in build/app/outputs/symbols"
