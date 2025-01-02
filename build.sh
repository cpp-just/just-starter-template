#!/bin/bash

BUILD_TYPE=${1:-Debug}

if [[ "$BUILD_TYPE" != "Debug" && "$BUILD_TYPE" != "Release" && "$BUILD_TYPE" != "Dist" ]]; then
    echo "Invalid build type: $BUILD_TYPE"
    echo "Usage: build.sh [Debug/Release/Dist]"
    echo "If no argument is provided, Debug is used"
    exit 1
fi

# Build it :D
cd .just || exit 1
cmake -G Ninja -B build -DCMAKE_BUILD_TYPE="$BUILD_TYPE" -DCMAKE_EXPORT_COMPILE_COMMANDS=1 .
cd build || exit 1
ninja
cd ../..
