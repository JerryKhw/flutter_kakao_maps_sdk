#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint flutter_kakao_maps_sdk.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'flutter_kakao_maps_sdk'
  s.version          = '0.1.0'
  s.summary          = 'KakaoMapsSDK for Flutter'
  s.description      = <<-DESC
  KakaoMapsSDK for Flutter
                       DESC
  s.homepage         = 'https://github.com/JerryKhw/flutter_kakao_maps_sdk'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'JERRY/JIHOON KIM' => 'hwjameshw@gmail.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.dependency 'KakaoMapsSDK','2.6.1'
  s.platform = :ios, '13.0'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'
end
