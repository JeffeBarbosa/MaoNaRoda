import 'package:MaoNaRoda/helpers/helper.dart';
import 'package:MaoNaRoda/paginas/paginaPrincipal.dart';
import 'package:flutter/material.dart';
import 'package:MaoNaRoda/paginas/registro.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Login();
  }
}

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextStyle style = const TextStyle(fontSize: 20);
  String? _email = "";
  String? _senha = "";
  var userHelper = UserHelper();

  final frmLoginKey = new GlobalKey<FormState>();

  void _validarLogin() async {
    await userHelper.open();
    final form = frmLoginKey.currentState;

    if (form!.validate()) {
      form.save();

      var u = await userHelper.validateLogin(_email!, _senha!);

      if (u != null) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => principal(user: u)));
      } else {
        showDialog(
            context: context,
            builder: (context) {
              return const AlertDialog(
                  title: Text("Erro Login"),
                  content: Text("Usuário e/ou senha inválidos!"),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15))));
            });
      }
    }
  }

  openRegister() {
    showDialog(context: context, builder: (context) => RegisterPage());
  }

  @override
  Widget build(BuildContext context) {
    final emailField = TextFormField(
      style: style,
      onSaved: (value) => _email = value,
      validator: (value) {
        return value!.length < 15
            ? "E-mail deve ter no mínimo 20 caracteres!"
            : null;
      },
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "E-mail",
          labelText: "E-mail",
          suffixIcon: Icon(
            Icons.login,
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(32))),
    );

    final passwordField = TextFormField(
      obscureText: true,
      style: style,
      onSaved: (value) => _senha = value,
      validator: (value) {
        return value!.length < 6 ? "Senha inválida!" : null;
      },
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Senha",
          labelText: "Senha",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(32)),
          suffixIcon: Icon(
            Icons.password,
          )),
    );

    return Scaffold(
        body: SingleChildScrollView(
            child: Center(
                child: Container(
                    height: MediaQuery.of(context).size.height,
                    color: Color.fromARGB(255, 175, 255, 45),
                    child: Padding(
                        padding: const EdgeInsets.all(36),
                        child: Form(
                            key: frmLoginKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                SizedBox(
                                    height: 280,
                                    child:
                                        Image.asset('assets/imagens/Logo.png')),
                                const SizedBox(
                                  height: 45,
                                ),
                                emailField,
                                const SizedBox(
                                  height: 25,
                                ),
                                passwordField,
                                const SizedBox(
                                  height: 35,
                                ),
                                ElevatedButton(
                                  onPressed: _validarLogin,
                                  child: Text("Login", style: style),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                TextButton(
                                    onPressed: openRegister,
                                    child: const Text("Registrar",
                                        style: TextStyle(
                                            fontSize: 25,
                                            color: Color.fromARGB(
                                                255, 190, 29, 0))))
                              ],
                            )))))));
  }
}
