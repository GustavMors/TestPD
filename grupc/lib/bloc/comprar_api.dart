import 'dart:convert' as convert;
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/compra.dart';

int idFornecedor = 1;

class CompraAPI {
  static Future<Compra?> postCompra(
    String codBarras,
    int quantidade,
    int idProduto,
    int idFuncionario,
  ) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };
    //localhost:7220/Compras/CadastrarCompra

    String urlBase = '10.0.2.2:7220';
    String urlComplementar = '/Compras/CadastrarCompra';

    Uri uri = Uri.https(urlBase, urlComplementar);
    var response = await http.post(uri,
        headers: headers,
        body: jsonEncode({
          "cnpj": "20.185.384/0001-71",
          "codBarras": "${codBarras}",
          "quantidade": '${quantidade}',
          "idProduto": '${idProduto}',
          "idFornecedor": '${idFornecedor}',
          "idFuncionarioSol": '${idFuncionario}',
          "idFuncionarioAut": '${idFuncionario}'
        }));
    print(response);

    if (response.statusCode >= 400) {
      return null;
    }
  }
}
