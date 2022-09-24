import 'dezena.dart';

class Sorteio {
  List<Dezena> listDezenas = [];
  List<int> lstRepetidas = [];
  List<int> lstNumerais = [];
  int totRepetidas = 0;
  String gpiRepet = '';
  int idsorteio = 0;
  int totPar = 0;
  int totImpar = 0;
  int totFibonacci = 0;
  int totMoldura = 0;
  int totPrimo = 0;
  int totSoma = 0;
  int totMult3 = 0;
  String gpi = '';
  String totPorLinha = '';
  String totPorColuna = '';
  String strBinario = '';
  List<int> arrBinario = [
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
  ];

  Sorteio();

  Sorteio.Set(List<Dezena> lista) {
    listDezenas.addAll(lista);
  }

  void SetListaNumerais() {
    listDezenas.forEach((element) {
      lstNumerais.add(element.numeral);
    });
  }

  Sorteio FactorySorteio() {
    var mdez = Dezena.Set(0, false, false, false, false, 0, 0, false);
    var sorteio = Sorteio();
    for (var i = 1; i <= 25; i++) {
      sorteio.listDezenas.add(mdez);
    }
    return sorteio;
  }

  void Add(Dezena dezena) {
    listDezenas.add(dezena);
  }

  void Processa() {
    SetGPI();
    TotalFibonacci();
    TotalMoldura();
    TotalPrimo();
    TotalSoma();
    TotalDezenasLinha();
    TotalDezenasColuna();
    StringBinario();
  }

  int SetGPI() {
    var tp = listDezenas.where((element) => element.par == true).length;
    if (tp > 0) {
      totImpar = 15 - tp;
      gpi = tp.toString() + totImpar.toString();
    }
    return tp;
  }

  String TotalDezenasLinha() {
    var tl = 0;
    var j = 0;
    for (var i = 0; i < 5; i++) {
      j = i + 1;
      tl = listDezenas.where((element) => element.linha == j).length;
      totPorLinha = totPorLinha + tl.toString();
    }
    return totPorLinha;
  }

  String TotalDezenasColuna() {
    var tl = 0;
    var j = 0;
    for (var i = 0; i < 5; i++) {
      j = i + 1;
      tl = listDezenas.where((element) => element.coluna == j).length;
      totPorColuna = totPorColuna + tl.toString();
    }
    return totPorColuna;
  }

  void TotalFibonacci() {
    totFibonacci = 0;
    listDezenas.forEach((element) {
      if (element.fibonacci) {
        totFibonacci++;
      }
    });
  }

  void TotalMoldura() {
    totMoldura = 0;
    listDezenas.forEach((element) {
      if (element.moldura) {
        totMoldura++;
      }
    });
  }

  void TotalPrimo() {
    //   totMoldura
    totPrimo = 0;
    listDezenas.forEach((element) {
      if (element.primo) {
        totPrimo++;
      }
    });
  }

  List<int> ArrayBinario() {
    listDezenas.forEach((e) {
      arrBinario[e.numeral - 1] = 1;
    });
    return arrBinario;
  }

  String StringBinario() {
    var values = <int>[];
    values = ArrayBinario();
    values.forEach((e) {
      if (e > 0) {
        strBinario = strBinario + '1';
      } else {
        strBinario = strBinario + '0';
      }
    });
    return strBinario;
  }

  int TotalSoma() {
    totSoma = 0;
    listDezenas.forEach((Dezena d) {
      totSoma += d.numeral;
    });
    return totSoma = totSoma;
  }
}
