part of flutter_kakao_maps_sdk;

/// 지도 설정
class KakaoMapOptions {
  final String appName;

  /// 추가할 KakaoMap의 name. 이미 추가한 view중에 중복된 이름이 있으면 추가되지 않는다.
  final String viewName;

  /// 표시할 viewInfo의 이름. map / skyview 등이 있다. 지정하지 않을 경우 type에 따른 기본값으로 지정된다.
  final KakaoMapViewInfo viewInfoName;

  /// 초기 overlay
  final KakaoMapOverlay? overlay;

  /// 한국어, 영어로 언어를 변경할 수 있습니다.
  final KakaoMapLanguage language;

  /// 초기 위치. 지정하지 않을 경우 기본값은 서울 시청.
  final KakaoMapPoint defaultPosition;

  /// 초기 레벨값. 지정하지 않을 경우 17.
  final int defaultLevel;

  /// 초기 활성화 여부. 지정하지 않을 경우 기본 값은 true.
  final bool enabled;

  /// 0~1사이의 Float값으로 지정하며, 값에 따라 지도를 기울였을 때 빌딩의 높이 값을 조절할 수 있습니다.
  final double buildingScale;

  /// 지도 여백
  final EdgeInsets padding;

  /// 로고 위치 및 좌표
  final KakaoMapPosition logoPosition;

  /// Poi 설정
  final KakaoMapPoiOptions poiOptions;

  /// 나침반 설정
  final CompassOptions compassOptions;

  /// 축척 설정
  final ScaleBarOptions scaleBarOptions;

  const KakaoMapOptions({
    this.appName = "openmap",
    this.viewName = "mapview",
    this.viewInfoName = KakaoMapViewInfo.map,
    this.overlay,
    this.language = KakaoMapLanguage.ko,
    this.defaultPosition = const KakaoMapPoint(
      longitude: 127.108678,
      latitude: 37.402001,
    ),
    this.defaultLevel = 17,
    this.enabled = true,
    this.padding = EdgeInsets.zero,
    this.buildingScale = 1.0,
    this.logoPosition = const KakaoMapPosition(
      alignment: KakaoMapAlignment.bottomRight,
      x: 0,
      y: 0,
    ),
    this.poiOptions = const KakaoMapPoiOptions(),
    this.compassOptions = const CompassOptions(
      enabled: false,
      position: KakaoMapPosition(
        alignment: KakaoMapAlignment.bottomRight,
        x: 0,
        y: 0,
      ),
    ),
    this.scaleBarOptions = const ScaleBarOptions(
      enabled: false,
      position: KakaoMapPosition(
        alignment: KakaoMapAlignment.bottomRight,
        x: 0,
        y: 0,
      ),
    ),
  });

  KakaoMapOptions copyWith({
    String? appName,
    String? viewName,
    KakaoMapViewInfo? viewInfoName,
    KakaoMapOverlay? overlay,
    KakaoMapLanguage? language,
    KakaoMapPoint? defaultPosition,
    int? defaultLevel,
    bool? enabled,
    double? buildingScale,
    EdgeInsets? padding,
    KakaoMapPosition? logoPosition,
    KakaoMapPoiOptions? poiOptions,
  }) =>
      KakaoMapOptions(
        appName: appName ?? this.appName,
        viewName: viewName ?? this.viewName,
        viewInfoName: viewInfoName ?? this.viewInfoName,
        overlay: overlay,
        language: language ?? this.language,
        defaultPosition: defaultPosition ?? this.defaultPosition,
        defaultLevel: defaultLevel ?? this.defaultLevel,
        enabled: enabled ?? this.enabled,
        buildingScale: buildingScale ?? this.buildingScale,
        padding: padding ?? this.padding,
        logoPosition: logoPosition ?? this.logoPosition,
        poiOptions: poiOptions ?? this.poiOptions,
      );

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      "appName": appName,
      "viewName": viewName,
      "viewInfoName": viewInfoName.toString(),
      "language": language.toString(),
      "defaultPosition": defaultPosition.toMap(),
      "defaultLevel": defaultLevel,
      "enabled": enabled,
      "buildingScale": buildingScale,
      "padding": padding.toMap(),
      "logoPosition": logoPosition.toMap(),
      "poiOptions": poiOptions.toMap(),
      "compassOptions": compassOptions.toMap(),
      "scaleBarOptions": scaleBarOptions.toMap(),
    };

    if (overlay != null) {
      map["overlay"] = overlay.toString();
    }

    return map;
  }
}

extension EdgeInsetsExtension on EdgeInsets {
  Map<String, dynamic> toMap() {
    return {
      "top": top,
      "bottom": bottom,
      "left": left,
      "right": right,
    };
  }
}
