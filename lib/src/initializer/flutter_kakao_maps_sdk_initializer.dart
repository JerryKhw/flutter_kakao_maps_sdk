part of flutter_kakao_maps_sdk;

class KakaoMapsSDK {
  static final KakaoMapsSDK instance = KakaoMapsSDK();

  bool _isInitialized = false;
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
