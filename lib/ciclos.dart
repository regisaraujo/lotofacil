import 'sorteio.dart';
import 'sorteios.dart';

class Ciclos {
  Sorteios sorteios = Sorteios();

  // Map<indice_grupo, Map<id_sorteio,List<numeros>>>
  List<int> fechamento = [];

  Ciclos();

  void setSorteios(Sorteios lstSorteios) {
    sorteios = lstSorteios;
    print(' Tamanho Lista de Sorteios: ' + sorteios.lista.length.toString());
  }

  List<int> getFechamento() {
    return fechamento;
  }

  List<int> MontarCiclosSorteios() {
    var indCiclo = 1;
    Sorteio sortCiclo;
    var ultsor = 0;
    List<int> dezocorridas = [];
    List<int> dezNaoocorridas = [];
    List<int> lotofacil = [
      1,
      2,
      3,
      4,
      5,
      6,
      7,
      8,
      9,
      10,
      11,
      12,
      13,
      14,
      15,
      16,
      17,
      18,
      19,
      20,
      21,
      22,
      23,
      24,
      25
    ];

    var tam = sorteios.lista.length;
    var fim = tam - 1;

    for (var ns = fim; ns >= 0; ns--) {
      sortCiclo = sorteios.lista[ns];
      ultsor = sortCiclo.idsorteio;
      var ind = 0;
      while (ind < 15) {
        var numero = sortCiclo.lstNumerais[ind];
        if (!dezocorridas.contains(numero)) {
          dezocorridas.add(numero);
        }
        ind++;
      }
      dezNaoocorridas = [];
      lotofacil.forEach((element) {
        if (!dezocorridas.contains(element)) {
          dezNaoocorridas.add(element);
        }
      });
      /*     print('UltSorteio: ' +
          ultsor.toString() +
          ' Sorteio ' +
          sortCiclo.lstNumerais.toString() +
          ' Faltam:  ' +
          dezNaoocorridas.toString() +
          'Ocorreram ' +
          dezocorridas.toString());
*/
      if (dezNaoocorridas.isEmpty) {
        fechamento.add(ultsor);
        sortCiclo.fechamento = true;
      }
      if (dezocorridas.length == 25) {
        indCiclo++;
        dezocorridas = [];
      }
      sortCiclo.lstDezenasCiclo.addAll(dezNaoocorridas);
      TotalParesImparesCiclo(sortCiclo);
    }
    //print(fechamento);
    return dezNaoocorridas;
  }

  void TotalParesImparesCiclo(Sorteio sorteio) {
    var countPar = 0;
    var lista = sorteio.lstDezenasCiclo;
    lista.forEach((dez) {
      if ((dez % 2) == 0) {
        countPar++;
      }
    });
    sorteio.gpiCiclo = countPar.toString() +
        (sorteio.lstDezenasCiclo.length - countPar).toString();
  }
}
