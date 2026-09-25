package com.example.demo_project_mohit

import android.content.Intent
import android.os.Build
import android.util.Log
import com.google.firebase.messaging.FirebaseMessagingService
import com.google.firebase.messaging.RemoteMessage

class AppFirebaseMessagingService : FirebaseMessagingService() {

    override fun onMessageReceived(message: RemoteMessage) {
        super.onMessageReceived(message)

        Log.d(
            "FCM_NATIVE",
            "🔥 FCM received"
        )

        Log.d(
            "FCM_NATIVE",
            "Data: ${message.data}"
        )

        // -----------------------------
        // Get title and body from FCM
        // -----------------------------

        val title = message.data["title"]
            ?: "New Ride Request"

        val body = message.data["body"]
            ?: ""

        Log.d(
            "FCM_NATIVE",
            "Notification title: $title"
        )

        Log.d(
            "FCM_NATIVE",
            "Notification body: $body"
        )

        // -----------------------------
        // Start Ride Overlay Service
        // -----------------------------

        val intent = Intent(
            this,
            RideOverlayService::class.java
        )

        intent.putExtra(
            "notification_title",
            title
        )

        intent.putExtra(
            "notification_body",
            body
        )

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {

            Log.d(
                "FCM_NATIVE",
                "Starting RideOverlayService as Foreground Service"
            )

            startForegroundService(intent)

        } else {

            Log.d(
                "FCM_NATIVE",
                "Starting RideOverlayService"
            )

            startService(intent)
        }
    }

    override fun onNewToken(token: String) {
        super.onNewToken(token)

        Log.d(
            "FCM_NATIVE",
            "🔥 New FCM Token: $token"
        )
    }
}