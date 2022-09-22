import 'sorteio.dart';

class DezenasColuna {
  Map<String, Map<int, int>> gpiColuna = {};

  void Processa(Sorteio element) {
    if (gpiColuna.containsKey(element.gpi) == false) {
      gpiColuna[element.gpi] = {}; //Map<int, int>();
    }
    element.listDezenas.forEach((dezena) {
      if (gpiColuna[element.gpi]!.containsKey(dezena.coluna)) {
        gpiColuna[element.gpi]!.update(dezena.coluna, (value) => value + 1);
      } else {
        gpiColuna[element.gpi]![dezena.coluna] = 1;
      }
    });
  }

  Map<String, Map<int, int>> get() => gpiColuna;

  void Sort() {
    gpiColuna.forEach((key, value) {
      var mapEntries = gpiColuna[key]!.entries.toList()
        ..sort((a, b) => a.value.compareTo(b.value));
      gpiColuna[key]!.clear();
      gpiColuna[key]!.addEntries(mapEntries);
    });
  }
}
