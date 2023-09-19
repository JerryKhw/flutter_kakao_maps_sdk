part of flutter_kakao_maps_sdk;

class KakaoMapsSDK {
  static final KakaoMapsSDK instance = KakaoMapsSDK();

  bool _isInitialized = false;

  /// 디버그 활성화 여부
  bool debug = false;

  void initialize() {
    if (_isInitialized) return;

    const EventChannel(_logEventChannelName)
        .receiveBroadcastStream()
        .listen((event) {
      if (debug) {
        debugPrint(event?.toString());
      }
    });

    _isInitialized = true;
  }
}
