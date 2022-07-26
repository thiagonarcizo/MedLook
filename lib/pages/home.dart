import 'dart:io';

import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:med/models/med.dart';
import 'package:med/models/meds.dart';
import 'package:med/pages/profile.dart';
import 'package:med/pages/welcome.dart';
import 'package:med/repositories/meddata.dart';
import '../repositories/data.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';

import '../models/person.dart';
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
      appBar: upMenu(),
      drawer: SideMenu(),
      body: Center(
        child: ListView(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (medsLoad.isNotEmpty)
                  Text(
                    'Remédio: ${medsLoad.first.nome}',
                    style: TextStyle(fontSize: 30),
                  )
                else
                  Text(
                    'Remédio: Nenhum remédio',
                    style: TextStyle(fontSize: 26),
                  ),
                Text(
                  '*ainda sob desenvolvimento',
                  style: TextStyle(fontSize: 16),
                ),
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        medsLoad.clear();
                        sharedPrefMed.save(medsLoad);
                      });
                    },
                    child: Text('Deletar todos os remédios')),
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
          print('Botão adicionar pressionado');
        },
        child: const Icon(Icons.add),
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

AppBar upMenu() {
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
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.search),
            SizedBox(width: 12),
            Icon(Icons.more_vert),
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
