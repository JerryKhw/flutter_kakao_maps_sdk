import Flutter

public class FlutterKakaoMapsSDKPlugin: NSObject, FlutterPlugin {
    
    private static let BASE_ID = "dev.jerrykhw.flutter_kakao_maps_sdk"
    
    private static let LOG_EVENT_CHANNEL_NAME = "\(BASE_ID)/log"
    
    private static let KAKAO_MAP_VIEW_VIEW_ID = "\(BASE_ID)/kakao_map_view"
    
    internal static func createViewMethodChannelName(id: Int64) -> String {
        "\(KAKAO_MAP_VIEW_VIEW_ID)#\(id)"
    }
    
    internal static let logStreamHandler = LogStreamHandler()
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let logEventChannel = FlutterEventChannel(name: LOG_EVENT_CHANNEL_NAME, binaryMessenger: registrar.messenger())
        logEventChannel.setStreamHandler(logStreamHandler)
        
        let kakaoMapViewFactory = KakaoMapViewFactory(messenger: registrar.messenger())
        registrar.register(kakaoMapViewFactory, withId: KAKAO_MAP_VIEW_VIEW_ID)
    }
}
