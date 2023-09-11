part of flutter_kakao_maps_sdk;

enum KakaoMapViewInfo {
  map,
  skyview,
  cadastralMap;

  @override
  String toString() {
    switch (this) {
      case KakaoMapViewInfo.map:
        return "map";
      case KakaoMapViewInfo.skyview:
        return "skyview";
      case KakaoMapViewInfo.cadastralMap:
        return "cadastral_map";
    }
  }
}
