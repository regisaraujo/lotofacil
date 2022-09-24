import 'sorteio.dart';
import 'dezena.dart';
import 'repeticoes.dart';

class Sorteios {
  int totSorteios = 0;

  List<Sorteio> sorteios = [];

  Sorteios();

  List<Sorteio> get() => sorteios;

  int totalSorteios() => sorteios.length;

  void loadSorteio(List<List<int>> dados) {
    var sorteio = Sorteio();
    dados.forEach((d) {
      d.forEach((int numero) {
        //        print(d.indexOf(numero));
        if (d.indexOf(numero) > 0) {
          sorteio.listDezenas.add((ProcessaDezena(numero)));
        } else {
          sorteio.idsorteio = numero;
        }
      });
      sorteio.Processa();
      sorteios.add(sorteio);
      sorteio = Sorteio();
    });
    var inicio = sorteios.length - 1;
    for (var i = inicio; i > 1; i--) {
      var repeticao = Repeticoes();
      var sorteio = sorteios[i - 1];
      var sorteioAnterior = sorteios[i];
      repeticao.ListDezenasRepetidasEntre2Jogos(sorteioAnterior, sorteio);
    }
  }

  void Sort() {
    sorteios.sort((a, b) => a.idsorteio.compareTo(b.idsorteio));
  }
}
