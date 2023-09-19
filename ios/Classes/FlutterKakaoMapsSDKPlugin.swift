import Flutter

public class FlutterKakaoMapsSDKPlugin: NSObject, FlutterPlugin {
    private static var registrar: FlutterPluginRegistrar!
    
    private static let BASE_ID = "dev.jerrykhw.flutter_kakao_maps_sdk"
    
    private static let LOG_EVENT_CHANNEL_NAME = "\(BASE_ID)/log"
    
    private static let KAKAO_MAP_VIEW_VIEW_ID = "\(BASE_ID)/kakao_map_view"
    
    internal static func createViewMethodChannelName(id: Int64) -> String {
        "\(KAKAO_MAP_VIEW_VIEW_ID)#\(id)"
    }
    
    internal static let logStreamHandler = LogStreamHandler()
    
    internal static func getAssetPath(named: String) -> String {
        let key = registrar.lookupKey(forAsset: named)
        let mainBundle = Bundle.main
        let path = mainBundle.path(forResource: key, ofType: nil)!
        
        return path
    }
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        self.registrar = registrar
        
        let logEventChannel = FlutterEventChannel(name: LOG_EVENT_CHANNEL_NAME, binaryMessenger: registrar.messenger())
        logEventChannel.setStreamHandler(logStreamHandler)
        
        let kakaoMapViewFactory = KakaoMapViewFactory(messenger: registrar.messenger())
        registrar.register(kakaoMapViewFactory, withId: KAKAO_MAP_VIEW_VIEW_ID)
    }
}
