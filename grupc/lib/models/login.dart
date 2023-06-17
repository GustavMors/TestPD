class Login {
  int? id;
  String? nome;
  String? email;
  String? setor;
  String? senha;


  Login({
    this.id,
    this.nome,
    this.email,
    this.setor,
    this.senha
  });

  static Login fromJSON(Map<dynamic, dynamic> json) {
    return Login(
      id: json['idFuncionario'],
      nome: json['nome'],
      email: json['email'],
      setor: json['setor'],
      senha: json['senha'],
    );
  }
}