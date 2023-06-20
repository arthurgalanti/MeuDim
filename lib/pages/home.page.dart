// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import '../controller/movement_controller.dart';
import '../model/movement.dart';
import '../widgets/drawer.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var txtUpdateDescription = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Color getIntuitiveColor(double amount, String source) {
      switch (source) {
        case 'balance':
          if (amount >= 0) {
            return Colors.green;
          } else {
            return Colors.red;
          }
        case 'movement':
          if (amount >= 0) {
            return Colors.green.shade300;
          } else {
            return Colors.red.shade300;
          }
        default:
          return Colors.black;
      }
    }

    IconData getIntuitiveIcone(bool debit) {
      if (debit == false) {
        return Icons.attach_money_outlined;
      } else {
        return Icons.money_off_outlined;
      }
    }

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFFF5F5F5),
          iconTheme: IconThemeData(color: Colors.black),
        ),
        body: SingleChildScrollView(
          child: SizedBox(
            child: Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.1,
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
                  child: SizedBox(
                    child: Center(
                      child: FutureBuilder<String>(
                          future: MovementController().balance(),
                          builder: (context, snapshot) {
                            switch (snapshot.connectionState) {
                              case ConnectionState.none:
                                return Text('');
                              case ConnectionState.waiting:
                                return SizedBox(
                                  height: 10.0,
                                  width: 10.0,
                                  child: Center(
                                      child: CircularProgressIndicator()),
                                );
                              default:
                                {
                                  return Text(
                                    'R\$ ${NumberFormat("#,##0.00", "pt_BR").format(double.parse(snapshot.data.toString()))}',
                                    style: TextStyle(
                                      fontSize: 50.0,
                                      fontWeight: FontWeight.bold,
                                      color: getIntuitiveColor(
                                          double.parse(
                                              snapshot.data.toString()),
                                          'balance'),
                                    ),
                                  );
                                }
                            }
                          }),
                    ),
                  ),
                ),
                StreamBuilder<QuerySnapshot>(
                    stream: MovementController().list().snapshots(),
                    builder: (context, snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.none:
                          return Center(
                            child: Text('Não foi possível conectar.'),
                          );
                        case ConnectionState.waiting:
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        default:
                          final data = snapshot.requireData;
                          if (data.size > 0) {
                            return SizedBox(
                              height: MediaQuery.of(context).size.height * 0.7,
                              child: ListView.builder(
                                  itemCount: data.size,
                                  itemBuilder: (context, index) {
                                    String id = data.docs[index].id;
                                    dynamic item = data.docs[index].data();
                                    return Card(
                                      child: Container(
                                        height: 80,
                                        color: getIntuitiveColor(
                                            item["amount"], 'movement'),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: SizedBox(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Icon(getIntuitiveIcone(
                                                        item["isDebit"])),
                                                    Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Text('Valor:'),
                                                            Text(('R\$ ${NumberFormat("#,##0.00", "pt_BR").format(item["amount"])}')
                                                                .toString()),
                                                          ],
                                                        ),
                                                        Row(
                                                          children: [
                                                            Text(
                                                              'Categoria: ',
                                                            ),
                                                            Text(
                                                              item["category"]
                                                                  .toString(),
                                                            ),
                                                          ],
                                                        ),
                                                        Row(
                                                          children: [
                                                            Text('Descrição: '),
                                                            Text(item[
                                                                    "description"]
                                                                .toString()),
                                                          ],
                                                        ),
                                                        Row(
                                                          children: [
                                                            Text('Data: '),
                                                            Text(
                                                              DateFormat(
                                                                      'dd/MM/yyyy')
                                                                  .format((item[
                                                                              "date"]
                                                                          as Timestamp)
                                                                      .toDate())
                                                                  .toString(),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                IconButton(
                                                    icon:
                                                        const Icon(Icons.edit),
                                                    onPressed: () {
                                                      txtUpdateDescription
                                                              .text =
                                                          item['description'];
                                                      updateDescription(
                                                          context,
                                                          Movement.fromJson(
                                                              item));
                                                    }),
                                                IconButton(
                                                    icon: const Icon(
                                                        Icons.delete),
                                                    onPressed: () {
                                                      deleteMovement(
                                                          context,
                                                          Movement.fromJson(
                                                              item));
                                                    })
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  }),
                            );
                          } else {
                            return Center(
                              child: Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(0, 60, 0, 0),
                                    child: Text(
                                        "Adicione sua primeira movimentação."),
                                  ),
                                ],
                              ),
                            );
                          }
                      }
                    })
              ],
            ),
          ),
        ),
        drawer: AppDrawer());
  }

  String getMovementType(bool isDebit) {
    if (isDebit) {
      return "débito";
    } else {
      return "crédito";
    }
  }

  void deleteMovement(context, Movement movementToDelete) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Confirmação"),
          content: SizedBox(
            height: 60,
            width: 300,
            child: Column(
              children: [
                Text(
                    'Tem certeza que deseja excluir esse ${getMovementType(movementToDelete.isDebit)} de R\$ ${NumberFormat("#,##0.00", "pt_BR").format(movementToDelete.amount)} ?')
              ],
            ),
          ),
          actionsPadding: EdgeInsets.fromLTRB(20, 0, 20, 10),
          actions: [
            TextButton(
              child: Text("fechar"),
              onPressed: () {
                Navigator.of(context).pop();
                txtUpdateDescription.clear();
              },
            ),
            ElevatedButton(
              child: Text("salvar"),
              onPressed: () {
                setState(() {
                  MovementController().delete(context, movementToDelete.uid);
                });
                Navigator.of(context).pop();
                txtUpdateDescription.clear();
              },
            ),
          ],
        );
      },
    );
  }

  void updateDescription(context, Movement newMovement) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Modificar descrição"),
          content: SizedBox(
            height: 60,
            width: 300,
            child: Column(
              children: [
                TextField(
                  controller: txtUpdateDescription,
                  decoration: InputDecoration(
                    labelText: 'Nova descrição:',
                    prefixIcon: Icon(Icons.description),
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),
          actionsPadding: EdgeInsets.fromLTRB(20, 0, 20, 10),
          actions: [
            TextButton(
              child: Text("fechar"),
              onPressed: () {
                Navigator.of(context).pop();
                txtUpdateDescription.clear();
              },
            ),
            ElevatedButton(
              child: Text("salvar"),
              onPressed: () {
                newMovement.description = txtUpdateDescription.text;
                MovementController()
                    .update(context, newMovement.uid, newMovement);
                Navigator.of(context).pop();
                txtUpdateDescription.clear();
              },
            ),
          ],
        );
      },
    );
  }
}
