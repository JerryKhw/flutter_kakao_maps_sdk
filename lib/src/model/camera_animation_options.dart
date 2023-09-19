part of flutter_kakao_maps_sdk;

/// 카메라 애니메이션 옵션
class CameraAnimationOptions {
  /// 장거리 이동시 카메라 높낮이를 올려 이동을 잘 보이도록 하는 애니메이션.
  final bool autoElevation;

  /// animateCamera를 연속적으로 호출하는 경우, 각 애니메이션을 이어서 연속적으로 수행한다.
  final bool consecutive;

  /// 애니메이션 동작시간(ms).
  final int durationInMillis;

  const CameraAnimationOptions({
    this.autoElevation = false,
    this.consecutive = true,
    this.durationInMillis = 2000,
  });

  CameraAnimationOptions copyWith({
    bool? autoElevation,
    bool? consecutive,
    int? durationInMillis,
  }) =>
      CameraAnimationOptions(
        autoElevation: autoElevation ?? this.autoElevation,
        consecutive: consecutive ?? this.consecutive,
        durationInMillis: durationInMillis ?? this.durationInMillis,
      );
}

extension CameraAnimationOptionsExtension on CameraAnimationOptions {
  Map<String, dynamic> toMap() {
    return {
      "autoElevation": autoElevation,
      "consecutive": consecutive,
      "durationInMillis": durationInMillis,
    };
  }
}
