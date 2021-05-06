import 'package:flutter/material.dart';
import 'package:todo_app/db/user_database.dart';
import 'package:todo_app/model/user.dart';
import 'package:todo_app/page/notes_page.dart';
import 'package:todo_app/page/singup.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  static final String title = 'Notes SQLite';
  bool? isAlreadyLogin;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: title,
      themeMode: ThemeMode.dark,
      theme: ThemeData(
        primaryColor: Colors.black,
        scaffoldBackgroundColor: Colors.blueGrey.shade900,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
      ),
      home: SignupPage(),
    );
  }
}
