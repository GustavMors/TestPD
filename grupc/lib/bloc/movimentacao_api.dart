import 'dart:convert' as convert;
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/movimentacao.dart';

int idFornecedor = 1;

class MovimentacaoAPI {
  static Future<Movimentacao?> postMovimentacao(
    int idEstoqueRecebedor,
    int idEstoqueSaida,
    int idFuncionario,
    int idProduto,
    int quantidade,
  ) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };
    //localhost:7220/Movimentacaos/CadastrarMovimentacao

    String urlBase = '10.0.2.2:7220';
    String urlComplementar = '/registrar/movimentacaoEstoque';

    Uri uri = Uri.https(urlBase, urlComplementar);
    var response = await http.post(uri,
        headers: headers,
        body: jsonEncode({
          "idEstoqueRecebedor": "${idEstoqueRecebedor}",
          "idEstoqueSaida": "${idEstoqueSaida}",
          "idTipoMovimentacaoEstoque": "5",
          "idFuncionarioSolicitador": "${idFuncionario}",
          "idFuncionarioAutenticador": "${idFuncionario}",
          "idProduto": "${idProduto}",
          "quantidade": "${quantidade}"
        }));
    print(response);

    if (response.statusCode >= 400) {
      return null;
    }
  }
}
