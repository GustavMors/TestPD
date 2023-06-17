import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

const baseURL = '10.0.2.2:7220';
const urlAuxiliar = '/Produtos';

class ProdutoAPI {
  static Future<Map?> getProduto(String codBarras) async {
    // localhost:7220/Produtos/ConsulatarProdutoCodBarras?codBarras=

    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };
    String urlBase = '10.0.2.2:7220';
    String urlComplementar = '/Produtos/ConsulatarProdutoCodBarras';
    Map<String, String> queryParams = {
      'codBarras' : codBarras
    };

    Uri uri = Uri.https(urlBase, urlComplementar, queryParams);
    var response = await http.get(uri, headers: headers);
    print(response);

    if (response.statusCode >= 400) {
      return null;
    }

    Map mapResponse = convert.json.decode(response.body);
    return mapResponse;
  }

  

  static Future getProdutos() async {

    Uri url = Uri.https(baseURL, urlAuxiliar);
    return await http.get(url);

  }
}
