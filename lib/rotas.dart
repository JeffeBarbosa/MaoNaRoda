import 'package:MaoNaRoda/paginas/paginaPrincipal.dart';
import 'package:flutter/material.dart';
import 'paginas/login.dart';
import 'paginas/splash.dart';

final routes = {
  '/login': (BuildContext context) => LoginPage(),
  '/principal': (BuildContext context) => principal(),
  '/splash': (BuildContext context) => Splash(),
};
