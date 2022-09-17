//import 'dart:core';
//import 'dart:collection';
//dart(unchecked_use_of_nullable_value)
//import 'package:lotofacil/lotofacil.dart' as lotofacil;

/*
   Ocorrencia dos grupos Par/Impar 
   Dezenas mais frequentes em cada grupo
   Dezenas mais repetidas nos grupos
   Quantidade de jogos com 3 ou mais dezenas seguidas 
   Quantidade de dezenas por linha e coluna em cada grupo
   Analise de Quantidade de sequencia dos grupos
   Analise de soma das dezenas de cada grupo
   Analise de fibonacci em cada grupo
   Analise de moldura em cada grupo

*/

import 'dart:typed_data';

class Analise {
  Map<String, int> grupoParImpar = {}; // Ocorrencia dos grupos par/impar -gpi

  Map<String, Map<int, int>> gpiRepetida =
      {}; // <gpi, Map<dezena,qtd_repeticoes>>

  Map<String, List<dynamic>> rngRepetida = {};

  Map<String, Map<int, int>> gpiFibonacci = {}; // <gpi, List<dezena,qtd>>

  Map<String, Map<int, int>> gpiMoldura =
      {}; // <gpi, List<sorteio,qtd_repeticoes>>

  Map<String, List<int>> gpiSoma = {}; // <gpi, List<sorteio,soma_dezenas>>

  Map<String, Map<String, int>> gpiSequencia = {}; // <gpi,Map<gpi, qtde>>

  Map<String, Map<int, int>> gpiLinha = {};

  Map<String, Map<int, int>> gpiColuna = {};

  Map<String, Map<String, int>> gpiFormacaoLinhas = {};

  Map<String, Map<String, int>> gpiFormacaoColunas = {};

  Map<String, List<String>> gpiBinario = {};
  Map<String, List<String>> gpiHexa = {};

  Map<String, int> TotalBinarios = {};

  Map<String, Map<int, int>> gpiMultiplo3 = {};

  Dezena mdez = Dezena.Set(0, false, false, false, false, 0, 0, false);
  Sorteio ultSorteio = Sorteio();
  List<Sorteio> jogos = [];

  Analise();

  Analise.Set(List<Sorteio> jogos);

  void SetJogos(List<Sorteio> lista) => {jogos = lista};

  void Processa() {
    ultSorteio.listDezenas.addAll({
      mdez,
      mdez,
      mdez,
      mdez,
      mdez,
      mdez,
      mdez,
      mdez,
      mdez,
      mdez,
      mdez,
      mdez,
      mdez,
      mdez,
      mdez
    });
    jogos.forEach((element) {
      TotalGPI(element);
      TotalFibonacci(element);
      TotalMoldura(element);
      TotalDezenas(element);
      Repeticoes(element, ultSorteio);
      Sequencia(element, ultSorteio);
      Multiplo3(element);
      DezenasPorLinha(element);
      DezenasPorColuna(element);
      FormacaoLinha(element);
      FormacaoColuna(element);
      CadeiaBinaria(element);
      CadeiaHexa(element);
      ultSorteio = element;
    });

    // Ordenar os dados aqui

    gpiRepetida.forEach((key, value) {
      var mapEntries = gpiRepetida[key]!.entries.toList()
        ..sort((a, b) => a.value.compareTo(b.value));
      if (mapEntries.isNotEmpty) {
        var min = mapEntries.first.value;
        var max = mapEntries.last.value;
        var range = max - min;
        if (rngRepetida.containsKey(key) == false) {
          rngRepetida[key] = [];
        }
        rngRepetida[key] = [min, max, range];
        gpiRepetida[key]!.clear();
        gpiRepetida[key]!.addEntries(mapEntries);
      }
    });

    gpiMoldura.forEach((key, value) {
      var mapEntries = gpiMoldura[key]!.entries.toList()
        ..sort((a, b) => a.value.compareTo(b.value));
      gpiMoldura[key]!.clear();
      gpiMoldura[key]!.addEntries(mapEntries);
    });

    gpiFibonacci.forEach((key, value) {
      var mapEntries = gpiFibonacci[key]!.entries.toList()
        ..sort((a, b) => a.value.compareTo(b.value));
      gpiFibonacci[key]!.clear();
      gpiFibonacci[key]!.addEntries(mapEntries);
    });

    gpiLinha.forEach((key, value) {
      var mapEntries = gpiLinha[key]!.entries.toList()
        ..sort((a, b) => a.value.compareTo(b.value));
      gpiLinha[key]!.clear();
      gpiLinha[key]!.addEntries(mapEntries);
    });

    gpiColuna.forEach((key, value) {
      var mapEntries = gpiColuna[key]!.entries.toList()
        ..sort((a, b) => a.value.compareTo(b.value));
      gpiColuna[key]!.clear();
      gpiColuna[key]!.addEntries(mapEntries);
    });

    gpiSequencia.forEach((key, value) {
      var mapEntries = gpiSequencia[key]!.entries.toList()
        ..sort((a, b) => a.value.compareTo(b.value));
      gpiSequencia[key]!.clear();
      gpiSequencia[key]!.addEntries(mapEntries);
    });
  }

