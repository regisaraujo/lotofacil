import 'sorteio.dart';
import 'sorteios.dart';

final List<int> lstFibonacci = [1, 2, 3, 5, 8, 13, 21];

final List<int> lstMoldura = [
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

class Dados {
  // Map<Dezena, quantidade>
  Map<int, int> qtdDezenasRepetidas = {};
  // Map<Dezenas_Moldura, qtde>
  Map<int, int> qtdDezenasMoldura = {};
  // Map<Dezenas_novas_repetidas, qtde>
  Map<int, int> dezRepetidasNovas = {};
  // Map<Dezena_repetida, qtde>
  Map<int, int> dezRepetidasMoldura = {};
  // Map<Tot_repetições, qtde>
  Map<int, int> qtdeTotalRepeticoesMoldura = {};

  // Map<Valor_soma_sorteio, qtde>
  Map<int, int> valorSomaSorteio = {};
  // Map<Total_Dezenas_Fibo, Qtde>
  Map<int, int> qtdeDezenasFibonacci = {};
  // Map<GPI das repeticoes, qtde>
  Map<String, int> qtdeParImparRepeticoes = {};
  // Map<GPI, qtde>
  Map<String, int> sequenciaGPI = {};
  // Map<Naipe, qtde>
  Map<String, int> qtdeNaipe = {};
}

class Consolidar {
  Sorteios sorteios = Sorteios();
  Map<String, Dados> GPIConsolidada = {};

  Consolidar();

  void setSorteios(Sorteios todosSorteios) {
    sorteios = todosSorteios;
  }

  Map<String, Dados> getGPIConsolidada() {
    return GPIConsolidada;
  }

  Dados updateDados(Dados d, Sorteio sorteio) {
    // Consolidacoes do Sorteio
    if (d.sequenciaGPI.containsKey(sorteio.gpi) == false) {
      d.sequenciaGPI[sorteio.gpi] = 1;
    } else {
      d.sequenciaGPI.update(sorteio.gpi, (value) => value + 1);
    }

    if (d.qtdeNaipe.containsKey(sorteio.naipe) == false) {
      d.qtdeNaipe[sorteio.naipe] = 1;
    } else {
      d.qtdeNaipe.update(sorteio.naipe, (value) => value + 1);
    }

    if (d.valorSomaSorteio.containsKey(sorteio.totSoma) == false) {
      d.valorSomaSorteio[sorteio.totSoma] = 1;
    } else {
      d.valorSomaSorteio.update(sorteio.totSoma, (value) => value + 1);
    }

    if (d.qtdeParImparRepeticoes.containsKey(sorteio.gpiRepet) == false) {
      d.qtdeParImparRepeticoes[sorteio.gpiRepet] = 1;
    } else {
      d.qtdeParImparRepeticoes.update(sorteio.gpiRepet, (value) => value + 1);
    }

    if (d.qtdeTotalRepeticoesMoldura.containsKey(sorteio.totRepMoldura) ==
        false) {
      d.qtdeTotalRepeticoesMoldura[sorteio.totRepMoldura] = 1;
    } else {
      d.qtdeTotalRepeticoesMoldura
          .update(sorteio.totRepMoldura, (value) => value + 1);
    }

    // Consoidações das dezenas
    sorteio.lstNumerais.forEach((element) {
      if (d.qtdDezenasRepetidas.containsKey(element) == false) {
        d.qtdDezenasRepetidas[element] = 1;
      } else {
        d.qtdDezenasRepetidas.update(element, (value) => value + 1);
      }

      if (lstMoldura.contains(element)) {
        if (d.qtdDezenasMoldura.containsKey(element) == false) {
          d.qtdDezenasMoldura[element] = 1;
        } else {
          d.qtdDezenasMoldura.update(element, (value) => value + 1);
        }
      }

      if (sorteio.lstNovasSorteioAnteriorRepetidasSorteioAtual
          .contains(element)) {
        if (d.dezRepetidasNovas.containsKey(element) == false) {
          d.dezRepetidasNovas[element] = 1;
        } else {
          d.dezRepetidasNovas.update(element, (value) => value + 1);
          ;
        }
      }

      if (sorteio.lstRepetidasMoldura.contains(element)) {
        if (d.dezRepetidasMoldura.containsKey(element) == false) {
          d.dezRepetidasMoldura[element] = 1;
        } else {
          d.dezRepetidasMoldura.update(element, (value) => value + 1);
          ;
        }
      }

      if (lstFibonacci.contains(element)) {
        if (d.qtdeDezenasFibonacci.containsKey(element) == false) {
          d.qtdeDezenasFibonacci[element] = 1;
        } else {
          d.qtdeDezenasFibonacci.update(element, (value) => value + 1);
        }
      }
    });
    return d;
  }

  void ProcessaConsolidacao() {
    var tam = sorteios.lista.length;
    var fim = tam - 1;
    for (var i = fim; i > 0; i--) {
      var sorteioAnterior = sorteios.lista[i];
      var sorteio = sorteios.lista[i - 1];
      Dados valor = Dados();
      if (GPIConsolidada.containsKey(sorteioAnterior.gpi) == true) {
        valor = GPIConsolidada[sorteioAnterior.gpi]!; //Map<String, int>();
      }
      GPIConsolidada[sorteioAnterior.gpi] = updateDados(valor, sorteio);
    }
  }
}
