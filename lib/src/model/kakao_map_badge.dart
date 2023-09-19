part of flutter_kakao_maps_sdk;

class KakaoMapBadge {
  /// Poi에서 특정 badge를 add/remove & show/hide 할 때 고유 식별자로 사용됩니다.
  final String badgeID;

  /// Badge에 사용할 이미지을 지정합니다.
  final String image;

  /// Badge 이미지의 height
  final double height;

  /// Badge 이미지의 width
  final double width;

  /// Poi 내부에서 Badge가 위치할 Offset을 결정합니다. KakaoMapPoint 타입을 사용합니다.
  final KakaoMapPoint offset;

  /// Badge간의 렌더링 우선순위. zOrder를 조절하여 특정 Badge간의 배치 순서를 지정할 수 있습니다.
  final int zOrder;

  const KakaoMapBadge({
    required this.badgeID,
    required this.image,
    required this.height,
    required this.width,
    required this.offset,
    required this.zOrder,
  });

  KakaoMapBadge copyWith({
    String? badgeID,
    String? image,
    double? height,
    double? width,
    KakaoMapPoint? offset,
    int? zOrder,
  }) =>
      KakaoMapBadge(
        badgeID: badgeID ?? this.badgeID,
        image: image ?? this.image,
        height: height ?? this.height,
        width: width ?? this.width,
        offset: offset ?? this.offset,
        zOrder: zOrder ?? this.zOrder,
      );
}

extension KakaoMapBadgeExtension on KakaoMapBadge {
  Map<String, dynamic> toMap() {
    return {
      "badgeID": badgeID,
      "image": image,
      "height": height,
      "width": width,
      "offset": offset.toMap(),
      "zOrder": zOrder,
    };
  }
}
