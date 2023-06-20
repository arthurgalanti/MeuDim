// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';

import '../controller/login_controller.dart';
import '../model/userdata.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({super.key});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  var txtUpdateName = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 5,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.3,
            child: DrawerHeader(
              decoration: BoxDecoration(
                  color: Color(0xFFF5F5F5),
                  image: DecorationImage(
                      image: AssetImage("lib/images/logo.png"),
                      fit: BoxFit.fitWidth)),
              child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          FutureBuilder<String>(
                              future: LoginController().loggedUsername(),
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
                                      txtUpdateName.text =
                                          snapshot.data.toString();
                                      return Text(snapshot.data.toString(),
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black));
                                    }
                                }
                              }),
                          TextButton(
                              onPressed: () {
                                updateName(context,
                                    docId: LoginController()
                                        .getUserId()
                                        .toString());
                              },
                              child: Text('alterar')),
                        ],
                      ),
                      IconButton(
                          onPressed: () {
                            LoginController().logout();
                            Navigator.pushReplacementNamed(context, 'login');
                          },
                          icon: Icon(Icons.logout_outlined))
                    ],
                  )),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Página Inicial - Saldo'),
            onTap: () {
              Navigator.pushReplacementNamed(context, 'home');
            },
          ),
          ListTile(
            leading: const Icon(Icons.add),
            title: const Text('Incluir Movimentação'),
            onTap: () {
              Navigator.pushReplacementNamed(context, 'add_movement');
            },
          ),
          ListTile(
            leading: const Icon(Icons.tab_outlined),
            title: const Text('Categorias'),
            onTap: () {
              Navigator.pushReplacementNamed(context, 'add_category');
            },
          ),
        ],
      ),
    );
  }

  void updateName(context, {docId}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Modificar nome"),
          content: SizedBox(
            height: 60,
            width: 300,
            child: Column(
              children: [
                TextField(
                  controller: txtUpdateName,
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
                txtUpdateName.clear();
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: Text("salvar"),
              onPressed: () {
                Navigator.of(context).pop();
                var newName = Userdata(
                  LoginController().getUserId().toString(),
                  txtUpdateName.text,
                );
                txtUpdateName.clear();
                if (docId != null) {
                  setState(() {
                    LoginController().updateUsername(context, docId, newName);
                  });
                } else {}
              },
            ),
          ],
        );
      },
    );
  }
}
