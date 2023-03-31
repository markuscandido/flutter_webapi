import 'dart:math';

import 'package:flutter/foundation.dart';

asyncStudy() {
  //execucaoNormal();
  //assincronismoBasico();
  //usandoFuncoesAssincronas();
  esperandoFuncoesAssincronas();
}

void execucaoNormal() {
  if (kDebugMode) {
    print("\nExecução Normal");
    print("01");
    print("02");
    print("03");
    print("04");
    print("05");
  }
}

void assincronismoBasico() {
  if (kDebugMode) {
    print("\nAssincronismo Básico");
    print("01");
    print("02");
    Future.delayed(const Duration(seconds: 4), () {
      if (kDebugMode) {
        print("03 (4s)");
      }
    });
    print("04");
    print("05");
  }
}

void usandoFuncoesAssincronas() {
  if (kDebugMode) {
    print("\nUsando funções assíncronas");
    print("A");
    print("B");
    //print(getRandomInt(3)); // Instance of Future<int>
    getRandomInt(3).then((value) {
      if (kDebugMode) {
        print("O número aleatório é $value.");
      }
      // E se eu quiser que as coisas só aconteçam depois?
    });
    print("C");
    print("D");
  }
}

void esperandoFuncoesAssincronas() async {
  if (kDebugMode) {
    print("A");
    print("B");
    int number = await getRandomInt(4);
    print("O outro número aleatório é $number.");
    print("C");
    print("D");
  }
}

Future<int> getRandomInt(int time) async {
  await Future.delayed(Duration(seconds: time));

  Random rng = Random();

  return rng.nextInt(10);
}
