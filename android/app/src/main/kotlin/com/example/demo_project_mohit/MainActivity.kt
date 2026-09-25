package com.example.demo_project_mohit

import android.content.Intent
import android.net.Uri
import android.os.Build
import android.provider.Settings
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {

    // Existing channel — DON'T CHANGE
    private val CHANNEL = "overlay_permission"

    // New channel
    private val RIDE_CHANNEL = "ride_action"

    // Ride channel reference
    private var rideChannel: MethodChannel? = null

    override fun configureFlutterEngine(
        flutterEngine: FlutterEngine
    ) {
        super.configureFlutterEngine(flutterEngine)

        // ==========================================
        // Existing Overlay Channel
        // ==========================================

        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            CHANNEL
        ).setMethodCallHandler { call, result ->

            when (call.method) {

                "openOverlaySettings" -> {

                    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {

                        val intent = Intent(
                            Settings.ACTION_MANAGE_OVERLAY_PERMISSION,
                            Uri.parse("package:$packageName")
                        )

                        startActivity(intent)

                        result.success(true)

                    } else {
                        result.success(false)
                    }
                }

                "startRideOverlay" -> {

                    val intent = Intent(
                        this,
                        RideOverlayService::class.java
                    )

                    startService(intent)

                    result.success(true)
                }

                else -> {
                    result.notImplemented()
                }
            }
        }

        // ==========================================
        // New Ride Action Channel
        // ==========================================

        rideChannel = MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            RIDE_CHANNEL
        )
    }

    // ==========================================
    // Receive action from RideOverlayService
    // ==========================================

    override fun onNewIntent(intent: Intent) {
        super.onNewIntent(intent)

        // Update Activity's current intent
        setIntent(intent)

        val action = intent.getStringExtra("action")

        if (action == "ACCEPT_RIDE") {

            rideChannel?.invokeMethod(
                "rideAccepted",
                action
            )
        }
    }
}