part of flutter_kakao_maps_sdk;

/// Overlay 종류
enum KakaoMapOverlay {
  /// Hill Shading
  hillShading,

  /// 로드뷰 라인
  roadViewLine,

  /// 자전거도로
  bicycleRoad,

  /// 하이브리드
  hybrid,

  /// 교통정보
  trafficInfo;

  @override
  String toString() {
    switch (this) {
      case KakaoMapOverlay.hillShading:
        return "hill_shading";
      case KakaoMapOverlay.roadViewLine:
        return "roadview_line";
      case KakaoMapOverlay.bicycleRoad:
        return "bicycle_road";
      case KakaoMapOverlay.hybrid:
        return "hybrid";
      case KakaoMapOverlay.trafficInfo:
        return "traffic_info";
    }
  }
}
