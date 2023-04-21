// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

final Uri github = Uri.parse('https://flutter.dev');

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black12,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(children: [
            SizedBox(
              height: 30,
            ),
            Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.height * 0.5,
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
                      Column(children: [
                        Text(
                          "Sobre",
                          style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        CircleAvatar(
                          backgroundImage: AssetImage("lib/images/author.png"),
                          radius: 90,
                        ),
                        Text(
                          "Arthur Galanti",
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.purple[600]),
                        ),
                        TextButton(
                            onPressed: _launchUrl, child: Text('Github')),
                        Text.rich(
                          textAlign: TextAlign.center,
                          TextSpan(
                            text: 'O aplicativo',
                            children: <TextSpan>[
                              TextSpan(
                                  text: ' MEU DIM ',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              TextSpan(
                                text:
                                    'é um aplicativo que oferece uma interface intuitiva e amigável para o usuário.\nCom apenas alguns cliques, você pode inserir suas despesas e receitas, categorizá-las e acompanhar seu saldo atualizado.\nÉ uma ótima ferramenta para quem busca organizar suas finanças pessoais e evitar gastos desnecessários. ',
                              )
                            ],
                          ),
                        ),
                      ]),
                    ],
                  ),
                ),
              ),
            ])
          ]),
        ),
      ),
    );
  }
}

Future<void> _launchUrl() async {
  if (!await launchUrl(github)) {
    throw Exception('Could not launch $github');
  }
}
