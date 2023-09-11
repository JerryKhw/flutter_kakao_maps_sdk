struct KakaoMapPosition {
    var alignment: KakaoMapAlignment
    var x: Double
    var y: Double
}

extension NSDictionary {
    func toKakaoMapPosition() -> KakaoMapPosition {
        return KakaoMapPosition(alignment: KakaoMapAlignment(rawValue: self["alignment"] as! String)!, x: self["x"] as! Double, y: self["y"] as! Double)
    }
}
