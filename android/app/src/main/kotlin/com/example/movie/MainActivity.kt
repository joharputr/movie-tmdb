package com.example.movie

import kotlin.random.Random
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "android/channel").setMethodCallHandler {
                call, result ->
            if(call.method == "getName") {
                val rand = Random.nextInt(100)
                result.success("User${rand}")
            }
            else {
                result.notImplemented()
            }
        }
    }
}
