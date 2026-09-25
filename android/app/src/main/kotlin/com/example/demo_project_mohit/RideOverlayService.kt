package com.example.demo_project_mohit

import android.util.Log
import android.app.NotificationChannel
import android.app.NotificationManager
import android.app.Service
import android.content.Intent
import android.content.pm.ServiceInfo
import android.graphics.Color
import android.graphics.PixelFormat
import android.graphics.drawable.GradientDrawable
import android.os.Build
import android.os.IBinder
import android.provider.Settings
import android.view.Gravity
import android.view.MotionEvent
import android.view.View
import android.view.WindowManager
import android.widget.Button
import android.widget.LinearLayout
import android.widget.TextView
import androidx.core.app.NotificationCompat
import kotlin.math.abs

class RideOverlayService : Service() {

    private lateinit var windowManager: WindowManager
    private lateinit var overlayView: View
    private lateinit var params: WindowManager.LayoutParams

    // FCM title/body
    private lateinit var titleView: TextView
    private lateinit var bodyView: TextView

    private var initialX = 0
    private var initialY = 0
    private var initialTouchX = 0f
    private var initialTouchY = 0f

    companion object {
        private const val CHANNEL_ID = "ride_overlay_channel"
        private const val NOTIFICATION_ID = 1001
    }

    // dp -> pixel
    private fun dp(value: Int): Int {
        return (value * resources.displayMetrics.density).toInt()
    }

    override fun onCreate() {
        super.onCreate()

        // --------------------------------
        // IMPORTANT:
        // Foreground Service notification
        // --------------------------------

        createNotificationChannel()

        val notification =
            NotificationCompat.Builder(this, CHANNEL_ID)
                .setContentTitle("Ride Request")
                .setContentText("New ride request received")
                .setSmallIcon(android.R.drawable.ic_dialog_info)
                .setOngoing(true)
                .setPriority(NotificationCompat.PRIORITY_LOW)
                .build()

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.UPSIDE_DOWN_CAKE) {

            startForeground(
                NOTIFICATION_ID,
                notification,
                ServiceInfo.FOREGROUND_SERVICE_TYPE_SPECIAL_USE
            )

        } else {

            startForeground(
                NOTIFICATION_ID,
                notification
            )
        }

        // --------------------------------
        // Check overlay permission
        // --------------------------------

        if (
            Build.VERSION.SDK_INT >= Build.VERSION_CODES.M &&
            !Settings.canDrawOverlays(this)
        ) {
            stopSelf()
            return
        }

        windowManager =
            getSystemService(WINDOW_SERVICE) as WindowManager

        // --------------------------------
        // Main Card
        // --------------------------------

        val card = LinearLayout(this).apply {

            orientation = LinearLayout.VERTICAL

            setPadding(
                dp(20),
                dp(18),
                dp(20),
                dp(16)
            )

            background = GradientDrawable().apply {
                setColor(Color.WHITE)
                cornerRadius = dp(20).toFloat()
            }

            elevation = dp(8).toFloat()
        }

        // --------------------------------
        // FCM Notification Title
        // --------------------------------

        titleView = TextView(this).apply {

            text = "🚗  New Ride Request"

            textSize = 20f

            setTextColor(Color.BLACK)

            setTypeface(
                null,
                android.graphics.Typeface.BOLD
            )
        }

        card.addView(titleView)

        // --------------------------------
        // FCM Notification Body
        // --------------------------------

        bodyView = TextView(this).apply {

            text = ""

            textSize = 16f

            setTextColor(Color.DKGRAY)

            setPadding(
                0,
                dp(8),
                0,
                dp(4)
            )
        }

        card.addView(bodyView)

        // --------------------------------
        // Pickup
        // --------------------------------

        val pickup = TextView(this).apply {

            text = "📍  Vijay Nagar"

            textSize = 16f

            setTextColor(Color.DKGRAY)

            setPadding(
                0,
                dp(16),
                0,
                dp(4)
            )
        }

        card.addView(pickup)

        // --------------------------------
        // Drop
        // --------------------------------

        val drop = TextView(this).apply {

            text = "🏁  Airport"

            textSize = 16f

            setTextColor(Color.DKGRAY)

            setPadding(
                0,
                dp(4),
                0,
                dp(4)
            )
        }

        card.addView(drop)

        // --------------------------------
        // Fare
        // --------------------------------

        val fare = TextView(this).apply {

            text = "₹245"

            textSize = 24f

            setTextColor(
                Color.rgb(0, 130, 70)
            )

            setTypeface(
                null,
                android.graphics.Typeface.BOLD
            )

            setPadding(
                0,
                dp(8),
                0,
                dp(12)
            )
        }

        card.addView(fare)

        // --------------------------------
        // Buttons
        // --------------------------------

        val buttonRow = LinearLayout(this).apply {

            orientation = LinearLayout.HORIZONTAL

            gravity = Gravity.CENTER
        }

        // --------------------------------
        // Reject Button
        // --------------------------------

        val rejectButton = Button(this).apply {

            text = "REJECT"

            textSize = 14f

            setTextColor(Color.RED)

            setOnClickListener {

                // TODO: Reject ride API

                stopSelf()
            }
        }

        // --------------------------------
        // Accept Button
        // --------------------------------

