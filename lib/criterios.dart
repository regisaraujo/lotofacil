class Criterios {
  String gpi = '';
  String gpiRepetidas = '';
  String naipe = '';
  int qtdemoldura = 0;

  // total de dezenas repetidas 4-6
  // inclui as qtdes n repetidas jogo anterior 3-5
  // qtdeRepetidas > qtdeNaoRepetidasJogoAnteriorSorteadasAtual
  int qtdeRepetidasTotal = 0;
  // total de dezenas não repetidas do jogo anterior e repetidas no atual
  int qtdeNovasSorteioAnteriorRepetidasSorteioAtual = 0;
  // total de dezenas novas
  // qtdeRepetidas+qtdeNovas = 15
  int qtdeNovas = 0;
  int repetidasMolduraSup = 0;
  int repetidasMolduraInf = 0;
  int qtefibonacci = 0;
  int totsomaSup = 0;
  int totsomaInf = 0;
  List<int> repetidas = [];
  List<int> naorepetidas = [];
  List<int> novas = [];
  List<int> gerador = [];
}
