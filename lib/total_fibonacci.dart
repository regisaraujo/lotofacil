import 'sorteio.dart';
import 'dezena.dart';

class TotalFibonacci {
  Map<String, Map<int, int>> gpiFibonacci = {}; // <gpi, List<dezena,qtd>>

// Acumula o total de ocorrencias das dezenas pertencentes ao grupo Fibonacci
  void Processa(Sorteio sorteio) {
    // Map<gpi do sorteio, Map<dezena de fibonacci,qtd>>
    // Se não existe a gpi do sorteio na hash do Map
    if (gpiFibonacci.containsKey(sorteio.gpi) == false) {
      gpiFibonacci[sorteio.gpi] = {}; //Map<int, int>();
    }
    sorteio.listDezenas.forEach((dezena) {
      if (EmFibonacci(dezena.numeral)) {
        if (gpiFibonacci[sorteio.gpi]!.containsKey(dezena.numeral)) {
          gpiFibonacci[sorteio.gpi]!
              .update(dezena.numeral, (value) => value + 1);
        } else {
          gpiFibonacci[sorteio.gpi]![dezena.numeral] = 1;
        }
      }
    });
  }

  Map<String, Map<int, int>> get() => gpiFibonacci;

  void Sort(){
    gpiFibonacci.forEach((key, value) {
      var mapEntries = gpiFibonacci[key]!.entries.toList()
        ..sort((a, b) => a.value.compareTo(b.value));
      gpiFibonacci[key]!.clear();
      gpiFibonacci[key]!.addEntries(mapEntries);
    });
  }

}