        val acceptButton = Button(this).apply {

            text = "ACCEPT"

            textSize = 14f

            setTextColor(
                Color.rgb(0, 120, 70)
            )

            setOnClickListener {

                // Debug: FCM data
                Log.d(
                    "RIDE_ACCEPT",
                    "Title: ${titleView.text}"
                )

                Log.d(
                    "RIDE_ACCEPT",
                    "Body: ${bodyView.text}"
                )

                // Open Flutter app
                val intent = Intent(
                    this@RideOverlayService,
                    MainActivity::class.java
                )
                intent.putExtra("action", "ACCEPT_RIDE")

                intent.addFlags(
                    Intent.FLAG_ACTIVITY_NEW_TASK or
                            Intent.FLAG_ACTIVITY_CLEAR_TOP
                )

                startActivity(intent)

                // Close overlay service
                stopSelf()
            }
        }

        buttonRow.addView(
            rejectButton,
            LinearLayout.LayoutParams(
                0,
                LinearLayout.LayoutParams.WRAP_CONTENT,
                1f
            )
        )

        buttonRow.addView(
            acceptButton,
            LinearLayout.LayoutParams(
                0,
                LinearLayout.LayoutParams.WRAP_CONTENT,
                1f
            )
        )

        card.addView(buttonRow)

        // --------------------------------
        // Outer Container
        // --------------------------------
        // 10dp space from screen edges

        val container = LinearLayout(this).apply {

            orientation = LinearLayout.VERTICAL

            setPadding(
                dp(10),
                0,
                dp(10),
                0
            )
        }

        container.addView(
            card,
            LinearLayout.LayoutParams(
                LinearLayout.LayoutParams.MATCH_PARENT,
                LinearLayout.LayoutParams.WRAP_CONTENT
            )
        )

        overlayView = container

        // --------------------------------
        // Window Type
        // --------------------------------

        val windowType =
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {

                WindowManager.LayoutParams.TYPE_APPLICATION_OVERLAY

            } else {

                WindowManager.LayoutParams.TYPE_PHONE
            }

        // --------------------------------
        // Window Params
        // --------------------------------

        params = WindowManager.LayoutParams(

            WindowManager.LayoutParams.MATCH_PARENT,

            WindowManager.LayoutParams.WRAP_CONTENT,

            windowType,

            WindowManager.LayoutParams.FLAG_NOT_FOCUSABLE,

            PixelFormat.TRANSLUCENT
        )

        params.gravity =
            Gravity.TOP or Gravity.CENTER_HORIZONTAL

        params.y = dp(20)

        // --------------------------------
        // Swipe / Drag
        // --------------------------------

        card.setOnTouchListener { view, event ->

            when (event.action) {

                MotionEvent.ACTION_DOWN -> {

                    initialX = params.x
                    initialY = params.y

                    initialTouchX = event.rawX
                    initialTouchY = event.rawY

                    true
                }

                MotionEvent.ACTION_MOVE -> {

                    val diffX =
                        event.rawX - initialTouchX

                    val diffY =
                        event.rawY - initialTouchY

                    // --------------------------------
                    // Horizontal Swipe
                    // --------------------------------

                    if (abs(diffX) > dp(120)) {

                        view.animate()
                            .translationX(
                                if (diffX > 0) {
                                    dp(500).toFloat()
                                } else {
                                    -dp(500).toFloat()
                                }
                            )
                            .setDuration(250)
                            .withEndAction {
                                stopSelf()
                            }
                            .start()

                        true

                    } else {

                        // --------------------------------
                        // Drag
                        // --------------------------------

                        params.x =
                            initialX + diffX.toInt()

                        params.y =
                            initialY + diffY.toInt()

                        windowManager.updateViewLayout(
                            overlayView,
                            params
                        )

                        true
                    }
                }

                MotionEvent.ACTION_UP -> {

                    true
                }

                else -> {

                    false
                }
            }
        }

        // --------------------------------
        // Show Overlay
        // --------------------------------

        windowManager.addView(
            overlayView,
            params
        )
    }

    // --------------------------------
    // Create Foreground Notification Channel
    // --------------------------------

    private fun createNotificationChannel() {

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {

            val channel = NotificationChannel(
                CHANNEL_ID,
                "Ride Overlay",
                NotificationManager.IMPORTANCE_LOW
            )

            channel.description =
                "Shows ride request service status"

            val notificationManager =
                getSystemService(
                    NotificationManager::class.java
                )

            notificationManager.createNotificationChannel(
                channel
            )
        }
    }

    // --------------------------------
    // Receive FCM data
    // --------------------------------

    override fun onStartCommand(
        intent: Intent?,
        flags: Int,
        startId: Int
    ): Int {

        val notificationTitle =
            intent?.getStringExtra(
                "notification_title"
            ) ?: "🚗  New Ride Request"

        val notificationBody =
            intent?.getStringExtra(
                "notification_body"
            ) ?: ""

        // Update overlay UI
        if (::titleView.isInitialized) {

            titleView.text =
                notificationTitle
        }

        if (::bodyView.isInitialized) {

            bodyView.text =
                notificationBody
        }

        return START_NOT_STICKY
    }

    // --------------------------------
    // Service Destroy
    // --------------------------------

    override fun onDestroy() {

        if (::overlayView.isInitialized) {

            try {

                windowManager.removeView(
                    overlayView
                )

            } catch (_: Exception) {
                // Already removed
            }
        }

        super.onDestroy()
    }

    // --------------------------------
    // Bind
    // --------------------------------

    override fun onBind(
        intent: Intent?
    ): IBinder? {

        return null
    }
}