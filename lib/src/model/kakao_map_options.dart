part of flutter_kakao_maps_sdk;

class KakaoMapOptions {
  final String appName;
  final String viewName;
  final KakaoMapViewInfo viewInfoName;
  final KakaoMapOverlay? overlay;
  final KakaoMapLanguage language;
  final KakaoMapPoint defaultPosition;
  final int defaultLevel;
  final bool enabled;
  final double buildingScale;
  final EdgeInsets padding;
  final KakaoMapPosition logoPosition;
  final PoiOptions poiOptions;
  final CompassOptions compassOptions;
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
    this.poiOptions = const PoiOptions(),
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
    PoiOptions? poiOptions,
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
