package dev.jerrykhw.flutter_kakao_maps_sdk.util

import io.flutter.plugin.common.EventChannel

class LogStreamHandler : EventChannel.StreamHandler {
    private var eventSink: EventChannel.EventSink? = null

    override fun onListen(arguments: Any?, sink: EventChannel.EventSink?) {
        eventSink = sink
    }

    override fun onCancel(arguments: Any?) {
        eventSink = null
    }

    fun sendMessage(message: String) {
        eventSink?.success(message)
    }
}