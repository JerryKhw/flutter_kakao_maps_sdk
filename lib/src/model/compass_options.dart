part of flutter_kakao_maps_sdk;

/// 나침반 설정
class CompassOptions {
  /// 활성화 여부. 지정하지 않을 경우 기본 값은 true.
  final bool enabled;

  /// 위치 및 좌표
  final KakaoMapPosition position;

  const CompassOptions({
    this.enabled = true,
    required this.position,
  });

  CompassOptions copyWith({
    bool? enabled,
    KakaoMapPosition? position,
  }) =>
      CompassOptions(
        enabled: enabled ?? this.enabled,
        position: position ?? this.position,
      );
}

extension CompassOptionsExtension on CompassOptions {
  Map<String, dynamic> toMap() {
    return {
      "enabled": enabled,
      "position": position.toMap(),
    };
  }
}