  void TotalGPI(Sorteio element) {
    if (grupoParImpar.containsKey(element.gpi)) {
      grupoParImpar.update(element.gpi, (value) => value + 1);
    } else {
      grupoParImpar[element.gpi] = 1;
    }
  }

  void TotalFibonacci(Sorteio element) {
    if (gpiFibonacci.containsKey(element.gpi) == false) {
      gpiFibonacci[element.gpi] = Map<int, int>();
    }
    element.listDezenas.forEach((dezena) {
      if (EmFibonacci(dezena.numeral)) {
        if (gpiFibonacci[element.gpi]!.containsKey(dezena.numeral)) {
          gpiFibonacci[element.gpi]!
              .update(dezena.numeral, (value) => value + 1);
        } else {
          gpiFibonacci[element.gpi]![dezena.numeral] = 1;
        }
      }
    });
  }

  void TotalMoldura(Sorteio element) {
    if (gpiMoldura.containsKey(element.gpi) == false) {
      gpiMoldura[element.gpi] = Map<int, int>();
    }
    element.listDezenas.forEach((dezena) {
      if (EmMoldura(dezena.numeral)) {
        if (gpiMoldura[element.gpi]!.containsKey(dezena.numeral)) {
          gpiMoldura[element.gpi]!.update(dezena.numeral, (value) => value + 1);
        } else {
          gpiMoldura[element.gpi]![dezena.numeral] = 1;
        }
      }
    });
  }

  void DezenasPorLinha(Sorteio element) {
    if (gpiLinha.containsKey(element.gpi) == false) {
      gpiLinha[element.gpi] = Map<int, int>();
    }
    element.listDezenas.forEach((dezena) {
      if (gpiLinha[element.gpi]!.containsKey(dezena.linha)) {
        gpiLinha[element.gpi]!.update(dezena.linha, (value) => value + 1);
      } else {
        gpiLinha[element.gpi]![dezena.linha] = 1;
      }
    });
  }

  void DezenasPorColuna(Sorteio element) {
    if (gpiColuna.containsKey(element.gpi) == false) {
      gpiColuna[element.gpi] = Map<int, int>();
    }
    element.listDezenas.forEach((dezena) {
      if (gpiColuna[element.gpi]!.containsKey(dezena.coluna)) {
        gpiColuna[element.gpi]!.update(dezena.coluna, (value) => value + 1);
      } else {
        gpiColuna[element.gpi]![dezena.coluna] = 1;
      }
    });
  }

  void TotalDezenas(Sorteio element) {
    if (gpiSoma.containsKey(element.gpi) == false) {
      gpiSoma[element.gpi] = [];
    }
    gpiSoma[element.gpi]!.add(element.totSoma);
  }

  void CadeiaBinaria(Sorteio element) {
    if (gpiBinario.containsKey(element.gpi) == false) {
      gpiBinario[element.gpi] = [];
    }
    gpiBinario[element.gpi]!.add(element.strBinario);
    if (TotalBinarios.containsKey(element.strBinario) == false) {
      TotalBinarios[element.strBinario] = 1;
    } else {
      TotalBinarios.update(element.strBinario, (value) => value + 1);
    }
  }

  void CadeiaHexa(Sorteio element) {
    if (gpiHexa.containsKey(element.gpi) == false) {
      gpiHexa[element.gpi] = [];
    }
    var valhex = convertHexDecimal('0000000' + element.strBinario);
    gpiHexa[element.gpi]!.add(valhex);
  }

