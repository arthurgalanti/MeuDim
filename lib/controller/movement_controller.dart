// ignore_for_file: invalid_return_type_for_catch_error, avoid_function_literals_in_foreach_calls

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../model/movement.dart';
import '../pages/util.dart';
import 'login_controller.dart';

class MovementController {
  var db = FirebaseFirestore.instance;

  void add(context, Movement movement) {
    db
        .collection('movements')
        .doc(movement.uid)
        .set(movement.toJson())
        .then((value) {
      sucesso(context, 'Movimentação adicionada com sucesso');
    }).catchError((e) => erro(context, 'Erro: ${e.code.toString()}'));
  }

  void update(context, id, Movement movement) {
    db.collection('movements').doc(id).update(movement.toJson()).then((value) {
      sucesso(context, 'Movimentação atualizada com sucesso');
    }).catchError((e) => erro(context, 'Erro: ${e.code.toString()}'));
  }

  void delete(context, id) {
    db
        .collection('movements')
        .doc(id)
        .delete()
        .then((value) => sucesso(context, 'Movimentação excluída com sucesso'))
        .catchError((e) => erro(context, 'Erro: ${e.code.toString()}'));
  }

  list() {
    return db
        .collection('movements')
        .where('userId', isEqualTo: LoginController().getUserId());
  }

  Future<String> balance() async {
    double balance = 0;
    await FirebaseFirestore.instance
        .collection('movements')
        .where('userId', isEqualTo: LoginController().getUserId())
        .get()
        .then(
      (result) {
        result.docs.forEach((doc) {
          balance += doc.data()['amount'];
        });
      },
    );
    return balance.toString();
  }
}
