import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:med/models/med.dart';
import 'package:med/models/meds.dart';
import 'package:med/pages/profile.dart';
import 'package:med/pages/welcome.dart';
import 'package:med/repositories/meddata.dart';
import 'package:proste_bezier_curve/proste_bezier_curve.dart';
import '../repositories/data.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';
import '../models/person.dart';
import '../widgets/med_list_item.dart';
import 'credits.dart';
import 'med_add/medadd.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

List<Med> medsLoad = [];

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    loadSharedPrefsPerson();
    sharedPrefMed.read().then((value) {
      setState(() {
        medsLoad = value;
      });
    });
  }

  SharedPref sharedPref = SharedPref();

  SharedPrefMed sharedPrefMed = SharedPrefMed();

  Person personSave = Person();

  Person personLoad = Person();

  Med? deletedMed;
  int? deletedMedPos;

  loadSharedPrefsPerson() async {
    try {
      Person person = Person.fromJson(await sharedPref.read("user"));
      setState(() {
        personLoad = person;
      });
    } catch (Excepetion) {
      print("No person found!");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: upMenu(context),
      drawer: SideMenu(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipPath(
              clipper: ProsteBezierCurve(
                position: ClipPosition.bottom,
                list: [
                  BezierCurveSection(
                    start: Offset(0, 75),
                    top: Offset(MediaQuery.of(context).size.width / 2, 90),
                    end: Offset(MediaQuery.of(context).size.width, 130),
                  ),
                  /*BezierCurveSection(
                    start: Offset(0, 125),
                    top: Offset(MediaQuery.of(context).size.width / 4, 150),
                    end: Offset(MediaQuery.of(context).size.width / 2, 125),
                  ),*/
                ],
              ),
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 18.0),
                      child: RotationTransition(
                          turns: AlwaysStoppedAnimation(43 / 360),
                          child: Image.asset(
                            "assets/launcher/medlogo_b.png",
                          )),
                    ),
                  ],
                ),
                width: MediaQuery.of(context).size.width,
                height: 130,
                color: Colors.black,
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: AutoSizeText('Meds:',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1),
                ),
              ],
            ),
            SizedBox(
              height: 16,
            ),
            ListView(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (medsLoad.isNotEmpty)
                      for (Med med in medsLoad)
                        Center(
                          child: MedListItem(
                            med: med,
                            onDelete: onDelete,
                          ),
                        )
                    else
                      Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Center(
                          child: AutoSizeText(
                            'Nenhum medicamento cadastrado',
                            style: TextStyle(fontSize: 26),
                            maxLines: 1,
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddMed()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void onDelete(Med med) {
    deletedMed = med;
    deletedMedPos = medsLoad.indexOf(med);

    setState(() {
      medsLoad.remove(med);
    });
    sharedPrefMed.save(medsLoad);

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Remédio ${med.nome} deletado',
            style: const TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        action: SnackBarAction(
          label: 'Desfazer',
          textColor: Colors.black,
          onPressed: () {
            setState(() {
              medsLoad.insert(deletedMedPos!, deletedMed!);
            });
            sharedPrefMed.save(medsLoad);
          },
        ),
        duration: const Duration(seconds: 5),
      ),
    );
  }
}

//A parte de baixo do código é o código do menu lateral e do menu superior

class SideMenu extends StatefulWidget {
  SideMenu({Key? key}) : super(key: key);

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  SharedPrefMed sharedPrefMed = SharedPrefMed();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: ListView(
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          children: [
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                'MedLook',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Início'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Home()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Perfil'),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: ((context) => Profile())));
              },
            ),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text('Créditos'),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).push(
                    MaterialPageRoute(builder: ((context) => const Credits())));
              },
            ),
            ListTile(
              leading: const Icon(Icons.exit_to_app),
              title: const Text('Resetar'),
              onTap: () {
                showAlertDialog(context);
              },
            ),
            if (Platform.isWindows || Platform.isLinux || Platform.isMacOS)
              Container(color: Colors.black, height: 3),
            if (Platform.isWindows || Platform.isLinux || Platform.isMacOS)
              ListTile(
                leading: const Icon(
                  Icons.minimize,
                ),
                title: const Text(
                  'Minimizar',
                ),
                onTap: () {
                  appWindow.minimize();
                },
              ),
            if (Platform.isWindows || Platform.isLinux || Platform.isMacOS)
              ListTile(
                leading: const Icon(
                  Icons.square_outlined,
                ),
                title: const Text(
                  'Maximizar',
                ),
                onTap: () {
                  appWindow.maximizeOrRestore();
                },
              ),
            if (Platform.isWindows || Platform.isLinux || Platform.isMacOS)
              ListTile(
                leading: const Icon(Icons.close,
                    color: Color.fromARGB(255, 109, 53, 49)),
                title: const Text('Fechar',
                    style: TextStyle(color: Color.fromARGB(255, 109, 53, 49))),
                onTap: () {
                  appWindow.close();
                },
              ),
          ],
        ),
      ),
    );
  }

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: const Text("Cancelar"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = TextButton(
      child: const Text("Prosseguir", style: TextStyle(color: Colors.red)),
      onPressed: () {
        SharedPref sharedPref = SharedPref();
        sharedPref.remove('med');
        sharedPref.remove('user');
        medsLoad.clear();
        sharedPrefMed.save(medsLoad);
        Navigator.pop(context);
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => const Welcome()));
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Tem certeza?"),
      content: const Text(
          "Todos os seus dados serão apagados, e você será redirecionado para a tela de boas-vindas."),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}

