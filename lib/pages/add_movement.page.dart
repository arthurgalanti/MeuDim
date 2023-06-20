// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, import_of_legacy_library_into_null_safe

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:meu_dim/model/movement.dart';
import 'package:meu_dim/pages/util.dart';
import 'package:uuid/uuid.dart';

import '../controller/category_controller.dart';
import '../controller/login_controller.dart';
import '../controller/movement_controller.dart';
import '../widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddMovementPage extends StatefulWidget {
  const AddMovementPage({super.key});

  @override
  State<AddMovementPage> createState() => _AddMovementPageState();
}

class _AddMovementPageState extends State<AddMovementPage> {
  final DateTime now = DateTime.now();
  final DateFormat formatter = DateFormat('dd-MM-yyyy');

  var txtAmount = MoneyMaskedTextController();
  var txtDate = MaskedTextController(text: "", mask: '00/00/0000');
  String selectedCategory = '0';
  late bool isDebit;
  var txtDescription = TextEditingController();

  @override
  void initState() {
    txtDate.text = formatter.format(now);
    isDebit = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black12,
        elevation: 0,
      ),
      drawer: AppDrawer(),
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
                          "Incluir Movimentação",
                          style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                      SizedBox(height: 60),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: txtAmount,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                labelText: "Valor",
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
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            child: TextFormField(
                              controller: txtDate,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                labelText: "Data",
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
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Text(
                            'Categoria: ',
                            style: TextStyle(color: Colors.black, fontSize: 16),
                          ),
                          StreamBuilder<QuerySnapshot>(
                              stream: CategoryController().list().snapshots(),
                              builder: (context, snapshot) {
                                List<DropdownMenuItem> categoriesItems = [];
                                if (!snapshot.hasData) {
                                  const CircularProgressIndicator();
                                } else {
                                  final categories =
                                      snapshot.data?.docs.reversed.toList();
                                  categoriesItems.add(
                                    const DropdownMenuItem(
                                      value: '0',
                                      child: Text(
                                        'Selecione',
                                      ),
                                    ),
                                  );
                                  for (var category in categories!) {
                                    categoriesItems.add(DropdownMenuItem(
                                      value: category['name'],
                                      child: Text(
                                        category['name'],
                                      ),
                                    ));
                                  }
                                }
                                return DropdownButton(
                                  items: categoriesItems,
                                  onChanged: (categorieValue) {
                                    setState(() {
                                      selectedCategory = categorieValue;
                                    });
                                  },
                                  value: selectedCategory,
                                  isExpanded: false,
                                );
                              }),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Tipo de movimentação: ',
                            style: TextStyle(color: Colors.black, fontSize: 16),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(children: [
                        SizedBox(
                          width: 150,
                          height: 50,
                          child: ListTile(
                              title: const Text('Entrada'),
                              leading: Radio<bool>(
                                  value: false,
                                  groupValue: isDebit,
                                  onChanged: (value) {
                                    setState(() {
                                      if (value != null) {
                                        isDebit = value;
                                      }
                                    });
                                  })),
                        ),
                        SizedBox(
                          width: 150,
                          height: 50,
                          child: ListTile(
                              title: const Text('Saída'),
                              leading: Radio<bool>(
                                  value: true,
                                  groupValue: isDebit,
                                  onChanged: (value) {
                                    setState(() {
                                      if (value != null) {
                                        isDebit = value;
                                      }
                                    });
                                  })),
                        ),
                      ]),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: txtDescription,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          labelText: "Descrição",
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
                          child: Text("Adicionar"),
                          onPressed: () {
                            DateFormat formatedDate = DateFormat("dd/MM/yyyy");
                            var amountConverted = double.parse(
                              modifyLastComma(txtAmount.text),
                            );

                            if (isDebit) {
                              amountConverted =
                                  amountConverted - (amountConverted * 2);
                            }
                            var movement = Movement(
                                Uuid().v4().toString(),
                                LoginController().getUserId().toString(),
                                amountConverted,
                                selectedCategory,
                                txtDescription.text,
                                formatedDate.parse(txtDate.text),
                                isDebit);
                            MovementController().add(context, movement);
                            Navigator.pushReplacementNamed(context, 'home');
                          },
                        ),
                      ),
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
