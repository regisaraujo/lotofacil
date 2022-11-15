import 'sorteio.dart';

class SequenciaGPI {
  Map<String, Map<String, int>> gpiSequencia = {}; // <gpi,Map<gpi, qtde>>

// Constroi um Map com os grupos gpi que sucederam o grupo gpi atual
  void Processa(Sorteio element, Sorteio ultimo) {
    // ignore: unrelated_type_equality_checks
    if (ultimo.gpi != 0) {
      if (gpiSequencia.containsKey(ultimo.gpi) == false) {
        gpiSequencia[ultimo.gpi] = {}; //Map<String, int>();
      }

      if (gpiSequencia[ultimo.gpi]!.containsKey(element.gpi) == false) {
        gpiSequencia[ultimo.gpi]![element.gpi] = 1;
      } else {
        gpiSequencia[ultimo.gpi]!.update(element.gpi, (value) => value + 1);
      }
    }
  }

  Map<String, Map<String, int>> get() => gpiSequencia;

  // Ordena por gpi
  void Sort() {
    gpiSequencia.forEach((key, value) {
      var mapEntries = gpiSequencia[key]!.entries.toList()
        ..sort((a, b) => a.value.compareTo(b.value));
      gpiSequencia[key]!.clear();
      gpiSequencia[key]!.addEntries(mapEntries);
    });
  }
}
