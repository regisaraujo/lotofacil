import 'package:trotter/trotter.dart';
import 'sorteios.dart';
import 'criterios.dart';
import 'sorteio.dart';

class GeradorJogos {
  GeradorJogos();

  List<List<int>> GeraCombinacoes(List<int> numeros, int comb) {
    List<List<int>> gerados = [];
    if (numeros.length < comb) {
      print('Tamanho do vetor simulaçãõ menor que ' + comb.toString());
      return [];
    }
    numeros.sort((a, b) => a.compareTo(b));
    final jogos = Combinations(comb, numeros);
    for (final jogo in jogos()) {
      gerados.add(jogo);
    }
    return gerados;
  }
}

class CriticarJogosGerados {
  List<List<int>> jogosGerados = [];
  Sorteios sorteiosACriticar = Sorteios();
  Criterios criterio = Criterios();
  List<int> critUsados = [
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
  ]; // Total de 15 criterios
  Sorteio sorteioAnterior = Sorteio();
  List<int> lstMoldura = [
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

  CriticarJogosGerados();

  void setJogos(List<List<int>> jogos) {
    jogosGerados = jogos;
  }

  void setCriterios(Criterios crit) {
    criterio = crit;
  }

  void setJogoAnterior(Sorteio jogoAnterior) {
    sorteioAnterior = jogoAnterior;
  }

  void Processa() {
    sorteiosACriticar.loadJogosSimulados(jogosGerados, sorteioAnterior);
    // Posicao 0
    if (criterio.gpi.isNotEmpty) {
      critUsados[0] = 1;
      CriticarGPI();
    }
    // Posicao 1
    if (criterio.qtdemoldura > 0) {
      critUsados[1] = 1;
      CriticarTotalMoldura();
    }
    // Posicao 2

    if (criterio.repetidasMolduraInf > 0 && criterio.repetidasMolduraSup > 0) {
      critUsados[2] = 1;
      CriticarRepeticoesMoldura();
    }
    // Posicao 3

    if (criterio.qtdeTotalGeralRepeticoes > 0) {
      critUsados[3] = 1;
      CriticarTotalGeralRepeticoes();
    }
    // Posicao 4

    if (criterio.qtdeNovasSorteioAtualDeveRepetir > 0) {
      critUsados[4] = 1;
      CriticarNovasSorteioAnteriorARepetirProximoSorteio();
    }
    // Posicao 5

    if (criterio.naipe.isNotEmpty) {
      critUsados[5] = 1;
      CriticarNaipe();
    }
    // Posicao 6
    if (criterio.qtefibonacci > 0) {
      critUsados[6] = 1;
      CriticarFibonacci();
    }

    // Posicao 7
    if (criterio.qtdeRestanteCiclo > 0) {
      critUsados[7] = 1;
      CriticarQtdeRestanteCiclo();
    }

    // Posicao 8
    if (criterio.totsomaInf > 0 && criterio.totsomaSup > 0) {
      critUsados[8] = 1;
      CriticarTotalSoma();
    }

    if (criterio.gpiRepetidas != '') {
      critUsados[9] = 1;
      CriticarGPIRepetidas();
    }

    //  if (criterio.eliminar.isNotEmpty) {
    //    critUsados[10] = 1;
    //    CriticarDezenasEliminadas();
    //  }

    if (criterio.totPrimos > 0) {
      critUsados[11] = 1;
      CriticarTotalPrimos();
    }

    if (criterio.totMult3 > 0) {
      critUsados[12] = 1;
      CriticarTotalMultiplo3();
    }

    Print();
  }

  void CriticarGPI() {
    sorteiosACriticar.lista.forEach((element) {
      if (element.gpi == criterio.gpi) {
        element.jogoValido[0] = 1;
      }
    });
  }

  void CriticarTotalMoldura() {
    sorteiosACriticar.lista.forEach((element) {
      if (element.totMoldura == criterio.qtdemoldura) {
        element.jogoValido[1] = 1;
      }
    });
  }

  void CriticarRepeticoesMoldura() {
    sorteiosACriticar.lista.forEach((element) {
      var count = 0;
      element.lstNumerais.forEach((numero) {
        // Verifica se ocorreu o numero no sorteio anterior  e se esse numero
        // pertence a moldura
        if (sorteioAnterior.lstNumerais.contains(numero) &&
            lstMoldura.contains(numero)) {
          count++;
        }
      });
      if (count >= criterio.repetidasMolduraInf &&
          count <= criterio.repetidasMolduraSup) {
        element.jogoValido[2] = 1;
      }
      // print('Repetidas Moldura ' + count.toString());
    });
  }

  void CriticarTotalGeralRepeticoes() {
    sorteiosACriticar.lista.forEach((element) {
      var count = 0;
      element.lstNumerais.forEach((numero) {
        if (sorteioAnterior.lstNumerais.contains(numero)) {
          count++;
        }
      });
      //element.totRepetidas = cont;
      if (count == criterio.qtdeTotalGeralRepeticoes) {
        element.jogoValido[3] = 1;
      }
      // print('Repetidas ' + count.toString());
    });
  }

  void CriticarNovasSorteioAnteriorARepetirProximoSorteio() {
    sorteiosACriticar.lista.forEach((element) {
      var count = 0;
      element.lstNumerais.forEach((numero) {
        // Verifica aas dezenas novas do jogo anterior que sao repetidas no jogo atual
        if (element.lstNovasSorteioAnteriorRepetidasSorteioAtual
            .contains(numero)) {
          count++;
        }
      });
      if (count == criterio.qtdeNovasSorteioAtualDeveRepetir) {
        element.jogoValido[4] = 1;
      }
      //print('Nao Repetidas ' + count.toString());
    });
  }

  void CriticarNaipe() {
    sorteiosACriticar.lista.forEach((element) {
      if (element.naipe == criterio.naipe) {
        element.jogoValido[5] = 1;
      }
    });
  }

  void CriticarFibonacci() {
    sorteiosACriticar.lista.forEach((element) {
      var count = 0;
      element.lstNumerais.forEach((numero) {
        if ([1, 2, 3, 5, 8, 13, 21].contains(numero)) {
          count++;
        }
      });
      if (criterio.qtefibonacci == count) {
        element.jogoValido[6] = 1;
      }
    });
  }

  // As dezenas novas são as dezenas que ainda nao foram sorteadas no ciclo
  void CriticarQtdeRestanteCiclo() {
    sorteiosACriticar.lista.forEach((element) {
      var count = 0;
      element.lstNumerais.forEach((numero) {
        if (criterio.ciclo.contains(numero)) {
          count++;
        }
      });
      if (count == criterio.qtdeRestanteCiclo) {
        element.jogoValido[7] = 1;
      }
    });
  }

  void CriticarTotalSoma() {
    sorteiosACriticar.lista.forEach((element) {
      if ((element.totSoma <= criterio.totsomaSup) &&
          (element.totSoma >= criterio.totsomaInf)) {
        element.jogoValido[8] = 1;
      }
    });
  }

  void CriticarGPIRepetidas() {
    sorteiosACriticar.lista.forEach((element) {
      var cimp, cpar = 0;
      var gpiRep = '';
      element.lstRepetidas.forEach((numero) {
        if ((numero % 2) == 0) {
          cpar++;
        }
      });
      cimp = 15 - cpar;
      gpiRep = cpar.toString() + cimp.toString();
      element.gpiRepet = gpiRep;
      if (gpiRep == criterio.gpiRepetidas) {
        element.jogoValido[9] = 1;
      }
    });
  }

  void CriticarDezenasEliminadas() {
    sorteiosACriticar.lista.forEach((element) {
      var count = 0;
      element.lstNumerais.forEach((numero) {
        if (criterio.eliminar.contains(numero)) {
          count++;
        }
      });
      if (count <= 1) {
        element.jogoValido[10] = 1;
      }
    });
  }

  void CriticarTotalPrimos() {
    sorteiosACriticar.lista.forEach((element) {
      if (element.totPrimo == criterio.totPrimos) {
        element.jogoValido[11] = 1;
      }
    });
  }

  void CriticarTotalMultiplo3() {
    sorteiosACriticar.lista.forEach((element) {
      if (element.totMult3 == criterio.totMult3) {
        element.jogoValido[12] = 1;
      }
    });
  }

  void Print() {
    var linha1 = '';
    //  print(sorteiosACriticar.lista.length);
    sorteiosACriticar.lista.forEach((jogosim) {
//      print('Criterio:  ' + critUsados.toString());
//      print('Jogo:      ' + jogosim.jogoValido.toString());
//      print('---------------------------');

      if ((jogosim.jogoValido[0] == critUsados[0]) &&
          (jogosim.jogoValido[1] == critUsados[1]) &&
          (jogosim.jogoValido[2] == critUsados[2]) &&
          (jogosim.jogoValido[3] == critUsados[3]) &&
          (jogosim.jogoValido[4] == critUsados[4]) &&
          (jogosim.jogoValido[5] == critUsados[5]) &&
          (jogosim.jogoValido[6] == critUsados[6]) &&
          (jogosim.jogoValido[7] == critUsados[7]) &&
          (jogosim.jogoValido[8] == critUsados[8]) &&
          (jogosim.jogoValido[9] == critUsados[9]) &&
          (jogosim.jogoValido[10] == critUsados[10]) &&
          (jogosim.jogoValido[11] == critUsados[11]) &&
          (jogosim.jogoValido[12] == critUsados[12]) &&
          (jogosim.jogoValido[13] == critUsados[13]) &&
          (jogosim.jogoValido[14] == critUsados[14])) {
        linha1 = '';
        jogosim.lstNumerais.forEach((number) {
          linha1 = linha1 + '  ' + number.toString();
        });
        linha1 = linha1 +
            ' Soma: ' +
            jogosim.totSoma.toString() +
            ' Moldura: ' +
            jogosim.totMoldura.toString() +
            '  GPI ' +
            jogosim.gpi +
            '  GPI Repetidas ' +
            jogosim.gpiRepet +
            '  Naipe  ' +
            jogosim.naipe +
            '  Repetidas Moldura: ' +
            jogosim.totRepMoldura.toString() +
            ' Total Repetidas: ' +
            jogosim.totRepetidas.toString() +
            '  Novas do jogo Anterior e Repetidas no Atual: ' +
            jogosim.lstNovasSorteioAnteriorRepetidasSorteioAtual.toString();
        print(linha1);
      }
    });
  }
}

/*
  void Imprime() {
    var tam = simul.lista.length;
    var fim = tam - 1;

    print(tam);
    print(fim);
    for (var i = 0; i < fim; i++) {
      var sorteio = simul.lista[i];
      var linha2 = 'Jogo: ';
      var count = 0;

      sorteio.lstNumerais.forEach((element) {
        linha2 = linha2 + '  ' + element.toString();
        count++;
      });
      linha2 = linha2 + '  Total: ' + count.toString();
      print(linha2);
      count = 0;
      print('Par/Impar Reptidas: ' +
          sorteio.gpiRepet +
          '  Par/Impar Sorteio: ' +
          sorteio.gpi +
          '  Total Fibo: ' +
          sorteio.totFibonacci.toString() +
          '  Total soma dezenas: ' +
          sorteio.totSoma.toString() +
          '  Total da Moldura: ' +
          sorteio.totMoldura.toString() +
          '  Repetidas da Moldura: ' +
          sorteio.totRepMoldura.toString() +
          '  Naipe: ' +
          sorteio.naipe);
      print('------------------------------------------------------');
    }
  }
*/
