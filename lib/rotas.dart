import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:mao/pages/PagePrestador.dart';
import 'package:mao/pages/loginPage.dart';
import 'package:mao/pages/pagePrincipal.dart';
import 'package:mao/pages/registerPage.dart';



final routes = {
  '/login': (BuildContext context) => const LoginPage(),
  '/register': (BuildContext context) => const RegisterPage(),
  '/pagePestador': (BuildContext context) => const PagePrestador(),
};