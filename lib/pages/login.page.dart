// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

import '../controller/login_controller.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var txtEmail = TextEditingController();
  var txtPassword = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: MediaQuery.of(context).size.height * 0.6,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          offset: Offset(1, 2.0),
                          blurRadius: 5,
                          spreadRadius: 1,
                        )
                      ],
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(left: 15, right: 15, top: 40),
                      child: Column(
                        children: [
                          Column(
                            children: [
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.20,
                                alignment: Alignment.center,
                                child: Image.asset(
                                  "lib/images/logo.png",
                                ),
                              ),
                            ],
                          ),
                          TextFormField(
                            // autofocus: true,
                            keyboardType: TextInputType.emailAddress,
                            controller: txtEmail,
                            decoration: InputDecoration(
                              labelText: "E-mail",
                              labelStyle: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                              ),
                            ),
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          SizedBox(height: 10),
                          TextFormField(
                            controller: txtPassword,
                            keyboardType: TextInputType.text,
                            obscureText: true,
                            decoration: InputDecoration(
                              labelText: "Senha",
                              labelStyle: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                              ),
                            ),
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 5),
                            alignment: Alignment.topRight,
                            child: TextButton(
                              onPressed: () {
                                Navigator.pushNamed(context, 'recovery');
                              },
                              child: Text(
                                'Esqueceu a senha?',
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          Container(
                            width: double.infinity,
                            height: 45,
                            decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(5),
                                )),
                            child: TextButton(
                              onPressed: () {
                                LoginController().login(
                                  context,
                                  txtEmail.text,
                                  txtPassword.text,
                                );
                              },
                              child: Text(
                                'Entrar',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 40),
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, 'signup');
                            },
                            child: Text('Criar conta'),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(top: 15, bottom: 15),
                        child: Text(
                          "- OU -",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        height: 60,
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 2.0,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(5),
                          ),
                        ),
                        child: TextButton(
                          onPressed: () {
                            genericError(context);
                          },
                          child: Row(
                            children: [
                              SizedBox(
                                height: 32,
                                width: 100,
                                child: Image.asset("lib/images/google.png"),
                              ),
                              Text(
                                "Entre com o Google",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            width: MediaQuery.of(context).size.width,
            child: Container(
              decoration: BoxDecoration(color: Colors.white, boxShadow: [
                BoxShadow(
                  offset: Offset(0, -1),
                  spreadRadius: 0,
                  blurRadius: 3,
                  color: Colors.black12,
                )
              ]),
              child: Column(children: [
                Text('Desenvolvido por Arthur Galanti © 2023'),
                InkWell(
                  child: Text('Sobre',
                      style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline)),
                  onTap: () {
                    Navigator.pushNamed(context, 'about');
                  },
                )
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

@override
Future<String?> genericError(BuildContext context) {
  return showDialog<String>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: const Text('Erro interno do servidor - 500'),
      content: const Text('Ocorreu um erro ao tentar se conectar ao servidor',
          textAlign: TextAlign.center),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Icon(Icons.done),
        ),
      ],
    ),
  );
}
