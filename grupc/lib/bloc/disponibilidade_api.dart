import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

  const urlBasee = '10.0.2.2:7220';
  

class DisponibilidadeAPI {
  static Future<Map?> getDisponibilidade(String idProduto) async {
    //localhost:7220/Disponibilidade?email=jonas&senha=jonas

    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };
    String urlBase = '10.0.2.2:7220';
    String urlComplementar = '/consultar/disponibilidade/$idProduto';
    Map<String, String> queryParams = {
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

  static Future getProdutosDisponiveis(idProduto) async {

    String urlComplementarr = '/consultar/disponibilidade/$idProduto';

    Uri url = Uri.https(urlBasee, urlComplementarr);
    return await http.get(url);
  }

  static Future getQuantidade(codBarras) async{

     String urlComplementarrr = '/consultar/disponibilidade/$codBarras';

     Uri urll = Uri.https(urlBasee, urlComplementarrr);
     var result =  await http.get(urll);
     if(result == null){
      return -1;
     } else {
      return result;
     }
  }

  static Future getQuantidadeEstoque() async{

     String urlComplementarrr = '/consultar/disponibilidade/all';

     Uri urll = Uri.https(urlBasee, urlComplementarrr);
     var result =  await http.get(urll);
     if(result == null){
      return -1;
     } else {
      return result;
     }
  }
}
