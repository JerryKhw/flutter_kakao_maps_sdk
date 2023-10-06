part of flutter_kakao_maps_sdk;

class KakaoMapController {
  final int _id;
  final void Function(KakaoMapController controller)? _onMapReady;

  late final MethodChannel _viewMethodChannel;

  KakaoMapController(this._id, this._onMapReady) {
    _viewMethodChannel = MethodChannel(
        _createViewMethodChannelName(_id), const JSONMethodCodec());

    _viewMethodChannel.setMethodCallHandler((call) async {
      switch (call.method) {
        case "onMapReady":
          if (_onMapReady != null) {
            _onMapReady!(this);
          }
          break;
        default:
          break;
      }
    });
  }

  void dispose() {
    _viewMethodChannel.invokeMethod("dispose");
  }

  /// PoiIconStyle 추가
  ///
  /// [styleID] style 아이디
  /// [styles] 스타일
  Future<void> addPoiIconStyle({
    required String styleID,
    required List<KakaoMapPoiIconStyle> styles,
  }) async {
    await _viewMethodChannel.invokeMethod(
      "addPoiIconStyle",
      {
        "styleID": styleID,
        "styles": styles.map((e) => e.toMap()).toList(),
      },
    );
  }

  /// LabelLayer 추가
  ///
  /// [layerID] layer의 고유 ID. ID는 중복으로 사용할 수 없습니다.
  /// [competitionType] 다른 Poi와 경쟁하는 방법을 결정합니다. 기본 룰은 타입 순서에 따라 순서가 빠를수록 우선순위가 높습니다.
  /// [competitionUnit] 경쟁하는 단위를 결정합니다.
  /// [orderType] competitionType이 same일 때 경쟁하는 기준이 됩니다.
  /// [zOrder] 레이어의 렌더링 우선순위를 정의합니다. 이 때 렌더링 우선순위는 레이어의 내부가 아닌 여러개의 LabelLayer간의 렌더링 우선순위를 의미합니다. 즉, zOrder가 0인 LabelLayer의 Poi는 zOrder가 1인 LabelLayer에 속한 Poi보다 뒤에 그려집니다.
  Future<KakaoMapLabelLayer> addLabelLayer({
    required String layerID,
    KakaoMapCompetitionType competitionType = KakaoMapCompetitionType.none,
    KakaoMapCompetitionUnit competitionUnit = KakaoMapCompetitionUnit.poi,
    KakaoMapOrderType orderType = KakaoMapOrderType.rank,
    int zOrder = 0,
  }) async {
    await _viewMethodChannel.invokeMethod(
      "addLabelLayer",
      {
        "layerID": layerID,
        "competitionType": competitionType.toInt(),
        "competitionUnit": competitionUnit.toInt(),
        "orderType": orderType.toInt(),
        "zOrder": zOrder,
      },
    );

    return KakaoMapLabelLayer(layerID, _viewMethodChannel);
  }

  /// 카메라 이동
  ///
  /// [point] 카메라가 바라보는 지점의 KakaoMapPoint
  /// [height] 카메라 zoomLvel
  /// [rotation] 카메라 회전각 (radian. 정북기준 시계방향)
  /// [tilt] 카메라의 기울임각 (radian. 수직방향 기준)
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

  /// 카메라 애니메이션 이동
  ///
  /// [point] 카메라가 바라보는 지점의 KakaoMapPoint
  /// [height] 카메라 zoomLvel
  /// [rotation] 카메라 회전각 (radian. 정북기준 시계방향)
  /// [tilt] 카메라의 기울임각 (radian. 수직방향 기준)
  /// [cameraAnimationOptions] 카메라 애니메이션 옵션
  Future<void> animateCamera({
    KakaoMapPoint? target,
    int? zoomLevel,
    double? rotation,
    double? tilt,
    CameraAnimationOptions cameraAnimationOptions =
        const CameraAnimationOptions(),
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

  /// 카메라 절대값 기준 이동
  ///
  /// [point] 카메라가 바라보는 위치 변화량. KakaoMapPoint 기준이므로 경위도좌표계의 변화량.
  /// [height] 카메라의 높이 변화량
  /// [rotation] 카메라의 회전각 변화량
  /// [tilt] 메라의 기울임각 변화량
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

  /// 카메라 절대값 기준 애니메이션 이동
  ///
  /// [point] 카메라가 바라보는 위치 변화량. KakaoMapPoint 기준이므로 경위도좌표계의 변화량.
  /// [height] 카메라의 높이 변화량
  /// [rotation] 카메라의 회전각 변화량
  /// [tilt] 메라의 기울임각 변화량
  /// [cameraAnimationOptions] 카메라 애니메이션 옵션
  Future<void> animateCameraTransform({
    KakaoMapPoint point = const KakaoMapPoint(longitude: 0, latitude: 0),
    double height = 0,
    double rotation = 0,
    double tilt = 0,
    CameraAnimationOptions cameraAnimationOptions =
        const CameraAnimationOptions(),
  }) async {
    await _viewMethodChannel.invokeMethod("animateCameraTransform", {
      "point": point.toMap(),
      "height": height,
      "rotation": rotation,
      "tilt": tilt,
      "cameraAnimationOptions": cameraAnimationOptions.toMap(),
    });
  }

  /// ViewInfo 설정
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

  /// 오버레이 활성화
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

  /// 오버레이 비활성화
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

  /// 활성화 설정
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

  /// 빌딩 높이 설정
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

  /// 지도 여백 조회
  Future<EdgeInsets> getPadding() async {
    final result = await _viewMethodChannel.invokeMethod("getPadding")
        as Map<String, dynamic>;

    return EdgeInsets.fromLTRB(
      result["left"].toDouble(),
      result["top"].toDouble(),
      result["right"].toDouble(),
      result["bottom"].toDouble(),
    );
  }

  /// 지도 여백 설정
  Future<void> setPadding({
    required EdgeInsets padding,
  }) async {
    await _viewMethodChannel.invokeMethod(
      "setPadding",
      padding.toMap(),
    );
  }

  /// 로고 위치 및 좌표 설정
  Future<void> setLogoPosition({
    required KakaoMapPosition logoPosition,
  }) async {
    await _viewMethodChannel.invokeMethod(
      "setLogoPosition",
      logoPosition.toMap(),
    );
  }

  /// Poi 옵션 설정
  Future<void> setPoiOptions({
    required KakaoMapPoiOptions poiOptions,
  }) async {
    await _viewMethodChannel.invokeMethod(
      "setPoiOptions",
      poiOptions.toMap(),
    );
  }

  /// 나침반 옵션 설정
  Future<void> setCompassOptions({
    required CompassOptions compassOptions,
  }) async {
    await _viewMethodChannel.invokeMethod(
      "setCompassOptions",
      compassOptions.toMap(),
    );
  }

  /// 축척 옵션 설정
  Future<void> setScaleBarOptions({
    required ScaleBarOptions scaleBarOptions,
  }) async {
    await _viewMethodChannel.invokeMethod(
      "setScaleBarOptions",
      scaleBarOptions.toMap(),
    );
  }

  /// 지도 리프레쉬 (iOS 에서만 동작)
  Future<void> refresh() async {
    if (Platform.isIOS) {
      await _viewMethodChannel.invokeMethod("refresh");
    }
  }
}
