part of flutter_kakao_maps_sdk;

/// 축척 설정
class ScaleBarOptions {
  /// 활성화 여부. 지정하지 않을 경우 기본 값은 true.
  final bool enabled;

  /// 위치 및 좌표
  final KakaoMapPosition position;

  /// 자동 비활성화 여부. 지정하지 않을 경우 기본 값은 true.
  final bool autoDisabled;

  /// 지도에 표시되었다가 일정 시간 후 사라질 때의 애니메이션 설정
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
