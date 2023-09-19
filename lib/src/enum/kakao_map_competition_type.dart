part of flutter_kakao_maps_sdk;

/// Poi의 경쟁 타입
enum KakaoMapCompetitionType {
  /// 경쟁하지 않고 겹쳐서 그린다.
  none,

  /// Upper, Same, Lower 모든 속성을 가지고 경쟁한다.
  all,

  /// 자신보다 우선순위가 높은 Layer와 경쟁한다. 우선순위가 높은 Layer에 우선권이 있으므로, 우선순위가 높은 Layer와의 경쟁할 경우 무조건 지게 되므로 표시되지 않는다.
  upper,

  /// Upper속성과 Lower속성을 가지고 경쟁한다.
  upperLower,

  /// Upper속성과 Same속성을 가지고 경쟁한다.
  upperSame,

  /// 같은 우선순위를 가진 Layer에 있는 Poi와 경쟁한다. 경쟁 룰은 OrderingType에 따라 결정된다.
  same,

  /// Same과 Lower속성을 가지고 경쟁한다.
  sameLower,

  /// 낮은 우선순위를 가진 Layer와 경쟁한다. 상위 Layer에 우선권이 있으므로, 표출된 위치에 "upper"속성이 들어간 하위 Layer의 Poi는 그려지지 않는다.
  lower;

  int toInt() {
    switch (this) {
      case KakaoMapCompetitionType.none:
        return 0;
      case KakaoMapCompetitionType.all:
        return 1;
      case KakaoMapCompetitionType.upper:
        return 2;
      case KakaoMapCompetitionType.upperLower:
        return 3;
      case KakaoMapCompetitionType.upperSame:
        return 4;
      case KakaoMapCompetitionType.same:
        return 5;
      case KakaoMapCompetitionType.sameLower:
        return 6;
      case KakaoMapCompetitionType.lower:
        return 7;
    }
  }
}
