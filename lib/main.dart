import 'package:flutter/material.dart';
import 'package:med/pages/home.dart';
import 'package:med/pages/intro.dart';
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
      theme: ThemeData(
        primarySwatch: const MaterialColor(
          0xFF000000, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
          <int, Color>{
            50: Color(0xffce5641), //10%
            100: Color(0xffb74c3a), //20%
            200: Color(0xffa04332), //30%
            300: Color(0xff89392b), //40%
            400: Color(0xff733024), //50%
            500: Color(0xff5c261d), //60%
            600: Color(0xff451c16), //70%
            700: Color(0xff2e130e), //80%
            800: Color(0xff170907), //90%
            900: Color(0xff000000), //100%
          },
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: showWelcome ? Home() : const IntroScreenDefault(),
      //home: IntroScreenDefault(),
      debugShowCheckedModeBanner: false,
    );
  }
}
