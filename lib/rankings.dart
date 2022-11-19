import 'sorteio.dart';
import 'sorteios.dart';

void Rankings(Sorteios sorteios) {
  sorteios.lista.forEach((sorteio) {
    var linha = ' Rank:Qtde:%';
    sorteio.sinteticoRanking.forEach((key, value) {
      double z = ((key * value) / 150) * 100;
      linha = linha +
          ' - ' +
          key.toString() +
          ':' +
          value.toString() +
          ':' +
          z.toStringAsFixed(2);
    });
    print(sorteio.idsorteio.toString() + '  ' + linha);
  });
}

List<int> RankingDezenasTodosSorteios(List<List<int>> faixa) {
  var tam = faixa.length;
  var qtdeDezenas = List<int>.filled(25, 0);
  for (var i = 0; i < tam; i++) {
    faixa[i].forEach((element) {
      if (faixa[i].indexOf(element) > 0) {
        qtdeDezenas[element - 1]++;
      }
    });
  }
  return qtdeDezenas;
}

void RankDezenasDeSorteio(Sorteio sorteio) {
  sorteio.lstNumerais.forEach((numero) {
    sorteio.rankSorteio[sorteio.lstNumerais.indexOf(numero)] =
        (sorteio.ranking[numero - 1]);
    sorteio.somaRank = sorteio.somaRank + sorteio.ranking[numero - 1];
  });
}

Map<int, int> SinteticoRanking(List<int> ranking) {
  Map<int, int> mapRank = {};
  ranking.forEach((qtdocorr) {
    if (mapRank.containsKey(qtdocorr)) {
      mapRank.update(qtdocorr, (value) => value + 1);
    } else {
      mapRank[qtdocorr] = 1;
    }
  });
  return mapRank;
}

void ProcessaRankingSorteio(Sorteio simulado, List<int> ranking) {
  simulado.lstNumerais.forEach((element) {
    simulado.rankSorteio[simulado.lstNumerais.indexOf(element)] =
        ranking[element - 1];
    simulado.somaRank = simulado.somaRank + ranking[element - 1];
  });
}
