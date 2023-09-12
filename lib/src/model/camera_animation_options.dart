part of flutter_kakao_maps_sdk;

class CameraAnimationOptions {
  final bool autoElevation;
  final bool consecutive;
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
