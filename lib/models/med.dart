import 'package:flutter/material.dart';

class Med {
  Med({
    this.nome,
    this.tipoDosagem,
    this.posologia,
    this.dosagem,
    this.quantidade = 1,
    this.tipoQuantidade,
    this.horario = const [],
    this.hora1,
    this.hora2,
    this.hora3,
    this.hora4,
    this.hora5,
    this.hora6,
    this.hora7,
    this.hora8,
  });

  String? nome;
  String? tipoDosagem;
  String? tipoQuantidade;
  int? posologia;
  int? dosagem;
  int quantidade;
  String? hora1;
  String? hora2;
  String? hora3;
  String? hora4;
  String? hora5;
  String? hora6;
  String? hora7;
  String? hora8;

  late List<String?> horario;

  Med.fromJson(Map<String, dynamic> json)
      : nome = json['nome'],
        posologia = json['posologia'],
        dosagem = json['dosagem'],
        tipoQuantidade = json['tipoQuantidade'],
        tipoDosagem = json['tipoDosagem'],
        quantidade = json['quantidade'],
        hora1 = json['hora1'],
        hora2 = json['hora2'],
        hora3 = json['hora3'],
        hora4 = json['hora4'],
        hora5 = json['hora5'],
        hora6 = json['hora6'],
        hora7 = json['hora7'],
        hora8 = json['hora8'];

  Map<String, dynamic> toJson() => {
        'nome': nome,
        'posologia': posologia,
        'dosagem': dosagem,
        'quantidade': quantidade,
        'tipoQuantidade': tipoQuantidade,
        'tipoDosagem': tipoDosagem,
        'hora1': hora1,
        'hora2': hora2,
        'hora3': hora3,
        'hora4': hora4,
        'hora5': hora5,
        'hora6': hora6,
        'hora7': hora7,
        'hora8': hora8,
      };
}
