package dev.jerrykhw.flutter_kakao_maps_sdk.model

import org.json.JSONObject

data class ScaleBarOptions(
    var enabled: Boolean,
    var position: KakaoMapPosition,
    var autoDisabled: Boolean,
    var fadeInOutOptions: FadeInOutOptions,
)


fun JSONObject.toScaleBarOptions(): ScaleBarOptions {
    return ScaleBarOptions(
        this.getBoolean("enabled"),
        this.getJSONObject("position").toKakaoMapPosition(),
        this.getBoolean("autoDisabled"),
        this.getJSONObject("fadeInOutOptions").toFadeInOutOptions(),
    )
}