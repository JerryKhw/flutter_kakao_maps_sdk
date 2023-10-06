part of flutter_kakao_maps_sdk;

class KakaoMapLabelLayer {
  final String id;
  final MethodChannel _viewMethodChannel;

  const KakaoMapLabelLayer(this.id, this._viewMethodChannel);

  /// Poi 추가
  ///
  /// [styleID] style의 고유 ID
  /// [at] 생성 위치
  Future<KakaoMapPoi> addPoi({
    required String styleID,
    required KakaoMapPoint at,
  }) async {
    final poiID = await _viewMethodChannel.invokeMethod(
      "addPoi",
      {
        "layerID": id,
        "styleID": styleID,
        "at": at.toMap(),
      },
    );

    return KakaoMapPoi(id, poiID, _viewMethodChannel);
  }

  /// Poi 삭제
  ///
  /// [poi] poi 객체
  Future<void> removePoi({
    required KakaoMapPoi poi,
  }) async {
    await _viewMethodChannel.invokeMethod(
      "removePoi",
      {
        "layerID": id,
        "poiID": poi.id,
      },
    );
  }
}
