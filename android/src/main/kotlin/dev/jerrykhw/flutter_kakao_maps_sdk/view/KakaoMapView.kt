package dev.jerrykhw.flutter_kakao_maps_sdk.view

import android.app.Activity
import android.view.View
import com.kakao.vectormap.Compass
import com.kakao.vectormap.KakaoMap
import com.kakao.vectormap.KakaoMapReadyCallback
import com.kakao.vectormap.LatLng
import com.kakao.vectormap.MapLifeCycleCallback
import com.kakao.vectormap.MapOverlay
import com.kakao.vectormap.MapType
import com.kakao.vectormap.MapView
import com.kakao.vectormap.MapViewInfo
import com.kakao.vectormap.Padding
import com.kakao.vectormap.ScaleBar
import dev.jerrykhw.flutter_kakao_maps_sdk.FlutterKakaoMapsSDKPlugin
import dev.jerrykhw.flutter_kakao_maps_sdk.enum.toMapGravity
import dev.jerrykhw.flutter_kakao_maps_sdk.model.KakaoMapOptions
import dev.jerrykhw.flutter_kakao_maps_sdk.model.toCompassOptions
import dev.jerrykhw.flutter_kakao_maps_sdk.model.toKakaoMapPosition
import dev.jerrykhw.flutter_kakao_maps_sdk.model.toPadding
import dev.jerrykhw.flutter_kakao_maps_sdk.model.toPoiOptions
import dev.jerrykhw.flutter_kakao_maps_sdk.model.toScaleBarOptions
import dev.jerrykhw.flutter_kakao_maps_sdk.util.dp
import dev.jerrykhw.flutter_kakao_maps_sdk.util.px
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.platform.PlatformView
import org.json.JSONObject

