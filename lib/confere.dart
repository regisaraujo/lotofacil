import 'ler_arquivo.dart';

class Confere {
  Confere();

  void Processa() {
    List<List<int>> myJogos = [];

    final leitura = LerArquivoCSV('jogos.csv');
    myJogos = leitura.ler();
    List<int> acertos = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
    if (myJogos.isEmpty) {
      print('Lista dos jogos não foi carregada');
      return;
    }
    var tam = myJogos.length;
    var fim = tam - 1;

    for (var ind = 1; ind <= fim; ind++) {
      myJogos[ind].forEach((element) {
        if (myJogos[ind].indexOf(element) > 0) {
          if (myJogos[0].contains(element)) {
            acertos[ind] = acertos[ind] + 1;
          }
        }
      });
    }
    print(acertos);
  }
}
