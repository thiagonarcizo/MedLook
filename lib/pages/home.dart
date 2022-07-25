import 'package:flutter/material.dart';
import 'package:med/pages/profile.dart';
import 'package:med/pages/welcome.dart';
import '../repositories/data.dart';

import '../models/person.dart';
import 'credits.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    loadSharedPrefs();
    super.initState();
  }

  SharedPref sharedPref = SharedPref();

  Person personSave = Person();

  Person personLoad = Person();

  loadSharedPrefs() async {
    try {
      Person person = Person.fromJson(await sharedPref.read("user"));
      setState(() {
        personLoad = person;
      });
    } catch (Excepetion) {
      print("Nothing found!");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: upMenu(),
      drawer: SideMenu(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              'Tela de início',
              style: TextStyle(fontSize: 30),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: () {
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

PreferredSizeWidget upMenu() {
  return AppBar(
    title: Text('Início'),
    actions: [
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: const [
            Icon(Icons.search),
            SizedBox(width: 12),
            Icon(Icons.more_vert),
          ],
        ),
      ),
    ],
    backgroundColor: Colors.black,
  );
}
