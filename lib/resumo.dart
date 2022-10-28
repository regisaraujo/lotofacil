import 'consolidar.dart';
import 'sorteios.dart';

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
  var consolidacao = Consolidar();
  var dc = Dados();
  consolidacao.setSorteios(todos);
  consolidacao.ProcessaConsolidacao();
  var resultado = consolidacao.getGPIConsolidada();
  resultado.keys.forEach((elementgpi) {
    dc = resultado[elementgpi]!;
    print('      ');
    print('Analise para o Grupo Par/Impar (GPI): ' +
        elementgpi +
        ' Esse grupo foi sucedido pelo GPI: ');
    print('      ');
    dc.sequenciaGPI.forEach((key, value) {
      print('     Grupo: ' + key + '  por  ' + value.toString() + ' vezes.');
    });

    print('      ');
    print('     GPI nas repeticoes: ');

    dc.qtdeParImparRepeticoes.forEach((key, value) {
      print('     GPI: ' + key + '  por  ' + value.toString() + ' vezes.');
    });

    print('      ');
    print('     Dezenas Repetidas na Moldura: ');
    dc.dezRepetidasMoldura.forEach((key, value) {
      print('     Dezena: ' +
          key.toString() +
          '  por  ' +
          value.toString() +
          ' vezes.');
    });

    print('      ');
    print('     Qtade total de Repeticoes na Moldura: ');
    dc.qtdeTotalRepeticoesMoldura.forEach((key, value) {
      print('     Total: ' +
          key.toString() +
          '  repeticoes por  ' +
          value.toString() +
          ' vezes.');
    });

    print('      ');
    print('     Qtde total de Ocorrencias de Naipes: ');
    dc.qtdeNaipe.forEach((key, value) {
      print('     Naipe: ' +
          key.toString() +
          '  ocorreu: ' +
          value.toString() +
          ' vezes.');
    });

    print('      ');
    print('     Dezenas novas de um jogo pra o outro e repetidas: ');
    dc.dezRepetidasNovas.forEach((key, value) {
      print('     Dezena: ' +
          key.toString() +
          '  por  ' +
          value.toString() +
          ' vezes.');
    });
    print('      ');
    print('----------------------------------');
    print('      ');
  });
}
