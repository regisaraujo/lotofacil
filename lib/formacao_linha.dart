import 'sorteio.dart';

class FormacaoLinha {
  FormacaoLinha();

  Map<String, Map<String, int>> gpiFormacaoLinhas = {};

  void Processa(Sorteio element) {
    if (gpiFormacaoLinhas.containsKey(element.gpi) == false) {
      gpiFormacaoLinhas[element.gpi] = {};
    }

    if (gpiFormacaoLinhas[element.gpi]!.containsKey(element.totPorLinha) ==
        false) {
      gpiFormacaoLinhas[element.gpi]![element.totPorLinha] = 1;
    } else {
      gpiFormacaoLinhas[element.gpi]!
          .update(element.totPorLinha, (value) => value + 1);
    }
  }

  Map<String, Map<String, int>> get() => gpiFormacaoLinhas;
}
