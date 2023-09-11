part of flutter_kakao_maps_sdk;

enum KakaoMapPoiScale {
  small,
  regular,
  large,
  xLarge;

  int toInt() {
    switch (this) {
      case KakaoMapPoiScale.small:
        return 0;
      case KakaoMapPoiScale.regular:
        return 1;
      case KakaoMapPoiScale.large:
        return 2;
      case KakaoMapPoiScale.xLarge:
        return 3;
    }
  }
}
