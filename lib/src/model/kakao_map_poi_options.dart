part of flutter_kakao_maps_sdk;

/// Poi 설정
class KakaoMapPoiOptions {
  /// 클릭 활성화 여부. 지정하지 않을 경우 기본 값은 true.
  final bool clickable;

  /// 활성화 여부. 지정하지 않을 경우 기본 값은 true.
  final bool enabled;

  /// small부터 xLarge까지 설정 가능하며, Poi의 글자 크기 및 심볼 크기를 조절할 수 있습니다.
  final KakaoMapPoiScale scale;

  const KakaoMapPoiOptions({
    this.clickable = true,
    this.enabled = true,
    this.scale = KakaoMapPoiScale.regular,
  });

  KakaoMapPoiOptions copyWith({
    bool? clickable,
    bool? enabled,
    KakaoMapPoiScale? scale,
  }) =>
      KakaoMapPoiOptions(
        clickable: clickable ?? this.clickable,
        enabled: enabled ?? this.enabled,
        scale: scale ?? this.scale,
      );
}

extension KakaoMapPoiOptionsExtension on KakaoMapPoiOptions {
  Map<String, dynamic> toMap() {
    return {
      "clickable": clickable,
      "enabled": enabled,
      "scale": scale.toInt(),
    };
  }
}
