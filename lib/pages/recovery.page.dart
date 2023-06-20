// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

import '../controller/login_controller.dart';

class RecoveryPage extends StatefulWidget {
  const RecoveryPage({super.key});

  @override
  State<RecoveryPage> createState() => _RecoveryPageState();
}

class _RecoveryPageState extends State<RecoveryPage> {
  var txtEmailEsqueceuSenha = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black12,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Color(0xFFF5F5F5),
          padding: EdgeInsets.only(
            top: 80,
            left: 20,
            right: 20,
            bottom: 40,
          ),
          child: Column(
            children: [
              Container(
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
                  padding: EdgeInsets.only(left: 15, right: 15, top: 60),
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Recuperar senha",
                          style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                      SizedBox(height: 60),
                      TextFormField(
                        controller: txtEmailEsqueceuSenha,
                        keyboardType: TextInputType.emailAddress,
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
                      Container(
                          margin: EdgeInsets.only(top: 40, bottom: 30),
                          width: double.infinity,
                          height: 45,
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.all(
                                Radius.circular(5),
                              )),
                          child: ElevatedButton(
                            onPressed: () {
                              LoginController().forgotPassword(
                                context,
                                txtEmailEsqueceuSenha.text,
                              );
                            },
                            child: const Text(
                              'Recuperar',
                              style: TextStyle(color: Colors.white),
                            ),
                          )),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
