import 'dart:math';

T getRandomElement<T>(List<T> list) {
  final random = Random();
  var i = random.nextInt(list.length);
  return list[i];
}


/*

Uso:

void main() {
    var list = [1, 2, 3];
    var element = getRandomElement(list);
    print(element);  
}

*/