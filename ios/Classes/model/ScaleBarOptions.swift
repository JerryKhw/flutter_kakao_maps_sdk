import KakaoMapsSDK

struct ScaleBarOptions {
    var enabled: Bool
    var position: KakaoMapPosition
    var autoDisabled: Bool
    var fadeInOutOptions: FadeInOutOptions
}

extension NSDictionary {
    func toScaleBarOptions() -> ScaleBarOptions {
        return ScaleBarOptions(
            enabled: self["enabled"] as! Bool,
            position: (self["position"] as! NSDictionary).toKakaoMapPosition(),
            autoDisabled: self["autoDisabled"] as! Bool,
            fadeInOutOptions: (self["fadeInOutOptions"] as! NSDictionary).toFadeInOutOptions()
        )
    }
}
