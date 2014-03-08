#!/bin/sh

#  Script.sh
#  TreePop
#
#  Created by Nick Martin on 3/7/14.
#  Copyright (c) 2014 org.monkeyman.com. All rights reserved.



XCODEBUILD_PATH=/Applications/Xcode.app/Contents/Developer/usr/bin
XCODEBUILD=$XCODEBUILD_PATH/xcodebuild
PROJECTROOT="/Users/Nick/ios/cocoalibspotify/iOS Library"
PROJECT="$PROJECTROOT/CocoaLibSpotify iOS Library.xcodeproj"
TARGET=CocoaLibSpotify


$XCODEBUILD -project $PROJECT -target $TARGET -sdk "iphonesimulator" -configuration "Release" clean build

$XCODEBUILD -project $PROJECT -target $TARGET -sdk "iphoneos" -configuration "Release" clean build

[ -d build/Release-combined ] || mkdir build/Release-combined 
lipo -create -output "build/Release-combined/libUniversalCocoaSpotify.a" "build/Release-iphoneos/libCocoaSpotify.a" "build/Release-iphonesimulator/libCocoaSpotify.a"