AppBar upMenu(BuildContext context) {
  showAlertDialogMed(BuildContext context) {
    Widget cancelButton = TextButton(
      child: const Text("Cancelar"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = TextButton(
      child: const Text("Prosseguir", style: TextStyle(color: Colors.red)),
      onPressed: () {
        SharedPref sharedPref = SharedPref();
        SharedPrefMed sharedPrefMed = SharedPrefMed();
        sharedPref.remove('med');
        medsLoad.clear();
        sharedPrefMed.save(medsLoad);
        Navigator.pop(context);
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => Home()));
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Tem certeza?"),
      content: const Text("Todos os seus medicamentos serão apagados!"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  return AppBar(
    title: Text('Início'),
    flexibleSpace: Platform.isWindows || Platform.isLinux || Platform.isMacOS
        ? Container(
            child: MoveWindow(),
            width: 25,
          )
        : null,
    actions: [
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
                onTap: () {
                  print('botão pesquisar pressionado');
                },
                child: Icon(Icons.search)),
            SizedBox(width: 4),
            PopupMenuButton(itemBuilder: (context) {
              return [
                PopupMenuItem<int>(
                  value: 0,
                  child: Text("Configurações"),
                ),
                PopupMenuItem<int>(
                  value: 1,
                  child: Text("Gerar PDF dos medicamentos"),
                ),
                PopupMenuItem<int>(
                  value: 2,
                  child: Text("Apagar todos os medicamentos"),
                ),
              ];
            }, onSelected: (value) {
              if (value == 0) {
                print("Configurações is selected.");
              } else if (value == 1) {
                print("Gerar PDF dos medicamentos.");
              } else if (value == 2) {
                print("Apagar todos os medicamentos is selected.");
                showAlertDialogMed(context);
              }
            }),
            if (Platform.isWindows || Platform.isLinux || Platform.isMacOS)
              SizedBox(width: 12),
            if (Platform.isWindows || Platform.isLinux || Platform.isMacOS)
              WindowButtons(),
          ],
        ),
      ),
    ],
    backgroundColor: Colors.black,
  );
}

class TitleBar extends StatefulWidget {
  const TitleBar({Key? key}) : super(key: key);

  @override
  State<TitleBar> createState() => _TitleBarState();
}

class _TitleBarState extends State<TitleBar> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        WindowTitleBarBox(
          child: Row(
            children: [
              Expanded(
                child: Container(),
              ),
              WindowButtons(),
            ],
          ),
        )
      ],
    );
  }
}

class WindowButtons extends StatelessWidget {
  const WindowButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        MinimizeWindowButton(
            animate: true,
            colors: WindowButtonColors(
                normal: Colors.transparent,
                iconNormal: Colors.white,
                mouseOver: Color(0xFF404040),
                mouseDown: Color(0xFF202020),
                iconMouseOver: Color(0xFFFFFFFF),
                iconMouseDown: Color(0xFFF0F0F0))),
        MaximizeWindowButton(
            animate: true,
            colors: WindowButtonColors(
                normal: Colors.transparent,
                iconNormal: Colors.white,
                mouseOver: Color(0xFF404040),
                mouseDown: Color(0xFF202020),
                iconMouseOver: Color(0xFFFFFFFF),
                iconMouseDown: Color(0xFFF0F0F0))),
        CloseWindowButton(
            animate: true,
            colors: WindowButtonColors(
                normal: Colors.transparent,
                iconNormal: Colors.white,
                mouseOver: Color.fromARGB(40, 255, 0, 0),
                mouseDown: Color(0xFF202020),
                iconMouseOver: Color.fromARGB(255, 255, 0, 0),
                iconMouseDown: Color(0xFFF0F0F0))),
      ],
    );
  }
}
