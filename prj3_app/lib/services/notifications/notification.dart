import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:prj3_app/models/reminder.model.dart';

class NotificationService {
  @pragma('vm:entry-point')
  static void _createEventNotification(int id, Map<String, dynamic> param) async {
    Event event = Event.fromJson(param["event"]);
    final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    await flutterLocalNotificationsPlugin.initialize(const InitializationSettings(
        android: AndroidInitializationSettings('@mipmap/ic_launcher')));
    flutterLocalNotificationsPlugin.show(
        (event.createdAt?.millisecondsSinceEpoch ?? 0) ~/ 1000,
        "${event.name} (Sẽ xảy ra sau ${event.timestamp!.difference(DateTime.now()).inMinutes} phút)",
        event.description,
        const NotificationDetails(
            android: AndroidNotificationDetails("0", "Channel",
                importance: Importance.high, priority: Priority.high)));
  }

  static void scheduleEventNotification(Event event) {
    DateTime scheduleTime = event.timestamp!.subtract(Duration(minutes: event.preNotifyTime));
    if (scheduleTime.compareTo(DateTime.now()) < 0) {
      _createEventNotification(0, {"event": event.toJson()});
      return;
    }
    AndroidAlarmManager.oneShotAt(event.timestamp!.subtract(Duration(minutes: event.preNotifyTime)),
        (event.createdAt?.millisecondsSinceEpoch ?? 0) ~/ 1000, _createEventNotification,
        alarmClock: true,
        allowWhileIdle: true,
        exact: true,
        wakeup: true,
        rescheduleOnReboot: true,
        params: {"event": event});
  }

  @pragma('vm:entry-point')
  static void _createRemindNotification(int id, Map<String, dynamic> param) async {
    if (param["weekday"].contains(DateTime.now().weekday)) {
      print("trigger ${DateTime.now()}");
    } else {
      print("not trigger ${DateTime.now()}");
      return;
    }
    Remind remind = Remind.fromJson(param["remind"]);
    final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    await flutterLocalNotificationsPlugin.initialize(const InitializationSettings(
        android: AndroidInitializationSettings('@mipmap/ic_launcher')));
    flutterLocalNotificationsPlugin.show(
        (remind.createdAt?.millisecondsSinceEpoch ?? 0) ~/ 1000,
        "Nhắc nhở: ${remind.name}",
        remind.description,
        const NotificationDetails(
            android: AndroidNotificationDetails("0", "Channel",
                importance: Importance.high, priority: Priority.high)));
  }

  static void scheduleRemindNotification(Remind remind) {
    var now = DateTime.now();
    var scheduleTime = now.copyWith(
        hour: remind.schedule["time"] ~/ 3600,
        minute: remind.schedule["time"] % 3600 ~/ 60,
        second: 0);
    if (now.isAfter(scheduleTime)) {
      print("df f");
      scheduleTime = scheduleTime.copyWith(day: scheduleTime.day + 1);
    }
    print("sche $scheduleTime");
    AndroidAlarmManager.periodic(const Duration(days: 1),
            (remind.createdAt?.millisecondsSinceEpoch ?? 0) ~/ 1000, _createRemindNotification,
            startAt: scheduleTime,
            allowWhileIdle: true,
            exact: true,
            wakeup: true,
            rescheduleOnReboot: true,
            params: {"remind": remind, "weekday": remind.schedule["weekday"]})
        .then((value) => print("df $value"));
  }
}
