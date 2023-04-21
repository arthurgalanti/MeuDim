// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:apppagar/pages/add_current.page.dart';
import 'package:apppagar/pages/add_category.page.dart';
import 'package:apppagar/pages/home.page.dart';
import 'package:apppagar/pages/login.page.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

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
                    Text("Olá, {User.Name}"),
                    IconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginPage()));
                        },
                        icon: Icon(Icons.logout_outlined))
                  ],
                ),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Página Inicial - Saldo'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HomePage()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.add),
            title: const Text('Adicionar - Débito/Crédito'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddCurrentPage()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.tab_outlined),
            title: const Text('Categorias'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const AddCategoryPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}
