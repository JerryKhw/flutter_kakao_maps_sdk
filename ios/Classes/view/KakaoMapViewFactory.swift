import Flutter
import KakaoMapsSDK

class KakaoMapViewFactory: NSObject, FlutterPlatformViewFactory {
    private var messenger: FlutterBinaryMessenger
    
    init(messenger: FlutterBinaryMessenger) {
        self.messenger = messenger
        super.init()
    }
    
    func create(
        withFrame frame: CGRect,
        viewIdentifier viewId: Int64,
        arguments args: Any?
    ) -> FlutterPlatformView {
        let arguments = args as! NSDictionary
        
        let options = arguments.toKakaoMapOptions()
        
        let viewMethodChannel = FlutterMethodChannel(name: FlutterKakaoMapsSDKPlugin.createViewMethodChannelName(id: viewId), binaryMessenger: messenger, codec: FlutterJSONMethodCodec.sharedInstance())
        
        return KakaoMapView(
            frame: frame,
            viewIdentifier: viewId,
            options: options,
            viewMethodChannel: viewMethodChannel
        )
    }
    
    func createArgsCodec() -> FlutterMessageCodec & NSObjectProtocol {
        return FlutterJSONMessageCodec.sharedInstance()
    }
}
