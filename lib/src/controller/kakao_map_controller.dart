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

  // Camera
  Future<void> moveCamera({
    KakaoMapPoint? target,
    int? zoomLevel,
    double? rotation,
    double? tilt,
  }) async {
    Map<String, dynamic> map = {};

    if (target != null) {
      map["target"] = target.toMap();
    }

    if (zoomLevel != null) {
      map["zoomLevel"] = zoomLevel;
    }

    if (rotation != null) {
      map["rotation"] = rotation;
    }

    if (tilt != null) {
      map["tilt"] = tilt;
    }

    await _viewMethodChannel.invokeMethod("moveCamera", map);
  }

  Future<void> animateCamera({
    KakaoMapPoint? target,
    int? zoomLevel,
    double? rotation,
    double? tilt,
    CameraAnimationOptions cameraAnimationOptions = const CameraAnimationOptions(),
  }) async {
    Map<String, dynamic> map = {
      "cameraAnimationOptions": cameraAnimationOptions.toMap(),
    };

    if (target != null) {
      map["target"] = target.toMap();
    }

    if (zoomLevel != null) {
      map["zoomLevel"] = zoomLevel;
    }

    if (rotation != null) {
      map["rotation"] = rotation;
    }

    if (tilt != null) {
      map["tilt"] = tilt;
    }

    await _viewMethodChannel.invokeMethod("animateCamera", map);
  }

  Future<void> moveCameraTransform({
    KakaoMapPoint point = const KakaoMapPoint(longitude: 0, latitude: 0),
    double height = 0,
    double rotation = 0,
    double tilt = 0,
  }) async {
    await _viewMethodChannel.invokeMethod("moveCameraTransform", {
      "point": point.toMap(),
      "height": height,
      "rotation": rotation,
      "tilt": tilt,
    });
  }

  Future<void> animateCameraTransform({
    KakaoMapPoint point = const KakaoMapPoint(longitude: 0, latitude: 0),
    double height = 0,
    double rotation = 0,
    double tilt = 0,
    CameraAnimationOptions cameraAnimationOptions = const CameraAnimationOptions(),
  }) async {
    await _viewMethodChannel.invokeMethod("animateCameraTransform", {
      "point": point.toMap(),
      "height": height,
      "rotation": rotation,
      "tilt": tilt,
      "cameraAnimationOptions": cameraAnimationOptions.toMap(),
    });
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
