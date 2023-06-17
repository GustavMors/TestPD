import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class LoginAPI {
  static Future<Map?> getLogin(String email, String senha) async {
    //localhost:7220/Login?email=jonas&senha=jonas

    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };
    String urlBase = '10.0.2.2:7220';
    String urlComplementar = '/Login';
    Map<String, String> queryParams = {
      'email' : email,
      'senha' : senha
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
}
