part of flutter_kakao_maps_sdk;

enum KakaoMapOverlay {
  hillshading,
  roadviewLine,
  bicycleRoad,
  hybrid,
  trafficInfo;

  @override
  String toString() {
    switch (this) {
      case KakaoMapOverlay.hillshading:
        return "hill_shading";
      case KakaoMapOverlay.roadviewLine:
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
