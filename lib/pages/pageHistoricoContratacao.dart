import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:mao/models/historicoContratado.dart';
import 'package:mao/pages/pagePrincipal.dart';
import 'package:http/http.dart' as http;

class PageHistoricoContratacao extends StatefulWidget {
  int id;
  String nome;
  PageHistoricoContratacao(this.id, this.nome);

  @override
  State<PageHistoricoContratacao> createState() => _PageHistoricoContratacaoState();
}

class _PageHistoricoContratacaoState extends State<PageHistoricoContratacao> {
  late Future<List<HistoricoContratado>> historicoContratado;

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
      drawer: Drawer(
        backgroundColor: Color.fromRGBO(185, 136, 62, 1),
        child: Column(children: [
          ListTile(
            title: Center(
              child: Text(
                'Bem vindo ',
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),ListTile( title: Center(
            child: Text(widget.nome,
                style: TextStyle(
                    fontSize: 15, color: Color.fromARGB(255, 66, 33, 23))),
          ),),
            ListTile(title: Text('Pagina de Contratação'), onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => PagePrincipal(widget.id, widget.nome))) ,),
            ListTile(title: Text('Historico de Contratação'), onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => PageHistoricoContratacao(widget.id, widget.nome))) ,)
        ]
        )),
        body: Column(children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: const Text(
            'Escolha o profissional desejado',
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
                        subtitle: Text(historico.data.toString()),
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
                                          backgroundColor: Colors.yellow,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          title: Text(''),
                                          content: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Row(
                                                children: [
                                                  Text('Telefone:'),
                                                ],
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
                                  onPressed: () async {},
                                  
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


  Future<List<HistoricoContratado>> pegarHistorico(int id) async{
    var url = Uri.parse('http://192.168.53.110/mao/index.php/historico/contratado/$id');
      var response = await http.get(url);
      if(response.statusCode == 200){
        List listaHistorico = json.decode(response.body);
        return listaHistorico.map((e) => HistoricoContratado.fromJson(e)).toList();
      }else{
        throw Exception('erro');
      }
  }
}