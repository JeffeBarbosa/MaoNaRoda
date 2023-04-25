import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:mao/pages/PagePrestador.dart';
import 'package:mao/pages/pagePrincipal.dart';
import 'package:mao/pages/pagePrincipalPrestador.dart';
import 'package:mao/pages/registerPage.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

void alertLogin(BuildContext context, String texto) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Erro ao logar"),
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

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController senhaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    int id;
    String nome;

    return Scaffold(
      body: ListView(children: <Widget>[
        _buildImageSoon(),
        _buildEmail(),
        _buildSenha(),
        _buildForgotPassaword(),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 30, 30, 30),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: const Color.fromARGB(255, 124, 61, 2),
                  side: const BorderSide(color: Colors.black, width: 1),
                  elevation: 5,
                  minimumSize: const Size(150, 50),
                  shadowColor: const Color.fromARGB(255, 4, 75, 68),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const RegisterPage()));
                },
                child: const Text('Registrar'),
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
                String email = emailController.text;
                String senha = senhaController.text;
                if (emailController.text.isNotEmpty &&
                    senhaController.text.isNotEmpty) {
                  final response = await http.get(Uri.parse(
                      'http://192.168.53.110/mao/index.php/login/$email/$senha'));
                  if (response.statusCode == 200) {
                    final jsonResponse = jsonDecode(response.body);
                    if (jsonResponse.isNotEmpty) {
                      id = jsonResponse[0]['idcadastro'];
                      nome = jsonResponse[0]['nome'];
                      if(jsonResponse[0]['tipo_cadastro'] == '1'){ 
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                               builder: (context) => PagePrincipal(id, nome)));
                      }else{
                        Navigator.push(context, MaterialPageRoute(builder: (context) => PagePrincipalPrestador(id, nome)));
                      }
                    } else {
                      alertLogin(context, "Email ou senha invalidos");
                    }
                  }
                } else {
                  alertLogin(context, 'Preencha os campos do login');
                }
              },
              child: const Text('Logar'),
            ),
          ],
        )
      ]),
    );
  }

  _buildEmail() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: TextField(
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
          prefixIcon: Icon(Icons.mail),
          labelText: 'Digite seu email',
        ),
        controller: emailController,
      ),
    );
  }

  _buildSenha() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: TextField(
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
          prefixIcon: Icon(Icons.lock),
          labelText: 'Digite seu Senha',
        ),
        controller: senhaController,
      ),
    );
  }

  _buildForgotPassaword() {
    return Container(
      padding: const EdgeInsets.fromLTRB(190, 0, 0, 0),
      child: TextButton(
        style: TextButton.styleFrom(
          foregroundColor: const Color.fromRGBO(109, 104, 104, 0.705),
        ),
        onPressed: () {},
        child: const Text("Esqueci minha senha"),
      ),
    );
  }

  _buildImageSoon() {
    return SizedBox(
      height: 370,
      width: 370,
      child: Image.asset(
        'imagens/logo.png',
      ),
    );
  }
}
