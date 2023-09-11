part of flutter_kakao_maps_sdk;

class KakaoMapController {
  final int _id;

  late final MethodChannel _viewMethodChannel;

  KakaoMapController(this._id) {
    _viewMethodChannel = MethodChannel(_createViewMethodChannelName(_id), const JSONMethodCodec());
  }

  void dispose() {
    _viewMethodChannel.invokeMethod("dispose");
  }

  // ViewInfo
  Future<void> setViewInfo({
    String appName = "openmap",
    required KakaoMapViewInfo viewInfoName,
  }) async {
    await _viewMethodChannel.invokeMethod(
      "setViewInfo",
      {
        "appName": appName,
        "viewInfoName": viewInfoName.toString(),
      },
    );
  }

  // Overlay
  Future<void> showOverlay({
    required KakaoMapOverlay overlay,
  }) async {
    await _viewMethodChannel.invokeMethod(
      "showOverlay",
      {
        "overlay": overlay.toString(),
      },
    );
  }

  Future<void> hideOverlay({
    required KakaoMapOverlay overlay,
  }) async {
    await _viewMethodChannel.invokeMethod(
      "hideOverlay",
      {
        "overlay": overlay.toString(),
      },
    );
  }

  // Enabled
  Future<void> setEnabled({
    required bool enabled,
  }) async {
    await _viewMethodChannel.invokeMethod(
      "setEnabled",
      {
        "enabled": enabled,
      },
    );
  }

  // BuildingScale
  Future<void> setBuildingScale({
    required double buildingScale,
  }) async {
    await _viewMethodChannel.invokeMethod(
      "setBuildingScale",
      {
        "buildingScale": buildingScale,
      },
    );
  }

  // Padding
  Future<EdgeInsets> getPadding() async {
    final result = await _viewMethodChannel.invokeMethod("getPadding") as Map<String, dynamic>;

    return EdgeInsets.fromLTRB(
      result["left"].toDouble(),
      result["top"].toDouble(),
      result["right"].toDouble(),
      result["bottom"].toDouble(),
    );
  }

  Future<void> setPadding({
    required EdgeInsets padding,
  }) async {
    await _viewMethodChannel.invokeMethod(
      "setPadding",
      padding.toMap(),
    );
  }

  // LogoPosition
  Future<void> setLogoPosition({
    required KakaoMapPosition logoPosition,
  }) async {
    await _viewMethodChannel.invokeMethod(
      "setLogoPosition",
      logoPosition.toMap(),
    );
  }

  // PoiOptions
  Future<void> setPoiOptions({
    required PoiOptions poiOptions,
  }) async {
    await _viewMethodChannel.invokeMethod(
      "setPoiOptions",
      poiOptions.toMap(),
    );
  }

  // CompassOptions
  Future<void> setCompassOptions({
    required CompassOptions compassOptions,
  }) async {
    await _viewMethodChannel.invokeMethod(
      "setCompassOptions",
      compassOptions.toMap(),
    );
  }

  // ScaleBarOptions
  Future<void> setScaleBarOptions({
    required ScaleBarOptions scaleBarOptions,
  }) async {
    await _viewMethodChannel.invokeMethod(
      "setScaleBarOptions",
      scaleBarOptions.toMap(),
    );
  }

  // Refresh (Only iOS)
  Future<void> refresh() async {
    await _viewMethodChannel.invokeMethod("refresh");
  }
}
