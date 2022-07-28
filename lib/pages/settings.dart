import 'dart:io';

import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:med/extensions/stringext.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/notification_api.dart';
import '../models/person.dart';
import '../repositories/data.dart';
import 'home.dart';
import 'package:auto_size_text/auto_size_text.dart';

class Settings extends StatefulWidget {
  Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  void initState() {
    loadSharedPrefs();
    super.initState();
  }

  SharedPref sharedPref = SharedPref();

  bool isChecked = false;

  final TextEditingController _textFieldController = TextEditingController();

  loadSharedPrefs() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final bool checked = prefs.getBool('notiset')!;
      setState(() {
        isChecked = checked;
      });
    } catch (Excepetion) {
      print("No notification setting found!");
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
                    height: MediaQuery.of(context).size.height * 0.1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: AutoSizeText(
                                  'Configurações',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 36,
                                  ),
                                  maxLines: 1,
                                ),
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
                      onTap: () {
                        setState(() {
                          if (!Platform.isWindows) {
                            NotificationApi.cancelAll();
                            print('Todas as notificações foram apagadas!');
                          } else {
                            print('Windows não suporta notificações...');
                          }
                        });
                      },
                      title: Text(
                        'Desativar todas as notificações agendadas',
                        style: const TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      trailing: Icon(Icons.delete_forever),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget upMenu() {
    return AppBar(
      flexibleSpace: Platform.isWindows || Platform.isLinux || Platform.isMacOS
          ? Container(
              child: MoveWindow(),
              width: 1,
            )
          : null,
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
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
}
