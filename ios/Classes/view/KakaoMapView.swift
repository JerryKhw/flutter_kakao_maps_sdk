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
        case "dispose": dispose(result: result)
        case "addPoi": addPoi(arguments: call.arguments as! NSDictionary, result: result)
        case "removePoi": removePoi(arguments: call.arguments as! NSDictionary, result: result)
        case "addPoiIconStyle": addPoiIconStyle(arguments: call.arguments as! NSDictionary, result: result)
        case "changePoiIconStyle": changePoiIconStyle(arguments: call.arguments as! NSDictionary, result: result)
        case "addLabelLayer": addLabelLayer(arguments: call.arguments as! NSDictionary, result: result)
        case "moveCamera": moveCamera(arguments: call.arguments as! NSDictionary, result: result)
        case "animateCamera": animateCamera(arguments: call.arguments as! NSDictionary, result: result)
        case "moveCameraTransform": moveCameraTransform(arguments: call.arguments as! NSDictionary, result: result)
        case "animateCameraTransform": animateCameraTransform(arguments: call.arguments as! NSDictionary, result: result)
        case "setViewInfo": setViewInfo(arguments: call.arguments as! NSDictionary, result: result)
        case "showOverlay": showOverlay(arguments: call.arguments as! NSDictionary, result: result)
        case "hideOverlay": hideOverlay(arguments: call.arguments as! NSDictionary, result: result)
        case "setEnabled": setEnabled(arguments: call.arguments as! NSDictionary, result: result)
        case "setBuildingScale": setBuildingScale(arguments: call.arguments as! NSDictionary, result: result)
        case "getPadding": getPadding(result: result)
        case "setPadding": setPadding(arguments: call.arguments as! NSDictionary, result: result)
        case "setLogoPosition": setLogoPosition(arguments: call.arguments as! NSDictionary, result: result)
        case "setPoiOptions": setPoiOptions(arguments: call.arguments as! NSDictionary, result: result)
        case "setCompassOptions": setCompassOptions(arguments: call.arguments as! NSDictionary, result: result)
        case "setScaleBarOptions": setScaleBarOptions(arguments: call.arguments as! NSDictionary, result: result)
        case "refresh": refresh(result: result)
        default: result(FlutterMethodNotImplemented)
        }
    }
    
    func dispose(result: @escaping (Any?) -> ()) {
        printLog("stopEngine")
        
        mapController.stopRendering()
        mapController.stopEngine()
        
        viewMethodChannel.setMethodCallHandler(nil)
        
        result(nil)
    }
    
    func addPoi(arguments: NSDictionary, result: @escaping (Any?) -> ()) {
        printLog("addPoi")
        
        let layerID = arguments["layerID"] as! String
        let styleID = arguments["styleID"] as! String
        
        guard let mapView = self.mapView else {
            result(FlutterError(code: "NOT_FOUND_MAPVIEW", message: "mapView is nil", details: nil))
            return
        }
        
        let labelManager = mapView.getLabelManager()
        
        guard let labelLayer = labelManager.getLabelLayer(layerID: layerID) else {
            result(FlutterError(code: "NOT_FOUND_LABEL_LAYER", message: "labelLayer is nil", details: nil))
            return
        }
        
        guard let poi = labelLayer.addPoi(option: PoiOptions(styleID: styleID), at: (arguments["at"] as! NSDictionary).toMapPoint()) else {
            result(FlutterError(code: "FAILED_ADD", message: "failed add poi", details: nil))
            return
        }
        
        poi.show()
        
        result(poi.itemID)
    }
    
    func removePoi(arguments: NSDictionary, result: @escaping (Any?) -> ()) {
        printLog("removePoi")
        
        let layerID = arguments["layerID"] as! String
        let poiID = arguments["poiID"] as! String
        
        guard let mapView = self.mapView else {
            result(FlutterError(code: "NOT_FOUND_MAPVIEW", message: "mapView is nil", details: nil))
            return
        }
        
        let labelManager = mapView.getLabelManager()
        
        guard let labelLayer = labelManager.getLabelLayer(layerID: layerID) else {
            result(FlutterError(code: "NOT_FOUND_LABEL_LAYER", message: "labelLayer is nil", details: nil))
            return
        }
        
        labelLayer.removePoi(poiID: poiID)
        
        result(nil)
    }
    
    func addPoiIconStyle(arguments: NSDictionary, result: @escaping (Any?) -> ()) {
        printLog("addPoiIconStyle")
        
        let styleID = arguments["styleID"] as! String
        let styles = (arguments["styles"] as! [NSDictionary])
        
        guard let mapView = self.mapView else {
            result(FlutterError(code: "NOT_FOUND_MAPVIEW", message: "mapView is nil", details: nil))
            return
        }
        
        let labelManager = mapView.getLabelManager()
        
        let poiStyles = styles.map { (style) in
            let badges = (style["badges"] as! [NSDictionary]).map { (badge) in
                let badgeID = style["badgeID"] as! String
                
                let imageNamed = badge["image"] as! String
                let imagePath = FlutterKakaoMapsSDKPlugin.getAssetPath(named: imageNamed)
                
                let height = badge["height"] as! Double
                let width = badge["width"] as! Double
                
                let image = UIImage.init(contentsOfFile: imagePath)?.resized(to: CGSize(width: width, height: height))
                
                let offset = (badge["offset"] as! NSDictionary).toCGPoint()
                let zOrder = badge["zOrder"] as! Int
                
                return PoiBadge(badgeID: badgeID, image: image, offset: offset, zOrder: zOrder)
            }
            
            let symbolNamed = style["symbol"] as! String
            let symbolPath = FlutterKakaoMapsSDKPlugin.getAssetPath(named: symbolNamed)
            
            let height = style["height"] as! Double
            let width = style["width"] as! Double
            
            let symbol = UIImage.init(contentsOfFile: symbolPath)?.resized(to: CGSize(width: width, height: height))
            
            let anchorPoint = (style["anchorPoint"] as! NSDictionary).toCGPoint()
            let level = style["level"] as! Int
            
            let transitionType = TransitionType(rawValue: style["transitionType"] as! Int)!
            
            let transition = PoiTransition.init(entrance: transitionType, exit: transitionType)
            
            return PerLevelPoiStyle(iconStyle: PoiIconStyle(symbol: symbol, anchorPoint: anchorPoint, transition: transition, badges: badges), level: level)
        }
        
        let poiStyle = PoiStyle(styleID: styleID, styles: poiStyles)
        
        labelManager.addPoiStyle(poiStyle)
        
        result(nil)
    }
    
    func changePoiIconStyle(arguments: NSDictionary, result: @escaping (Any?) -> ()) {
        printLog("changePoiIconStyle")
        
        let layerID = arguments["layerID"] as! String
        let poiID = arguments["poiID"] as! String
        let styleID = arguments["styleID"] as! String
        
        guard let mapView = self.mapView else {
            result(FlutterError(code: "NOT_FOUND_MAPVIEW", message: "mapView is nil", details: nil))
            return
        }
        
        let labelManager = mapView.getLabelManager()
        
        guard let labelLayer = labelManager.getLabelLayer(layerID: layerID) else {
            result(FlutterError(code: "NOT_FOUND_LABEL_LAYER", message: "labelLayer is nil", details: nil))
            return
        }
        
        guard let poi = labelLayer.getPoi(poiID: poiID) else {
            result(FlutterError(code: "NOT_FOUND_POI", message: "poi is nil", details: nil))
            return
        }
        
        poi.changeStyle(styleID: styleID)
        
        result(nil)
    }
    
    func addLabelLayer(arguments: NSDictionary, result: @escaping (Any?) -> ()) {
        printLog("addLabelLayer")
        
        guard let mapView = self.mapView else {
            result(FlutterError(code: "NOT_FOUND_MAPVIEW", message: "mapView is nil", details: nil))
            return
        }
        
        let labelManager = mapView.getLabelManager()
        
        guard let labelLayer = labelManager.addLabelLayer(option: arguments.toLabelLayerOptions()) else {
            result(FlutterError(code: "FAILED_ADD", message: "failed add labelLayer", details: nil))
            return
        }
        
        result(nil)
    }
    
    func moveCamera(arguments: NSDictionary, result: @escaping (Any?) -> ()) {
        printLog("moveCamera")
        
        guard let mapView = self.mapView else {
            result(FlutterError(code: "NOT_FOUND_MAPVIEW", message: "mapView is nil", details: nil))
            return
        }
        
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
        
        result(nil)
    }
    
    func animateCamera(arguments: NSDictionary, result: @escaping (Any?) -> ()) {
        printLog("animateCamera")
        
        guard let mapView = self.mapView else {
            result(FlutterError(code: "NOT_FOUND_MAPVIEW", message: "mapView is nil", details: nil))
            return
        }
        
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
        
        result(nil)
    }
    
    func moveCameraTransform(arguments: NSDictionary, result: @escaping (Any?) -> ()) {
        printLog("moveCameraTransform")
        
        guard let mapView = self.mapView else {
            result(FlutterError(code: "NOT_FOUND_MAPVIEW", message: "mapView is nil", details: nil))
            return
        }
        
        let point = (arguments["point"] as! NSDictionary).toCameraTransformDelta()
        let height = arguments["height"] as! Double
        let rotation = arguments["rotation"] as! Double
        let tilt = arguments["tilt"] as! Double
        
        let cameraUpdate = CameraUpdate.make(transform: CameraTransform(deltaPos: point, deltaHeight: height, deltaRotation: rotation, deltaTilt: tilt))
        
        mapView.moveCamera(cameraUpdate)
        
        result(nil)
    }
    
    func animateCameraTransform(arguments: NSDictionary, result: @escaping (Any?) -> ()) {
        printLog("animateCameraTransform")
        
        guard let mapView = self.mapView else {
            result(FlutterError(code: "NOT_FOUND_MAPVIEW", message: "mapView is nil", details: nil))
            return
        }
        
        let point = (arguments["point"] as! NSDictionary).toCameraTransformDelta()
        let height = arguments["height"] as! Double
        let rotation = arguments["rotation"] as! Double
        let tilt = arguments["tilt"] as! Double
        let cameraAnimationOptions = (arguments["cameraAnimationOptions"] as! NSDictionary).toCameraAnimationOptions()
        
        let cameraUpdate = CameraUpdate.make(transform: CameraTransform(deltaPos: point, deltaHeight: height, deltaRotation: rotation, deltaTilt: tilt))
        
        mapView.animateCamera(cameraUpdate: cameraUpdate, options: cameraAnimationOptions)
        
        result(nil)
    }
    
    func setViewInfo(arguments: NSDictionary, result: @escaping (Any?) -> ()) {
        printLog("setViewInfo")
        
        guard let mapView = self.mapView else {
            result(FlutterError(code: "NOT_FOUND_MAPVIEW", message: "mapView is nil", details: nil))
            return
        }
        
        let appName = arguments["appName"] as! String
        let viewInfoName = arguments["viewInfoName"] as! String
        
        mapView.changeViewInfo(appName: appName, viewInfoName: viewInfoName)
        
        result(nil)
    }
    
    func showOverlay(arguments: NSDictionary, result: @escaping (Any?) -> ()) {
        printLog("showOverlay")
        
        guard let mapView = self.mapView else {
            result(FlutterError(code: "NOT_FOUND_MAPVIEW", message: "mapView is nil", details: nil))
            return
        }
        
        let overlay = arguments["overlay"] as! String
        
        mapView.showOverlay(overlay)
        
        result(nil)
    }
    
    func hideOverlay(arguments: NSDictionary, result: @escaping (Any?) -> ()) {
        printLog("hideOverlay")
        
        guard let mapView = self.mapView else {
            result(FlutterError(code: "NOT_FOUND_MAPVIEW", message: "mapView is nil", details: nil))
            return
        }
        
        let overlay = arguments["overlay"] as! String
        
        mapView.hideOverlay(overlay)
        
        result(nil)
    }
    
    func setEnabled(arguments: NSDictionary, result: @escaping (Any?) -> ()) {
        printLog("setEnabled")
        
        guard let mapView = self.mapView else {
            result(FlutterError(code: "NOT_FOUND_MAPVIEW", message: "mapView is nil", details: nil))
            return
        }
        
        let enabled = arguments["enabled"] as! Bool
        
        mapView.isEnabled = enabled
        
        result(nil)
    }
    
    func setBuildingScale(arguments: NSDictionary, result: @escaping (Any?) -> ()) {
        printLog("setBuildingScale")
        
        guard let mapView = self.mapView else {
            result(FlutterError(code: "NOT_FOUND_MAPVIEW", message: "mapView is nil", details: nil))
            return
        }
        
        let buildingScale = Float(arguments["buildingScale"] as! Double)
        
        mapView.buildingScale = buildingScale
        
        result(nil)
    }
    
    func getPadding(result: @escaping (Any?) -> ()) {
        printLog("getPadding")
        
        guard let mapView = self.mapView else {
            result(FlutterError(code: "NOT_FOUND_MAPVIEW", message: "mapView is nil", details: nil))
            return
        }
        
        let margins = mapView.margins
        
        result(["left": margins.left, "top": margins.top, "right": margins.right, "bottom":margins.bottom])
    }
    
    func setPadding(arguments: NSDictionary, result: @escaping (Any?) -> ()) {
        printLog("setPadding")
        
        guard let mapView = self.mapView else {
            result(FlutterError(code: "NOT_FOUND_MAPVIEW", message: "mapView is nil", details: nil))
            return
        }
        
        let padding = arguments.toUIEdgeInsets()
        
        mapView.setMargins(padding)
        
        result(nil)
    }
    
    func setLogoPosition(arguments: NSDictionary, result: @escaping (Any?) -> ()) {
        printLog("setLogoPosition")
        
        guard let mapView = self.mapView else {
            result(FlutterError(code: "NOT_FOUND_MAPVIEW", message: "mapView is nil", details: nil))
            return
        }
        
        let logoPosition = arguments.toKakaoMapPosition()
        
        mapView.setLogoPosition(origin: logoPosition.alignment.toGuiAlignment(), position: CGPoint(x:logoPosition.x, y: logoPosition.y))
        
        result(nil)
    }
    
    func setPoiOptions(arguments: NSDictionary, result: @escaping (Any?) -> ()) {
        printLog("setPoiOptions")
        
        guard let mapView = self.mapView else {
            result(FlutterError(code: "NOT_FOUND_MAPVIEW", message: "mapView is nil", details: nil))
            return
        }
        
        let poiOptions = arguments.toKakaoMapPoiOptions()
        
        mapView.poiClickable = poiOptions.clickable
        mapView.setPoiEnabled(poiOptions.enabled)
        mapView.poiScale = poiOptions.scale
        
        result(nil)
    }
    
    func setCompassOptions(arguments: NSDictionary, result: @escaping (Any?) -> ()) {
        printLog("setCompassOptions")
        
        guard let mapView = self.mapView else {
            result(FlutterError(code: "NOT_FOUND_MAPVIEW", message: "mapView is nil", details: nil))
            return
        }
        
        let compassOptions = arguments.toCompassOptions()
        
        if(compassOptions.enabled) {
            mapView.showCompass()
        } else {
            mapView.hideCompass()
        }
        mapView.setCompassPosition(origin: compassOptions.position.alignment.toGuiAlignment(), position: CGPoint(x: compassOptions.position.x, y: compassOptions.position.y))
        
        result(nil)
    }
    
    func setScaleBarOptions(arguments: NSDictionary, result: @escaping (Any?) -> ()) {
        printLog("setScaleBarOptions")
        
        guard let mapView = self.mapView else {
            result(FlutterError(code: "NOT_FOUND_MAPVIEW", message: "mapView is nil", details: nil))
            return
        }
        
        let scaleBarOptions = arguments.toScaleBarOptions()
        
        if(scaleBarOptions.enabled) {
            mapView.showScaleBar()
        } else {
            mapView.hideScaleBar()
        }
        mapView.setScaleBarPosition(origin: scaleBarOptions.position.alignment.toGuiAlignment(), position: CGPoint(x:scaleBarOptions.position.x, y: scaleBarOptions.position.y))
        mapView.setScaleBarAutoDisappear(scaleBarOptions.autoDisabled)
        mapView.setScaleBarFadeInOutOption(scaleBarOptions.fadeInOutOptions)
        
        result(nil)
    }
    
    func refresh(result: @escaping (Any?) -> ()) {
        printLog("refresh")
        
        guard let mapView = self.mapView else {
            result(FlutterError(code: "NOT_FOUND_MAPVIEW", message: "mapView is nil", details: nil))
            return
        }
        
        mapView.refresh()
        
        result(nil)
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
            
            if let mapView = self.mapView {
                // Overlay
                if(options.overlay != nil) {
                    mapView.showOverlay(options.overlay!)
                }
                // Language
                mapView.setLanguage(options.language)
                // BuildingScale
                mapView.buildingScale = options.buildingScale
                // Padding
                mapView.setMargins(options.padding)
                // LogoPosition
                mapView.setLogoPosition(origin: options.logoPosition.alignment.toGuiAlignment(), position: CGPoint(x: options.logoPosition.x, y: options.logoPosition.y))
                // PoiOptions
                mapView.poiClickable = options.poiOptions.clickable
                mapView.setPoiEnabled(options.poiOptions.enabled)
                mapView.poiScale = options.poiOptions.scale
                // CompassOptions
                if(options.compassOptions.enabled) {
                    mapView.showCompass()
                } else {
                    mapView.hideCompass()
                }
                mapView.setCompassPosition(origin: options.compassOptions.position.alignment.toGuiAlignment(), position: CGPoint(x: options.compassOptions.position.x, y: options.compassOptions.position.y))
                // ScaleBarOptions
                if(options.scaleBarOptions.enabled) {
                    mapView.showScaleBar()
                } else {
                    mapView.hideScaleBar()
                }
                mapView.setScaleBarPosition(origin: options.scaleBarOptions.position.alignment.toGuiAlignment(), position: CGPoint(x: options.scaleBarOptions.position.x, y: options.scaleBarOptions.position.y))
                mapView.setScaleBarAutoDisappear(options.scaleBarOptions.autoDisabled)
                mapView.setScaleBarFadeInOutOption(options.scaleBarOptions.fadeInOutOptions)
                
                viewMethodChannel.invokeMethod("onMapReady", arguments: nil)
            }
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
