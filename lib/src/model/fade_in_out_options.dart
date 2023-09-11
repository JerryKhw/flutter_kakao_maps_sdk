part of flutter_kakao_maps_sdk;

class FadeInOutOptions {
  final int fadeInTime;
  final int fadeOutTime;
  final int retentionTime;

  const FadeInOutOptions({
    required this.fadeInTime,
    required this.fadeOutTime,
    required this.retentionTime,
  });

  FadeInOutOptions copyWith({
    int? fadeInTime,
    int? fadeOutTime,
    int? retentionTime,
  }) =>
      FadeInOutOptions(
        fadeInTime: fadeInTime ?? this.fadeInTime,
        fadeOutTime: fadeOutTime ?? this.fadeOutTime,
        retentionTime: retentionTime ?? this.retentionTime,
      );
}

extension FadeInOutOptionsExtension on FadeInOutOptions {
  Map<String, dynamic> toMap() {
    return {
      "fadeInTime": fadeInTime,
      "fadeOutTime": fadeOutTime,
      "retentionTime": retentionTime,
    };
  }
}