  void Sequencia(Sorteio element, Sorteio ultimo) {
    // ignore: unrelated_type_equality_checks
    if (ultimo.gpi != 0) {
      if (gpiSequencia.containsKey(ultimo.gpi) == false) {
        gpiSequencia[ultimo.gpi] = Map<String, int>();
      }

      if (gpiSequencia[ultimo.gpi]!.containsKey(element.gpi) == false) {
        gpiSequencia[ultimo.gpi]![element.gpi] = 1;
      } else {
        gpiSequencia[ultimo.gpi]!.update(element.gpi, (value) => value + 1);
      }
    }
  }

  void FormacaoLinha(Sorteio element) {
    if (gpiFormacaoLinhas.containsKey(element.gpi) == false) {
      gpiFormacaoLinhas[element.gpi] = Map<String, int>();
    }

    if (gpiFormacaoLinhas[element.gpi]!.containsKey(element.totPorLinha) ==
        false) {
      gpiFormacaoLinhas[element.gpi]![element.totPorLinha] = 1;
    } else {
      gpiFormacaoLinhas[element.gpi]!
          .update(element.totPorLinha, (value) => value + 1);
    }
  }

  void FormacaoColuna(Sorteio element) {
    if (gpiFormacaoColunas.containsKey(element.gpi) == false) {
      gpiFormacaoColunas[element.gpi] = Map<String, int>();
    }

    if (gpiFormacaoColunas[element.gpi]!.containsKey(element.totPorColuna) ==
        false) {
      gpiFormacaoColunas[element.gpi]![element.totPorColuna] = 1;
    } else {
      gpiFormacaoColunas[element.gpi]!
          .update(element.totPorColuna, (value) => value + 1);
    }
  }

  void Repeticoes(Sorteio element, Sorteio ultSort) {
    if (gpiRepetida.containsKey(element.gpi) == false) {
      gpiRepetida[element.gpi] = Map<int, int>();
    }
    element.listDezenas.forEach((dezena) {
      ultSort.listDezenas.forEach((dznant) {
        if ((dznant.numeral == dezena.numeral) && (dznant.numeral != 0)) {
          if (gpiRepetida[element.gpi]!.containsKey(dezena.numeral)) {
            gpiRepetida[element.gpi]!
                .update(dezena.numeral, (value) => value + 1);
          } else {
            gpiRepetida[element.gpi]![dezena.numeral] = 1;
          }
        }
      });
    });
  }

  void Multiplo3(Sorteio element) {
    if (gpiMultiplo3.containsKey(element.gpi) == false) {
      gpiMultiplo3[element.gpi] = Map<int, int>();
    }
    element.listDezenas.forEach((dezena) {
      if (dezena.numeral % 3 == 0) {
        if (gpiMultiplo3[element.gpi]!.containsKey(dezena.numeral)) {
          gpiMultiplo3[element.gpi]!
              .update(dezena.numeral, (value) => value + 1);
        } else {
          gpiMultiplo3[element.gpi]![dezena.numeral] = 1;
        }
      }
    });
  }
}

class Sorteio {
  List<Dezena> listDezenas = [];
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
    0
  ];

  Sorteio();

  Sorteio.Set(List<Dezena> lista) {
    listDezenas.addAll(lista);
  }

  void Add(Dezena dezena) {
    listDezenas.add(dezena);
  }

  void Processa() {
    TotalPares();
    TotalFibonacci();
    TotalMoldura();
    TotalPrimo();
    TotalSoma();
    TotalDezenasLinha();
    TotalDezenasColuna();
    StringBinario();
  }

  int TotalPares() {
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

  int TotalFibonacci() {
    return listDezenas.where((element) => element.fibonacci == true).length;
  }

  int TotalMoldura() {
    return listDezenas.where((element) => element.moldura == true).length;
  }

  int TotalPrimo() {
    return listDezenas.where((element) => element.primo == true).length;
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
    listDezenas.forEach((Dezena d) {
      totSoma += d.numeral;
    });
    return totSoma;
  }
}

class Dezena {
  int numeral = 0;
  bool par = false;
  bool fibonacci = false;
  bool moldura = false;
  bool primo = false;
  int linha = 0;
  int coluna = 0;
  bool mult3 = false;
  Dezena();

