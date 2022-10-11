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

  void Processa(List<Sorteio> lstSorteios) {
    var fim = lstSorteios.length - 1;
    for (var i = fim; i > 0; i--) {
      var repeticao = Repeticoes();
      var sorteio = lstSorteios[i - 1];
      var sorteioAnterior = lstSorteios[i];
      repeticao.DezenasRepetidasEntre2Jogos(sorteioAnterior, sorteio);
      repeticao.DezenasNaoRepetidas(sorteioAnterior, sorteio);
      repeticao.DezenasRepetidasSorteioAnteriorRepetidasSorteioAtual(
          sorteioAnterior, sorteio);
      repeticao.DezenasNovasSorteioAnteriorRepetidasSorteioAtual(
          sorteioAnterior, sorteio);
      repeticao.TotalParesImparesListaDeRepetidasEntre2Jogos(sorteio);
      repeticao.TotalRepetidasMoldura(sorteio);
    }
  }


  void ProcessaSimulacao(List<Sorteio> lstSorteios, Sorteio sorteioAnterior) {
    var fim = lstSorteios.length - 1;
    for (var i = fim; i > 0; i--) {
      var repeticao = Repeticoes();
      var sorteio = lstSorteios[i];
      repeticao.DezenasRepetidasEntre2Jogos(sorteioAnterior, sorteio);
      repeticao.DezenasNaoRepetidas(sorteioAnterior, sorteio);
      repeticao.DezenasRepetidasSorteioAnteriorRepetidasSorteioAtual(
          sorteioAnterior, sorteio);
      repeticao.DezenasNovasSorteioAnteriorRepetidasSorteioAtual(
          sorteioAnterior, sorteio);
      repeticao.TotalParesImparesListaDeRepetidasEntre2Jogos(sorteio);
      repeticao.TotalRepetidasMoldura(sorteio);
    }
  }

  void DezenasNovasSorteioAnteriorRepetidasSorteioAtual(
      Sorteio sorteioAnterior, Sorteio sorteio) {
    // são as dezenas novas no jogo anterior e que repetiram
    // no jogo atual
    sorteioAnterior.lstNaoRepetidas.forEach((element) {
      if (sorteio.lstNumerais.contains(element)) {
        sorteio.lstNovasSorteioAnteriorRepetidasSorteioAtual.add(element);
      }
    });
  }

  void DezenasRepetidasSorteioAnteriorRepetidasSorteioAtual(
      Sorteio sorteioAnterior, Sorteio sorteio) {
    // Procura as dezenas repetidas no jogo anterior  e que reptiram
    // novamente
    sorteioAnterior.lstRepetidas.forEach((element) {
      if (sorteio.lstNumerais.contains(element)) {
        sorteio.lstRepetidasSorteadas.add(element);
      }
    });
  }

  void DezenasNaoRepetidas(Sorteio sorteioAnterior, Sorteio sorteio) {
    // Procura as dezenas nao repetidas
    sorteio.lstNumerais.forEach((element) {
      if (!sorteio.lstRepetidas.contains(element)) {
        sorteio.lstNaoRepetidas.add(element);
      }
    });
  }

  void DezenasRepetidasEntre2Jogos(Sorteio sorteioAnterior, Sorteio sorteio) {
    sorteioAnterior.lstNumerais.forEach((element) {
      if (sorteio.lstNumerais.contains(element)) {
        sorteio.lstRepetidas.add(element);
        sorteio.totRepetidas = sorteio.totRepetidas + 1;
      }
    });
  }

  void TotalParesImparesListaDeRepetidasEntre2Jogos(Sorteio sorteio) {
    var countPar = 0;
    var lista = sorteio.lstRepetidas;
    lista.forEach((dez) {
      if ((dez % 2) == 0) {
        countPar++;
      }
    });
    sorteio.gpiRepet = countPar.toString() +
        (sorteio.lstRepetidas.length - countPar).toString();
  }

  void TotalRepetidasMoldura(Sorteio sorteio) {
    List<int>? lstMoldura = [
      1,
      2,
      3,
      4,
      5,
      6,
      10,
      11,
      15,
      16,
      20,
      21,
      22,
      23,
      24,
      25
    ];
    sorteio.totRepMoldura = 0;
    sorteio.lstRepetidas.forEach((element) {
      if (lstMoldura.contains(element)) {
        sorteio.totRepMoldura++;
        sorteio.lstRepetidasMoldura.add(element);
      }
    });
  }

  Map<String, Map<int, int>> get() => gpiRepetida;
}
