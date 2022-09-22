import 'dart:convert';
import 'dart:io';

import 'package:csv/csv.dart';

class LerArquivoCSV {
  final String nomeArquivo;
  final List<List<int>> dadosRet = [];
  final List<int> dadoStr = [];

  LerArquivoCSV(this.nomeArquivo);

  List<List<int>> ler() {
    List<int> elem2list;
    List<String> dadosString;
    dadosString = File(nomeArquivo).readAsLinesSync().toList();
//    print(dadosString.runtimeType);
    dadosString.forEach((element) {
      //print(element.runtimeType);
      //print(element );
      elem2list =
          (element.split(',')).map((e) => int.parse(e.toString())).toList();
      // print(elem2list.runtimeType);
      // print(elem2list);
      dadosRet.add(elem2list);
    });
    //print(dadosRet);
    return dadosRet;
  }

/*
    dadosDyn = _get();
    dadosDyn.then((value) =>  value.forEach((element) {
            arrJogo = element.map((e) => int.parse(e.toString())).toList();
            dadosInt.add(arrJogo);
          })
          
        });

    if (dadosInt.isEmpty) {
      print('** Leitura não conseguiu carregar dados dos jogos');
    } else {
      print(dadosInt);
    }
    return dadosInt;
  }
*/
  Future<List<List<dynamic>>> _get() async {
    final input = File(nomeArquivo).openRead();
    return (await input
        .transform(utf8.decoder)
        .transform(CsvToListConverter())
        .toList());
  }
}
