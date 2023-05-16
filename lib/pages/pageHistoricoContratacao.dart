import 'dart:convert';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:mao/models/historicoContratado.dart';
import 'package:mao/pages/pagePrincipal.dart';
import 'package:http/http.dart' as http;
import 'package:mao/pages/pagePrincipalPrestador.dart';

class PageHistoricoContratacao extends StatefulWidget {
  int id;
  String nome;
 String tipo_cadastro;
  PageHistoricoContratacao(this.id, this.nome, this.tipo_cadastro);

  @override
  State<PageHistoricoContratacao> createState() =>
      _PageHistoricoContratacaoState();
}

class _PageHistoricoContratacaoState extends State<PageHistoricoContratacao> {
  late Future<List<HistoricoContratado>> historicoContratado;
  int valorAvaliacao = 0;

  @override
  void initState() {
    super.initState();
    historicoContratado = pegarHistorico(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1f1545),
      appBar: AppBar(
        title: Text('Serviços para a Agricultura'),
      ),
      drawer:_menu(),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: const Text(
            'Histórico de Contratações',
            style: TextStyle(color: Colors.deepPurple, fontSize: 20),
          ),
        ),
        Center(
            child: FutureBuilder<List<HistoricoContratado>>(
          future: historicoContratado,
          builder: ((context, snapshot) {
            if (snapshot.hasData) {
              return SizedBox(
                height: 560,
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      HistoricoContratado historico = snapshot.data![index];
                      return ListTile(
                        title: Text(historico.nomecontratado,
                            style: TextStyle(color: Colors.white)),
                        trailing: SizedBox(
                          width: 150,
                          child: Row(
                            children: <Widget>[
                              IconButton(
                                  color: Colors.blue,
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          title: Text(historico.nomecontratado),
                                          content: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Row(
                                                children: [
                                                  Text(DateFormat(
                                                          "'Data de Contratação: ' dd/MM/yyyy")
                                                      .format(historico.data))
                                                ],
                                              )
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
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        String retorno;
                                        return AlertDialog(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          title: const Text(
                                            'Selecione a opção de satisfação',
                                            style: TextStyle(fontSize: 15),
                                          ),
                                          content: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              RatingBar.builder(
                                                itemCount: 5,
                                                itemBuilder: (context, index) {
                                                  switch (index) {
                                                    case 0:
                                                      return const Icon(
                                                        Icons
                                                            .sentiment_very_dissatisfied,
                                                        color: Colors.red,
                                                      );
                                                    case 1:
                                                      return const Icon(
                                                        Icons
                                                            .sentiment_dissatisfied,
                                                        color: Colors.redAccent,
                                                      );
                                                    case 2:
                                                      return const Icon(
                                                        Icons.sentiment_neutral,
                                                        color: Colors.amber,
                                                      );
                                                    case 3:
                                                      return const Icon(
                                                        Icons
                                                            .sentiment_satisfied,
                                                        color:
                                                            Colors.lightGreen,
                                                      );
                                                    case 4:
                                                      return const Icon(
                                                        Icons
                                                            .sentiment_very_satisfied,
                                                        color: Colors.green,
                                                      );
                                                    default:
                                                      return const Icon(
                                                        Icons
                                                            .sentiment_very_satisfied,
                                                        color: Colors.green,
                                                      );
                                                  }
                                                },
                                                onRatingUpdate: (rating) {
                                                  valorAvaliacao =
                                                      rating.toInt();
                                                  print(rating);
                                                },
                                              ),
                                            ],
                                          ),
                                          actions: [
                                            TextButton(
                                              onPressed: () async {
                                                postAvaliacao(historico.id,
                                                    valorAvaliacao);
                                                Navigator.of(context).pop();
                                              },
                                              child: const Text('Avaliar'),
                                            ),
                                            TextButton(
                                              onPressed: () async {
                                                Navigator.of(context).pop();
                                              },
                                              child: const Text('Voltar'),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                  child: const Text('Avaliação')),
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

  Future<List<HistoricoContratado>> pegarHistorico(int id) async {
    var url = Uri.parse(
        'http://192.168.53.110/mao/index.php/historico/contratado/$id');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      List listaHistorico = json.decode(response.body);
      return listaHistorico
          .map((e) => HistoricoContratado.fromJson(e))
          .toList();
    } else {
      throw Exception('erro');
    }
  }

  Future<void> postAvaliacao(int cadastro_idcadastro, int avaliacao) async {
    final url = Uri.parse('http://192.168.53.110/mao/index.php/posServico');
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({
      'service_idservico': cadastro_idcadastro,
      'avaliacao': avaliacao,
    });

    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      print("Cadastrado com sucesso");
    } else {
      print("Cadastro mal sucedido");
    }
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
