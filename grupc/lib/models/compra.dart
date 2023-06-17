class Compra{
  String? cnpj;
  String? codBarras;
  int? idProduto;
  int? quantidade;
  int? idFornecedor;
  int? idFuncionario;
  int? idFuncionarioA;

  Compra({
    this.cnpj,
    this.codBarras,
    this.idProduto,
    this.idFornecedor,
    this.idFuncionario,
    this.quantidade,
    this.idFuncionarioA
  });

  static Compra fromJSON(Map<dynamic, dynamic> json) {
    return Compra(
      cnpj: json['cnpj'],
      codBarras: json['codBarras'],
      quantidade: json['quantidade'],
      idProduto: json['idProduto'],
      idFornecedor: json['idFornecedor'],
      idFuncionario: json['idFuncionarioSol'],
      idFuncionarioA: json['idFuncionarioAut']
    );
  }
}