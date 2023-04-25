import 'package:flutter/material.dart';
import 'package:mao/pages/PagePrestador.dart';
import 'package:mao/pages/loginPage.dart';
import 'package:mao/pages/pagePrincipal.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mão na Roda',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PagePrincipal(12, 'jeferson'),
    );
  }
}



