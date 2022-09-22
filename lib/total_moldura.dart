import 'dezena.dart';
import 'sorteio.dart';

class TotalMoldura {
  Map<String, Map<int, int>> gpiMoldura = {}; //

// Acumula o total de ocorrencias das dezenas pertencentes a Moldura
  void Processa(Sorteio element) {
    // Map<gpi do sorteio, Map<dezena da moldura,qtd>>
    // Se não existe a gpi do sorteio na hash do Map

    if (gpiMoldura.containsKey(element.gpi) == false) {
      gpiMoldura[element.gpi] = {};
    }
    element.listDezenas.forEach((dezena) {
      if (EmMoldura(dezena.numeral)) {
        if (gpiMoldura[element.gpi]!.containsKey(dezena.numeral)) {
          gpiMoldura[element.gpi]!.update(dezena.numeral, (value) => value + 1);
        } else {
          gpiMoldura[element.gpi]![dezena.numeral] = 1;
        }
      }
    });
  }

  Map<String, Map<int, int>> get() => gpiMoldura;

  void Sort() {
    // Ordena as dezenas que pertencem a moldura
    gpiMoldura.forEach((key, value) {
      var mapEntries = gpiMoldura[key]!.entries.toList()
        ..sort((a, b) => a.value.compareTo(b.value));
      gpiMoldura[key]!.clear();
      gpiMoldura[key]!.addEntries(mapEntries);
    });
  }
}
