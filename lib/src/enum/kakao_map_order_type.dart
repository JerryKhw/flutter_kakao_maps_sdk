part of flutter_kakao_maps_sdk;

/// 우선순위가 같은 라벨끼리 경쟁하는 경우, 경쟁을 처리하는 방법
enum KakaoMapOrderType {
  /// Poi 별로 가지고 있는 rank 속성값이 높을수록 경쟁에서 우선순위를 갖는다.
  rank,

  /// 화면 좌하단과 거리가 가까울수록 높은 우선순위를 갖는다.
  closerFromLeftBottom;

  int toInt() {
    switch (this) {
      case KakaoMapOrderType.rank:
        return 0;
      case KakaoMapOrderType.closerFromLeftBottom:
        return 1;
    }
  }
}
