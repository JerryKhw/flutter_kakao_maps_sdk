part of flutter_kakao_maps_sdk;

class KakaoMapPoiIconStyle {
  /// Poi에 사용할 심볼을 지정합니다. 실제 Poi의 영역으로 인식되어 탭 이벤트나 경쟁을 처리하는 범위로 사용됩니다.
  final String symbol;

  /// Poi 심볼의 height
  final double height;

  /// Poi 심볼의 width
  final double width;

  /// Poi가 그려지는 지점을 지정합니다.
  final KakaoMapPoint anchorPoint;

  /// Poi에 추가하는 일종의 부가적인 데코레이션입니다.
  final List<KakaoMapBadge>? badges;

  /// Poi 심볼이 나타날 때 / 사라질 때 간단한 애니메이션 타입을 지정할 수 있습니다.
  final KakaoMapTransitionType transitionType;

  /// 지도에 나타나기 시작하는 zoomLevel 값.
  final int level;

  const KakaoMapPoiIconStyle({
    required this.symbol,
    required this.height,
    required this.width,
    required this.anchorPoint,
    this.badges,
    this.transitionType = KakaoMapTransitionType.none,
    this.level = 0,
  });

  KakaoMapPoiIconStyle copyWith({
    String? symbol,
    double? height,
    double? width,
    KakaoMapPoint? anchorPoint,
    List<KakaoMapBadge>? badges,
    KakaoMapTransitionType? transitionType,
    int? level,
  }) =>
      KakaoMapPoiIconStyle(
        symbol: symbol ?? this.symbol,
        height: height ?? this.height,
        width: width ?? this.width,
        anchorPoint: anchorPoint ?? this.anchorPoint,
        badges: badges ?? this.badges,
        transitionType: transitionType ?? this.transitionType,
        level: level ?? this.level,
      );
}

extension KakaoMapPoiIconStyleExtension on KakaoMapPoiIconStyle {
  Map<String, dynamic> toMap() {
    return {
      "symbol": symbol,
      "height": height,
      "width": width,
      "anchorPoint": anchorPoint.toMap(),
      "badges": badges?.map((e) => e.toMap()).toList() ?? [],
      "transitionType": transitionType.toInt(),
      "level": level,
    };
  }
}
