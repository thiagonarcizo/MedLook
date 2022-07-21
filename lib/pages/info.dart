import 'package:flutter/material.dart';
import '/pages/welcome.dart' as welcome;
import '../models/person.dart';
import '/repositories/globals.dart' as globals;
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class Info extends StatelessWidget {
  Info({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          children: [
            Text('Precisamos de mais informações suas...'),
            SizedBox(height: 32),
            TextField(
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(
                    color: Colors.black,
                    width: 1,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(
                    color: Colors.black,
                    width: 1,
                  ),
                ),
                labelText: 'Quantos anos você tem?',
              ),
              //controller: idade,
              //onSubmitted: submit,
            ),
          ],
        ),
      ),
    );
  }
}
