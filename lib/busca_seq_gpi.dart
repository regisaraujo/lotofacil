import 'sorteios.dart';

class BuscaSequenciaGPI {
  List<int> sequenciasEncontradas = [];

  List<String> sequenciaGPIBuscar = [];

  Sorteios sorteios = Sorteios();

  BuscaSequenciaGPI();

  void LoadSequencia(int qtde) {
    var tam = sorteios.lista.length;
    var fim = tam - 1;
    var ind = qtde - 1;
    for (var q = 0; q < qtde; q++) {
      sequenciaGPIBuscar.add('');
    }
    for (var i = 0; i < qtde; i++) {
      sequenciaGPIBuscar[ind] = sorteios.lista[i].gpi;
      ind--;
    }
    print(sequenciaGPIBuscar.toString());
  }

  List<int> Execute() {
    var tam = sorteios.lista.length;
    var lim = sequenciaGPIBuscar.length;
    var fim = tam - 1;
    List<int> numsorteios = [];
    List<List<String>> todosSeguintes = [];
    List<String> seguinte = [];
    for (var i = fim; i > lim - 2; i--) {
      var n = 0;
      for (var v = i; v > i - lim; v--) {
        if (sorteios.lista[v].gpi == sequenciaGPIBuscar[n]) {
          n++;
        }
      }
      if (n == lim) {
        sequenciasEncontradas.add(i);
        numsorteios.add(sorteios.lista[i].idsorteio);
        print('--------------------------------');
        for (var v = i; v > i - lim; v--) {
          print(sorteios.lista[v].idsorteio.toString() +
              '  ' +
              'GPI ' +
              sorteios.lista[v].gpi +
              '  ' +
              'GPIR ' +
              sorteios.lista[v].gpiRepet.toString() +
              '  ' +
              'Rep ' +
              sorteios.lista[v].totRepetidas.toString() +
              ' ' +
              'Fibo ' +
              sorteios.lista[v].totFibonacci.toString() +
              ' ' +
              'Soma ' +
              sorteios.lista[v].totSoma.toString() +
              ' ' +
              'Mold ' +
              sorteios.lista[v].totMoldura.toString() +
              ' ' +
              'MoldR ' +
              sorteios.lista[v].totRepMoldura.toString() +
              ' ' +
              'Primo ' +
              sorteios.lista[v].totPrimo.toString() +
              ' ' +
              'Mult3 ' +
              sorteios.lista[v].totMult3.toString());
        }
        var seg = i - lim;

        if (seg > 0) {
          seguinte = [];
          seguinte.add(sorteios.lista[seg].idsorteio.toString());
          seguinte.add(sorteios.lista[seg].gpi);
          seguinte.add(sorteios.lista[seg].gpiRepet);
          seguinte.add(sorteios.lista[seg].totRepetidas.toString());
          seguinte.add(sorteios.lista[seg].totFibonacci.toString());
          seguinte.add(sorteios.lista[seg].totSoma.toString());
          seguinte.add(sorteios.lista[seg].totMoldura.toString());
          seguinte.add(sorteios.lista[seg].totRepMoldura.toString());
          seguinte.add(sorteios.lista[seg].totMult3.toString());
          seguinte.add(sorteios.lista[seg].totPrimo.toString());
          seguinte.add(sorteios.lista[seg].lstNumerais.toString());
          todosSeguintes.add(seguinte);
          print('     Sorteio seguinte: ' +
              sorteios.lista[seg].idsorteio.toString() +
              '  ' +
              'GPI ' +
              sorteios.lista[seg].gpi +
              '  ' +
              'GPIR ' +
              sorteios.lista[seg].gpiRepet.toString() +
              ' ' +
              'Rep ' +
              sorteios.lista[seg].totRepetidas.toString() +
              ' ' +
              'Fibo ' +
              sorteios.lista[seg].totFibonacci.toString() +
              ' ' +
              'Soma ' +
              sorteios.lista[seg].totSoma.toString() +
              ' ' +
              'Mold ' +
              sorteios.lista[seg].totMoldura.toString() +
              ' ' +
              'MoldR ' +
              sorteios.lista[seg].totRepMoldura.toString() +
              ' ' +
              'Primo ' +
              sorteios.lista[seg].totPrimo.toString() +
              ' ' +
              'Mult3 ' +
              sorteios.lista[seg].totMult3.toString());
        }
      }
    }
    print('==============================================');
    print('Buscar Sequencias: ' + sequenciaGPIBuscar.toString());
    print('Sequencias Encontradas: ' + sequenciasEncontradas.toString());
    print('Sorteios: ' + numsorteios.toString());
    return sequenciasEncontradas;
  }
}
