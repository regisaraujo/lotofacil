import 'dart:math';

import 'criterios.dart';
import 'criticar_jogos.dart';
import 'sorteios.dart';

void Simulacao(Sorteios todos, List<int> dezSortearCiclo) {
  var comb = 15;
  List<List<int>> jogosGerados;
  List<List<int>> jogosRanking = [];
  todos.lista.forEach((element) {
    jogosRanking.add(element.lstNumerais);
  });

  List<int> naoSorteadasUltimoSorteio = [];
  var ultSorteio = todos.lista[0];
  List<int> rankingDezenas = RankingDezenas(jogosRanking);
  var penultimoSorteio = todos.lista[1];
  var gerador = GeradorJogos();
  var criterio = Criterios();
  var n = 0;
  var totDezenasRestanteCiclo = 0;
  List<int> dezCicloReduzidas = [];
  var maxNaoSorteadasPossiveis = 0;
  var rangeMax = 0;
  var randomIndex = 0;
  // novas contem as dezenas que ainda nao foram sorteadas no ciclo
  totDezenasRestanteCiclo = dezSortearCiclo.length;

  if (totDezenasRestanteCiclo > 5) {
    totDezenasRestanteCiclo = 5;
  }
  maxNaoSorteadasPossiveis = 10 - totDezenasRestanteCiclo;
  if (maxNaoSorteadasPossiveis > 5) {
    maxNaoSorteadasPossiveis = 5;
  }
  naoSorteadasUltimoSorteio = [];
  n = 0;
  for (var r = 0; r < 25; r++) {
    if ((rankingDezenas[r] > 0) &&
        (rankingDezenas[r] < 4) &&
        (!ultSorteio.lstNumerais.contains(r + 1)) &&
        n < 2) {
      naoSorteadasUltimoSorteio.add(r + 1);
      n++;
    }
    if (n >= 2) {
      break;
    }
  }

  n = 0;

  for (var r = 0; r < 25; r++) {
    if ((rankingDezenas[r] > 3) &&
        (rankingDezenas[r] < 6) &&
        (!ultSorteio.lstNumerais.contains(r + 1)) &&
        n < 3) {
      naoSorteadasUltimoSorteio.add(r + 1);
      n++;
    }
    if (n > 2) {
      break;
    }
  }

  for (var r = 0; r < 25; r++) {
    if ((rankingDezenas[r] > 5) && (!ultSorteio.lstNumerais.contains(r + 1))) {
      naoSorteadasUltimoSorteio.add(r + 1);
    }
  }

  dezSortearCiclo.sort((a, b) => a.compareTo(b));
  print(
      'Dezenas             1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24  25');
  print('Ranking Dezenas: ' + rankingDezenas.toString());

  print('Dezenas que faltam para fechar o ciclo - no max 6 -');
  print(dezSortearCiclo);
  //naoSorteadasUltimoSorteio.sort((a, b) => a.compareTo(b));
  print('Dezenas não sorteadas no ultimo jogo e selecionadas para a simulação');
  print(naoSorteadasUltimoSorteio);
  //criterio.eliminar = [10, 17, 23];
  criterio.gerador.addAll(ultSorteio.lstNumerais);
//  criterio.gerador.addAll(ultSorteio.lstNaoRepetidas);
  criterio.gerador.addAll(dezSortearCiclo);
  criterio.gerador.addAll(naoSorteadasUltimoSorteio);
  criterio.gerador.sort((a, b) => a.compareTo(b));
  print('Dezenas no gerador ');
  print(criterio.gerador);
  print('Dezenas que nao devem constar nos jogos ');
  print(criterio.eliminar);
  criterio.ExcluiEliminados();
  print(
      'Penultimo sorteio considerado ' + penultimoSorteio.idsorteio.toString());
  print(penultimoSorteio.lstNumerais);
  print('Novas no penultimo sorteio considerado ' +
      penultimoSorteio.idsorteio.toString());
  print(penultimoSorteio.lstNaoRepetidas);

  print('Ultimo sorteio considerado ' + ultSorteio.idsorteio.toString());
  print(ultSorteio.lstNumerais);
  jogosGerados = gerador.GeraCombinacoes(criterio.gerador, comb);
  criterio.ciclo.addAll(dezSortearCiclo);
  criterio.gpi = '96';
  criterio.gpiRepetidas = '';
  criterio.naipe = '';
  criterio.totMult3 = 0;
  criterio.totPrimos = 0;
  criterio.qtdeTotalGeralRepeticoes = 0;
  criterio.qtdeNovasUltimoSorteioDeveraRepetir = 0;
  criterio.qtdeRestanteCiclo = totDezenasRestanteCiclo;
  criterio.totsomaInf = 170;
  criterio.totsomaSup = 210;
  criterio.qtefibonacci = 0;
  criterio.qtdemoldura = 9;
  criterio.repetidasMolduraSup = 0;
  criterio.repetidasMolduraInf = 0;
  print('Conjunto de Dezenas que serão usadas para geracao de novos jogos');
  print(criterio.gerador.toString() +
      '   Tam: ' +
      criterio.gerador.length.toString());
  var criticar = CriticarJogosGerados();
  criticar.setJogos(jogosGerados);
  criticar.setCriterios(criterio);
  criticar.setJogoAnterior(ultSorteio);
  criticar.Processa();
}

List<int> RankingDezenas(List<List<int>> lstNumeros) {
  var fim = 10; //lstNumeros.length - 1;
  List<int> qtdeDezenas = [
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0
  ];
  for (var i = 0; i < fim; i++) {
    lstNumeros[i].forEach((element) {
      qtdeDezenas[element - 1]++;
    });
    print(lstNumeros[i]);
  }
  return qtdeDezenas;
}
