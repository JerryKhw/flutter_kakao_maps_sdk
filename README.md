# flutter_kakao_maps_sdk

KakaoMapsSDK for Flutter

⚠️ 현재 개발 진행중인 패키지입니다.

## Requirements

- Dart sdk: ">=3.1.0 <4.0.0"
- Flutter: ">=3.13.0"
- Android: 6.0(API level 23) 이상 ([참고](https://apis.map.kakao.com/android_v2/docs/getting-started/#sdk-%EC%9A%94%EA%B5%AC%EC%82%AC%EC%96%91))
- iOS: iOS13 이상 ([참고](https://apis.map.kakao.com/ios_v2/docs/getting-started/gettingstarted/#%EC%9A%94%EA%B5%AC%EC%82%AC%ED%95%AD))

## Installation

```
$ flutter pub add flutter_kakao_maps_sdk
```

## Configuration

### Android

1. 앱 등록

   먼저, [카카오 개발자 사이트](https://developers.kakao.com/) 에서 지도를 사용 할 앱 등록을 합니다. 자세한 안내는 [앱 등록](https://developers.kakao.com/docs/latest/ko/getting-started/app#create) 을 참고합니다.

2. 네이티브 앱 키 추가

   카카오 개발자 사이트를 통해 앱 등록을 하면 네이티브 앱 키(App Key) 가 발급됩니다. 발급받은 네이티브 앱 키를 `AndroidManifest.xml` 의 `<application>` 안에 아래와 같이 추가합니다. 앱 키 관련 자세한 안내는 [앱 키](https://developers.kakao.com/docs/latest/ko/getting-started/app#app-key) 를 참고합니다.

   ```xml
   <manifest xmlns:android="http://schemas.android.com/apk/res/android">
        <uses-permission android:name="android.permission.INTERNET" />

        ...

        <application
            ...
            <meta-data
                android:name="com.kakao.vectormap.APP_KEY"
                android:value="${APP_KEY}"/>   // 네이티브 앱 키 넣기
        </application>
   </manifest>
   ```

   phase 마다 다르게 앱 키를 넣어야 할 때는 android:name="com.kakao.vectormap.${phase}.APP_KEY" 이렇게 이름 설정을 합니다.

3. 키 해시 추가

   마지막으로, 플랫폼 등록 후 키 해시(Key Hash) 를 추가하면 인증을 위한 절차가 끝납니다. 이와 관련 자세한 안내는 [플랫폼 등록](https://developers.kakao.com/docs/latest/ko/getting-started/app#platform) 과 [키 해시](https://developers.kakao.com/docs/latest/ko/getting-started/app#platform-android) 부분을 참고합니다.

4. 프로가드 설정 (선택)

   앱 배포 시, [코드 축소, 난독화, 최적화](https://developer.android.com/build/shrink-code#shrink-code) 를 하는 경우, 카카오지도 SDK를 제외하고 진행하기 위하여 ProGuard 규칙 파일에 다음 코드를 추가합니다.

   ```
   -keep class com.kakao.vectormap.** { *; }
   -keep interface com.kakao.vectormap.**
   ```

### iOS

1. 앱 등록

   먼저, [카카오 개발자 사이트](https://developers.kakao.com/) 에서 지도를 사용 할 앱 등록을 합니다. 자세한 안내는 [앱 등록](https://developers.kakao.com/docs/latest/ko/getting-started/app#create) 을 참고합니다.

2. 네이티브 앱 키 추가

   카카오 개발자 사이트를 통해 앱 등록을 하면 네이티브 앱 키(App Key) 가 발급됩니다. `Info.plist` 에 아래와 같은 필드를 추가합니다.

   ```xml
   <key>KAKAO_APP_KEY</key>
   <string>${APP_KEY}</string>
   <key>KAKAO_PHASE</key>
   <string>${APP_PHASE}</string>
   ```

   KAKAO_APP_KEY : KakaoMapsSDK 사용을 위해서 필수로 입력해야 하는 필드입니다. 발급받은 네이티브 앱 키를 해당 필드에 등록합니다.

   KAKAO_PHASE : 테스트를 위해 phase별로 등록한 앱은 앱의 phase 정보를 해당 필드에 등록합니다. alpha, beta, sandbox중 하나를 해당 필드에 등록합니다. 예를 들어, https://sandbox-developers.kakao.com 의 경우 KAKAO_PHASE 필드에 sandbox 로 명시합니다. real인 경우, 공란으로 둡니다.

3. 프로모션 디스플레이 설정 (선택)

   ProMotion Display가 지원되는 기기에 대해서만 프로모션이 동작합니다. `Info.plist` 에 아래와 같은 필드를 추가합니다.

   ```xml
   <key>CADisableMinimumFrameDurationOnPhone</key>
   <true/>
   ```
