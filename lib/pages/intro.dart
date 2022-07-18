import 'dart:developer';

import 'package:med/pages/welcome.dart';

import 'package:med/main.dart';
import 'package:flutter/material.dart';
import 'package:intro_slider/intro_slider.dart';

class IntroScreenDefault extends StatefulWidget {
  const IntroScreenDefault({Key? key}) : super(key: key);

  @override
  IntroScreenDefaultState createState() => IntroScreenDefaultState();
}

class IntroScreenDefaultState extends State<IntroScreenDefault> {
  List<Slide> slides = [];

  @override
  void initState() {
    super.initState();

    slides.add(
      Slide(
        title: "BOAS VINDAS",
        description:
            "Temos como objetivo facilitar a forma com que você gerencia os seus remédios.",
        pathImage: null,
        backgroundColor: Color.fromARGB(255, 0, 0, 0),
      ),
    );
    slides.add(
      Slide(
        title: "TENHA CONTROLE",
        description:
            "A principal funcionalidade do aplicativo é realizar o controle facilitado de horário que se adequa a sua rotina!",
        pathImage: null,
        backgroundColor: Color.fromARGB(255, 65, 65, 65),
      ),
    );
    slides.add(
      Slide(
        title: "É ÓTIMO TE TER AQUI",
        description:
            "Todas as suas informações serão salvas no aplicativo para que você não precise colocar tudo de novo toda vez.",
        pathImage: null,
        backgroundColor: Color.fromARGB(255, 153, 153, 153),
      ),
    );
  }

  void onDonePress() {
    // Do what you want
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => Welcome()));
    log("End of slides");
  }

  @override
  Widget build(BuildContext context) {
    return IntroSlider(
      slides: slides,
      onDonePress: onDonePress,
    );
  }
}
