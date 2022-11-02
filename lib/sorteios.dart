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
    dados.forEach((numjogo) {
      sorteio.idsorteio = numjogo[0];
      for (var ind = 1; ind < 16; ind++) {
        sorteio.listDezenas.add((ProcessaDezena(numjogo[ind])));
      }

      if (sorteio.listDezenas.length < 15) {
        print('Erro em processa DEZENA ' + sorteio.idsorteio.toString());
      }
      sorteio.Processa();
      lista.add(sorteio);
      sorteio = Sorteio();
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
}
