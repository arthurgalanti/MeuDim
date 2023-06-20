import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../model/userdata.dart';
import '../pages/util.dart';

class LoginController {
  var auth = FirebaseAuth.instance;
  var db = FirebaseFirestore.instance;

  create(context, name, email, password) {
    auth
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((result) {
      db
          .collection('usuarios')
          .doc(result.user!.uid)
          .set(Userdata(result.user!.uid, name).toJson(),
              SetOptions(merge: true))
          .onError((e, _) => erro(context, "Erro: $e"));
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Cadastrado'),
          content: const Text(
              'E-mail enviado. \n Verifique sua caixa de correio para confirmar o cadastro.',
              textAlign: TextAlign.center),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context)
                ..pop()
                ..pop(),
              child: const Icon(Icons.done),
            ),
          ],
        ),
      );
    }).catchError((e) {
      switch (e.code) {
        case 'email-already-in-use':
          erro(context, 'O email já foi cadastrado.');
          break;
        case 'invalid-email':
          erro(context, 'O formato do email é inválido.');
          break;
        default:
          erro(context, 'Erro: ${e.code.toString()}');
      }
    });
  }

  login(context, email, password) {
    auth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((result) {
      sucesso(context, 'Usuário autenticado com sucesso.');
      Navigator.pushReplacementNamed(context, 'home');
    }).catchError((e) {
      switch (e.code) {
        case 'invalid-email':
          erro(context, 'O formato do email é inválido.');
          break;
        case 'user-not-found':
          erro(context, 'Usuário não encontrado.');
          break;
        case 'wrong-password':
          erro(context, 'Senha incorreta.');
          break;
        default:
          erro(context, 'Erro: ${e.code.toString()}');
      }
    });
  }

  void updateUsername(context, id, Userdata userdata) {
    db
        .collection('usuarios')
        .doc(id)
        .update(userdata.toJson())
        .catchError((e) => erro(context, 'ERRO: ${e.code.toString()}'));
  }

  forgotPassword(context, String email) {
    if (email.isNotEmpty) {
      auth.sendPasswordResetEmail(
        email: email,
      );
      showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
                title: const Text('Recuperação'),
                content: const Text(
                    'Enviaremos um email caso existir esse cadastro em nossa base, caso receba siga as instruções no e-mail.'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () => Navigator.of(context)
                      ..pop()
                      ..pop(),
                    child: const Icon(Icons.done),
                  ),
                ],
              ));
    } else {
      erro(context, 'Informe o email para recuperar a conta.');
    }
  }

  logout() {
    auth.signOut();
  }

  getUserId() {
    return FirebaseAuth.instance.currentUser!.uid;
  }

  Future<String> loggedUsername() async {
    var user = '';
    await FirebaseFirestore.instance
        .collection('usuarios')
        .where('uid', isEqualTo: getUserId())
        .get()
        .then(
      (result) {
        user = result.docs[0].data()['name'] ?? '';
      },
    );
    return user;
  }
}
