import Flutter
import KakaoMapsSDK

class KakaoMapView: NSObject, FlutterPlatformView, MapControllerDelegate {
    private let mapViewContainer: KMViewContainer
    private let mapController: KMController
    private var mapView: KakaoMap?
    
    private var options: KakaoMapOptions
    private let viewMethodChannel: FlutterMethodChannel
    
    private let viewId: Int64
    
    private var auth: Bool
    
    private func printLog(_ message: String) {
        FlutterKakaoMapsSDKPlugin.logStreamHandler.sendMessage("KakaoMapView#\(viewId)[\(options.viewName)] \(message)")
    }
    
    private func viewMethodCallHandler(call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "dispose": dispose(onSuccess: result)
        case "moveCamera": moveCamera(arguments: call.arguments as! NSDictionary, onSuccess: result)
        case "animateCamera": animateCamera(arguments: call.arguments as! NSDictionary, onSuccess: result)
        case "moveCameraTransform": moveCameraTransform(arguments: call.arguments as! NSDictionary, onSuccess: result)
        case "animateCameraTransform": animateCameraTransform(arguments: call.arguments as! NSDictionary, onSuccess: result)
        case "setViewInfo": setViewInfo(arguments: call.arguments as! NSDictionary, onSuccess: result)
        case "showOverlay": showOverlay(arguments: call.arguments as! NSDictionary, onSuccess: result)
        case "hideOverlay": hideOverlay(arguments: call.arguments as! NSDictionary, onSuccess: result)
        case "setEnabled": setEnabled(arguments: call.arguments as! NSDictionary, onSuccess: result)
        case "setBuildingScale": setBuildingScale(arguments: call.arguments as! NSDictionary, onSuccess: result)
        case "getPadding": getPadding(onSuccess: result)
        case "setPadding": setPadding(arguments: call.arguments as! NSDictionary, onSuccess: result)
        case "setLogoPosition": setLogoPosition(arguments: call.arguments as! NSDictionary, onSuccess: result)
        case "setPoiOptions": setPoiOptions(arguments: call.arguments as! NSDictionary, onSuccess: result)
        case "setCompassOptions": setCompassOptions(arguments: call.arguments as! NSDictionary, onSuccess: result)
        case "setScaleBarOptions": setScaleBarOptions(arguments: call.arguments as! NSDictionary, onSuccess: result)
        case "refresh": refresh(onSuccess: result)
        default: result(FlutterMethodNotImplemented)
        }
    }
    
    func dispose(onSuccess: @escaping (Any?) -> ()) {
        printLog("stopEngine")
        
        mapController.stopRendering()
        mapController.stopEngine()
        
        viewMethodChannel.setMethodCallHandler(nil)
        
        onSuccess(nil)
    }
    
    func moveCamera(arguments: NSDictionary, onSuccess: @escaping (Any?) -> ()) {
        printLog("moveCamera")
        
        if let mapView = self.mapView {
            let cameraPosition = CameraUpdate.make(mapView: mapView).cameraPosition!
            var cameraTarget = cameraPosition.targetPoint
            var cameraZoomLevel = mapView.zoomLevel
            var cameraRotation = cameraPosition.rotation
            var cameraTilt = cameraPosition.tilt
            
            let target = arguments["target"] as? NSDictionary
            if let target = target {
                cameraTarget = target.toMapPoint()
            }
            
            let zoomLevel = arguments["zoomLevel"] as? Int
            if let zoomLevel = zoomLevel {
                cameraZoomLevel = zoomLevel
            }
            
            let rotation = arguments["rotation"] as? Double
            if let rotation = rotation {
                cameraRotation = rotation
            }
            
            let tilt = arguments["tilt"] as? Double
            if let tilt = tilt {
                cameraTilt = tilt
            }
            
            let cameraUpdate = CameraUpdate.make(target: cameraTarget, zoomLevel: cameraZoomLevel, rotation: cameraRotation, tilt: cameraTilt, mapView: mapView)
            
            mapView.moveCamera(cameraUpdate)
        }
        
        onSuccess(nil)
    }
    
    func animateCamera(arguments: NSDictionary, onSuccess: @escaping (Any?) -> ()) {
        printLog("animateCamera")
        
        if let mapView = self.mapView {
            let cameraPosition = CameraUpdate.make(mapView: mapView).cameraPosition!
            var cameraTarget = cameraPosition.targetPoint
            var cameraZoomLevel = mapView.zoomLevel
            var cameraRotation = cameraPosition.rotation
            var cameraTilt = cameraPosition.tilt
            
            let target = arguments["target"] as? NSDictionary
            if let target = target {
                cameraTarget = target.toMapPoint()
            }
            
            let zoomLevel = arguments["zoomLevel"] as? Int
            if let zoomLevel = zoomLevel {
                cameraZoomLevel = zoomLevel
            }
            
            let rotation = arguments["rotation"] as? Double
            if let rotation = rotation {
                cameraRotation = rotation
            }
            
            let tilt = arguments["tilt"] as? Double
            if let tilt = tilt {
                cameraTilt = tilt
            }
            
            let cameraAnimationOptions = (arguments["cameraAnimationOptions"] as! NSDictionary).toCameraAnimationOptions()
            
            let cameraUpdate = CameraUpdate.make(target: cameraTarget, zoomLevel: cameraZoomLevel, rotation: cameraRotation, tilt: cameraTilt, mapView: mapView)
            
            mapView.animateCamera(cameraUpdate: cameraUpdate, options: cameraAnimationOptions)
        }
        
        onSuccess(nil)
    }
    
    func moveCameraTransform(arguments: NSDictionary, onSuccess: @escaping (Any?) -> ()) {
        printLog("moveCameraTransform")
        
        if let mapView = self.mapView {
            let point = (arguments["point"] as! NSDictionary).toCameraTransformDelta()
            let height = arguments["height"] as! Double
            let rotation = arguments["rotation"] as! Double
            let tilt = arguments["tilt"] as! Double
            
            let cameraUpdate = CameraUpdate.make(transform: CameraTransform(deltaPos: point, deltaHeight: height, deltaRotation: rotation, deltaTilt: tilt))
            
            mapView.moveCamera(cameraUpdate)
        }
        
        onSuccess(nil)
    }
    
    func animateCameraTransform(arguments: NSDictionary, onSuccess: @escaping (Any?) -> ()) {
        printLog("animateCameraTransform")
        
        if let mapView = self.mapView {
            let point = (arguments["point"] as! NSDictionary).toCameraTransformDelta()
            let height = arguments["height"] as! Double
            let rotation = arguments["rotation"] as! Double
            let tilt = arguments["tilt"] as! Double
            let cameraAnimationOptions = (arguments["cameraAnimationOptions"] as! NSDictionary).toCameraAnimationOptions()
            
            let cameraUpdate = CameraUpdate.make(transform: CameraTransform(deltaPos: point, deltaHeight: height, deltaRotation: rotation, deltaTilt: tilt))
            
            mapView.animateCamera(cameraUpdate: cameraUpdate, options: cameraAnimationOptions)
        }
        
        onSuccess(nil)
    }
    
    func setViewInfo(arguments: NSDictionary, onSuccess: @escaping (Any?) -> ()) {
        printLog("setViewInfo")
        
        let appName = arguments["appName"] as! String
        let viewInfoName = arguments["viewInfoName"] as! String
        options.appName = appName
        options.viewInfoName = viewInfoName
        
        mapView?.changeViewInfo(appName: appName, viewInfoName: viewInfoName)
        
        onSuccess(nil)
    }
    
    func showOverlay(arguments: NSDictionary, onSuccess: @escaping (Any?) -> ()) {
        printLog("showOverlay")
        
        let overlay = arguments["overlay"] as! String
        options.overlay = overlay
        
        mapView?.showOverlay(overlay)
        
        onSuccess(nil)
    }
    
    func hideOverlay(arguments: NSDictionary, onSuccess: @escaping (Any?) -> ()) {
        printLog("hideOverlay")
        
        let overlay = arguments["overlay"] as! String
        
        mapView?.hideOverlay(overlay)
        
        onSuccess(nil)
    }
    
    func setEnabled(arguments: NSDictionary, onSuccess: @escaping (Any?) -> ()) {
        printLog("setEnabled")
        
        let enabled = arguments["enabled"] as! Bool
        options.enabled = enabled
        
        mapView?.isEnabled = enabled
        
        onSuccess(nil)
    }
    
    func setBuildingScale(arguments: NSDictionary, onSuccess: @escaping (Any?) -> ()) {
        printLog("setBuildingScale")
        
        let buildingScale = Float(arguments["buildingScale"] as! Double)
        options.buildingScale = buildingScale
        
        mapView?.buildingScale = buildingScale
        
        onSuccess(nil)
    }
    
    func getPadding(onSuccess: @escaping (Any?) -> ()) {
        printLog("getPadding")
        
        let margins = mapView?.margins ?? UIEdgeInsets()
        
        onSuccess(["left": margins.left, "top": margins.top, "right": margins.right, "bottom":margins.bottom])
    }
    
    func setPadding(arguments: NSDictionary, onSuccess: @escaping (Any?) -> ()) {
        printLog("setPadding")
        
        let padding = arguments.toUIEdgeInsets()
        options.padding = padding
        
        mapView?.setMargins(padding)
        
        onSuccess(nil)
    }
    
    func setLogoPosition(arguments: NSDictionary, onSuccess: @escaping (Any?) -> ()) {
        printLog("setLogoPosition")
        
        let logoPosition = arguments.toKakaoMapPosition()
        options.logoPosition = logoPosition
        
        mapView?.setLogoPosition(origin: logoPosition.alignment.toGuiAlignment(), position: CGPoint(x:logoPosition.x, y: logoPosition.y))
        
        onSuccess(nil)
    }
    
    func setPoiOptions(arguments: NSDictionary, onSuccess: @escaping (Any?) -> ()) {
        printLog("setPoiOptions")
        
        let poiOptions = arguments.toPoiOptions()
        options.poiOptions = poiOptions
        
        mapView?.poiClickable = poiOptions.clickable
        mapView?.setPoiEnabled(poiOptions.enabled)
        mapView?.poiScale = poiOptions.scale
        
        onSuccess(nil)
    }
    
    func setCompassOptions(arguments: NSDictionary, onSuccess: @escaping (Any?) -> ()) {
        printLog("setCompassOptions")
        
        let compassOptions = arguments.toCompassOptions()
        options.compassOptions = compassOptions
        
        if(compassOptions.enabled) {
            mapView?.showCompass()
        } else {
            mapView?.hideCompass()
        }
        mapView?.setCompassPosition(origin: compassOptions.position.alignment.toGuiAlignment(), position: CGPoint(x: compassOptions.position.x, y: compassOptions.position.y))
        
        onSuccess(nil)
    }
    
    func setScaleBarOptions(arguments: NSDictionary, onSuccess: @escaping (Any?) -> ()) {
        printLog("setScaleBarOptions")
        
        let scaleBarOptions = arguments.toScaleBarOptions()
        options.scaleBarOptions = scaleBarOptions
        
        if(scaleBarOptions.enabled) {
            mapView?.showScaleBar()
        } else {
            mapView?.hideScaleBar()
        }
        mapView?.setScaleBarPosition(origin: scaleBarOptions.position.alignment.toGuiAlignment(), position: CGPoint(x:scaleBarOptions.position.x, y: scaleBarOptions.position.y))
        mapView?.setScaleBarAutoDisappear(scaleBarOptions.autoDisabled)
        mapView?.setScaleBarFadeInOutOption(scaleBarOptions.fadeInOutOptions)
        
        onSuccess(nil)
    }
    
    func refresh(onSuccess: @escaping (Any?) -> ()) {
        printLog("refresh")
        
        mapView?.refresh()
        
        onSuccess(nil)
    }
    
    init(
        frame: CGRect,
        viewIdentifier viewId: Int64,
        options: KakaoMapOptions,
        viewMethodChannel: FlutterMethodChannel
    ) {
        self.auth = false
        self.viewId = viewId
        self.options = options
        self.viewMethodChannel = viewMethodChannel
        
        mapViewContainer = KMViewContainer(frame: frame)
        mapController = KMController(viewContainer: mapViewContainer)!
        
        if mapViewContainer.proMotionDisplay == true {
            mapController.proMotionSupport = true
        }
        
        super.init()
        
        viewMethodChannel.setMethodCallHandler(viewMethodCallHandler)
        
        mapController.delegate = self
        
        printLog("init")
    }
    
    func authenticationSucceeded() {
        printLog("auth success")
        
        if auth == false {
            auth = true
            self.mapController.startEngine()
            self.mapController.startRendering()
        }
    }
    
    func authenticationFailed(_ errorCode: Int, desc: String) {
        printLog("auth error code: \(errorCode)")
        printLog("auth desc: \(desc)")
        
        auth = false
        
        switch errorCode {
        case 499:
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.printLog("auth retry")
                
                self.mapController.authenticate()
            }
            break;
        default:
            break;
        }
    }
    
    func addViews() {
        let mapViewInfo = MapviewInfo(viewName: options.viewName, appName: options.appName, viewInfoName: options.viewInfoName, defaultPosition: options.defaultPosition, defaultLevel: options.defaultLevel, enabled: options.enabled)
        
        if mapController.addView(mapViewInfo) == Result.OK {
            mapView = mapController.getView(options.viewName) as? KakaoMap
            
            // Overlay
            if(options.overlay != nil) {
                mapView?.showOverlay(options.overlay!)
            }
            // Language
            mapView?.setLanguage(options.language)
            // BuildingScale
            mapView?.buildingScale = options.buildingScale
            // Padding
            mapView?.setMargins(options.padding)
            // LogoPosition
            mapView?.setLogoPosition(origin: options.logoPosition.alignment.toGuiAlignment(), position: CGPoint(x: options.logoPosition.x, y: options.logoPosition.y))
            // PoiOptions
            mapView?.poiClickable = options.poiOptions.clickable
            mapView?.setPoiEnabled(options.poiOptions.enabled)
            mapView?.poiScale = options.poiOptions.scale
            // CompassOptions
            if(options.compassOptions.enabled) {
                mapView?.showCompass()
            } else {
                mapView?.hideCompass()
            }
            mapView?.setCompassPosition(origin: options.compassOptions.position.alignment.toGuiAlignment(), position: CGPoint(x: options.compassOptions.position.x, y: options.compassOptions.position.y))
            // ScaleBarOptions
            if(options.scaleBarOptions.enabled) {
                mapView?.showScaleBar()
            } else {
                mapView?.hideScaleBar()
            }
            mapView?.setScaleBarPosition(origin: options.scaleBarOptions.position.alignment.toGuiAlignment(), position: CGPoint(x: options.scaleBarOptions.position.x, y: options.scaleBarOptions.position.y))
            mapView?.setScaleBarAutoDisappear(options.scaleBarOptions.autoDisabled)
            mapView?.setScaleBarFadeInOutOption(options.scaleBarOptions.fadeInOutOptions)
            
        }
    }
    
    func view() -> UIView {
        printLog("initEngine")
        mapController.initEngine()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            if self.auth {
                self.printLog("startEngine")
                self.mapController.startEngine()
                self.mapController.startRendering()
            } else {
                self.printLog("authenticate")
                self.mapController.authenticate()
            }
        }
        
        return mapViewContainer
    }
}
