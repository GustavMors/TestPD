
import 'package:http/http.dart' as http;

const baseURL = '10.0.2.2:7220';
const urlAuxiliar = '/Fornecedores/ListarFornecedores';

class FornecedoresAPI {
  
  static Future getFornecedores() async {

    Uri url = Uri.https(baseURL, urlAuxiliar);
    return await http.get(url);

  }
}