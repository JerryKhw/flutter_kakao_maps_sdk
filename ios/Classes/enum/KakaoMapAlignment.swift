import KakaoMapsSDK

enum KakaoMapAlignment: String {
    case topLeft
    case topCenter
    case topRight
    case centerLeft
    case center
    case centerRight
    case bottomLeft
    case bottomCenter
    case bottomRight
}

extension KakaoMapAlignment {
    func toGuiAlignment() -> GuiAlignment {
        switch self {
        case .topLeft:
            return GuiAlignment(vAlign: .top, hAlign: .left)
        case .topCenter:
            return GuiAlignment(vAlign: .top, hAlign: .center)
        case .topRight:
            return GuiAlignment(vAlign: .top, hAlign: .right)
        case .centerLeft:
            return GuiAlignment(vAlign: .middle, hAlign: .left)
        case .center:
            return GuiAlignment(vAlign: .middle, hAlign: .center)
        case .centerRight:
            return GuiAlignment(vAlign: .middle, hAlign: .right)
        case .bottomLeft:
            return GuiAlignment(vAlign: .bottom, hAlign: .left)
        case .bottomCenter:
            return GuiAlignment(vAlign: .bottom, hAlign: .center)
        case .bottomRight:
            return GuiAlignment(vAlign: .bottom, hAlign: .right)
        }
    }
}
