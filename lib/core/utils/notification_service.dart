import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz_data;

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  final FlutterLocalNotificationsPlugin _notifications =
      FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    tz_data.initializeTimeZones();
    const androidSettings = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );
    const iosSettings = DarwinInitializationSettings();

    const initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );
    await _notifications.initialize(initSettings);
  }

  Future<void> scheduleNotifications({
    required DateTime nextPeriod,
    required DateTime ovulationDay,
  }) async {
    await cancelAll();

    // Period reminder (1 day before)
    await scheduleNotification(
      id: 1,
      title: 'Period Reminder',
      body: 'Your period is expected tomorrow.',
      scheduledDate: nextPeriod.subtract(const Duration(days: 1)),
    );

    // Ovulation reminder
    await scheduleNotification(
      id: 2,
      title: 'Ovulation Day',
      body: 'Today is your estimated ovulation day!',
      scheduledDate: ovulationDay,
    );
  }

  Future<void> scheduleNotification({
    required int id,
    required String title,
    required String body,
    required DateTime scheduledDate,
  }) async {
    if (scheduledDate.isBefore(DateTime.now())) return;

    await _notifications.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.from(scheduledDate, tz.local),
      const NotificationDetails(
        android: AndroidNotificationDetails('ovula_channel', 'Ovula Reminders'),
        iOS: DarwinNotificationDetails(),
      ),
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    );
  }

  Future<void> cancelAll() async {
    await _notifications.cancel(1);
    await _notifications.cancel(2);
  }
}
