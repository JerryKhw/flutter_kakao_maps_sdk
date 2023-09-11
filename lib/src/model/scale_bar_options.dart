part of flutter_kakao_maps_sdk;

class ScaleBarOptions {
  final bool enabled;
  final KakaoMapPosition position;
  final bool autoDisabled;
  final FadeInOutOptions fadeInOutOptions;

  const ScaleBarOptions({
    this.enabled = true,
    required this.position,
    this.autoDisabled = true,
    this.fadeInOutOptions = const FadeInOutOptions(
      fadeInTime: 300,
      fadeOutTime: 300,
      retentionTime: 3000,
    ),
  });

  ScaleBarOptions copyWith({
    bool? enabled,
    KakaoMapPosition? position,
    bool? autoDisabled,
    FadeInOutOptions? fadeInOutOptions,
  }) =>
      ScaleBarOptions(
        enabled: enabled ?? this.enabled,
        position: position ?? this.position,
        autoDisabled: autoDisabled ?? this.autoDisabled,
        fadeInOutOptions: fadeInOutOptions ?? this.fadeInOutOptions,
      );
}

extension ScaleBarOptionsExtension on ScaleBarOptions {
  Map<String, dynamic> toMap() {
    return {
      "enabled": enabled,
      "position": position.toMap(),
      "autoDisabled": autoDisabled,
      "fadeInOutOptions": fadeInOutOptions.toMap(),
    };
  }
}
