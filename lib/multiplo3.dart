import 'sorteio.dart';

class Multiplo3 {
  Multiplo3();

  Map<String, Map<int, int>> gpiMultiplo3 = {};

  void Processa(Sorteio element) {
    if (gpiMultiplo3.containsKey(element.gpi) == false) {
      gpiMultiplo3[element.gpi] = {}; //   Map<int, int>();
    }
    element.listDezenas.forEach((dezena) {
      if (dezena.numeral % 3 == 0) {
        if (gpiMultiplo3[element.gpi]!.containsKey(dezena.numeral)) {
          gpiMultiplo3[element.gpi]!
              .update(dezena.numeral, (value) => value + 1);
        } else {
          gpiMultiplo3[element.gpi]![dezena.numeral] = 1;
        }
      }
    });
  }

  Map<String, Map<int, int>> get() => gpiMultiplo3;
}
