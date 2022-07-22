import 'package:flutter/material.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:med/pages/intro.dart';
import 'package:med/pages/welcome.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();
  bool showWelcome = prefs.getBool('showWelcome') ?? false;

  runApp(MyApp(showWelcome: showWelcome));
}

class MyApp extends StatelessWidget {
  final bool showWelcome;
  const MyApp({Key? key, required this.showWelcome}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MedLook',
      home: showWelcome ? Welcome() : IntroScreenDefault(),
      //home: IntroScreenDefault(),
      debugShowCheckedModeBanner: false,
    );
  }
}
