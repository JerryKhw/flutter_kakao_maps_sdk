part of flutter_kakao_maps_sdk;

/// 애니메이션 타입
enum KakaoMapTransitionType {
  /// 애니메이션 효과를 지정하지 않습니다.
  none,

  /// 알파값을 조절해서 FadeIn/Out 효과를 줍니다.
  alpha,

  /// 심볼이 확대/축소되는 효과를 줄 수 있습니다.
  scale;

  int toInt() {
    switch (this) {
      case KakaoMapTransitionType.none:
        return 0;
      case KakaoMapTransitionType.alpha:
        return 1;
      case KakaoMapTransitionType.scale:
        return 2;
    }
  }
}
