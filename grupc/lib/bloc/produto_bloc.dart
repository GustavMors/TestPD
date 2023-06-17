
import 'package:grupc/bloc/produto_api.dart';
import '../models/produto.dart';
import '../utils/bloc_response.dart';
import '../utils/simple_bloc.dart';

class ProdutoBloc extends SimpleBloc<BlocResponse?> {
  fetchByName(String codBarras) async {
    try {
      add(BlocResponse(loading: true));
      var result = await ProdutoAPI.getProduto(codBarras);
      if (result == null) {
        addError('Produto não encontrado!');
      } else {
        var produto = Produto.fromJSON(result);
        add(BlocResponse(
          response: produto,
          loading: false
        ));
      }
    } catch (e) {
      addError(e.toString());
    }
  }

  Future<Produto?> getProdutos () async {
    try {
      add(BlocResponse(loading: true));
      var result = await ProdutoAPI.getProdutos();
      if (result == null) {
        addError('Erro!');
      } else {
        var produtos = Produto.fromJSON(result);   

        add(BlocResponse(
          response: produtos,
          loading: false
        ));
        
      }
    } catch (e) {
      addError(e.toString());
      return null;
    }
    
  }
  
}