package com.snakeway.flutter_log

import androidx.annotation.NonNull

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry.Registrar
import android.util.Log

/** FlutterLogPlugin */
class FlutterLogPlugin : FlutterPlugin, MethodCallHandler {
    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private lateinit var channel: MethodChannel

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "flutter_log")
        channel.setMethodCallHandler(this)
    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        var tag: String = call.argument("tag") ?: "NativeLog"
        var message: String = call.argument("msg") ?: "Unknown log message"
        if (call.method == "logD") {
            longLog(tag, message, 0)
            result.success(true)
        } else if (call.method == "logE") {
            longLog(tag, message, 1)
            result.success(true)
        } else {
            result.notImplemented()
        }
    }

    fun longLog(tag: String?, msg: String?, type: Int) {
        if (tag == null || tag.length == 0 || msg == null || msg.length == 0) return
        var result = msg
        val segmentSize = 1024 * 2;//native max is 4096
        val length = result.length.toLong()
        if (length <= segmentSize) {
            Log.e(tag, result)
        } else {
            while (result!!.length > segmentSize) {
                var logContent = result.substring(0, segmentSize)
                result = result.replace(logContent, "")
                if (type == 1) {
                    Log.e(tag, logContent)
                } else {
                    Log.d(tag, logContent)
                }
            }
            if (type == 1) {
                Log.e(tag, result)
            } else {
                Log.d(tag, result)
            }
        }
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }
}
