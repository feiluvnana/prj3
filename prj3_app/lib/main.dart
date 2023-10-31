import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:prj3_app/blocs/authentication_bloc.dart';
import 'package:prj3_app/ui/home_ui.dart';
import 'package:prj3_app/ui/register_ui.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';

import 'ui/login_ui.dart';

const storage = FlutterSecureStorage();
final navigatorKey = GlobalKey<NavigatorState>();
const String dataPath = "storage/emulated/0/Download";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseMessaging.instance.setAutoInitEnabled(true);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(lazy: false, create: (context) => AuthenticationBloc())],
      child: MaterialApp(
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xffadf7b6)),
          useMaterial3: true,
        ),
        routes: {
          "/login": (context) => const LoginUI(),
          "/register": (context) => const RegisterUI(),
          "/home": (context) => const HomeUI()
        },
        initialRoute: "/login",
      ),
    );
  }
}
