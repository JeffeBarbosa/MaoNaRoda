import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:http/http.dart' as http;
import 'package:mao/pages/loginPage.dart';

enum Profissoes {
  EngenheiroAgronomo,
  Agrimensor,
  TecnicoAgricola,
  Veterinario,
  Zootecnista,
  Gestaoambiental,
  EngenheiroHidrico,
  ServicodeDrones
}

class PagePrestador extends StatefulWidget {
  const PagePrestador({super.key});

  @override
  State<PagePrestador> createState() => _PagePrestadorState();
}

Future<void> postData(int idcadastro, String descProfissao,
    String formProfissao, int idprofissao) async {
  final url =
      Uri.parse('http://192.168.53.110/mao/index.php/registro/profissional');
  final headers = {'Content-Type': 'application/json'};
  final body = jsonEncode({
    'desc_profissao': descProfissao,
    'form_profissao': formProfissao,
    'id_cadastro': idcadastro,
    'id_profissao': idprofissao,
  });

  final response = await http.post(url, headers: headers, body: body);

  if (response.statusCode == 200) {
    print("Cadastrado com sucesso");
  } else {
    print("Cadastro mal sucedido");
  }
}

class _PagePrestadorState extends State<PagePrestador> {
  late int idlast;
  Profissoes profissoes = Profissoes.EngenheiroAgronomo;
  int idprofissao = 1;
  TextEditingController descProfissao = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(children: <Widget>[
      Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8, 20, 8, 0),
          child: TextField(
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              labelText: 'Informe suas formações profissionais',
            ),
            maxLines: 10,
            controller: descProfissao,
          ),
        ),
      ),
      Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 30, 0, 30),
            child: const Center(
                child:
                    Text("Escolha a profissão desejada a prestar o serviço")),
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: const Text('Engenheiro Agrônomo'),
              ),
              Radio(
                value: Profissoes.EngenheiroAgronomo,
                groupValue: profissoes,
                onChanged: (profissaoselecioada) {
                  setState(() {
                    profissoes = profissaoselecioada!;
                    idprofissao = 1;
                  });
                },
              ),
              Radio(
                value: Profissoes.Agrimensor,
                groupValue: profissoes,
                onChanged: (profissaoselecioada) {
                  setState(() {
                    profissoes = profissaoselecioada!;
                    idprofissao = 2;
                  });
                },
              ),
              const Text('Agrimensor'),
            ],
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: const Text('Engenheiro Hídrico'),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                child: Radio(
                  value: Profissoes.EngenheiroHidrico,
                  groupValue: profissoes,
                  onChanged: (profissaoselecioada) {
                    setState(() {
                      profissoes = profissaoselecioada!;
                      idprofissao = 3;
                    });
                  },
                ),
              ),
              Radio(
                value: Profissoes.Gestaoambiental,
                groupValue: profissoes,
                onChanged: (profissaoselecioada) {
                  setState(() {
                    profissoes = profissaoselecioada!;
                    idprofissao = 4;
                  });
                },
              ),
              const Text('Gestão Ambiental'),
            ],
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: const Text('Serviços de Drone'),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(25, 0, 0, 0),
                child: Radio(
                  value: Profissoes.ServicodeDrones,
                  groupValue: profissoes,
                  onChanged: (profissaoselecioada) {
                    setState(() {
                      profissoes = profissaoselecioada!;
                      idprofissao = 5;
                    });
                  },
                ),
              ),
              Radio(
                value: Profissoes.TecnicoAgricola,
                groupValue: profissoes,
                onChanged: (profissaoselecioada) {
                  setState(() {
                    profissoes = profissaoselecioada!;
                    idprofissao = 6;
                  });
                },
              ),
              const Text('Técnico Agrícola'),
            ],
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: const Text('Veterinário'),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(69, 0, 0, 0),
                child: Radio(
                  value: Profissoes.Veterinario,
                  groupValue: profissoes,
                  onChanged: (profissaoselecioada) {
                    setState(() {
                      profissoes = profissaoselecioada!;
                      idprofissao = 7;
                    });
                  },
                ),
              ),
              Radio(
                value: Profissoes.Zootecnista,
                groupValue: profissoes,
                onChanged: (profissaoselecioada) {
                  setState(() {
                    profissoes = profissaoselecioada!;
                    idprofissao = 8;
                  });
                },
              ),
              const Text('Zootecnista'),
            ],
          ),
        ],
      ),
      Padding(
        padding: const EdgeInsets.fromLTRB(12, 20, 12, 12),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: const Color.fromARGB(185, 136, 62, 1),
            side: const BorderSide(color: Colors.black, width: 1),
            elevation: 5,
            minimumSize: const Size(150, 50),
            shadowColor: Colors.teal,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          ),
          onPressed: () async {
            final response = await http.get(Uri.parse(
                'http://192.168.53.110/mao/index.php/registro/ultimo'));
            if (response.statusCode == 200) {
              final jsonResponse = jsonDecode(response.body);
              idlast = jsonResponse[0]['idcadastro'];
            }
            String formProfissao = descProfissao.text;
            if (descProfissao.text.isNotEmpty) {
              postData(
                  idlast, profissoes.toString(), formProfissao, idprofissao);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
              );
            } else {
              alertRegister(context,
                  "Preencha todos os campos obrigatorios para o registro");
            }
          },
          child: const Text('Registrar'),
        ),
      ),
    ]));
  }

  void alertRegister(BuildContext context, String texto) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Erro ao Registrar"),
          content: Text(texto),
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
  }
}
