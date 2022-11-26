import 'package:flutter/material.dart';
import 'package:MaoNaRoda/helpers/user.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

class principal extends StatefulWidget {
  final User? user;
  principal({Key? key, this.user}) : super(key: key);

  @override
  State<principal> createState() => _principalState();
}

class _principalState extends State<principal> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 175, 255, 45),
      body: Stack(
        children: [
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height / 4,
                ),
                Container(
                  alignment: Alignment.center,
                  height: MediaQuery.of(context).size.height / 1.5,
                  width: MediaQuery.of(context).size.height / 2.3,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 255, 255, 255),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 150),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(20),
                            child: Text(
                              "Mão na Roda",
                              style: TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Container(
                              width: MediaQuery.of(context).size.width / 2,
                              child: Text(
                                FlutterI18n.translate(
                                    context, "text_explication"),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 17,
                                ),
                              ),
                            ),
                          ),
                          Container(height: 70),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Container(
                              width: MediaQuery.of(context).size.width / 1.5,
                              child: Text(
                                FlutterI18n.translate(
                                    context, "futter_principal"),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 30,
                                    color: Color.fromARGB(255, 89, 143, 2)),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height / 7,
                ),
                Container(
                  alignment: Alignment.center,
                  height: MediaQuery.of(context).size.height / 4,
                  width: MediaQuery.of(context).size.height / 4,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 224, 201, 193),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 25.0,
                        spreadRadius: 2,
                      )
                    ],
                  ),
                  child: Image.asset('assets/imagens/Logo.png'),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
