part of flutter_kakao_maps_sdk;

enum KakaoMapAlignment {
  topLeft,
  topCenter,
  topRight,
  centerLeft,
  center,
  centerRight,
  bottomLeft,
  bottomCenter,
  bottomRight;

  @override
  String toString() {
    switch (this) {
      case KakaoMapAlignment.topLeft:
        return "topLeft";
      case KakaoMapAlignment.topCenter:
        return "topCenter";
      case KakaoMapAlignment.topRight:
        return "topRight";
      case KakaoMapAlignment.centerLeft:
        return "centerLeft";
      case KakaoMapAlignment.center:
        return "center";
      case KakaoMapAlignment.centerRight:
        return "centerRight";
      case KakaoMapAlignment.bottomLeft:
        return "bottomLeft";
      case KakaoMapAlignment.bottomCenter:
        return "bottomCenter";
      case KakaoMapAlignment.bottomRight:
        return "bottomRight";
    }
  }
}
