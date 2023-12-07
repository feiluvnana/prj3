import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:prj3_app/blocs/course.bloc.dart';
import 'package:prj3_app/blocs/document.bloc.dart';
import 'package:prj3_app/blocs/reminder.bloc.dart';
import 'package:prj3_app/blocs/student.bloc.dart';
import 'package:prj3_app/ui/home.ui.dart';
import 'package:prj3_app/ui/init.ui.dart';
import 'package:prj3_app/ui/register.ui.dart';
import 'package:flutter/material.dart';
import 'ui/login.ui.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

const storage = FlutterSecureStorage();
final navigatorKey = GlobalKey<NavigatorState>();
const String dataPath = "storage/emulated/0/Download";
final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  tz.initializeTimeZones();
  tz.setLocalLocation(tz.getLocation("Asia/Ho_Chi_Minh"));
  await AndroidAlarmManager.initialize();
  await flutterLocalNotificationsPlugin.initialize(
      const InitializationSettings(android: AndroidInitializationSettings('@mipmap/ic_launcher')));
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
      ?.requestNotificationsPermission();
  String? initialRoute = await storage.read(key: "first");
  runApp(PRJ3(initialRoute: initialRoute ?? "/init"));
}

class PRJ3 extends StatelessWidget {
  final String initialRoute;

  const PRJ3({super.key, this.initialRoute = "/login"});

  @override
  Widget build(BuildContext context) {
    var colorScheme = ColorScheme.fromSeed(seedColor: const Color(0xffadf7b6));
    return MultiBlocProvider(
      providers: [
        BlocProvider(lazy: false, create: (context) => StudentBloc()),
        BlocProvider(lazy: false, create: (context) => DocumentBloc()),
        BlocProvider(lazy: false, create: (context) => ReminderBloc()),
        BlocProvider(lazy: false, create: (context) => CourseBloc())
      ],
      child: MaterialApp(
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          chipTheme: Theme.of(context).chipTheme.copyWith(
                iconTheme: Theme.of(context).chipTheme.iconTheme?.copyWith(size: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                padding: EdgeInsets.zero,
              ),
          floatingActionButtonTheme: const FloatingActionButtonThemeData(shape: CircleBorder()),
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                  backgroundColor: colorScheme.primary,
                  foregroundColor: colorScheme.onPrimary,
                  padding: const EdgeInsets.all(10),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)))),
          inputDecorationTheme: InputDecorationTheme(
              fillColor: colorScheme.onInverseSurface,
              filled: true,
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide.none, borderRadius: BorderRadius.circular(8)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: colorScheme.primary, width: 1.5),
                  borderRadius: BorderRadius.circular(8)),
              focusedErrorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: colorScheme.error, width: 1.5),
                  borderRadius: BorderRadius.circular(8)),
              errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: colorScheme.error),
                  borderRadius: BorderRadius.circular(8))),
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xffadf7b6)),
          useMaterial3: true,
        ),
        routes: {
          "/init": (context) => const InitUI(),
          "/login": (context) => const LoginUI(),
          "/register": (context) => const RegisterUI(),
          "/home": (context) => const HomeUI()
        },
        initialRoute: initialRoute,
      ),
    );
  }
}
