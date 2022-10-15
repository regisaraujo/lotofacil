import 'dezena.dart';

class Sorteio {
  List<Dezena> listDezenas = [];
  List<int> lstRepetidas = [];
  List<int> lstNumerais = [];
  List<int> lstNaoRepetidas = [];
  List<int> lstNovasSorteioAnteriorRepetidasSorteioAtual = [];
  List<int> lstRepetidasSorteadas = [];
  List<int> lstRepetidasMoldura = [];
  List<int> lstDezenasCiclo = [];
  int totRepetidas = 0;
  String gpiRepet = '';
  String gpiCiclo = '';
  int totRepMoldura = 0;
  int idsorteio = 0;
  int totPar = 0;
  int totImpar = 0;
  int totFibonacci = 0;
  int totMoldura = 0;
  int totPrimo = 0;
  int totSoma = 0;
  int totMult3 = 0;
  bool fechamento = false;
  String naipe = '';
  String naipeFibonacci = '';
  String gpi = '';
  String totPorLinha = '';
  String totPorColuna = '';
  String strBinario = '';
  List<int> lstNaoSorteadas = [];
  List<int> jogoValido = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
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
    if (lista.length < 15) {
      print('Erro na carga das DEzenas');
    }
    listDezenas.addAll(lista);
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
    SetListaNumerais();
    DezenasNaoSorteadas();
    SetNaipe();
    SetNaipeFibonacci();
    TotalFibonacci();
    TotalMoldura();
    TotalMult3();
    TotalPrimo();
    TotalSoma();
    TotalDezenasLinha();
    TotalDezenasColuna();
    StringBinario();
  }

  // Calcula o total de pares e impares e atribui a gpi
  int SetGPI() {
    var tp = listDezenas.where((element) => element.par == true).length;
    if (tp > 0) {
      totImpar = 15 - tp;
      gpi = tp.toString() + totImpar.toString();
    }
    return tp;
  }

  // Gera a lista apenas com os numeros. Difere de listDezenas que contem o
  // objeto Dezena
  void SetListaNumerais() {
    listDezenas.forEach((element) {
      lstNumerais.add(element.numeral);
    });
    if (listDezenas.length < 15) {
      print('Erro no tamanho dos dados DEZENAS ...Sorteio: ' +
          idsorteio.toString());
    }
  }

  // Varre de 1-25 para contruir a lista de dezenas nao Sorteadas
  void DezenasNaoSorteadas() {
    for (var i = 1; i <= 25; i++) {
      if (!lstNumerais.contains(i)) {
        lstNaoSorteadas.add(i);
      }
    }
    // print(lstNaoSorteadas);
  }

  // Calcula o Naipe do jogo
  void SetNaipe() {
    var n1 = listDezenas.where((element) => element.numeral < 9).length;
    var n2 = listDezenas
        .where((element) => (element.numeral > 8) && (element.numeral < 18))
        .length;
    var n3 = listDezenas.where((element) => (element.numeral > 17)).length;
    naipe = n1.toString() + n2.toString() + n3.toString();
  }

  // Calcula o Naipe do jogo
  void SetNaipeFibonacci() {
    var n1 = listDezenas.where((element) => element.numeral < 2).length;
    var n2 = listDezenas
        .where((element) => (element.numeral > 1) && (element.numeral < 4))
        .length;
    var n3 = listDezenas
        .where((element) => (element.numeral > 3) && (element.numeral < 7))
        .length;
    var n5 = listDezenas
        .where((element) => (element.numeral > 6) && (element.numeral < 12))
        .length;
    var n8 = listDezenas
        .where((element) => (element.numeral > 11) && (element.numeral < 20))
        .length;
    var n13 = listDezenas
        .where((element) => (element.numeral > 19) && (element.numeral < 26))
        .length;
    naipeFibonacci = n1.toString() +
        n2.toString() +
        n3.toString() +
        n5.toString() +
        n8.toString() +
        n13.toString();
  }

  // Calcula o total de dezenas por linha
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

  // Calcula o total de dezenas por coluna
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

  // Calcula o total de dezenas pertencentes a sequencia de Fibonacci
  void TotalFibonacci() {
    totFibonacci = 0;
    listDezenas.forEach((element) {
      if (element.fibonacci) {
        totFibonacci++;
      }
    });
  }

  void TotalMult3() {
    totMult3 = 0;
    listDezenas.forEach((element) {
      if (element.mult3) {
        totMult3++;
      }
    });
  }

  // Calcula o total de dezenas pertencentes a moldura
  void TotalMoldura() {
    totMoldura = 0;
    listDezenas.forEach((element) {
      if (element.moldura) {
        totMoldura = totMoldura + 1;
      }
    });
  }

  // Calcula o total de numeros primos
  void TotalPrimo() {
    //   totMoldura
    totPrimo = 0;
    listDezenas.forEach((element) {
      if (element.primo) {
        totPrimo = totPrimo + 1;
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

  // Calcula o total da soma das dezenas
  int TotalSoma() {
    totSoma = 0;
    listDezenas.forEach((Dezena d) {
      totSoma += d.numeral;
    });
    return totSoma = totSoma;
  }

  // Calcula o total de ocorrencias de multiplos de 3
  int TotalMultiplosDe3() {
    var totMult = 0;
    lstNumerais.forEach((numero) {
      if ((numero % 3) == 0) {
        totMult++;
      }
    });
    return totMult;
  }
}
