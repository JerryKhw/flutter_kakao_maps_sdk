package dev.jerrykhw.flutter_kakao_maps_sdk.model

import com.kakao.vectormap.LatLng
import com.kakao.vectormap.MapOverlay
import com.kakao.vectormap.Padding
import com.kakao.vectormap.PoiScale
import dev.jerrykhw.flutter_kakao_maps_sdk.enum.KakaoMapAlignment
import org.json.JSONObject

data class KakaoMapOptions(
    var appName: String = "openmap",
    var viewName: String = "mapview",
    var viewInfoName: String = "map",
    var overlay: MapOverlay?,
    var language: String,
    var defaultPosition: LatLng = LatLng.from(37.402001, 127.108678),
    var defaultLevel: Int = 17,
    var enabled: Boolean = true,
    var buildingScale: Float = 1.0F,
    var padding: Padding = Padding(0, 0, 0, 0),
    var logoPosition: KakaoMapPosition = KakaoMapPosition(
        KakaoMapAlignment.BottomRight,
        0.0F,
        0.0F
    ),
    var poiOptions: PoiOptions = PoiOptions(
        clickable = true,
        enabled = true,
        scale = PoiScale.REGULAR
    ),
    var compassOptions: CompassOptions = CompassOptions(
        false, KakaoMapPosition(KakaoMapAlignment.BottomRight, 0.0F, 0.0F),
    ),
    var scaleBarOptions: ScaleBarOptions = ScaleBarOptions(
        false, KakaoMapPosition(KakaoMapAlignment.BottomRight, 0.0F, 0.0F),
        true, FadeInOutOptions(
            300,
            300,
            3000
        )
    )
)

fun JSONObject.toKakaoMapOptions(): KakaoMapOptions {
    return KakaoMapOptions(
        this.getString("appName"),
        this.getString("viewName"),
        this.getString("viewInfoName"),
        if (this.isNull("overlay")) null else MapOverlay.getEnum(this.getString("overlay")),
        this.getString("language"),
        this.getJSONObject("defaultPosition").toLatLng(),
        this.getInt("defaultLevel"),
        this.getBoolean("enabled"),
        this.getDouble("buildingScale").toFloat(),
        this.getJSONObject("padding").toPadding(),
        this.getJSONObject("logoPosition").toKakaoMapPosition(),
        this.getJSONObject("poiOptions").toPoiOptions(),
        this.getJSONObject("compassOptions").toCompassOptions(),
        this.getJSONObject("scaleBarOptions").toScaleBarOptions(),
    )
}

fun JSONObject.toLatLng(): LatLng {
    return LatLng.from(
        this.getDouble("latitude"),
        this.getDouble("longitude")
    )
}

fun JSONObject.toPadding(): Padding {
    return Padding(
        this.getInt("left"),
        this.getInt("top"),
        this.getInt("right"),
        this.getInt("bottom"),
    )
}