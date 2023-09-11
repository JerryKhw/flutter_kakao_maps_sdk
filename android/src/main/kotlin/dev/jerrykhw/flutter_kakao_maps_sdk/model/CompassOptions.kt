package dev.jerrykhw.flutter_kakao_maps_sdk.model

import com.kakao.vectormap.PoiScale
import org.json.JSONObject

data class CompassOptions(
    var enabled: Boolean,
    var position: KakaoMapPosition,
)

fun JSONObject.toCompassOptions(): CompassOptions {
    return CompassOptions(
        this.getBoolean("enabled"),
        this.getJSONObject("position").toKakaoMapPosition(),
    )
}