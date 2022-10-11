import 'dart:math';

import '../lib/criterios.dart';
import '../lib/ler_arquivo.dart';
import '../lib/criticar_jogos.dart';
import '../lib/sorteios.dart';
import '../lib/ciclos.dart';

void main() {
  List<List<int>> listJogos = [];
  final leitura = LerArquivoCSV('lotofacil10.csv');
  listJogos = leitura.ler();
  List<int> dezciclo = [];

  if (listJogos.isEmpty) {
    print('Lista dos jogos não foi carregada');
    return;
  }
  var todos = Sorteios();
  todos.loadSorteio(listJogos);
  var ciclo = Ciclos();
  ciclo.setSorteios(todos);
  dezciclo = ciclo.MontarCiclosSorteios();
//  Historico(todos);
//  Resumo(todos);
  Simulacao(todos, dezciclo);
}

void Simulacao(Sorteios todos, List<int> novas) {
  var comb = 15;
  List<List<int>> jogosGerados;
  var ultSorteio = todos.lista[0];
  var penultimoSorteio = todos.lista[1];
  var gerador = GeradorJogos();
  var criterio = Criterios();
  var n = 0;
  var totnovas = 0;
  var adicNovas = 0;
  var randomIndex = 0;
  // novas contem as dezenas que ainda nao foram sorteadas no ciclo
  print('Dezenas que faltam para fechar o ciclo');
  print(novas);
  totnovas = novas.length;
  adicNovas = 5;
  while (n < adicNovas) {
    randomIndex = Random().nextInt(9);
    if (!novas.contains(ultSorteio.lstNaoSorteadas[randomIndex])) {
      novas.add(ultSorteio.lstNaoSorteadas[randomIndex]);
      n++;
    }
  }

  novas.sort((a, b) => a.compareTo(b));
  print('Dezenas não sorteadas no ultimo jogo e selecionadas para a simulação');
  print(novas);
  criterio.gerador.addAll(ultSorteio.lstRepetidas);
  criterio.gerador.addAll(ultSorteio.lstNaoRepetidas);
  criterio.gerador.addAll(novas);
  criterio.gerador.sort((a, b) => a.compareTo(b));
  print(
      'Penultimo sorteio considerado ' + penultimoSorteio.idsorteio.toString());
  print(penultimoSorteio.lstNumerais);
  print('Novas no penultimo sorteio considerado ' +
      penultimoSorteio.idsorteio.toString());
  print(penultimoSorteio.lstNaoRepetidas);

  print('Ultimo sorteio considerado ' + ultSorteio.idsorteio.toString());
  print(ultSorteio.lstNumerais);
  jogosGerados = gerador.GeraCombinacoes(criterio.gerador, comb);
//  print('Total de jogos gerados ' + jogosGerados.length.toString());
  // rever as 3 linhas seguintes
  criterio.repetidas.addAll(ultSorteio.lstRepetidas);
  criterio.naorepetidas.addAll(ultSorteio.lstNaoRepetidas);
  criterio.novas.addAll(novas);
  criterio.gpi = '';
  criterio.gpiRepetidas = '';
  criterio.naipe = '';
  criterio.qtdemoldura = 10;
  criterio.qtdeNovasSorteioAnteriorRepetidasSorteioAtual = 0;
  criterio.qtdeNovas = totnovas;
  criterio.totsomaInf = 180;
  criterio.totsomaSup = 220;
  criterio.qtdeRepetidasTotal = 9;
  criterio.qtefibonacci = 0;
  criterio.repetidasMolduraSup = 5;
  criterio.repetidasMolduraInf = 6;
  print('Conjunto de Dezenas que serão usadas para geracao de novos jogos');
  print(criterio.gerador);
  var criticar = CriticarJogosGerados();
  criticar.setJogos(jogosGerados);
  criticar.setCriterios(criterio);
  criticar.setJogoAnterior(ultSorteio);
  criticar.Processa();
}

