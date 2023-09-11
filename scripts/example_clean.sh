cd example

fvm flutter precache --ios

fvm flutter clean
fvm flutter pub get

cd ios
pod install