import 'package:app/screens/login_screen.dart';
import 'package:app/screens/tasks_screen.dart';
import 'package:app/services/auth_service.dart';
import 'package:app/services/shared_preferences.dart';
import 'package:app/services/task_service.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

void setupLocator() {
  GetIt.instance.registerLazySingleton(() => AuthService());
  GetIt.instance.registerLazySingleton(() => TaskService());
  GetIt.instance.registerLazySingleton(() => SharedPrefernces());
}

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Widget active_page = Container();

  SharedPrefernces shared_prefs = GetIt.I<SharedPrefernces>();

  initUser() async {
    print("================ INITIALIZE ID ================");
    var id = await shared_prefs.getLoggedUserIDFromPrefs();
    if (id == null) {
      setState(() {
        active_page = LoginScreen();
      });
    } else {
      setState(() {
        active_page = TasksScreen();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    initUser();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: active_page,
    );
  }
}
