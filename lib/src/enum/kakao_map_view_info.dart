part of flutter_kakao_maps_sdk;

/// ViewInfo 종류
enum KakaoMapViewInfo {
  /// 2d지도
  map,

  /// 스카이뷰
  skyview,

  /// 지적편집도
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
