import 'sorteio.dart';

class FormacaoColuna {
  FormacaoColuna();

  Map<String, Map<String, int>> gpiFormacaoColunas = {};

  void Processa(Sorteio element) {
    if (gpiFormacaoColunas.containsKey(element.gpi) == false) {
      gpiFormacaoColunas[element.gpi] = {};
    }

    if (gpiFormacaoColunas[element.gpi]!.containsKey(element.totPorColuna) ==
        false) {
      gpiFormacaoColunas[element.gpi]![element.totPorColuna] = 1;
    } else {
      gpiFormacaoColunas[element.gpi]!
          .update(element.totPorColuna, (value) => value + 1);
    }
  }

  Map<String, Map<String, int>> get() => gpiFormacaoColunas;
}
