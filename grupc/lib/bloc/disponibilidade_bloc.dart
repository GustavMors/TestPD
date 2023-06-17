import '../models/quantidadeDisponivel.dart';
import '../utils/bloc_response.dart';
import '../utils/simple_bloc.dart';
import 'disponibilidade_api.dart';

class DisponibilidadeBloc extends SimpleBloc<BlocResponse?> {
  Future<Disponivel?> getDisponibilidade (String idProduto) async {
    try {
      add(BlocResponse(loading: true));
      var result = await DisponibilidadeAPI.getDisponibilidade(idProduto);
      if (result == null) {
        addError('Erro!');
      } else {
        var disponibilidade = Disponivel.fromJSON(result);
        return disponibilidade;    
        add(BlocResponse(
          response: disponibilidade,
          loading: false
        ));
        
      }
    } catch (e) {
      addError(e.toString());
    }
  }
}