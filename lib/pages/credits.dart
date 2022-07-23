import 'package:flutter/material.dart';
import 'package:med/pages/home.dart';
import 'package:proste_bezier_curve/proste_bezier_curve.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io';

class Credits extends StatelessWidget {
  const Credits({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: upMenu(),
      drawer: SideMenu(),
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipPath(
              clipper: ProsteThirdOrderBezierCurve(
                position: ClipPosition.bottom,
                list: [
                  ThirdOrderBezierCurveSection(
                    p1: Offset(0, 100),
                    p2: Offset(0, 200),
                    p3: Offset(MediaQuery.of(context).size.width, 100),
                    p4: Offset(MediaQuery.of(context).size.width, 200),
                  ),
                ],
              ),
              child: Container(
                height: 200,
                color: Colors.black,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 48.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(bottom: 16),
                    child: Text(
                      'feito por thiago narcizo em flutter',
                      style: TextStyle(fontSize: 24),
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          final Uri uri = Uri.parse("https://www.narcizo.xyz/");
                          if (await canLaunchUrl(uri)) {
                            await launchUrl(uri,
                                mode: LaunchMode.externalApplication);
                          } else {
                            print('can\'t launch');
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.black,
                          onPrimary: Colors.white,
                          fixedSize: const Size(130, 45),
                        ),
                        child: const Text('ver mais'),
                      ),
                      const SizedBox(width: 24),
                      ElevatedButton(
                        onPressed: () async {
                          final Uri uri = Uri.parse(
                              "https://github.com/thiagonarcizo/MedLook");
                          if (await canLaunchUrl(uri)) {
                            await launchUrl(uri,
                                mode: LaunchMode.externalApplication);
                          } else {
                            print('can\'t launch');
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.black,
                          onPrimary: Colors.white,
                          fixedSize: const Size(130, 45),
                        ),
                        child: const Text('link do projeto'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Expanded(
              child: Align(
                alignment: FractionalOffset.bottomCenter,
                child: Text('Versão: 1.0.0'),
              ),
            ),
            if (Platform.isWindows || Platform.isLinux || Platform.isMacOS)
              const Expanded(
                child: Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: Text(
                      '*notar que essa aplicação desktop é uma versão adaptada de uma apliacação mobile!'),
                ),
              ),
            ClipPath(
              clipper: ProsteBezierCurve(
                position: ClipPosition.top,
                list: [
                  BezierCurveSection(
                    start: Offset(MediaQuery.of(context).size.width, 0),
                    top: Offset(MediaQuery.of(context).size.width / 2, 30),
                    end: Offset(0, 0),
                  ),
                ],
              ),
              child: Container(
                color: Colors.black,
                height: 150,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

PreferredSizeWidget upMenu() {
  return AppBar(
    title: const Text('Créditos'),
    actions: [
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: const [
            SizedBox(width: 12),
          ],
        ),
      ),
    ],
    backgroundColor: Colors.black,
  );
}
