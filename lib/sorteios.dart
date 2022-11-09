import 'sorteio.dart';
import 'dezena.dart';
import 'repeticoes.dart';

class Sorteios {
  int totSorteios = 0;
  Sorteio sorteioAnterior = Sorteio();
  List<Sorteio> lista = [];
  List<int> dezQuentes = [];
  List<int> dezMornas = [];
  List<int> dezFrias = [];
  Sorteios();

  List<Sorteio> get() => lista;

  int totalSorteios() => lista.length;

  void setSorteioAnterior(Sorteio anterior) {
    sorteioAnterior = anterior;
  }

  void loadSorteio(List<List<int>> dados) {
    var sorteio = Sorteio();
    var contadorLinha = 0;
    dados.forEach((numjogo) {
      sorteio.idsorteio = numjogo[0];
      if (contadorLinha + 10 < dados.length) {
        var faixa =
            dados.getRange(contadorLinha, (contadorLinha + 10)).toList();
        sorteio.ranking = RankingDezenas(faixa);
        sorteio.sinteticoRanking = SinteticoRanking(sorteio.ranking);
      }
      for (var ind = 1; ind < 16; ind++) {
        sorteio.listDezenas.add((ProcessaDezena(numjogo[ind])));
      }

      if (sorteio.listDezenas.length < 15) {
        print('Erro em processa DEZENA ' + sorteio.idsorteio.toString());
      }
      sorteio.Processa();
      lista.add(sorteio);
      sorteio = Sorteio();
      contadorLinha++;
    });
    var repeticoes = Repeticoes();
    repeticoes.Processa(lista);
  }

  void loadJogosSimulados(List<List<int>> dados, Sorteio anterior) {
    var sorteio = Sorteio();
    var num_jogo = 0;
    dados.forEach((d) {
      d.forEach((int numero) {
        sorteio.listDezenas.add((ProcessaDezena(numero)));
        num_jogo++;
        sorteio.idsorteio = num_jogo;
      });
      sorteio.Processa();
      lista.add(sorteio);
      sorteio = Sorteio();
    });
    var repeticoes = Repeticoes();
    repeticoes.ProcessaSimulacao(lista, anterior);
  }

  void Sort() {
    lista.sort((a, b) => a.idsorteio.compareTo(b.idsorteio));
  }

  List<int> RankingDezenas(List<List<int>> faixa) {
    var tam = faixa.length;
    List<int> qtdeDezenas = List<int>.filled(25, 0);
    for (var i = 0; i < tam; i++) {
      faixa[i].forEach((element) {
        if (faixa[i].indexOf(element) > 0) {
          qtdeDezenas[element - 1]++;
        }
      });
    }
    return qtdeDezenas;
  }

  Map<int,int> SinteticoRanking(List<int> ranking) {
    Map<int, int> mapRank = {};
    ranking.forEach((qtdocorr) {
       if (mapRank.containsKey(qtdocorr)) {
          mapRank.update(qtdocorr, (value) => value+1 ); 
       } else {
          mapRank[qtdocorr]=1;
       }
     });
    return mapRank; 
  }


  
}



