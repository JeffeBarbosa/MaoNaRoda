import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:mao/pages/PagePrestador.dart';
import 'package:mao/pages/loginPage.dart';
import 'package:http/http.dart' as http;

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

Future<void> postData(int tipocadastro, String email, String endereco,
    String senha, String nome, int idade, int telefone) async {
  final url = Uri.parse('http://192.168.53.110/mao/index.php/registro');
  final headers = {'Content-Type': 'application/json'};
  final body = jsonEncode({
    'tipo_cadastro': tipocadastro,
    'email': email,
    'endereco': endereco,
    'senha': senha,
    'nome': nome,
    'idade': idade,
    'telefone': telefone
  });

  final response = await http.post(url, headers: headers, body: body);

  if (response.statusCode == 200) {
    print("Cadastrado com sucesso");
  } else {
    print("Cadastro mal sucedido");
  }
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

class _RegisterPageState extends State<RegisterPage> {
  bool value = false;
  String $buttonName = "Cadastrar-se";
  int $tipo_cadastro = 1;

  TextEditingController nameController = TextEditingController();
  TextEditingController enderecoController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController idadeController = TextEditingController();
  TextEditingController telefoneController = TextEditingController();

  void nameButtonRegister(bool? $value) {
    if (value == true) {
      $tipo_cadastro = 2;
      $buttonName = "Va para segunda etapa";
    } else {
      $tipo_cadastro = 1;
      $buttonName = "Cadastrar-se";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(children: <Widget>[
        SizedBox(
          height: 220,
          width: 220,
          child: Image.asset(
            'imagens/logo.png',
          ),
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                labelText: 'Insira seu Nome',
              ),
              controller: nameController,
            ),
          ),
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                labelText: 'Insira seu Endereço',
              ),
              controller: enderecoController,
            ),
          ),
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                labelText: 'Insira seu Email',
              ),
              controller: emailController,
            ),
          ),
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                labelText: 'Insira sua Senha',
              ),
              controller: passwordController,
            ),
          ),
        ),Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: 150,
                  child: TextFormField(
                    keyboardType:  TextInputType.number,
                    decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                    labelText: 'Insira sua idade'), controller: idadeController, 
                  ),
                  
              ),
            ),
            Container(
              width: 220,
              child: TextFormField(
                keyboardType:  TextInputType.number,
                decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                labelText: 'Insira seu Telefone'), controller: telefoneController, 
            )),
          ],
        ),
  

        Center(
          child: Padding(
            padding: EdgeInsets.fromLTRB(50, 0, 0, 0),
            child: Row(
              children: [
                Checkbox(
                    value: this.value,
                    onChanged: (bool? value) {
                      setState(() {
                        this.value = value!;
                      });
                      nameButtonRegister(value);
                    }),
                const Text('Clique se for prestador de serviços',
                    style: TextStyle(
                        fontSize: 17.0,
                        color: Color.fromRGBO(255, 124, 61, 2))),
              ],
            ),
          ),
        ),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 30, 30, 30),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: const Color.fromARGB(185, 136, 62, 1),
                  side: const BorderSide(color: Colors.black, width: 1),
                  elevation: 5,
                  minimumSize: const Size(150, 50),
                  shadowColor: Colors.teal,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                  );
                },
                child: const Text('Voltar'),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: const Color.fromARGB(185, 136, 62, 1),
                side: const BorderSide(color: Colors.black, width: 1),
                elevation: 5,
                minimumSize: const Size(150, 50),
                shadowColor: Colors.teal,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
              ),
              onPressed: () async {
                int tipoCadastro = $tipo_cadastro;
                int idade = int.parse(idadeController.text);
                int telefone = int.parse(telefoneController.text);

                
                if (emailController.text.isNotEmpty &&
                    enderecoController.text.isNotEmpty &&
                    passwordController.text.isNotEmpty &&
                    nameController.text.isNotEmpty
                    && idadeController.text.isNotEmpty && telefoneController.text.isNotEmpty) {
                  postData(tipoCadastro, emailController.text, enderecoController.text, passwordController.text, nameController.text, idade, telefone);
                  if (value == true) {
                    showDialog(
                        context: context,
                        builder: (context) => const PagePrestador());
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginPage()),
                    );
                  }
                } else {
                  alertRegister(context,
                      "Preencha todos os campos obrigatorios para o registro");
                }
              },
              child: Text($buttonName),
            ),
          ],
        ),
      ]),
    );
  }
}
