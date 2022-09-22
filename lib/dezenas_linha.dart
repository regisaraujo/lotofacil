import 'sorteio.dart';

class DezenasPorLinha {
  Map<String, Map<int, int>> gpiLinha = {};

  DezenasPorLinha();

  void Processa(Sorteio element) {
    if (gpiLinha.containsKey(element.gpi) == false) {
      gpiLinha[element.gpi] = {};
    }
    element.listDezenas.forEach((dezena) {
      if (gpiLinha[element.gpi]!.containsKey(dezena.linha)) {
        gpiLinha[element.gpi]!.update(dezena.linha, (value) => value + 1);
      } else {
        gpiLinha[element.gpi]![dezena.linha] = 1;
      }
    });
  }

  Map<String, Map<int, int>> get() => gpiLinha;

  void Sort() {
    gpiLinha.forEach((key, value) {
      var mapEntries = gpiLinha[key]!.entries.toList()
        ..sort((a, b) => a.value.compareTo(b.value));
      gpiLinha[key]!.clear();
      gpiLinha[key]!.addEntries(mapEntries);
    });
  }
}
