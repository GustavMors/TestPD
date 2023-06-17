
import 'package:grupc/bloc/produto_api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/login.dart';
import '../models/produto.dart';
import '../utils/bloc_response.dart';
import '../utils/simple_bloc.dart';
import 'login_api.dart';

class LoginBloc extends SimpleBloc<BlocResponse?> {
  Future<Login?> logar (String email, String senha) async {
    try {
      add(BlocResponse(loading: true));
      var result = await LoginAPI.getLogin(email, senha);
      if (result == null) {
        addError('Usuário ou senha incorretos!');
      } else {
        var login = Login.fromJSON(result);
        return login;    
        add(BlocResponse(
          response: login,
          loading: false
        ));
        
      }
    } catch (e) {
      addError(e.toString());
    }
  }
}