void Historico(Sorteios todos) {
  var tam = todos.lista.length;
  var fim = tam - 1;
  var strfechamento = '';
  for (var i = fim; i > 0; i--) {
    // fim-2 subst 0
    var sorteioAnterior = todos.lista[i];
    var sorteio = todos.lista[i - 1];
    strfechamento = '';
    if (sorteio.fechamento == true) {
      strfechamento = 'FECHAMENTO DO CICLO';
    }
    var linha1 = 'Anterior: ' + sorteioAnterior.idsorteio.toString() + '  ';
    var linha2 = 'Atual: ' + sorteio.idsorteio.toString() + '  ';
    var linha3 = 'Repetidas no jogo atual: ';
    var linha4 = 'Dezenas novas no jogo atual: ';
    var linha5 =
        'Dezenas novas no jogo anterior e sorteadas no jogo atual: (repetiu 1a vez) ';
    var linha6 =
        'Repetidas do jogo anterior e repetidas jogo no atual, (reptiu novamente): ';
    var linha7 = 'Dezenas Repetidas na Moldura: ';
    var count = 0;

    sorteioAnterior.lstNumerais.forEach((element) {
      linha1 = linha1 + '  ' + element.toString();
      count++;
    });
    linha1 = linha1 + '  Total: ' + count.toString();
    print(linha1);
    count = 0;

    sorteio.lstNumerais.forEach((element) {
      linha2 = linha2 + '  ' + element.toString();
      count++;
    });
    linha2 = linha2 + '  Total: ' + count.toString() + '  ' + strfechamento;
    print(linha2);
    count = 0;

    sorteio.lstRepetidas.forEach((element) {
      linha3 = linha3 + '   ' + element.toString();
      count++;
    });
    linha3 = linha3 + '  Total: ' + count.toString();
    print(linha3);
    count = 0;

    sorteio.lstNaoRepetidas.forEach((element) {
      linha4 = linha4 + '   ' + element.toString();
      count++;
    });
    linha4 = linha4 + '  Total: ' + count.toString();
    print(linha4);
    count = 0;

    sorteio.lstNovasSorteioAnteriorRepetidasSorteioAtual.forEach((element) {
      linha5 = linha5 + '   ' + element.toString();
      count++;
    });
    linha5 = linha5 + '  Total: ' + count.toString();
    print(linha5);
    count = 0;

    sorteio.lstRepetidasSorteadas.forEach((element) {
      linha6 = linha6 + '   ' + element.toString();
      count++;
    });
    linha6 = linha6 + '  Total: ' + count.toString();
    print(linha6);
    count = 0;
    sorteio.lstRepetidasMoldura.forEach((element) {
      linha7 = linha7 + '   ' + element.toString();
      count++;
    });
    linha7 = linha7 + '  Total: ' + count.toString();
    print(linha7);

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

void Resumo(Sorteios todos) {
  var fim = todos.lista.length - 1;
  for (var i = fim; i > 0; i--) {
    // fim-2 subst 0
    var sorteio = todos.lista[i - 1];
    print('GPIRep: ' +
        sorteio.gpiRepet +
        ' GPI: ' +
        sorteio.gpi +
        '  Fibo: ' +
        sorteio.totFibonacci.toString() +
        '  Soma: ' +
        sorteio.totSoma.toString() +
        '  QtMold: ' +
        sorteio.totMoldura.toString() +
        '  RepMold: ' +
        sorteio.totRepMoldura.toString() +
        '  Naipe: ' +
        sorteio.naipe);
  }
}




/*  for (var i = inicio; i > 1; i--) {
    var repeticao = Repeticoes();
    var sorteio = todos.sorteios[i - 1];
    var sorteioAnterior = todos.sorteios[i];
    repeticao.ListDezenasRepetidasEntre2Jogos(sorteioAnterior, sorteio);
    var linha1 = 'Sorteio Anterior: ' + sorteioAnterior.idsorteio.toString() + '  ';
    var linha2 = 'Sorteio Atual: ' + sorteio.idsorteio.toString() + '  ';
    var linha3 = 'Dezenas Repetidas: ';

    //print('Sorteio Anterior:  ');
    //sorteioAnterior.listDezenas.forEach((element) => print(element.numeral));
    //print('Sorteio Atual:  ');
    //sorteio.listDezenas.forEach((element) => print(element.numeral));

    //print('Repetidas: ');
    //print(sorteio.lstRepetidas);  
  }
*/
//  var analise = EstruturaDadosAnalise();
  // Carrega o conjunto de jogos que serão analisados
//  analise.SetSorteios(sorteios.get());
  //print(analise.sorteios);
  //Processa os jogos carregados
//  analise.Processa();
  //analise.sorteios.forEach((element) {
  //  print(element);
  //   print('Numero do sorteio: ${element} \n');
  //   print('Dezenas sorteadas:  ${element.listDezenas} \n ');
  //   print('Dezenas Repetidas: ${element.lstRepetidas} \n');
  //   print('--------------------- Fim do sorteio ----------------------');
  //});

  /*
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
    print(analise.gpiFormacaoLinhas[key].toString() + '  ');
    print('');
    print('***** Formação das Colunas');
    print(analise.gpiFormacaoColunas[key].toString() + '  ');
    print('');
    /*  print('***** Total de formações Binarias apresentadas');
    analise.gpiBinario.forEach((key, value) {
      print('Grupo: ${key}');
      print('${value}');
    });
    print(''); */
    print('***** Formações Hexadecimais apresentadas');
    analise.gpiHexa.forEach((key, value) {
      print('Grupo: ${key}');
      print('${value}');
    });
  });  */

