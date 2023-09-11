part of flutter_kakao_maps_sdk;

class CompassOptions {
  final bool enabled;
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
