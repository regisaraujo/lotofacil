import 'sorteio.dart';
import 'dezena.dart';

class ProcessaAnalise {
  Dezena mdez = Dezena.Set(0, false, false, false, false, 0, 0, false);
  int sorteioInicial = 0;
  int sorteioFinal = 0;

  Sorteio ultSorteio = Sorteio();
  List<Sorteio> sorteios = [];

  // Construtores
  ProcessaAnalise();
  ProcessaAnalise.Set(List<Sorteio> sorteios);
  ProcessaAnalise.Range(
      List<Sorteio> sorteios, int sorteioInicial, int sorteioFinal);

  void SetSorteios(List<Sorteio> lista) => {sorteios = lista};

  void Processa() {
    ultSorteio = Sorteio().FactorySorteio();

    // Processa todos os sorteios
    sorteios.forEach((element) {
      TotalGPI(element);
      TotalFibonacci(element);
      TotalMoldura(element);
      SomatorioDezenas(element);
      Repeticoes(element, ultSorteio);
      Sequencia(element, ultSorteio);
      Multiplo3(element);
      DezenasPorLinha(element);
      DezenasPorColuna(element);
      FormacaoLinha(element);
      FormacaoColuna(element);
      CadeiaBinaria(element);
      CadeiaHexa(element);
      ultSorteio = element;
    });

    // Ordenar os dados processados

    // Armazena e acumula para o grupo par/impar (gpi) a quantidade de repetições
    // de cada dezena
  }
}
