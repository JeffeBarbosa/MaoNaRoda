import 'package:flutter/material.dart';
import 'paginas/home.dart';
import 'paginas/login.dart';

final routes = {
  '/login': (BuildContext context) => LoginPage(),
  '/principal': (BuildContext context) => Home(),
};
