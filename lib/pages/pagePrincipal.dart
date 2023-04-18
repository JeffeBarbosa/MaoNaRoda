import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';




class PagePrincipal extends StatefulWidget {
  
  int id;
  String nome;
  PagePrincipal(this.id, this.nome);
  @override
  State<PagePrincipal> createState() => _PagePrincipalState();
}

class _PagePrincipalState extends State<PagePrincipal> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        title: Text('Serviços para a Agricultura'),
      ),
      body: ListView(
       
  
      ),
    );
  }


}
