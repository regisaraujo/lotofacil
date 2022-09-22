import 'sorteio.dart';

class CadeiaBinaria {
  Map<String, List<String>> gpiBinario = {};
  Map<String, int> TotalBinarios = {};

  void Processa(Sorteio element) {
    if (gpiBinario.containsKey(element.gpi) == false) {
      gpiBinario[element.gpi] = [];
    }
    gpiBinario[element.gpi]!.add(element.strBinario);
    if (TotalBinarios.containsKey(element.strBinario) == false) {
      TotalBinarios[element.strBinario] = 1;
    } else {
      TotalBinarios.update(element.strBinario, (value) => value + 1);
    }
  }

  Map<String, List<String>> get() => gpiBinario;
}
