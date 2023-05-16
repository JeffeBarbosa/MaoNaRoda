import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:http/http.dart' as http;

import 'package:mao/models/userModel.dart';
import 'package:mao/pages/pageHistoricoContratacao.dart';
import 'package:mao/pages/pagePrincipalPrestador.dart';

// ignore: must_be_immutable
class PagePrincipal extends StatefulWidget {
  int id;
  String nome;
  String tipo_cadastro;
  PagePrincipal(this.id, this.nome, this.tipo_cadastro);
  late int quatidade;
  @override
  State<PagePrincipal> createState() => _PagePrincipalState();
}

Future<void> postData(int idcadastro, int idcontratado) async {
  final url = Uri.parse('http://192.168.53.110/mao/index.php/servico');
  final headers = {'Content-Type': 'application/json'};
  final body = jsonEncode({
    'cadastro_idcadastro': idcadastro,
    'id_contratado': idcontratado,
  });

  final response = await http.post(url, headers: headers, body: body);

  if (response.statusCode == 200) {
    print("Cadastrado com sucesso");
  } else {
    print("Cadastro mal sucedido");
  }
}

class _PagePrincipalState extends State<PagePrincipal> {
  late Future<List<UserModel>> usermodel;
  double rating = 0;
  double media = 0;

  @override
  void initState() {
    super.initState();
    usermodel = pegarUsuario();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1f1545),
      appBar: AppBar(
        title: Text('Serviços para a Agricultura'),
      ),
      drawer: _menu(),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: const Text(
            'Escolha o profissional desejado',
            style: TextStyle(color: Colors.deepPurple, fontSize: 20),
          ),
        ),
        Center(
            child: FutureBuilder<List<UserModel>>(
          future: usermodel,
          builder: ((context, snapshot) {
            if (snapshot.hasData) {
              return SizedBox(
                height: 560,
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      UserModel usermodel = snapshot.data![index];
                      return ListTile(
                        title: Text(usermodel.nome,
                            style: TextStyle(color: Colors.white)),
                        subtitle: Text(retornarTrabalho(usermodel.idprofissao),
                            style: TextStyle(color: Colors.white)),
                        trailing: SizedBox(
                          width: 150,
                          child: Row(
                            children: <Widget>[
                              IconButton(
                                  color: Colors.blue,
                                  onPressed: () async {
                                    media = await avaliacao(
                                        usermodel.idprofissional);
                                    // ignore: use_build_context_synchronously
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          backgroundColor: Colors.white,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          title: Text(usermodel.nome),
                                          content: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                      'Telefone: ${usermodel.telefone.toString()}'),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  TextButton(
                                                      onPressed: () {
                                                        especificacao(
                                                            context,
                                                            usermodel
                                                                .profissao);
                                                      },
                                                      child: Text(
                                                          'Especificações Técnicas')),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  RatingBar.builder(
                                                      initialRating: media,
                                                      allowHalfRating: true,
                                                      ignoreGestures: true,
                                                      itemBuilder: (context,
                                                              _) =>
                                                          const Icon(Icons.star,
                                                              color:
                                                                  Colors.amber),
                                                      onRatingUpdate:
                                                          (value) {}),
                                                ],
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Row(
                                                  children: [
                                                    Text(
                                                        '${widget.quatidade} avaliações'),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                          .fromLTRB(70, 0, 0, 0),
                                                      child: Text(media
                                                          .toStringAsPrecision(
                                                              2)),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: Text("OK"),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                  icon: Icon(Icons.search)),
                              ElevatedButton(
                                  onPressed: () async {
                                    postData(
                                        widget.id, usermodel.idprofissional);
                                  },
                                  child: const Text('Contratar')),
                            ],
                          ),
                        ),
                      );
                    }),
              );
            } else if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }
            return const CircularProgressIndicator();
          }),
        ))
      ]),
    );
  }

  Future<List<UserModel>> pegarUsuario() async {
    var url =
        Uri.parse('http://192.168.53.110/mao/index.php/registro/profissional');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      List listaUsuario = json.decode(response.body);
      return listaUsuario.map((json) => UserModel.fromJson(json)).toList();
    } else {
      throw Exception('erro');
    }
  }

  Future<double> avaliacao(int id) async {
    double media = 0;
    var url = Uri.parse('http://192.168.53.110/mao/index.php/avaliacao/$id');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      List avaliacao = json.decode(response.body);
      avaliacao.forEach((value) {
        media += value['avaliacao'];
      });
      media = media / avaliacao.length;
      if (avaliacao.isEmpty) {
        media = 0;
      }
      widget.quatidade = avaliacao.length;
      return media;
    } else {
      throw Exception('erro');
    }
  }

  String retornarTrabalho(int idtrabalho) {
    late String trabalho;

    if (idtrabalho == 1) {
      trabalho = 'Engenheiro Agrônomo ';
    } else if (idtrabalho == 2) {
      trabalho = "Agrimensor";
    } else if (idtrabalho == 3) {
      trabalho = 'Engenheiro Hídrico';
    } else if (idtrabalho == 4) {
      trabalho = 'Gestão Ambiental';
    } else if (idtrabalho == 5) {
      trabalho = 'Serviços de Drone';
    } else if (idtrabalho == 6) {
      trabalho = 'Técnico Agrícola';
    } else if (idtrabalho == 7) {
      trabalho = 'Veterinário';
    } else {
      trabalho = 'Zootecnista';
    }

    return trabalho;
  }

  void especificacao(BuildContext context, String texto) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Especificação"),
          content: Text(texto),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }

  _menu(){
    if(widget.tipo_cadastro == '1'){
     return Drawer(
          backgroundColor: Color.fromRGBO(185, 136, 62, 1),
          child: Column(children: [
            ListTile(
              title: Center(
                child: Text(
                  'Bem vindo ',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
            ListTile(
              title: Center(
                child: Text(widget.nome,
                    style: TextStyle(
                        fontSize: 15, color: Color.fromARGB(255, 66, 33, 23))),
              ),
            ),
            ListTile(
              title: Text('Pagina de Contratação'),
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          PagePrincipal(widget.id, widget.nome, widget.tipo_cadastro))),
            ),
            ListTile(
              title: Text('Historico de Contratação'),
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          PageHistoricoContratacao(widget.id, widget.nome, widget.tipo_cadastro))),
            )
          ]));
    }else{
      return Drawer(
          backgroundColor: Color.fromRGBO(185, 136, 62, 1),
          child: Column(children: [
            ListTile(
              title: Center(
                child: Text(
                  'Bem vindo ',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
            ListTile(
              title: Center(
                child: Text(widget.nome,
                    style: TextStyle(
                        fontSize: 15, color: Color.fromARGB(255, 66, 33, 23))),
              ),
            ),ListTile(
              title: Text('Historico de Contratos'),
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          PagePrincipalPrestador(widget.id, widget.nome, widget.tipo_cadastro))),
            ),
            ListTile(
              title: Text('Pagina de Contratação'),
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          PagePrincipal(widget.id, widget.nome, widget.tipo_cadastro))),
            ),
            ListTile(
              title: Text('Historico de Contratação'),
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          PageHistoricoContratacao(widget.id, widget.nome, widget.tipo_cadastro))),
            )
          ]));
    }
  }


}
