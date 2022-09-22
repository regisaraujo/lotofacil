import 'sorteio.dart';

class SomatorioDezenas {
  Map<String, List<int>> gpiSoma = {}; // <gpi, List<sorteio,soma_dezenas>>

  void Processa(Sorteio element) {
    if (gpiSoma.containsKey(element.gpi) == false) {
      gpiSoma[element.gpi] = [];
    }
    gpiSoma[element.gpi]!.add(element.totSoma);
  }

  Map<String, List<int>> get() => gpiSoma;
}
