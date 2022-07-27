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
    this.dataInicio,
    this.dataFim,
    this.diasTratamento,
    this.periodoNaoInformado = true,
  });

  String? nome;
  String? tipoDosagem;
  String? tipoQuantidade;
  int? posologia;
  int? dosagem;
  int? quantidade;
  String? hora1;
  String? hora2;
  String? hora3;
  String? hora4;
  String? hora5;
  String? hora6;
  String? hora7;
  String? hora8;
  DateTime? dataInicio;
  DateTime? dataFim;
  int? diasTratamento;
  bool periodoNaoInformado;

  late List<String?> horario;

  Med.fromJson(Map<String, dynamic> json)
      : nome = json['nome'] as String?,
        posologia = json['posologia'] as int?,
        dosagem = json['dosagem'] as int?,
        tipoQuantidade = json['tipoQuantidade'] as String?,
        tipoDosagem = json['tipoDosagem'] as String?,
        quantidade = json['quantidade'] as int?,
        hora1 = json['hora1'] as String?,
        hora2 = json['hora2'] as String?,
        hora3 = json['hora3'] as String?,
        hora4 = json['hora4'] as String?,
        hora5 = json['hora5'] as String?,
        hora6 = json['hora6'] as String?,
        hora7 = json['hora7'] as String?,
        hora8 = json['hora8'] as String?,
        dataInicio = DateTime.parse(json['dataInicio'] as String),
        dataFim = DateTime.parse(json['dataFim'] as String),
        diasTratamento = json['diasTratamento'] as int?,
        periodoNaoInformado = json['periodoNaoInformado'] as bool;

  Map<String, dynamic> toJson() {
    return {
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
      'dataInicio':
          dataInicio?.toIso8601String() ?? DateTime.now().toIso8601String(),
      'dataFim': dataFim?.toIso8601String() ?? DateTime.now().toIso8601String(),
      'diasTratamento': diasTratamento ?? 0,
      'periodoNaoInformado': periodoNaoInformado,
    };
  }
}
