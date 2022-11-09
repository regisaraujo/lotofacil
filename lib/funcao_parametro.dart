void funcmain() {
  metodoSemFuncao();
  metodoComFuncao(funcaoAntes, 31);
  metodoComFuncao(funcaoDepois, 57);
}

void metodoSemFuncao() {
  funcao();
}

void metodoComFuncao(Function func, int param) {
  func(param);
}

void funcao() {
  print('Botão Criado!');
}

double funcaoAntes(int valor) {
  var antes = valor / 2 - valor % 2;
  print(antes);
  return antes;
}

void funcaoDepois(int valor) {
  var depois = valor / 2 + valor % 2;
  print(depois);
}
