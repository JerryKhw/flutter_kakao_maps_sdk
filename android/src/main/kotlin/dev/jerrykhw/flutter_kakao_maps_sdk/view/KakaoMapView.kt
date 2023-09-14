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
import com.kakao.vectormap.camera.CameraPosition
import com.kakao.vectormap.camera.CameraUpdateFactory
import dev.jerrykhw.flutter_kakao_maps_sdk.FlutterKakaoMapsSDKPlugin
import dev.jerrykhw.flutter_kakao_maps_sdk.enum.toMapGravity
import dev.jerrykhw.flutter_kakao_maps_sdk.model.KakaoMapOptions
import dev.jerrykhw.flutter_kakao_maps_sdk.model.toCameraAnimation
import dev.jerrykhw.flutter_kakao_maps_sdk.model.toCompassOptions
import dev.jerrykhw.flutter_kakao_maps_sdk.model.toKakaoMapPosition
import dev.jerrykhw.flutter_kakao_maps_sdk.model.toLatLng
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
                "moveCamera" -> moveCamera(call.arguments as JSONObject, result)
                "animateCamera" -> animateCamera(call.arguments as JSONObject, result)
                "moveCameraTransform" -> moveCameraTransform(call.arguments as JSONObject, result)
                "animateCameraTransform" -> animateCameraTransform(
                    call.arguments as JSONObject,
                    result
                )

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

    private fun moveCamera(arguments: JSONObject, result: MethodChannel.Result) {
        printLog("moveCamera")

        val mapView = mapView ?: run {
            result.error("NOT_FOUND_MAPVIEW", "mapview is null", null)
            return
        }

        val cameraPosition = mapView.cameraPosition!!
        var cameraTarget = cameraPosition.position
        var cameraZoomLevel = cameraPosition.zoomLevel
        val cameraHeight = cameraPosition.height
        var cameraRotation = cameraPosition.rotationAngle
        var cameraTilt = cameraPosition.tiltAngle

        if (!arguments.isNull("target")) {
            cameraTarget = arguments.getJSONObject("target").toLatLng()
        }

        if (!arguments.isNull("zoomLevel")) {
            cameraZoomLevel = arguments.getInt("zoomLevel")
        }

        if (!arguments.isNull("rotation")) {
            cameraRotation = arguments.getDouble("rotation")
        }

        if (!arguments.isNull("tilt")) {
            cameraTilt = arguments.getDouble("tilt")
        }

        val cameraUpdate = CameraUpdateFactory.newCameraPosition(
            CameraPosition.from(
                cameraTarget.latitude,
                cameraTarget.longitude,
                cameraZoomLevel,
                cameraTilt,
                cameraRotation,
                cameraHeight,
            ),
        )

        mapView.moveCamera(cameraUpdate)

        result.success(null)
    }

    private fun animateCamera(arguments: JSONObject, result: MethodChannel.Result) {
        printLog("animateCamera")

        val mapView = mapView ?: run {
            result.error("NOT_FOUND_MAPVIEW", "mapview is null", null)
            return
        }

        val cameraPosition = mapView.cameraPosition!!
        var cameraTarget = cameraPosition.position
        var cameraZoomLevel = cameraPosition.zoomLevel
        val cameraHeight = cameraPosition.height
        var cameraRotation = cameraPosition.rotationAngle
        var cameraTilt = cameraPosition.tiltAngle

        if (!arguments.isNull("target")) {
            cameraTarget = arguments.getJSONObject("target").toLatLng()
        }

        if (!arguments.isNull("zoomLevel")) {
            cameraZoomLevel = arguments.getInt("zoomLevel")
        }

        if (!arguments.isNull("rotation")) {
            cameraRotation = arguments.getDouble("rotation")
        }

        if (!arguments.isNull("tilt")) {
            cameraTilt = arguments.getDouble("tilt")
        }

        val cameraAnimationOptions =
            arguments.getJSONObject("cameraAnimationOptions").toCameraAnimation()

        val cameraUpdate = CameraUpdateFactory.newCameraPosition(
            CameraPosition.from(
                cameraTarget.latitude,
                cameraTarget.longitude,
                cameraZoomLevel,
                cameraTilt,
                cameraRotation,
                cameraHeight,
            ),
        )

        mapView.moveCamera(cameraUpdate, cameraAnimationOptions)

        result.success(null)
    }

    private fun moveCameraTransform(arguments: JSONObject, result: MethodChannel.Result) {
        printLog("moveCameraTransform")

        val mapView = mapView ?: run {
            result.error("NOT_FOUND_MAPVIEW", "mapview is null", null)
            return
        }

        val cameraPosition = mapView.cameraPosition!!
        val cameraTarget = cameraPosition.position
        val cameraZoomLevel = cameraPosition.zoomLevel
        val cameraHeight = cameraPosition.height
        val cameraRotation = cameraPosition.rotationAngle
        val cameraTilt = cameraPosition.tiltAngle

        val point = arguments.getJSONObject("point").toLatLng()
        val height = arguments.getDouble("height")
        val rotation = arguments.getDouble("rotation")
        val tilt = arguments.getDouble("tilt")

        val cameraUpdate = CameraUpdateFactory.newCameraPosition(
            CameraPosition.from(
                cameraTarget.latitude + point.latitude,
                cameraTarget.longitude + point.longitude,
                cameraZoomLevel,
                cameraTilt + tilt,
                cameraRotation + rotation,
                cameraHeight + height,
            ),
        )

        mapView.moveCamera(cameraUpdate)

        result.success(null)
    }

    private fun animateCameraTransform(arguments: JSONObject, result: MethodChannel.Result) {
        printLog("animateCameraTransform")

        val mapView = mapView ?: run {
            result.error("NOT_FOUND_MAPVIEW", "mapview is null", null)
            return
        }

            val cameraPosition = mapView.cameraPosition!!
            val cameraTarget = cameraPosition.position
            val cameraZoomLevel = cameraPosition.zoomLevel
            val cameraHeight = cameraPosition.height
            val cameraRotation = cameraPosition.rotationAngle
            val cameraTilt = cameraPosition.tiltAngle

            val point = arguments.getJSONObject("point").toLatLng()
            val height = arguments.getDouble("height")
            val rotation = arguments.getDouble("rotation")
            val tilt = arguments.getDouble("tilt")

            val cameraAnimationOptions =
                arguments.getJSONObject("cameraAnimationOptions").toCameraAnimation()

            val cameraUpdate = CameraUpdateFactory.newCameraPosition(
                CameraPosition.from(
                    cameraTarget.latitude + point.latitude,
                    cameraTarget.longitude + point.longitude,
                    cameraZoomLevel,
                    cameraTilt + tilt,
                    cameraRotation + rotation,
                    cameraHeight + height,
                ),
            )

            mapView.moveCamera(cameraUpdate, cameraAnimationOptions)

        result.success(null)
    }

    private fun setViewInfo(arguments: JSONObject, result: MethodChannel.Result) {
        printLog("setViewInfo")

        val mapView = mapView ?: run {
            result.error("NOT_FOUND_MAPVIEW", "mapview is null", null)
            return
        }

        val appName = arguments.getString("appName")
        val viewInfoName = arguments.getString("viewInfoName")

        mapView.changeMapViewInfo(MapViewInfo.from(appName, viewInfoName))

        result.success(null)
    }

    private fun showOverlay(arguments: JSONObject, result: MethodChannel.Result) {
        printLog("showOverlay")

        val mapView = mapView ?: run {
            result.error("NOT_FOUND_MAPVIEW", "mapview is null", null)
            return
        }

        val overlay = MapOverlay.getEnum(arguments.getString("overlay"))

        mapView.showOverlay(overlay)

        result.success(null)
    }

    private fun hideOverlay(arguments: JSONObject, result: MethodChannel.Result) {
        printLog("hideOverlay")

        val mapView = mapView ?: run {
            result.error("NOT_FOUND_MAPVIEW", "mapview is null", null)
            return
        }

        val overlay = MapOverlay.getEnum(arguments.getString("overlay"))

        mapView.hideOverlay(overlay)

        result.success(null)
    }

    private fun setEnabled(arguments: JSONObject, result: MethodChannel.Result) {
        printLog("setEnabled")

        val mapView = mapView ?: run {
            result.error("NOT_FOUND_MAPVIEW", "mapview is null", null)
            return
        }

        val enabled = arguments.getBoolean("enabled")

        mapView.isVisible = enabled

        result.success(null)
    }

    private fun setBuildingScale(arguments: JSONObject, result: MethodChannel.Result) {
        printLog("setBuildingScale")

        val mapView = mapView ?: run {
            result.error("NOT_FOUND_MAPVIEW", "mapview is null", null)
            return
        }

        val buildingScale = arguments.getDouble("buildingScale").toFloat()

        mapView.buildingHeightScale = buildingScale

        result.success(null)
    }

    private fun getPadding(result: MethodChannel.Result) {
        printLog("getPadding")

        val mapView = mapView ?: run {
            result.error("NOT_FOUND_MAPVIEW", "mapview is null", null)
            return
        }

        val padding = mapView.padding

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

        val mapView = mapView ?: run {
            result.error("NOT_FOUND_MAPVIEW", "mapview is null", null)
            return
        }

        val padding = arguments.toPadding()

        mapView.setPadding(
            padding.left.px,
            padding.top.px,
            padding.right.px,
            padding.bottom.px,
        )

        result.success(null)
    }

    private fun setLogoPosition(arguments: JSONObject, result: MethodChannel.Result) {
        printLog("setLogoPosition")

        val mapView = mapView ?: run {
            result.error("NOT_FOUND_MAPVIEW", "mapview is null", null)
            return
        }

        val logoPosition = arguments.toKakaoMapPosition()

        mapView.logo?.setPosition(
            logoPosition.alignment.toMapGravity(),
            logoPosition.x.px,
            logoPosition.y.px,
        )

        result.success(null)
    }

    private fun setPoiOptions(arguments: JSONObject, result: MethodChannel.Result) {
        printLog("setPoiOptions")

        val mapView = mapView ?: run {
            result.error("NOT_FOUND_MAPVIEW", "mapview is null", null)
            return
        }

        val poiOptions = arguments.toPoiOptions()

        mapView.setPoiClickable(poiOptions.clickable)
        mapView.setPoiVisible(poiOptions.enabled)
        mapView.setPoiScale(poiOptions.scale)

        result.success(null)
    }

    private fun setCompassOptions(arguments: JSONObject, result: MethodChannel.Result) {
        printLog("setCompassOptions")

        val mapView = mapView ?: run {
            result.error("NOT_FOUND_MAPVIEW", "mapview is null", null)
            return
        }

        val compassOptions = arguments.toCompassOptions()

        compass = mapView.compass
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

        val mapView = mapView ?: run {
            result.error("NOT_FOUND_MAPVIEW", "mapview is null", null)
            return
        }

        val scaleBarOptions = arguments.toScaleBarOptions()

        scaleBar = mapView.scaleBar
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
                        // Overlay
                        if (options.overlay != null) {
                            mapView.showOverlay(options.overlay!!)
                        }
                        // Language
                        mapView.setPoiLanguage(options.language)
                        // BuildingScale
                        mapView.buildingHeightScale = options.buildingScale
                        // Padding
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

                        viewMethodChannel.invokeMethod("onMapReady", null)
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
