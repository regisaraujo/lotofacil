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

//import 'dart:typed_data';

import 'package:lotofacil/ler_arquivo.dart';
import 'package:lotofacil/sorteios.dart';

void main() {
  List<List<int>> listJogos = [];

  final leitura = LerArquivoCSV('lotofacil10.csv');
  listJogos = leitura.ler();
  if (listJogos.isEmpty) {
    print('Lista dos jogos não foi carregada');
    return;
  }
  var sorteios = Sorteios();
  //print(listJogos);
  sorteios.carregaSorteio(listJogos);
  int totjogos = sorteios.totSorteios;

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
}
