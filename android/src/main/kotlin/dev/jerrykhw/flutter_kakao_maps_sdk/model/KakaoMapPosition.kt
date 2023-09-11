package dev.jerrykhw.flutter_kakao_maps_sdk.model

import dev.jerrykhw.flutter_kakao_maps_sdk.enum.KakaoMapAlignment
import org.json.JSONObject

data class KakaoMapPosition(
    var alignment: KakaoMapAlignment,
    var x: Float,
    var y: Float,
)

fun JSONObject.toKakaoMapPosition(): KakaoMapPosition {
    return KakaoMapPosition(
        KakaoMapAlignment.fromValue(this.getString("alignment")),
        this.getDouble("x").toFloat(),
        this.getDouble("y").toFloat(),
    )
}