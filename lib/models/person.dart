import 'package:flutter/material.dart';

class Person {
  Person({this.nome, this.idade, this.altura, this.peso});

  String? nome;
  int? idade;
  int? altura;
  double? peso;

  Person.fromJson(Map<String, dynamic> json)
      : nome = json['name'],
        idade = json['age'],
        altura = json['height'],
        peso = json['weight'];

  Map<String, dynamic> toJson() => {
        'name': nome,
        'age': idade,
        'height': altura,
        'weight': peso,
      };
}
