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
  var penultimoSorteio = todos.lista[1];
  var gerador = GeradorJogos();
  var criterio = Criterios();
  var n = 0;
  var totDezenasRestanteCiclo = 0;
  var maxNaoSorteadasPossiveis = 0;
  var totNaoSorteadasAIncluir = 8;
  // novas contem as dezenas que ainda nao foram sorteadas no ciclo
  totDezenasRestanteCiclo = dezSortearCiclo.length;

  if (totDezenasRestanteCiclo > 4) {
    totDezenasRestanteCiclo = 3;
  }
  maxNaoSorteadasPossiveis = 10 - totDezenasRestanteCiclo;
  if (maxNaoSorteadasPossiveis > 5) {
    maxNaoSorteadasPossiveis = 5;
  }
  naoSorteadasUltimoSorteio = [];
  if (dezSortearCiclo.isNotEmpty) {
    naoSorteadasUltimoSorteio.addAll(dezSortearCiclo);
  }
  // incluindo dezenas com ranking maior que 5
  if (naoSorteadasUltimoSorteio.length < totNaoSorteadasAIncluir) {
    n = 0;
    for (var r = 0; r < 25; r++) {
      if ((ultSorteio.ranking[r] > 5) &&
          (!ultSorteio.lstNumerais.contains(r + 1)) &&
          (!naoSorteadasUltimoSorteio.contains(r + 1)) &&
          n < 7) {
        naoSorteadasUltimoSorteio.add(r + 1);
        n++;
      }
      if (n > 6 || naoSorteadasUltimoSorteio.length > totNaoSorteadasAIncluir) {
        break;
      }
    }
  }

  if (naoSorteadasUltimoSorteio.length < totNaoSorteadasAIncluir) {
    n = 0;
    for (var r = 0; r < 25; r++) {
      if ((ultSorteio.ranking[r] < 6) &&
          (ultSorteio.ranking[r] > 2) &&
          (!ultSorteio.lstNumerais.contains(r + 1)) &&
          (!naoSorteadasUltimoSorteio.contains(r + 1)) &&
          n < 5) {
        naoSorteadasUltimoSorteio.add(r + 1);
        n++;
      }
      if (n > 4 || naoSorteadasUltimoSorteio.length > totNaoSorteadasAIncluir) {
        break;
      }
    }
  }

  dezSortearCiclo.sort((a, b) => a.compareTo(b));
  print('Ranking Dezenas: ' + ultSorteio.ranking.toString());
  print('Ranking Sintetico: ' + ultSorteio.sinteticoRanking.toString());

  print('Dezenas que faltam para fechar o ciclo ');
  print(dezSortearCiclo);
  //naoSorteadasUltimoSorteio.sort((a, b) => a.compareTo(b));
  print('Dezenas não sorteadas no ultimo jogo e selecionadas para a simulação');
  print(naoSorteadasUltimoSorteio);
  //criterio.eliminar = [10, 17, 23];
  criterio.gerador.addAll(ultSorteio.lstNumerais);
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
  criterio.gpi = '105';
  criterio.gpiRepetidas = '';
  criterio.naipe = '';
  criterio.totMult3 = 0;
  criterio.totPrimos = 0;
  criterio.qtdeTotalGeralRepeticoes = 10;
  criterio.qtdeNovasUltimoSorteioDeveraRepetir = 4;
  criterio.qtdeRestanteCiclo = totDezenasRestanteCiclo;
  var poenovas =
      15 - criterio.qtdeRestanteCiclo - criterio.qtdeTotalGeralRepeticoes;
  if (poenovas > 0) {
    criterio.totnovas = poenovas;
  }
  criterio.dezenasPorLinhas = '';
  criterio.dezenasPorColunas = '';
  criterio.totsomaInf = 0;
  criterio.totsomaSup = 0;
  criterio.qtefibonacci = 3;
  criterio.qtdemoldura = 9;
  criterio.repetidasMolduraSup = 5;
  criterio.repetidasMolduraInf = 6;
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
