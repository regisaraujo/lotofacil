class Criterios {
  String gpi = '';
  String gpiRepetidas = '';
  String naipe = '';
  int qtdemoldura = 0;
  final numerosOuro = [5,6,7,12,13,14,19,20,21];

  // total de dezenas repetidas 4-6
  // inclui as qtdes n repetidas jogo anterior 3-5
  // qtdeRepetidas > qtdeNaoRepetidasJogoAnteriorSorteadasAtual
  int qtdeTotalGeralRepeticoes = 0;
  // total de dezenas não repetidas do jogo anterior e repetidas no atual
  int qtdeNovasUltimoSorteioDeveraRepetir = 0;
  // total de dezenas novas
  // qtdeRepetidas+qtdeNovas = 157
  int qtdeRestanteCiclo = 0;
  int repetidasMolduraSup = 0;
  int repetidasMolduraInf = 0;
  int totnovas = 0;
  String dezenasPorLinhas = '';
  String dezenasPorColunas = '';
  int qtefibonacci = 0;
  int totsomaSup = 0;
  int totsomaInf = 0;
  int totPrimos = 0;
  int totMult3 = 0;
  List<int> eliminar = [];
  List<int> indice_eliminar = [];
  // List<int> naorepetidas = [];
  List<int> ciclo = [];
  List<int> gerador = [];

  Criterios();

  void ExcluiEliminados() {
    indice_eliminar = [];
    gerador.forEach((numero) {
      if (eliminar.contains(numero)) {
        indice_eliminar.add(gerador.indexOf(numero));
//        print(gerador.indexOf(numero).toString() + '  ' + numero.toString());
      }
    });
    indice_eliminar.sort(((a, b) => a.compareTo(b)));
    for (var ind = indice_eliminar.length - 1; ind >= 0; ind--) {
      gerador.removeAt(indice_eliminar[ind]);
    }
  }
}
