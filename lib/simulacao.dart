import 'dart:math';

import 'criterios.dart';
import 'criticar_jogos.dart';
import 'sorteios.dart';

void Simulacao(Sorteios todos, List<int> dezSortearCiclo) {
  var comb = 15;
  List<List<int>> jogosGerados;
  List<int> naoSorteadasUltimoSorteio = [];
  var ultSorteio = todos.lista[0];
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
  maxNaoSorteadasPossiveis = 6;
  naoSorteadasUltimoSorteio = [2, 7, 9, 20];

  rangeMax = ultSorteio.lstNaoSorteadas.length;
  while (n < maxNaoSorteadasPossiveis) {
    randomIndex = Random().nextInt(rangeMax);
    if (!naoSorteadasUltimoSorteio
            .contains(ultSorteio.lstNaoSorteadas[randomIndex]) &&
        !(dezSortearCiclo.contains(ultSorteio.lstNaoSorteadas[randomIndex]))) {
      naoSorteadasUltimoSorteio.add(ultSorteio.lstNaoSorteadas[randomIndex]);
      n++;
    }
  }
  dezSortearCiclo.sort((a, b) => a.compareTo(b));
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
  criterio.totMult3 = 5;
  criterio.totPrimos = 6;
  criterio.qtdeTotalGeralRepeticoes = 10;
  criterio.qtdeNovasUltimoSorteioDeveraRepetir = 0;
  criterio.qtdeRestanteCiclo = totDezenasRestanteCiclo;
  criterio.totsomaInf = 170;
  criterio.totsomaSup = 210;
  criterio.qtefibonacci = 4;
  criterio.qtdemoldura = 10;
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