  Dezena.Set(this.numeral, this.par, this.fibonacci, this.moldura, this.primo,
      this.linha, this.coluna, this.mult3);
}

bool EmFibonacci(int dezena) {
  List<int>? lstFibonacci = [1, 2, 3, 5, 8, 13, 21];
  return lstFibonacci.contains(dezena);
}

bool EmPrimo(int dezena) {
  List<int>? lstPrimo = [1, 2, 3, 5, 7, 9, 11, 13, 17, 19, 23];
  return lstPrimo.contains(dezena);
}

bool EmMoldura(int dezena) {
  List<int>? lstMoldura = [
    1,
    2,
    3,
    4,
    5,
    6,
    10,
    11,
    15,
    16,
    20,
    21,
    22,
    23,
    24,
    25
  ];
  return lstMoldura.contains(dezena);
}

Dezena funcDezena(int numeral) {
  bool par = false;
  bool fibonacci = false;
  bool moldura = false;
  bool primo = false;
  int linha = 0;
  int coluna = 0;
  bool mult3 = false;
  List<List<int>> lstLinhas = [];
  List<int> lstLinha1 = [1, 2, 3, 4, 5];
  List<int> lstLinha2 = [6, 7, 8, 9, 10];
  List<int> lstLinha3 = [11, 12, 13, 14, 15];
  List<int> lstLinha4 = [16, 17, 18, 19, 20];
  List<int> lstLinha5 = [21, 22, 23, 24, 25];

  lstLinhas.add(lstLinha1);
  lstLinhas.add(lstLinha2);
  lstLinhas.add(lstLinha3);
  lstLinhas.add(lstLinha4);
  lstLinhas.add(lstLinha5);

  par = (numeral % 2 == 0);

  mult3 = (numeral % 3 == 0);
  /*
                le 
                |                  
           1,   2,  3,  4,  5
     li->  6,   7,  8,  9, 10
           ......
           21, 22, 23, 24, 25
              
  */
  fibonacci = EmFibonacci(numeral);
  moldura = EmMoldura(numeral);
  primo = EmPrimo(numeral);
  // varre cada linha da lista de linhas do volante
  lstLinhas.forEach((li) {
    // varre uma linha
    li.forEach((le) {
      if (numeral == le) {
        coluna = li.indexOf(le) + 1; // le é o elemento em analise da linha li
        linha = lstLinhas.indexOf(li) +
            1; // li é a linha em analise da lista de linhas lstLinhas
      }
    });
  });

  var dez =
      Dezena.Set(numeral, par, fibonacci, moldura, primo, linha, coluna, mult3);
  return dez;
}

/*
String dumpHexToString(List<int> data) {
  var sb = StringBuffer();
  data.forEach((f) {
    sb.write(f.toRadixString(16).padLeft(2, '0'));
    sb.write(" ");
  });
  return sb.toString();
}
*/
String convertHexDecimal(String str1) {
  final fullString = str1;
  var number = 0;
  for (var i = 0; i <= fullString.length - 8; i += 8) {
    final hex = fullString.substring(i, i + 8);

    number = int.parse(hex, radix: 16);
    // print(number);
  }
  return number.toString();
}