internal class KakaoMapView(
    private val activity: Activity,
    private val viewId: Int,
    private var options: KakaoMapOptions,
    private val viewMethodChannel: MethodChannel
) :
    PlatformView {
    private val mapViewContainer: MapView
    private var mapView: KakaoMap? = null
    private var compass: Compass? = null
    private var scaleBar: ScaleBar? = null

    private fun printLog(message: String) {
        FlutterKakaoMapsSDKPlugin.logStreamHandler.sendMessage("KakaoMapView#${viewId}[${options.viewName}] $message")
    }

    private val viewMethodCallHandler =
        MethodChannel.MethodCallHandler { call, result ->
            when (call.method) {
                "dispose" -> dispose(result)
                "setViewInfo" -> setViewInfo(call.arguments as JSONObject, result)
                "showOverlay" -> showOverlay(call.arguments as JSONObject, result)
                "hideOverlay" -> hideOverlay(call.arguments as JSONObject, result)
                "setEnabled" -> setEnabled(call.arguments as JSONObject, result)
                "setBuildingScale" -> setBuildingScale(call.arguments as JSONObject, result)
                "getPadding" -> getPadding(result)
                "setPadding" -> setPadding(call.arguments as JSONObject, result)
                "setLogoPosition" -> setLogoPosition(call.arguments as JSONObject, result)
                "setPoiOptions" -> setPoiOptions(call.arguments as JSONObject, result)
                "setCompassOptions" -> setCompassOptions(call.arguments as JSONObject, result)
                "setScaleBarOptions" -> setScaleBarOptions(call.arguments as JSONObject, result)
                "refresh" -> result.success(null)
                else -> result.notImplemented()
            }
        }

    private fun dispose(result: MethodChannel.Result) {
        printLog("stop")

        mapViewContainer.finish()

        viewMethodChannel.setMethodCallHandler(null)

        result.success(null)
    }

    private fun setViewInfo(arguments: JSONObject, result: MethodChannel.Result) {
        printLog("setPadding")

        val appName = arguments.getString("appName")
        val viewInfoName = arguments.getString("viewInfoName")
        options.appName = appName
        options.viewInfoName = viewInfoName

        mapView?.changeMapViewInfo(MapViewInfo.from(appName, viewInfoName))

        result.success(null)
    }

    private fun showOverlay(arguments: JSONObject, result: MethodChannel.Result) {
        printLog("showOverlay")

        val overlay = MapOverlay.getEnum(arguments.getString("overlay"))
        options.overlay = overlay

        mapView?.showOverlay(overlay)

        result.success(null)
    }

    private fun hideOverlay(arguments: JSONObject, result: MethodChannel.Result) {
        printLog("hideOverlay")

        val overlay = MapOverlay.getEnum(arguments.getString("overlay"))

        mapView?.hideOverlay(overlay)

        result.success(null)
    }

    private fun setEnabled(arguments: JSONObject, result: MethodChannel.Result) {
        printLog("setEnabled")

        val enabled = arguments.getBoolean("enabled")
        options.enabled = enabled

        mapView?.isVisible = enabled

        result.success(null)
    }

    private fun setBuildingScale(arguments: JSONObject, result: MethodChannel.Result) {
        printLog("setBuildingScale")

        val buildingScale = arguments.getDouble("buildingScale").toFloat()
        options.buildingScale = buildingScale

        mapView?.buildingHeightScale = buildingScale

        result.success(null)
    }

    private fun getPadding(result: MethodChannel.Result) {
        printLog("getPadding")

        val padding = mapView?.padding ?: Padding()

        val json = JSONObject().apply {
            put("left", padding.left.dp)
            put("top", padding.top.dp)
            put("bottom", padding.bottom.dp)
            put("right", padding.right.dp)
        }

        result.success(json)
    }

    private fun setPadding(arguments: JSONObject, result: MethodChannel.Result) {
        printLog("setPadding")

        val padding = arguments.toPadding()
        options.padding = padding

        mapView?.setPadding(
            padding.left.px,
            padding.top.px,
            padding.right.px,
            padding.bottom.px,
        )

        result.success(null)
    }

    private fun setLogoPosition(arguments: JSONObject, result: MethodChannel.Result) {
        printLog("setLogoPosition")

        val logoPosition = arguments.toKakaoMapPosition()
        options.logoPosition = logoPosition

        mapView?.logo?.setPosition(
            logoPosition.alignment.toMapGravity(),
            logoPosition.x.px,
            logoPosition.y.px,
        )

        result.success(null)
    }

    private fun setPoiOptions(arguments: JSONObject, result: MethodChannel.Result) {
        printLog("setPoiOptions")

        val poiOptions = arguments.toPoiOptions()
        options.poiOptions = poiOptions

        mapView?.setPoiClickable(poiOptions.clickable)
        mapView?.setPoiVisible(poiOptions.enabled)
        mapView?.setPoiScale(poiOptions.scale)

        result.success(null)
    }

    private fun setCompassOptions(arguments: JSONObject, result: MethodChannel.Result) {
        printLog("setCompassOptions")

        val compassOptions = arguments.toCompassOptions()
        options.compassOptions = compassOptions

        compass = mapView?.compass
        compass?.let { compass ->
            if (compassOptions.enabled) {
                compass.show()
            } else {
                compass.hide()
            }
            compass.setPosition(
                compassOptions.position.alignment.toMapGravity(),
                compassOptions.position.x.px,
                compassOptions.position.y.px,
            )
        }

        result.success(null)
    }

    private fun setScaleBarOptions(arguments: JSONObject, result: MethodChannel.Result) {
        printLog("setScaleBarOptions")

        val scaleBarOptions = arguments.toScaleBarOptions()
        options.scaleBarOptions = scaleBarOptions

        scaleBar = mapView?.scaleBar
        scaleBar?.let { scaleBar ->
            if (scaleBarOptions.enabled) {
                scaleBar.show()
            } else {
                scaleBar.hide()
            }
            scaleBar.setPosition(
                scaleBarOptions.position.alignment.toMapGravity(),
                scaleBarOptions.position.x.px,
                scaleBarOptions.position.y.px,
            )
            scaleBar.isAutoHide = scaleBarOptions.autoDisabled
            scaleBar.setFadeInOutTime(
                scaleBarOptions.fadeInOutOptions.fadeInTime,
                scaleBarOptions.fadeInOutOptions.fadeOutTime,
                scaleBarOptions.fadeInOutOptions.retentionTime
            )
        }

        result.success(null)
    }

    init {
        viewMethodChannel.setMethodCallHandler(viewMethodCallHandler)

        mapViewContainer = MapView(activity)

        printLog("start")
        mapViewContainer.start(
            object : MapLifeCycleCallback() {
                override fun onMapResumed() {
                    printLog("onMapResumed")
                }

                override fun onMapPaused() {
                    printLog("onMapPaused")
                }

                override fun onMapDestroy() {
                    printLog("onMapDestroy")
                }

                override fun onMapError(error: Exception) {
                    printLog("onMapError: ${error.message}")
                }
            },
            object : KakaoMapReadyCallback() {
                override fun onMapReady(kakaoMap: KakaoMap) {
                    mapView = kakaoMap

                    mapView?.let { mapView ->
                        mapView.setOnPaddingChangeListener {  }

                        // Overlay
                        if (options.overlay != null) {
                            mapView.showOverlay(options.overlay!!)
                        }
                        // Language
                        mapView.setPoiLanguage(options.language)
                        // BuildingScale
                        mapView.buildingHeightScale = options.buildingScale
                        // Pading
                        mapView.setPadding(
                            options.padding.left.px,
                            options.padding.top.px,
                            options.padding.right.px,
                            options.padding.bottom.px,
                        )
                        // LogoPosition
                        mapView.logo?.setPosition(
                            options.logoPosition.alignment.toMapGravity(),
                            options.logoPosition.x.px,
                            options.logoPosition.y.px,
                        )
                        // PoiOptions
                        mapView.setPoiClickable(options.poiOptions.clickable)
                        mapView.setPoiVisible(options.poiOptions.enabled)
                        mapView.setPoiScale(options.poiOptions.scale)
                        // CompassOptions
                        compass = mapView.compass
                        compass?.let { compass ->
                            if (options.compassOptions.enabled) {
                                compass.show()
                            } else {
                                compass.hide()
                            }
                            compass.setPosition(
                                options.compassOptions.position.alignment.toMapGravity(),
                                options.compassOptions.position.x.px,
                                options.compassOptions.position.y.px,
                            )
                        }
                        // ScaleBarOptions
                        scaleBar = mapView.scaleBar
                        scaleBar?.let { scaleBar ->
                            if (options.scaleBarOptions.enabled) {
                                scaleBar.show()
                            } else {
                                scaleBar.hide()
                            }
                            scaleBar.setPosition(
                                options.scaleBarOptions.position.alignment.toMapGravity(),
                                options.scaleBarOptions.position.x.px,
                                options.scaleBarOptions.position.y.px,
                            )
                            scaleBar.isAutoHide = options.scaleBarOptions.autoDisabled
                            scaleBar.setFadeInOutTime(
                                options.scaleBarOptions.fadeInOutOptions.fadeInTime,
                                options.scaleBarOptions.fadeInOutOptions.fadeOutTime,
                                options.scaleBarOptions.fadeInOutOptions.retentionTime
                            )
                        }
                    }
                }

                override fun getViewName(): String {
                    return options.viewName
                }

                override fun getMapViewInfo(): MapViewInfo {
                    return MapViewInfo.from(options.appName, MapType.getEnum(options.viewInfoName))
                }

                override fun getPosition(): LatLng {
                    return options.defaultPosition
                }

                override fun getZoomLevel(): Int {
                    return options.defaultLevel
                }

                override fun isVisible(): Boolean {
                    return options.enabled
                }
            },
        )
    }

    override fun getView(): View {
        return mapViewContainer
    }

    override fun dispose() = Unit
}
