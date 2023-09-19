import KakaoMapsSDK

struct KakaoMapPoiOptions {
    var clickable: Bool
    var enabled: Bool
    var scale: PoiScaleType
}

extension NSDictionary {
    func toKakaoMapPoiOptions() -> KakaoMapPoiOptions {
        return KakaoMapPoiOptions(
            clickable: self["clickable"] as! Bool,
            enabled: self["enabled"] as! Bool,
            scale: PoiScaleType(rawValue: (self["scale"] as! Int)) ?? PoiScaleType.regular
        )
    }
}
