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
