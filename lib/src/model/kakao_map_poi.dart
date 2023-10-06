part of flutter_kakao_maps_sdk;

class KakaoMapPoi {
  final String id;
  final String layerID;
  final MethodChannel _viewMethodChannel;

  const KakaoMapPoi(this.layerID, this.id, this._viewMethodChannel);

  /// PoiIconStyle 변경
  ///
  /// [styleID] style 아이디
  Future<void> changePoiIconStyle({
    required String styleID,
  }) async {
    await _viewMethodChannel.invokeMethod(
      "changePoiIconStyle",
      {
        "layerID": layerID,
        "poiID": id,
        "styleID": styleID,
      },
    );
  }
}