/*
void executarConversao(Uint8List data) {
  var conversorHexDeVar = dumpHexToString(data);
  conversorHexDeVar = conversorHexDeVar
      .substring(3, conversorHexDeVar.length)
      .replaceAll(' ', '')
      .padLeft(8, '0');
  conversorHexDeVar = conertHexDecimal(conversorHexDeVar);

  print('data $conversorHexDeVar');
}
*/
main() {
  var sor = Sorteio();
  var dez = Dezena();

  List<List<int>>? listJogos = [
    [2, 3, 4, 5, 6, 7, 8, 9, 10, 15, 17, 19, 21, 22, 25], // 2350
    [1, 3, 4, 5, 6, 7, 8, 9, 10, 12, 14, 15, 20, 23, 24],
    [3, 4, 7, 8, 11, 12, 15, 16, 17, 18, 20, 22, 23, 24, 25],
    [1, 2, 3, 7, 8, 12, 13, 14, 15, 16, 18, 20, 23, 24, 25],
    [1, 2, 5, 6, 9, 10, 11, 12, 13, 16, 17, 18, 19, 20, 21],
    [2, 3, 4, 5, 6, 8, 9, 10, 11, 12, 18, 19, 20, 21, 25],
    [3, 5, 6, 7, 8, 9, 10, 13, 16, 18, 19, 20, 21, 22, 25],
    [1, 2, 4, 6, 7, 8, 9, 10, 12, 13, 14, 20, 23, 24, 25],
    [3, 4, 5, 6, 7, 12, 14, 15, 17, 19, 20, 21, 22, 23, 24],
  ];
  var idsor = 2359;
  List<Sorteio> jogos = [];
  listJogos.forEach((jogo) {
    jogo.forEach((int numero) {
      dez = funcDezena(numero);
      sor.Add(dez);
    });
    sor.idsorteio = idsor++;
    sor.Processa();
    jogos.add(sor);
    sor = Sorteio();
  });
  var totjogos = jogos.length;
  var analise = Analise();
  // Carrega o conjunto de jogos que serão analisados
  analise.SetJogos(jogos);
  // Processa os jogos carregados 
  analise.Processa();
  print('***** Analises ******');
  analise.grupoParImpar.forEach((key, value) {
    print(
        '===============================================================================');
    print(
        '***** Grupo: ${key}  Ocorreu: ${value} vezes do total de ${totjogos} jogos. *****');
    print(
        '===============================================================================');
    print('');
    print('***** Total de Numeros de Fibonacci');
    print(analise.gpiFibonacci[key]);
    print('');
    print('***** Total de Numeros de Moldura');
    print(analise.gpiMoldura[key]);
    print('');
    print('***** Multiplos de 3');
    print(analise.gpiMultiplo3[key]);
    print('');
    print('***** Total da Repeticoes das dezenas');
    print(analise.gpiRepetida[key]);
    print('');
    print('***** Grupos Par/Impar que sucederam');
    print(analise.gpiSequencia[key]);
    print('');
    print('***** Total da Soma das dezenas');
    print(analise.gpiSoma[key]);
    print('');
    print('***** Dezenas por Linhas');
    print(analise.gpiLinha[key]);
    print('');
    print('***** Dezenas por Colunas');
    print(analise.gpiColuna[key]);
    print('');
    print('***** Formação das Linhas');
    print(analise.gpiFormacaoLinhas[key]);
    print('');
    print('***** Formação das Colunas');
    print(analise.gpiFormacaoColunas[key]);
    print('');
    print('***** Total de formações Binarias apresentadas');
    analise.gpiBinario.forEach((key, value) {
      print('Grupo: ${key}');
      print('${value}');
    });
    print('');
    print('***** Formações Hexadecimais apresentadas');
    analise.gpiHexa.forEach((key, value) {
      print('Grupo: ${key}');
      print('${value}');
    });
  });
/*
  print('-----------------------------------------------------------');
  print('');
  print('Formação Binaria -------');
  analise.gpiBinario.forEach((key, value) {
    print('Grupo: ${key}');
    print('${value}');
  });

  print('-----------------------------------------------------------');
  print('');
  print('Total de formações Binarias apresentadas -------');
  analise.TotalBinarios.forEach((key, value) {
    print('${key}');
    print('${value}');
  });

  */
}



//void main(List<String> arguments) {
//  print('Hello world: ${lotofacil.calculate()}!');
//}


