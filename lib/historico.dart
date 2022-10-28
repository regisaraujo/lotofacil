import 'sorteios.dart';

void Historico(Sorteios todos, List<int> dezciclo) {
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
    var linha8 = 'Dezenas restantes ciclo: ';
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

    linha8 = linha8 +
        '  ' +
        sorteio.lstDezenasCiclo.toString() +
        '  Total: de: ' +
        sorteio.lstDezenasCiclo.length.toString() +
        '  GPI Ciclo: ' +
        sorteio.gpiCiclo.toString();
    print(linha8);
    count = 0;

    print('Par/Impar Reptidas: ' +
        sorteio.gpiRepet +
        '  Par/Impar Sorteio: ' +
        sorteio.gpi +
        '  Total Fibo: ' +
        sorteio.totFibonacci.toString() +
        '  Naipe: ' +
        sorteio.naipe +
        '  Naipe Fibonacci: ' +
        sorteio.naipeFibonacci +
        ' Primos: ' +
        sorteio.totPrimo.toString() +
        ' Multiplos3: ' +
        sorteio.totMult3.toString() +
        '  Total soma dezenas: ' +
        sorteio.totSoma.toString());

    print('Total da Moldura: ' +
        sorteio.totMoldura.toString() +
        '  Repetidas da Moldura: ' +
        sorteio.totRepMoldura.toString() +
        ' Dez linhas: ' +
        sorteio.totPorLinha.toString() +
        ' Dez colunas: ' +
        sorteio.totPorColuna.toString());

    print(
        '-------------------------------------------------------------------');
  }
  print('Dezenas que faltam para fechar o ciclo: ' + dezciclo.toString());
}
