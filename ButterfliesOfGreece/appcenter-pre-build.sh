#!/usr/bin/env bash
CUR_COCOAPODS_VER=`sed -n -e 's/^COCOAPODS: \([0-9.]*\)/\1/p' ios/Podfile.lock`
ENV_COCOAPODS_VER=`pod --version`

echo "Uninstalling all CocoaPods versions"
    sudo gem uninstall cocoapods --all --executables
    echo "Installing CocoaPods version $CUR_COCOAPODS_VER"
    sudo gem install cocoapods -v $CUR_COCOAPODS_VER

cd $APPCENTER_SOURCE_DIRECTORY
pod install