// Ocorrencia dos grupos par/impar -gpi
import 'sorteio.dart';

class TotalGPI {
  Map<String, int> grupoParImpar = {};
  TotalGPI();

  void Processa(Sorteio sorteio) {
    if (grupoParImpar.containsKey(sorteio.gpi)) {
      grupoParImpar.update(sorteio.gpi, (value) => value + 1);
    } else {
      grupoParImpar[sorteio.gpi] = 1;
    }
  }

  Map<String, int> get() => grupoParImpar;

  
}
