import 'package:flutter/material.dart';

import '../models/person.dart';
import '../repositories/data.dart';
import 'home.dart';

class Profile extends StatefulWidget {
  Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
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
      body: SafeArea(
        child: ListView(
          children: [
            Center(
              child: Column(
                children: [
                  Container(
                    color: Colors.black,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: Row(
                            children: [
                              Text(
                                'Oi, ${personLoad.nome}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 56,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(left: 12.0),
                                child: Icon(Icons.edit, color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: ListTile(
                      title: Text(
                        'Idade: ${personLoad.idade} anos',
                        style: const TextStyle(
                          fontSize: 24,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios),
                      onTap: () {},
                    ),
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: ListTile(
                      title: Text(
                        'Altura: ${personLoad.altura} cm',
                        style: const TextStyle(
                          fontSize: 24,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios),
                      onTap: () {},
                    ),
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: ListTile(
                      title: Text(
                        'Peso: ${personLoad.peso} kg',
                        style: const TextStyle(
                          fontSize: 24,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios),
                      onTap: () {},
                    ),
                  ),
                  /*Padding(
                  padding: const EdgeInsets.symmetric(vertical: 64.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Você possui ${personLoad.idade} anos',
                        style: const TextStyle(fontSize: 30),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Text(
                        'Mede ${personLoad.altura} cm',
                        style: const TextStyle(fontSize: 30),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Text(
                        'E pesa ${personLoad.peso} kg',
                        style: const TextStyle(fontSize: 30),
                      ),
                      const SizedBox(
                        height: 32,
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          primary: Colors.black,
                          onPrimary: Colors.white,
                          fixedSize: const Size(250, 50),
                        ),
                        child: const Text('Desejo alterar meus dados'),
                      ),
                    ],
                  ),
                ),*/
                ],
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
    title: Text('Perfil'),
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
