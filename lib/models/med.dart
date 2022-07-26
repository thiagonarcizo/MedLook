import 'package:flutter/material.dart';

class Med {
  Med(
      {this.nome,
      this.tipoDosagem,
      this.posologia,
      this.dosagem,
      this.quantidade = 1,
      this.tipoQuantidade,
      this.hora1});

  String? nome;
  String? tipoDosagem;
  String? tipoQuantidade;
  int? posologia;
  int? dosagem;
  int quantidade;
  String? hora1;

  Med.fromJson(Map<String, dynamic> json)
      : nome = json['nome'],
        posologia = json['posologia'],
        dosagem = json['dosagem'],
        tipoQuantidade = json['tipoQuantidade'],
        tipoDosagem = json['tipoDosagem'],
        quantidade = json['quantidade'],
        hora1 = json['hora1'];

  Map<String, dynamic> toJson() => {
        'nome': nome,
        'posologia': posologia,
        'dosagem': dosagem,
        'quantidade': quantidade,
        'tipoQuantidade': tipoQuantidade,
        'tipoDosagem': tipoDosagem,
        'hora': hora1
      };
}
