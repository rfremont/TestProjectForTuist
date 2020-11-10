#!/bin/bash
if test "$#" -ne 1; then
 echo "Le nombre d'arguments est invalide"
 exit
fi

if [ ! -d "$1" ]
then
    echo "Directory $1 DOES NOT exists. - Exit"
    exit
fi



echo "Tuist clean"
tuist clean

echo "Remove copied podfile"
pod deintegrate
rm -f ./Podfile

echo "Remove workspace"
rm -rf *.xcworkspace
echo "Remove project file"
rm -rf *.xcodeproj


echo "Copy podfile"
cp ./$1/Podfile ./Podfile

echo "Copy env files"
rm -rf .env.*
cp ./$1/.env.default ./.env.default

echo "Kill current xcode"
#s aux | grep /Applications/Xcode.app/Contents/MacOS/Xcode | awk '{ print $2 }' | xargs -L 1 kill -9

echo "Generate swiftlint configuration file"
tuist scaffold SwiftlintConfigurationFile --folder $1

echo "Tuist up"
tuist up

echo "Tuist generate"
TUIST_APP_FOLDER=$1 tuist generate --open
