// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:apppagar/pages/drawer.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFFF5F5F5),
          iconTheme: IconThemeData(color: Colors.black),
        ),
        body: SingleChildScrollView(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.2,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 167, 165, 165),
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0, 7),
                        spreadRadius: -7,
                        blurRadius: 15,
                        color: Color.fromRGBO(0, 0, 0, 1),
                      )
                    ],
                  ),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Saldo:",
                            style: TextStyle(
                                color: Colors.black87,
                                fontSize: 72.0,
                                fontWeight: FontWeight.bold)),
                        Text(
                          "-R\$540",
                          style: TextStyle(
                              color: Colors.red[600],
                              fontSize: 68.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: ListView(
                    children: [
                      Container(
                        height: 80,
                        color: Colors.red[100],
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Center(
                                child: Text.rich(
                              textAlign: TextAlign.center,
                              TextSpan(
                                text: 'Valor: ',
                                children: <TextSpan>[
                                  TextSpan(
                                      text: 'R\$-1.000,00',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.red,
                                      )),
                                  TextSpan(
                                    text: ' Categoria: ',
                                  ),
                                  TextSpan(
                                      text: 'Apostas',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      )),
                                  TextSpan(
                                    text: ' Descrição: ',
                                  ),
                                  TextSpan(
                                      text: 'Valor apostado no Flamengo',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      )),
                                ],
                              ),
                            )),
                            Text.rich(
                              textAlign: TextAlign.center,
                              TextSpan(text: 'Data: ', children: <TextSpan>[
                                TextSpan(
                                    text: '19/04/2023',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    )),
                              ]),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 80,
                        color: Colors.red[100],
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Center(
                                child: Text.rich(
                              textAlign: TextAlign.center,
                              TextSpan(
                                text: 'Valor: ',
                                children: <TextSpan>[
                                  TextSpan(
                                      text: 'R\$-45,00',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.red,
                                      )),
                                  TextSpan(
                                    text: ' Categoria: ',
                                  ),
                                  TextSpan(
                                      text: 'Comida',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      )),
                                  TextSpan(
                                    text: ' Descrição: ',
                                  ),
                                  TextSpan(
                                      text: 'Gasto com comida mercadinho',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      )),
                                ],
                              ),
                            )),
                            Text.rich(
                              textAlign: TextAlign.center,
                              TextSpan(text: 'Data: ', children: <TextSpan>[
                                TextSpan(
                                    text: '18/04/2023',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    )),
                              ]),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 80,
                        color: Colors.red[100],
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Center(
                                child: Text.rich(
                              textAlign: TextAlign.center,
                              TextSpan(
                                text: 'Valor: ',
                                children: <TextSpan>[
                                  TextSpan(
                                      text: 'R\$-1.500,00',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.red,
                                      )),
                                  TextSpan(
                                    text: ' Categoria: ',
                                  ),
                                  TextSpan(
                                      text: 'Contas Mensais',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      )),
                                  TextSpan(
                                    text: ' Descrição: ',
                                  ),
                                  TextSpan(
                                      text: 'Boleto pago',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      )),
                                ],
                              ),
                            )),
                            Text.rich(
                              textAlign: TextAlign.center,
                              TextSpan(text: 'Data: ', children: <TextSpan>[
                                TextSpan(
                                    text: '15/04/2023',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    )),
                              ]),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 80,
                        color: Colors.green[100],
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Center(
                                child: Text.rich(
                              textAlign: TextAlign.center,
                              TextSpan(
                                text: 'Valor: ',
                                children: <TextSpan>[
                                  TextSpan(
                                      text: 'R\$+2.000,00',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.green,
                                      )),
                                  TextSpan(
                                    text: ' Categoria: ',
                                  ),
                                  TextSpan(
                                      text: 'Salário',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      )),
                                  TextSpan(
                                    text: ' Descrição: ',
                                  ),
                                  TextSpan(
                                      text: 'Recebido',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      )),
                                ],
                              ),
                            )),
                            Text.rich(
                              textAlign: TextAlign.center,
                              TextSpan(text: 'Data: ', children: <TextSpan>[
                                TextSpan(
                                    text: '10/04/2023',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    )),
                              ]),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        drawer: AppDrawer());
  }
}
