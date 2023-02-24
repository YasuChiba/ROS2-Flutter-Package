package com.example.ros2_flutter_package_example

import android.content.Context
import android.net.wifi.WifiManager
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
    private val CHANNEL = "wifi_lock"
    private var wifiLock: WifiManager.WifiLock? = null

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
            // This method is invoked on the main thread.
                call, result ->
            if (call.method == "acquire") {
                var result = acquire()
                System.out.println("result : " + result.toString());
            } else {
                result.notImplemented()
            }
        }
    }

    private fun acquire(): Boolean {
        System.out.println("acquire called")
        val wifi: WifiManager =
            activity.getApplicationContext().getSystemService(Context.WIFI_SERVICE) as WifiManager
                ?: return false
        wifiLock = wifi.createWifiLock(WifiManager.WIFI_MODE_FULL_HIGH_PERF, "discovery")
        wifiLock?.acquire()
        return true
    }
}
