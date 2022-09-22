import 'sorteio.dart';
import 'dezena.dart';

class Sorteios {
  int totSorteios = 0;

  List<Sorteio> sorteios = [];

  Sorteios();

  List<Sorteio> get() => sorteios;

  int totalSorteios() => sorteios.length;

  void carregaSorteio(List<List<int>> dados) {
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
  }

  void Sort() {
    sorteios.sort((a, b) => a.idsorteio.compareTo(b.idsorteio));
  }
}
