// ignore_for_file: invalid_return_type_for_catch_error

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../model/category.dart';
import '../pages/util.dart';
import 'login_controller.dart';

class CategoryController {
  var db = FirebaseFirestore.instance;

  void add(context, Category category) {
    db
        .collection('categories')
        .doc(category.uid)
        .set(category.toJson())
        .then((value) {
      sucesso(context, 'Categoria adicionada com sucesso');
    }).catchError((e) => erro(context, 'Erro: ${e.code.toString()}'));
  }

  void update(context, id, Category category) {
    db.collection('categories').doc(id).update(category.toJson()).then((value) {
      sucesso(context, 'Categoria atualizada com sucesso');
    }).catchError((e) => erro(context, 'Erro: ${e.code.toString()}'));
  }

  void delete(context, id) {
    db
        .collection('categories')
        .doc(id)
        .delete()
        .then((value) => sucesso(context, 'Categoria excluída com sucesso'))
        .catchError((e) => erro(context, 'Erro: ${e.code.toString()}'));
  }

  list() {
    return db
        .collection('categories')
        .where('userId', isEqualTo: LoginController().getUserId());
  }
}
