// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';

import 'pages/about.page.dart';
import 'pages/add_category.page.dart';
import 'pages/add_movement.page.dart';
import 'pages/home.page.dart';
import 'pages/login.page.dart';
import 'pages/recovery.page.dart';
import 'pages/signup.page.dart';

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ).then((value) => runApp(DevicePreview(
        enabled: true,
        builder: (context) => MaterialApp(
            useInheritedMediaQuery: true,
            debugShowCheckedModeBanner: false,
            initialRoute: 'login',
            routes: {
              'about': (context) => AboutPage(),
              'add_category': (context) => AddCategoryPage(),
              'add_movement': (context) => AddMovementPage(),
              'home': (context) => HomePage(),
              'login': (context) => LoginPage(),
              'recovery': (context) => RecoveryPage(),
              'signup': (context) => SignupPage(),
            }),
      )));
}
