import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class PagePrincipalPrestador extends StatefulWidget {

  int id;
  String nome;
  PagePrincipalPrestador(this.id, this.nome);
  @override
  State<PagePrincipalPrestador> createState() => _PagePrincipalPrestadorState();
}

class _PagePrincipalPrestadorState extends State<PagePrincipalPrestador> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}