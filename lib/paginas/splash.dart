import 'dart:async';
import 'package:MaoNaRoda/paginas/login.dart';
import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();

    Timer(Duration(seconds: 8), () {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Login(),
          ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(color: Color.fromARGB(255, 175, 255, 45)),
          Container(
            width: 400,
            height: 550,
            child: Image.asset('assets/imagens/Logo.png'),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Text(
                  'Aguarde um pouco, isso pode demorar...',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 70.0,
                ),
                CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Colors.red),
                  strokeWidth: 10.0,
                ),
                SizedBox(
                  height: 50.0,
                ),
                Text('Desenvolvido por Jefferson e Eduardo',
                    style:
                        TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
