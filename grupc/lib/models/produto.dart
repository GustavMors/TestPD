class Produto {
  int? id;
  String? codBarras;
  String? descricao;


  Produto({
    this.id,
    this.codBarras,
    this.descricao
  });

  static Produto fromJSON(Map<dynamic, dynamic> json) {
    return Produto(
      id: json['idProduto'],
      codBarras: json['codBarras'],
      descricao: json['descricao'],
    );
  }
}