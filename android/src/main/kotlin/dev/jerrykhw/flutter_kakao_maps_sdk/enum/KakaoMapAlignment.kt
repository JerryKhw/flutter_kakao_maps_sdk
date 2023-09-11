package dev.jerrykhw.flutter_kakao_maps_sdk.enum

import com.kakao.vectormap.MapGravity

enum class KakaoMapAlignment(val value: String) {
    TopLeft("topLeft"),
    TopCenter("topCenter"),
    TopRight("topRight"),
    CenterLeft("centerLeft"),
    Center("center"),
    CenterRight("centerRight"),
    BottomLeft("bottomLeft"),
    BottomCenter("bottomCenter"),
    BottomRight("bottomRight");

    companion object {
        fun fromValue(value: String): KakaoMapAlignment = when (value) {
            "topLeft" -> TopLeft
            "topCenter" -> TopCenter
            "topRight" -> TopRight
            "centerLeft" -> CenterLeft
            "center" -> Center
            "centerRight" -> CenterRight
            "bottomLeft" -> BottomLeft
            "bottomCenter" -> BottomCenter
            "bottomRight" -> BottomRight
            else -> throw IllegalArgumentException()
        }
    }
}

fun KakaoMapAlignment.toMapGravity(): Int {
    return when (this) {
        KakaoMapAlignment.TopLeft -> MapGravity.TOP + MapGravity.LEFT
        KakaoMapAlignment.TopCenter -> MapGravity.TOP + MapGravity.CENTER_HORIZONTAL
        KakaoMapAlignment.TopRight -> MapGravity.TOP + MapGravity.RIGHT
        KakaoMapAlignment.CenterLeft -> MapGravity.CENTER_VERTICAL + MapGravity.LEFT
        KakaoMapAlignment.Center -> MapGravity.CENTER_VERTICAL + MapGravity.CENTER_HORIZONTAL
        KakaoMapAlignment.CenterRight -> MapGravity.CENTER_VERTICAL + MapGravity.RIGHT
        KakaoMapAlignment.BottomLeft -> MapGravity.BOTTOM + MapGravity.LEFT
        KakaoMapAlignment.BottomCenter -> MapGravity.BOTTOM + MapGravity.CENTER_HORIZONTAL
        KakaoMapAlignment.BottomRight -> MapGravity.BOTTOM + MapGravity.RIGHT
    }
}