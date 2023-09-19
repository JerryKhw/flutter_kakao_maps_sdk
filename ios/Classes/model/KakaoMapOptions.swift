import KakaoMapsSDK

struct KakaoMapOptions {
    var appName: String = "openmap"
    var viewName: String = "mapview"
    var viewInfoName: String = "map"
    var overlay: String?
    var language: String
    var defaultPosition: MapPoint = MapPoint(longitude: 127.108678, latitude: 37.402001)
    var defaultLevel: Int = 17
    var enabled: Bool = true
    var buildingScale: Float = 1.0
    var padding: UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    var logoPosition: KakaoMapPosition = KakaoMapPosition(alignment: .bottomRight, x: 0, y: 0)
    var poiOptions: KakaoMapPoiOptions = KakaoMapPoiOptions(clickable: true, enabled: true, scale: PoiScaleType.regular)
    var compassOptions: CompassOptions = CompassOptions(enabled: false, position: KakaoMapPosition(alignment: .bottomRight, x: 0, y: 0))
    var scaleBarOptions: ScaleBarOptions = ScaleBarOptions(enabled: false, position: KakaoMapPosition(alignment: .bottomRight, x: 0, y: 0), autoDisabled: true, fadeInOutOptions: FadeInOutOptions(fadeInTime: 300, fadeOutTime: 300, retentionTime: 3000))
}

extension NSDictionary {
    func toKakaoMapOptions() -> KakaoMapOptions {
        return KakaoMapOptions(
            appName: self["appName"] as! String,
            viewName: self["viewName"] as! String,
            viewInfoName: self["viewInfoName"] as! String,
            overlay: self["overlay"] as? String,
            language: self["language"] as! String,
            defaultPosition: (self["defaultPosition"] as! NSDictionary).toMapPoint(),
            defaultLevel:self["defaultLevel"] as! Int,
            enabled: self["enabled"] as! Bool,
            buildingScale: Float(self["buildingScale"] as! Double),
            padding: (self["padding"] as! NSDictionary).toUIEdgeInsets(),
            logoPosition: (self["logoPosition"] as! NSDictionary).toKakaoMapPosition(),
            poiOptions: (self["poiOptions"] as! NSDictionary).toKakaoMapPoiOptions(),
            compassOptions: (self["compassOptions"] as! NSDictionary).toCompassOptions(),
            scaleBarOptions:(self["scaleBarOptions"] as! NSDictionary).toScaleBarOptions()
        )
    }
    
    func toMapPoint() -> MapPoint {
        return MapPoint(longitude: self["longitude"] as! Double, latitude: self["latitude"] as! Double)
    }
    
    func toCGPoint() -> CGPoint {
        return CGPoint(x: self["longitude"] as! Double, y: self["latitude"] as! Double)
    }
    
    func toCameraTransformDelta() -> CameraTransformDelta {
        return CameraTransformDelta(deltaLon: self["longitude"] as! Double, deltaLat: self["latitude"] as! Double)
    }
    
    func toCameraAnimationOptions() -> CameraAnimationOptions {
        return CameraAnimationOptions(autoElevation: ObjCBool(self["autoElevation"] as! Bool), consecutive: ObjCBool(self["consecutive"] as! Bool), durationInMillis: UInt(self["durationInMillis"] as! Int))
    }
    
    func toUIEdgeInsets() -> UIEdgeInsets {
        return UIEdgeInsets(top: self["top"] as! Double, left: self["left"] as! Double, bottom: self["bottom"] as! Double, right: self["right"] as! Double)
    }
    
    func toFadeInOutOptions() -> FadeInOutOptions {
        return FadeInOutOptions(fadeInTime: UInt32(self["fadeInTime"] as! Int), fadeOutTime: UInt32(self["fadeOutTime"] as! Int), retentionTime: UInt32(self["retentionTime"] as! Int))
    }
    
    func toLabelLayerOptions() -> LabelLayerOptions {
        return LabelLayerOptions(layerID: self["layerID"] as! String, competitionType: CompetitionType(rawValue: (self["competitionType"] as! Int))!, competitionUnit: CompetitionUnit(rawValue: (self["competitionUnit"] as! Int))!, orderType: OrderingType(rawValue: (self["orderType"] as! Int))!, zOrder: self["zOrder"] as! Int)
    }
}
