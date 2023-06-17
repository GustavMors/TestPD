class Movimentacao{
  int? idEstoqueRecebedor;
  int? idEstoqueSaida;
  int? idTipoMovimentacaoEstoque;
  int? idFuncionarioSolicitador;
  int? idFuncionarioAutenticador;
  int? idProduto;
  int? quantidade;

  Movimentacao({
    this.idEstoqueRecebedor,
    this.idEstoqueSaida,
    this.idTipoMovimentacaoEstoque,
    this.idFuncionarioAutenticador,
    this.idProduto,
    this.idFuncionarioSolicitador,
    this.quantidade
  });

  static Movimentacao fromJSON(Map<dynamic, dynamic> json) {
    return Movimentacao(
      idEstoqueRecebedor: json['idEstoqueRecebedor'],
      idEstoqueSaida: json['idEstoqueSaida'],
      idFuncionarioSolicitador: json['idFuncionarioSolicitador'],
      idTipoMovimentacaoEstoque: json['idTipoMovimentacaoEstoque'],
      idFuncionarioAutenticador: json['idFuncionarioAutenticador'],
      idProduto: json['idProduto'],
      quantidade: json['quantidade']
    );
  }
}