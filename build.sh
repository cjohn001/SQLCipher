#!/bin/sh

echo "Set exit on simple errors"
set -e

BUILD_DIR=$(PWD)/build
rm -rf $BUILD_DIR

echo "Build for iphonesimulator"
xcodebuild \
    -project SQLCipher.xcodeproj \
    -scheme SQLCipher \
    -configuration Release \
    -destination "generic/platform=iOS Simulator" \
    clean build \
    BUILD_DIR=$BUILD_DIR \
    SKIP_INSTALL=NO \
    BUILD_LIBRARY_FOR_DISTRIBUTION=YES \
    -quiet

echo "Build for iphoneos"
xcodebuild \
    -project SQLCipher.xcodeproj \
    -scheme SQLCipher \
    -destination "generic/platform=iOS" \
    -configuration Release \
    clean build \
    BUILD_DIR=$BUILD_DIR \
    CODE_SIGN_IDENTITY="" \
    CODE_SIGNING_REQUIRED=NO \
    SKIP_INSTALL=NO \
    BUILD_LIBRARY_FOR_DISTRIBUTION=YES \
    -quiet

# Only available with Xcode >= 15.2
echo "Build for visionOS Simulator"
xcodebuild \
    -project SQLCipher.xcodeproj \
    -scheme SQLCipher \
    -configuration Release \
    -destination "generic/platform=visionOS Simulator" \
    clean build \
    BUILD_DIR=$BUILD_DIR \
    SKIP_INSTALL=NO \
    BUILD_LIBRARY_FOR_DISTRIBUTION=YES \
    -quiet

echo "Build for visionOS"
xcodebuild \
    -project SQLCipher.xcodeproj \
    -scheme SQLCipher \
    -configuration Release \
    -destination "generic/platform=visionOS" \
    clean build \
    BUILD_DIR=$BUILD_DIR \
    SKIP_INSTALL=NO \
    BUILD_LIBRARY_FOR_DISTRIBUTION=YES \
    -quiet

echo "Creating XCFramework"
BASE=$BUILD_DIR/Release
xcodebuild \
    -create-xcframework \
    -framework $BASE-iphoneos/SQLCipher.framework \
    -debug-symbols $BASE-iphoneos/SQLCipher.framework.dSYM \
    -framework $BASE-iphonesimulator/SQLCipher.framework \
    -debug-symbols $BASE-iphonesimulator/SQLCipher.framework.dSYM \
    -framework     $BASE-xrsimulator/SQLCipher.framework \
    -debug-symbols $BASE-xrsimulator/SQLCipher.framework.dSYM \
    -framework     $BASE-xros/SQLCipher.framework \
    -debug-symbols $BASE-xros/SQLCipher.framework.dSYM \
    -output $BUILD_DIR/SQLCipher.xcframework
