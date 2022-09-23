import 'sorteio.dart';

// Acumula em gpiRepetidas as dezenas repetidas e a qunatidade de repetições
// da mesma.
class Repeticoes {
  Map<String, Map<int, int>> gpiRepetida = {};
  Map<String, List<dynamic>> rngRepetida = {};

  void AcumulaDezenasRepetidas(Sorteio element, Sorteio ultSort) {
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

  void ListDezenasRepetidasEntre2Jogos(
      Sorteio sorteioAnterior, Sorteio sorteio) {
    sorteioAnterior.SetListaNumerais();
    sorteio.SetListaNumerais();
    var sAnterior = Set.from(sorteioAnterior.lstNumerais);
    var ssorteio = Set.from(sorteio.lstNumerais);
    var linha1 = 'Anterior: ' + sorteioAnterior.idsorteio.toString() + '  ';
    var linha2 = 'Atual: ' + sorteio.idsorteio.toString() + '  ';
    var linha3 = 'Repetidas: ';

    sAnterior.forEach((element) {
      linha1 = linha1 + '  ' + element.toString();
    });
    print(linha1);
    ssorteio.forEach((element) {
      linha2 = linha2 + '  ' + element.toString();
    });
    print(linha2);
    sorteio.lstRepetidas =
        List<int>.from(ssorteio.intersection(sAnterior).toList());
    sorteio.lstRepetidas.forEach((element) {
      linha3 = linha3 + '   ' + element.toString();
    });
    print('>>>> ' + linha3);
    TotalParesImparesListaDeRepetidasEntre2Jogos(sorteio);
  }

  void TotalParesImparesListaDeRepetidasEntre2Jogos(Sorteio sorteio) {
    var countPar = 0;
    var lista = sorteio.lstRepetidas;
    lista.forEach((dez) {
      if ((dez % 2) == 0) {
        countPar++;
      }
    });
    sorteio.totRepPar = countPar;
    sorteio.totRepImpar = sorteio.lstRepetidas.length - countPar;
    print('Par/Impar  ' +
        sorteio.totRepPar.toString() +
        '-' +
        sorteio.totRepImpar.toString());
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
