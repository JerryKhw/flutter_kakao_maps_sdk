part of flutter_kakao_maps_sdk;

class PoiOptions {
  final bool clickable;
  final bool enabled;
  final KakaoMapPoiScale scale;

  const PoiOptions({
    this.clickable = true,
    this.enabled = true,
    this.scale = KakaoMapPoiScale.regular,
  });

  PoiOptions copyWith({
    bool? clickable,
    bool? enabled,
    KakaoMapPoiScale? scale,
  }) =>
      PoiOptions(
        clickable: clickable ?? this.clickable,
        enabled: enabled ?? this.enabled,
        scale: scale ?? this.scale,
      );
}

extension PoiOptionsExtension on PoiOptions {
  Map<String, dynamic> toMap() {
    return {
      "clickable": clickable,
      "enabled": enabled,
      "scale": scale.toInt(),
    };
  }
}
