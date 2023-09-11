struct CompassOptions {
    var enabled: Bool
    var position: KakaoMapPosition
}

extension NSDictionary {
    func toCompassOptions() -> CompassOptions {
        return CompassOptions(
            enabled: self["enabled"] as! Bool,
            position: (self["position"] as! NSDictionary).toKakaoMapPosition()
        )
    }
}
