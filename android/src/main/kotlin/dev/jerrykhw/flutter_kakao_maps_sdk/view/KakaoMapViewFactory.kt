package dev.jerrykhw.flutter_kakao_maps_sdk.view

import android.app.Activity
import android.content.Context
import dev.jerrykhw.flutter_kakao_maps_sdk.FlutterKakaoMapsSDKPlugin
import dev.jerrykhw.flutter_kakao_maps_sdk.model.toKakaoMapOptions
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.JSONMessageCodec
import io.flutter.plugin.common.JSONMethodCodec
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory
import org.json.JSONObject

class KakaoMapViewFactory(
    private val activity: Activity,
    private val messenger: BinaryMessenger,
) : PlatformViewFactory(JSONMessageCodec.INSTANCE) {
    override fun create(context: Context, viewId: Int, args: Any?): PlatformView {
        val arguments = args as JSONObject

        val options = arguments.toKakaoMapOptions()

        val viewMethodChannel =
            MethodChannel(
                messenger,
                FlutterKakaoMapsSDKPlugin.createViewMethodChannelName(viewId),
                JSONMethodCodec.INSTANCE
            )

        return KakaoMapView(activity, viewId, options, viewMethodChannel)
    }
}