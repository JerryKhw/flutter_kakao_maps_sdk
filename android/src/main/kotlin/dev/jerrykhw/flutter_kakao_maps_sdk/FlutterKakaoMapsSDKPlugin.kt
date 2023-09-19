package dev.jerrykhw.flutter_kakao_maps_sdk

import android.graphics.Bitmap
import android.graphics.BitmapFactory
import dev.jerrykhw.flutter_kakao_maps_sdk.util.LogStreamHandler
import dev.jerrykhw.flutter_kakao_maps_sdk.view.KakaoMapViewFactory
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.EventChannel
import java.io.InputStream

class FlutterKakaoMapsSDKPlugin : FlutterPlugin, ActivityAware {

    override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        pluginBinding = binding
        flutterAssets = binding.flutterAssets

        val logEventChannel = EventChannel(binding.binaryMessenger, LOG_EVENT_CHANNEL_NAME)
        logEventChannel.setStreamHandler(logStreamHandler)
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) = Unit

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        val kakaoMapViewFactory =
            KakaoMapViewFactory(binding.activity, pluginBinding.binaryMessenger)

        pluginBinding.platformViewRegistry.registerViewFactory(
            KAKAO_MAP_VIEW_VIEW_ID,
            kakaoMapViewFactory
        )
    }

    override fun onDetachedFromActivityForConfigChanges() = Unit

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) = Unit

    override fun onDetachedFromActivity() = Unit

    companion object {
        private const val BASE_ID = "dev.jerrykhw.flutter_kakao_maps_sdk"

        private const val LOG_EVENT_CHANNEL_NAME = "${BASE_ID}/log"

        private const val KAKAO_MAP_VIEW_VIEW_ID = "${BASE_ID}/kakao_map_view"

        val logStreamHandler = LogStreamHandler()

        internal fun createViewMethodChannelName(id: Int): String =
            "${KAKAO_MAP_VIEW_VIEW_ID}#$id"

        private lateinit var pluginBinding: FlutterPlugin.FlutterPluginBinding
        private lateinit var flutterAssets: FlutterPlugin.FlutterAssets

        internal fun getAsset(named: String): InputStream {
            val path = flutterAssets.getAssetFilePathByName(named)
            return pluginBinding.applicationContext.assets.open(path)
        }
    }
}