/*  [1, 2, 4, 6, 8, 9, 10, 11, 13, 14, 16, 17, 19, 23, 25],
    [1, 3, 5, 6, 7, 8, 9, 10, 13, 14, 16, 18, 19, 21, 24],
    [1, 5, 9, 10, 13, 14, 15, 16, 17, 18, 20, 21, 22, 24, 25],
    [2, 3, 5, 7, 10, 12, 13, 14, 18, 20, 21, 22, 23, 24, 25],
    [1, 2, 3, 4, 5, 6, 9, 11, 12, 13, 16, 18, 20, 23, 24],
    [1, 2, 5, 6, 7, 9, 10, 12, 14, 17, 18, 19, 22, 24, 25],
    [1, 2, 3, 4, 6, 8, 12, 13, 15, 16, 17, 20, 21, 23, 25],
    [3, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 17, 20, 22, 25],
    [4, 5, 9, 10, 11, 12, 14, 15, 16, 18, 19, 21, 22, 23, 24],
    [1, 4, 5, 6, 7, 9, 11, 12, 14, 15, 16, 17, 21, 22, 23],
    [1, 3, 4, 8, 9, 10, 13, 14, 15, 16, 17, 19, 22, 23, 25],
    [4, 5, 8, 9, 10, 11, 12, 13, 17, 18, 19, 20, 21, 22, 23],
    [1, 4, 5, 6, 7, 8, 10, 11, 12, 13, 17, 18, 20, 21, 22],
    [3, 4, 5, 6, 7, 8, 10, 16, 17, 18, 19, 20, 22, 24, 25],
    [3, 6, 7, 9, 11, 12, 13, 14, 16, 17, 19, 21, 22, 23, 25],
    [2, 3, 4, 6, 7, 9, 11, 13, 15, 17, 18, 19, 23, 24, 25],
    [1, 2, 3, 4, 6, 9, 10, 13, 14, 15, 17, 19, 21, 22, 25],
    [1, 6, 7, 9, 10, 11, 14, 15, 16, 18, 19, 20, 22, 23, 25],
    [3, 4, 5, 6, 11, 12, 13, 15, 16, 17, 18, 20, 21, 23, 24],
    [2, 5, 6, 7, 8, 10, 13, 15, 16, 17, 19, 20, 22, 24, 25],
    [1, 5, 6, 7, 8, 9, 10, 12, 13, 16, 18, 20, 23, 24, 25],
    [1, 2, 3, 4, 5, 8, 9, 10, 12, 13, 16, 18, 20, 22, 23],
    [2, 4, 5, 6, 7, 8, 9, 10, 12, 13, 14, 19, 22, 23, 24],
    [1, 4, 5, 7, 8, 9, 11, 12, 14, 18, 20, 21, 22, 24, 25],
    [3, 5, 6, 7, 9, 10, 12, 13, 14, 15, 18, 19, 20, 23, 24],
    [2, 3, 4, 7, 8, 9, 10, 11, 13, 17, 19, 21, 22, 23, 25],
    [1, 3, 4, 5, 9, 10, 12, 13, 14, 15, 16, 17, 19, 21, 22],
    [2, 3, 7, 8, 9, 10, 11, 12, 15, 17, 20, 21, 22, 23, 24],
    [1, 4, 5, 6, 7, 11, 12, 13, 16, 17, 18, 19, 20, 22, 23],
    [1, 2, 3, 4, 7, 8, 9, 10, 14, 17, 19, 20, 23, 24, 25],
    [3, 4, 6, 8, 9, 10, 11, 13, 14, 15, 17, 18, 19, 20, 24],
    [1, 4, 5, 6, 7, 8, 10, 11, 16, 18, 19, 20, 22, 24, 25],
    [2, 4, 5, 6, 8, 9, 12, 13, 14, 19, 20, 22, 23, 24, 25],
    [1, 2, 6, 7, 8, 9, 10, 12, 13, 14, 15, 16, 20, 21, 25],
    [1, 2, 3, 6, 7, 11, 14, 15, 17, 18, 20, 21, 22, 24, 25],
    [2, 4, 6, 7, 8, 10, 11, 12, 16, 17, 19, 21, 22, 23, 25],
    [2, 3, 4, 5, 8, 9, 10, 11, 12, 17, 18, 19, 21, 22, 24],
    [3, 5, 6, 9, 12, 13, 14, 15, 17, 19, 20, 21, 22, 23, 25],
    [1, 3, 4, 5, 6, 7, 10, 11, 14, 15, 16, 18, 19, 20, 25],
    [1, 2, 5, 6, 7, 10, 13, 14, 15, 16, 17, 20, 22, 23, 24],
    [2, 3, 4, 6, 7, 9, 11, 12, 13, 15, 17, 18, 19, 20, 25],
    [1, 3, 7, 8, 9, 10, 13, 15, 16, 18, 20, 21, 23, 24, 25],
    [3, 4, 5, 8, 9, 10, 11, 12, 16, 17, 19, 20, 21, 22, 25],
    [1, 5, 6, 8, 10, 11, 14, 15, 17, 18, 19, 20, 21, 24, 25],
    [4, 5, 6, 8, 9, 10, 11, 13, 14, 15, 16, 17, 21, 23, 25],
    [2, 5, 6, 7, 8, 13, 14, 16, 17, 18, 21, 22, 23, 24, 25],
    [2, 3, 4, 5, 7, 8, 10, 11, 12, 13, 14, 15, 18, 20, 25],
    [1, 3, 6, 7, 8, 9, 10, 12, 17, 18, 19, 20, 22, 24, 25],
    [1, 2, 4, 6, 7, 8, 10, 11, 12, 13, 14, 16, 17, 23, 25],
    [2, 6, 11, 12, 14, 15, 16, 17, 18, 19, 21, 22, 23, 24, 25],
    [4, 5, 6, 10, 12, 13, 14, 18, 19, 20, 21, 22, 23, 24, 25],
    [2, 4, 5, 7, 9, 12, 13, 14, 15, 18, 19, 21, 22, 23, 24],
    [1, 5, 6, 8, 9, 10, 12, 16, 17, 19, 20, 21, 22, 24, 25],
    [2, 3, 5, 6, 7, 8, 12, 14, 15, 16, 18, 19, 20, 23, 25],
    [2, 3, 5, 6, 7, 8, 10, 12, 13, 14, 19, 20, 21, 24, 25],
    [1, 3, 6, 7, 8, 11, 14, 15, 17, 19, 20, 21, 22, 24, 25],
    [1, 3, 4, 5, 6, 8, 9, 10, 11, 12, 13, 16, 20, 23, 24],
    [1, 4, 5, 6, 7, 8, 9, 11, 12, 13, 15, 18, 20, 22, 24],
    [3, 5, 6, 7, 8, 10, 11, 14, 15, 16, 17, 19, 20, 22, 24],
    [5, 6, 7, 8, 9, 10, 14, 16, 18, 19, 20, 22, 23, 24, 25],
    [1, 2, 4, 6, 9, 10, 11, 12, 14, 16, 17, 20, 22, 23, 25],
    [1, 3, 4, 6, 7, 8, 9, 12, 13, 17, 18, 22, 23, 24, 25],
    [2, 3, 4, 6, 7, 8, 9, 10, 11, 19, 20, 21, 22, 24, 25],
    [1, 2, 3, 7, 8, 10, 11, 14, 15, 16, 18, 19, 22, 23, 25],
    [2, 3, 4, 5, 6, 8, 9, 10, 12, 14, 15, 16, 17, 18, 19],
    [2, 4, 5, 7, 9, 10, 12, 13, 14, 15, 16, 18, 19, 20, 22],
    [1, 3, 5, 9, 10, 11, 12, 13, 15, 16, 19, 21, 23, 24, 25],
    [2, 3, 5, 6, 7, 9, 10, 13, 14, 15, 17, 19, 20, 22, 24],
    [1, 3, 8, 10, 11, 12, 14, 15, 18, 19, 20, 21, 23, 24, 25],
    [2, 3, 4, 5, 7, 9, 10, 11, 13, 14, 17, 20, 21, 22, 25],
    [1, 4, 5, 6, 8, 10, 11, 15, 16, 18, 19, 20, 21, 22, 25],
    [2, 3, 5, 6, 7, 8, 10, 11, 16, 17, 18, 19, 21, 23, 24],
    [1, 2, 5, 7, 8, 10, 11, 13, 14, 15, 16, 18, 21, 22, 24],
    [1, 2, 4, 6, 7, 8, 9, 10, 11, 12, 13, 17, 21, 23, 25],
    [2, 3, 4, 6, 8, 9, 10, 12, 16, 17, 19, 20, 22, 23, 24],
    [1, 2, 4, 5, 7, 10, 11, 12, 13, 14, 15, 16, 19, 20, 21],
    [1, 4, 5, 7, 10, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21],
    [2, 3, 5, 10, 11, 12, 13, 14, 15, 17, 18, 21, 22, 23, 24],
    [2, 4, 6, 7, 10, 11, 12, 13, 14, 16, 17, 18, 20, 21, 24],
    [1, 3, 5, 8, 10, 11, 13, 14, 15, 16, 17, 18, 21, 22, 25],
    [2, 3, 4, 7, 9, 12, 16, 18, 19, 20, 21, 22, 23, 24, 25],
    [2, 3, 5, 6, 7, 9, 10, 11, 14, 15, 16, 17, 18, 20, 21],
    [1, 2, 4, 5, 6, 10, 11, 12, 13, 14, 18, 20, 21, 23, 24],
    [1, 2, 5, 7, 9, 10, 11, 15, 17, 18, 19, 20, 22, 23, 25],
    [1, 3, 4, 8, 9, 10, 11, 14, 15, 17, 19, 20, 21, 23, 24],
    [1, 2, 6, 7, 8, 10, 12, 13, 15, 16, 18, 20, 22, 23, 24],
    [2, 3, 6, 8, 11, 12, 13, 15, 16, 17, 20, 22, 23, 24, 25],
    [1, 3, 4, 6, 7, 9, 10, 11, 12, 14, 16, 17, 18, 19, 25],
    [1, 2, 3, 5, 7, 9, 10, 11, 12, 14, 19, 20, 21, 22, 25],
    [1, 2, 5, 7, 8, 10, 12, 14, 15, 16, 17, 19, 20, 22, 25],
    [2, 3, 4, 5, 8, 9, 10, 11, 13, 15, 19, 22, 23, 24, 25],
    [1, 5, 6, 7, 9, 12, 13, 14, 16, 17, 19, 20, 21, 24, 25],
    [3, 5, 6, 7, 9, 10, 11, 12, 13, 18, 19, 20, 22, 23, 24],
    [1, 2, 4, 5, 8, 9, 11, 12, 13, 16, 18, 19, 20, 21, 22],
    [6, 7, 8, 10, 11, 12, 15, 16, 17, 18, 19, 22, 23, 24, 25],
    [1, 2, 6, 9, 10, 11, 12, 13, 14, 16, 17, 20, 23, 24, 25],
    [2, 3, 4, 8, 9, 10, 12, 14, 15, 16, 18, 21, 22, 23, 24],
    [2, 3, 7, 9, 11, 13, 14, 15, 17, 18, 20, 21, 22, 24, 25],
    [1, 3, 4, 6, 10, 12, 13, 14, 16, 18, 20, 21, 23, 24, 25],
    [1, 3, 5, 7, 8, 9, 11, 12, 14, 15, 16, 20, 21, 23, 25],
    [1, 2, 3, 4, 8, 9, 13, 15, 16, 17, 19, 22, 23, 24, 25],
    [3, 5, 9, 10, 12, 13, 15, 16, 17, 18, 19, 20, 22, 24, 25], // 2301
    [3, 4, 6, 7, 8, 10, 11, 12, 13, 14, 16, 17, 18, 20, 21],
    [1, 3, 5, 7, 8, 10, 11, 12, 15, 18, 19, 20, 21, 22, 24],
    [1, 2, 6, 8, 9, 11, 12, 13, 14, 16, 18, 20, 21, 22, 24], // 2304
    [1, 5, 7, 8, 10, 11, 14, 16, 17, 18, 19, 22, 23, 24, 25],
    [1, 4, 5, 6, 7, 8, 9, 11, 14, 15, 16, 18, 20, 21, 22],
    [1, 4, 5, 6, 8, 9, 11, 12, 13, 14, 15, 17, 19, 20, 23],
    [1, 2, 3, 4, 6, 10, 15, 17, 18, 19, 20, 22, 23, 24, 25], //2308
    [1, 3, 4, 7, 9, 10, 11, 12, 13, 17, 18, 19, 22, 24, 25],
    [1, 3, 5, 6, 7, 10, 11, 13, 16, 18, 20, 22, 23, 24, 25],
    [1, 3, 4, 5, 9, 10, 12, 13, 14, 15, 18, 19, 20, 21, 25],
    [1, 2, 3, 6, 7, 10, 11, 12, 14, 15, 18, 20, 21, 22, 25],
    [4, 5, 6, 7, 8, 10, 11, 12, 14, 15, 18, 19, 20, 22, 25],
    [1, 2, 7, 8, 9, 11, 13, 14, 15, 17, 19, 20, 23, 24, 25],
    [3, 7, 8, 11, 12, 13, 14, 16, 17, 18, 19, 21, 22, 23, 25],
    [2, 3, 4, 5, 6, 9, 10, 13, 14, 15, 16, 17, 19, 24, 25],
    [1, 2, 3, 5, 6, 7, 9, 14, 15, 16, 17, 20, 21, 23, 25],
    [2, 5, 6, 7, 8, 11, 13, 16, 17, 18, 19, 20, 21, 24, 25],
    [2, 3, 8, 12, 13, 14, 15, 16, 17, 19, 21, 22, 23, 24, 25],
*/