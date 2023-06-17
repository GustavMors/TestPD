class Disponivel {
  int? idEstoque;
  int? idProduto;
  int? quantidade;
  String? codBarras;
  String? descricao;



  Disponivel({
    this.idEstoque,
    this.idProduto,
    this.quantidade,
    this.codBarras,
    this.descricao
  });

  static Disponivel fromJSON(Map<dynamic, dynamic> json) {
    return Disponivel(
      idEstoque: json['idEstoque'],
      idProduto: json['idProduto'],
      quantidade: json['quantidade'],
      codBarras: json['codBarras'],
      descricao: json['descricao']
    );
  }
}