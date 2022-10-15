/*
   Classe Dezena 
*/
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
  var fi = lstFibonacci.contains(dezena);
  return fi;
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

//
// Função que processa a dezena do jogo retornando uma instancia
//
Dezena ProcessaDezena(int numeral) {
  var par = false;
  var fibonacci = false;
  var moldura = false;
  var primo = false;
  var linha = 0;
  var coluna = 0;
  var mult3 = false;
  var lstLinhas = <List<int>>[];
  var lstLinha1 = <int>[1, 2, 3, 4, 5];
  var lstLinha2 = <int>[6, 7, 8, 9, 10];
  var lstLinha3 = <int>[11, 12, 13, 14, 15];
  var lstLinha4 = <int>[16, 17, 18, 19, 20];
  var lstLinha5 = <int>[21, 22, 23, 24, 25];

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
  if (dez == Null) {
    print('erro no retorno da dezena');
  }
  return dez;
}
