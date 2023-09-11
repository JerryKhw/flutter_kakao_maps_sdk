part of flutter_kakao_maps_sdk;

class KakaoMapPosition {
  final KakaoMapAlignment alignment;
  final double x;
  final double y;

  const KakaoMapPosition({
    required this.alignment,
    required this.x,
    required this.y,
  });

  KakaoMapPosition copyWith({
    KakaoMapAlignment? alignment,
    double? x,
    double? y,
  }) =>
      KakaoMapPosition(
        alignment: alignment ?? this.alignment,
        x: x ?? this.x,
        y: y ?? this.y,
      );
}

extension KakaoMapPositionExtension on KakaoMapPosition {
  Map<String, dynamic> toMap() {
    return {
      "alignment": alignment.toString(),
      "x": x,
      "y": y,
    };
  }
}
