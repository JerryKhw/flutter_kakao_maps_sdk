part of flutter_kakao_maps_sdk;

/// Poi 경챙 처리 단위
enum KakaoMapCompetitionUnit {
  /// Poi의 icon과 Text모두 경쟁에서 통과해야 그려진다.
  poi,

  /// Poi의 icon만 경쟁 기준이 된다. 단, text가 경쟁에서 진 경우 text는 표출되지 않는다.
  symbolFirst;

  int toInt() {
    switch (this) {
      case KakaoMapCompetitionUnit.poi:
        return 0;
      case KakaoMapCompetitionUnit.symbolFirst:
        return 1;
    }
  }
}
