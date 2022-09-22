import 'sorteio.dart';

class Repeticoes {
  Map<String, Map<int, int>> gpiRepetida = {};
  Map<String, List<dynamic>> rngRepetida = {};

  void Processa(Sorteio element, Sorteio ultSort) {
    if (gpiRepetida.containsKey(element.gpi) == false) {
      gpiRepetida[element.gpi] = {};
    }
    element.listDezenas.forEach((dezena) {
      ultSort.listDezenas.forEach((dznant) {
        if ((dznant.numeral == dezena.numeral) && (dznant.numeral != 0)) {
          element.lstRepetidas.add(dezena.numeral);
          element.totRepetidas = element.totRepetidas + 1;
          if (gpiRepetida[element.gpi]!.containsKey(dezena.numeral)) {
            gpiRepetida[element.gpi]!
                .update(dezena.numeral, (value) => value + 1);
          } else {
            gpiRepetida[element.gpi]![dezena.numeral] = 1;
          }
        }
      });
    });
  }

  Map<String, Map<int, int>> get() => gpiRepetida;

  void Sort() {
    gpiRepetida.forEach((key, value) {
      var mapEntries = gpiRepetida[key]!.entries.toList()
        ..sort((a, b) => a.value.compareTo(b.value));
      if (mapEntries.isNotEmpty) {
        var min = mapEntries.first.value;
        var max = mapEntries.last.value;
        var range = max - min;
        if (rngRepetida.containsKey(key) == false) {
          rngRepetida[key] = [];
        }
        rngRepetida[key] = [min, max, range];
        gpiRepetida[key]!.clear();
        gpiRepetida[key]!.addEntries(mapEntries);
      }
    });
  }
}
