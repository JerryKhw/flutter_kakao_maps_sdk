import KakaoMapsSDK

struct PoiOptions {
    var clickable: Bool
    var enabled: Bool
    var scale: PoiScaleType
}

extension NSDictionary {
    func toPoiOptions() -> PoiOptions {
        return PoiOptions(
            clickable: self["clickable"] as! Bool,
            enabled: self["enabled"] as! Bool,
            scale: PoiScaleType(rawValue: (self["scale"] as! Int)) ?? PoiScaleType.regular
        )
    }
}
