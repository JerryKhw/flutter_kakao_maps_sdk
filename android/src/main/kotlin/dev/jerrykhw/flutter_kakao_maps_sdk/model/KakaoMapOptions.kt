package dev.jerrykhw.flutter_kakao_maps_sdk.model

import android.graphics.PointF
import com.kakao.vectormap.LatLng
import com.kakao.vectormap.MapOverlay
import com.kakao.vectormap.Padding
import com.kakao.vectormap.PoiScale
import com.kakao.vectormap.camera.CameraAnimation
import com.kakao.vectormap.label.CompetitionType
import com.kakao.vectormap.label.CompetitionUnit
import com.kakao.vectormap.label.LabelLayerOptions
import com.kakao.vectormap.label.OrderingType
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
fun JSONObject.toPointF(): PointF {
    val arguments = this

    return PointF().apply {
        set(arguments.getDouble("longitude").toFloat(), arguments.getDouble("latitude").toFloat())
    }
}

fun JSONObject.toPadding(): Padding {
    return Padding(
        this.getInt("left"),
        this.getInt("top"),
        this.getInt("right"),
        this.getInt("bottom"),
    )
}

fun JSONObject.toCameraAnimation(): CameraAnimation {
    return CameraAnimation.from(
        this.getInt("durationInMillis"),
        this.getBoolean("autoElevation"),
        this.getBoolean("consecutive"),
    )
}

fun JSONObject.toLabelLayerOptions(): LabelLayerOptions {
    val arguments = this

    return LabelLayerOptions.from(arguments.getString("layerID")).apply {
        setCompetitionType(arguments.getInt("competitionType").toCompetitionType())
        setCompetitionUnit(arguments.getInt("competitionUnit").toCompetitionUnit())
        setOrderingType(arguments.getInt("orderType").toOrderingType())
        setZOrder(arguments.getInt("zOrder"))
    }
}

fun Int.toCompetitionType(): CompetitionType = when (this) {
    0 -> CompetitionType.None
    1 -> CompetitionType.All
    2 -> CompetitionType.Upper
    3 -> CompetitionType.UpperLower
    4 -> CompetitionType.UpperSame
    5 -> CompetitionType.Same
    6 -> CompetitionType.SameLower
    7 -> CompetitionType.Lower
    else -> throw IllegalArgumentException()
}

fun Int.toCompetitionUnit(): CompetitionUnit = when (this) {
    0 -> CompetitionUnit.IconAndText
    1 -> CompetitionUnit.IconFirst
    else -> throw IllegalArgumentException()
}

fun Int.toOrderingType(): OrderingType = when (this) {
    0 -> OrderingType.Rank
    1 -> OrderingType.LeftBottom
    else -> throw IllegalArgumentException()
}