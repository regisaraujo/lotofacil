import 'sorteio.dart';
import 'dezena.dart';
import 'repeticoes.dart';

class Sorteios {
  int totSorteios = 0;

  List<Sorteio> lista = [];

  Sorteios();

  List<Sorteio> get() => lista;

  int totalSorteios() => lista.length;

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
/*
  void loadSorteio(List<List<int>> dados) {
    var sorteio = Sorteio();
    dados.forEach((d) {
      if (d.length < 16) {
        print('Erro no tamanho do dado a ser carregado');
      }
      d.forEach((int numero) {
        if (d.indexOf(numero) > 0 && numero > 0 && numero < 26) {
          sorteio.listDezenas.add((ProcessaDezena(numero)));
          if (sorteio.idsorteio == 24 ||
              sorteio.idsorteio == 4 ||
              sorteio.idsorteio == 6 ||
              sorteio.idsorteio == 7) {
            print(sorteio.idsorteio);
            print('Numero: ' +
                numero.toString() +
                ' Tamnho: ' +
                sorteio.listDezenas.length.toString());
          }
        } else {
          if (d.indexOf(numero) == 0) {
            sorteio.idsorteio = numero;
          } else {
            print('Dezena maior que 25');
          }
        }
      });
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
*/

  void loadJogosSimulados(List<List<int>> dados, Sorteio sorteioAnterior) {
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
    repeticoes.ProcessaSimulacao(lista, sorteioAnterior);
  }

  void Sort() {
    lista.sort((a, b) => a.idsorteio.compareTo(b.idsorteio));
  }
}
