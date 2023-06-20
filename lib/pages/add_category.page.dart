// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../controller/login_controller.dart';
import '../controller/category_controller.dart';
import '../widgets/drawer.dart';
import '../model/category.dart';

class AddCategoryPage extends StatefulWidget {
  const AddCategoryPage({super.key});

  @override
  State<AddCategoryPage> createState() => _AddCategoryPageState();
}

class _AddCategoryPageState extends State<AddCategoryPage> {
  var txtCategory = TextEditingController();
  var txtUpdateCategory = TextEditingController();

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
                          "Adicionar Categoria",
                          style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                      SizedBox(height: 60),
                      TextFormField(
                        controller: txtCategory,
                        decoration: InputDecoration(
                          labelText: "Nome da categoria",
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
                            var category = Category(
                                LoginController().getUserId().toString(),
                                txtCategory.text,
                                Uuid().v4().toString());
                            txtCategory.clear();
                            CategoryController().add(context, category);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
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
                  padding: EdgeInsets.only(left: 15, right: 15),
                  child: StreamBuilder<QuerySnapshot>(
                    stream: CategoryController().list().snapshots(),
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
                          final dados = snapshot.requireData;
                          if (dados.size > 0) {
                            return Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 15),
                                  child: Text(
                                      "Mantenha pressionado para excluír."),
                                ),
                                SizedBox(
                                  height: 200.0,
                                  child: ListView.builder(
                                    itemCount: dados.size,
                                    itemBuilder: (context, index) {
                                      String id = dados.docs[index].id;
                                      dynamic item = dados.docs[index].data();
                                      return Card(
                                        child: ListTile(
                                          leading: Icon(Icons.description),
                                          title: Text(item['name'],
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black)),
                                          onTap: () {
                                            txtUpdateCategory.text =
                                                item['name'];
                                            updateCategory(context, id);
                                          },
                                          onLongPress: () {
                                            CategoryController()
                                                .delete(context, id);
                                          },
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            );
                          } else {
                            return Center(
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 30, bottom: 30),
                                    child: Text(
                                        "Adicione sua primeira categoria."),
                                  ),
                                ],
                              ),
                            );
                          }
                      }
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void updateCategory(context, docId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // retorna um objeto do tipo Dialog
        return AlertDialog(
          title: Text("Modificar categoria"),
          content: SizedBox(
            height: 60,
            width: 300,
            child: Column(
              children: [
                TextField(
                  controller: txtUpdateCategory,
                  decoration: InputDecoration(
                    labelText: 'Nome',
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
                txtUpdateCategory.clear();
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: Text("salvar"),
              onPressed: () {
                Navigator.of(context).pop();
                var newName = Category(
                  LoginController().getUserId().toString(),
                  txtUpdateCategory.text,
                  docId,
                );
                if (docId == null) {
                  CategoryController().add(context, newName);
                } else {
                  CategoryController().update(context, docId, newName);
                }
                txtUpdateCategory.clear();
              },
            ),
          ],
        );
      },
    );
  }
}
