import '../lib/historico.dart';
import '../lib/simulacao.dart';
import '../lib/resumo.dart';
import '../lib/confere.dart';
import '../lib/consolidar.dart';
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
  var con = Confere();
  ciclo.setSorteios(todos);
  dezciclo = ciclo.MontarCiclosSorteios();
  //Historico(todos, dezciclo);
  //Resumo(todos);
  Simulacao(todos, dezciclo);
  //con.Processa();
}
