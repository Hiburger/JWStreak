package com.jwstreak.app

import android.app.PendingIntent
import android.content.Context
import android.os.Build
import androidx.core.app.NotificationCompat
import androidx.core.app.NotificationManagerCompat

/**
 * Posts the reading-session notification as an Android 16 "Live Update" — a
 * promoted ongoing notification, which the system surfaces as a chip in the
 * status bar with the timer running inside it, instead of only as a row in
 * the notification shade.
 *
 * This exists as native code because flutter_local_notifications builds its
 * NotificationCompat.Builder internally and exposes no way to set the
 * promoted-ongoing request, so the feature is unreachable from Dart through
 * that plugin (see MaikuB/flutter_local_notifications#2773).
 *
 * Below API 36 this reports failure rather than posting anything, and the
 * Dart side falls back to the plugin's ordinary ongoing notification — which
 * is what the large majority of devices will get for a while yet.
 */
object ReadingSessionLiveUpdate {
    /** Android 16, where promoted ongoing notifications were introduced. */
    private const val API_LIVE_UPDATES = 36

    /**
     * Mirrors the four-hour cap the Dart fallback sets, for the same reason:
     * Android can kill this process while the user reads in another app, and
     * a posted notification outlives its process, so an ongoing (and so
     * undismissable) one could otherwise strand the user.
     */
    private const val TIMEOUT_MILLIS = 4L * 60L * 60L * 1000L

    /**
     * Returns true only if a promoted notification was actually posted, so
     * the caller knows whether it still has to fall back.
     */
    fun show(
        context: Context,
        channelId: String,
        notificationId: Int,
        title: String,
        body: String,
        startedAtMillis: Long
    ): Boolean {
        if (Build.VERSION.SDK_INT < API_LIVE_UPDATES) {
            return false
        }
        return try {
            // Resumes the existing task rather than starting a second copy of
            // the app — this notification's whole job is "get me back to
            // where I was".
            val launchIntent = context.packageManager
                .getLaunchIntentForPackage(context.packageName)
            val contentIntent = PendingIntent.getActivity(
                context,
                0,
                launchIntent,
                PendingIntent.FLAG_IMMUTABLE or PendingIntent.FLAG_UPDATE_CURRENT
            )

            // Deliberately not setSilent(true), unlike the Dart fallback: a
            // silent notification ranks low enough that it can lose the
            // promotion this whole class exists to get. It stays quiet
            // anyway — the channel it posts to is created with no sound and
            // no vibration.
            val notification = NotificationCompat.Builder(context, channelId)
                .setSmallIcon(R.drawable.ic_stat_notify)
                .setContentTitle(title)
                .setContentText(body)
                .setContentIntent(contentIntent)
                // Ongoing is a hard requirement for promotion, not a
                // preference.
                .setOngoing(true)
                .setAutoCancel(false)
                // The pair that makes the timer tick on its own, in the chip
                // as well as in the shade — nothing pushed from our side.
                .setUsesChronometer(true)
                .setWhen(startedAtMillis)
                // Deliberately no setShortCriticalText: the chip renders
                // either that text or the chronometer, not both, and with the
                // text set it won — so the chip sat there showing a word
                // that never changed. Leaving it unset is what lets the
                // running timer through, which is the point of a Live Update.
                .setTimeoutAfter(TIMEOUT_MILLIS)
                // The actual ask. Without it this is just an ordinary ongoing
                // notification, which is exactly what we already had.
                .setRequestPromotedOngoing(true)
                .build()

            NotificationManagerCompat.from(context)
                .notify(notificationId, notification)
            true
        } catch (error: Throwable) {
            // A missing channel, a revoked POST_NOTIFICATIONS, a vendor build
            // that refuses the promotion — any of those leave the caller free
            // to fall back rather than losing the notification entirely.
            false
        }
    }
}
