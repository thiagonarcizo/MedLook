class Person {
  Person({this.nome, this.idade, this.altura, this.peso, this.sexo});

  String? nome;
  int? idade;
  int? altura;
  double? peso;
  String? sexo;

  Person.fromJson(Map<String, dynamic> json)
      : nome = json['name'],
        idade = json['age'],
        altura = json['height'],
        peso = json['weight'],
        sexo = json['sex'];

  Map<String, dynamic> toJson() => {
        'name': nome,
        'age': idade,
        'height': altura,
        'weight': peso,
        'sex': sexo,
      };
}
