class Fornecedor{
  int? idFornecedor;
  String? cnpj;
  String? nome;


  Fornecedor({
    this.idFornecedor,
    this.cnpj,
    this.nome
  });

  static Fornecedor fromJSON(Map<dynamic, dynamic> json) {
    return Fornecedor(
      idFornecedor: json['idFornecedor'],
      cnpj: json['cnpj'],
      nome: json['nome'],
    );
  }
}