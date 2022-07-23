import 'package:flutter/material.dart';
import 'package:med/pages/home.dart';
import 'package:proste_bezier_curve/proste_bezier_curve.dart';
import 'package:url_launcher/url_launcher.dart';

class Credits extends StatelessWidget {
  const Credits({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: upMenu(),
      drawer: SideMenu(),
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
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
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  Center(
                    child: Column(
                      children: [
                        const Text(
                          'Feito por Thiago Narcizo em Flutter',
                          style: TextStyle(fontSize: 24),
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            final Uri uri =
                                Uri.parse("https://www.narcizo.xyz/");
                            if (await canLaunchUrl(uri)) {
                              await launchUrl(uri);
                            } else {
                              print('can\'t launch');
                            }
                          },
                          child: Text('oi'),
                        ),
                      ],
                    ),
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
