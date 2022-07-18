import 'package:flutter/material.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:med/pages/intro.dart';
import 'package:med/pages/welcome.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'MedLook',
      home: IntroScreenDefault(),
      debugShowCheckedModeBanner: false,
    );
  }
}
