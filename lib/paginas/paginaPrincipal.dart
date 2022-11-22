import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:MaoNaRoda/helpers/user.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:MaoNaRoda/helpers/helper.dart';

class principal extends StatefulWidget {
  final User? user;
  principal({Key? key, this.user}) : super(key: key);

  @override
  State<principal> createState() => _principalState();
}

class _principalState extends State<principal> {
  var userHelper = UserHelper();

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () async {
      await userHelper.open();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      body: Column(children: [
        SizedBox(height: 20),
        Container(
          child: Container(
              height: 250,
              width: 250,
              decoration: BoxDecoration(
                  color: Colors.yellow, borderRadius: BorderRadius.circular(100)
                  //more than 50% of width makes circle
                  )),
        ),
      ]),
      drawer: Drawer(
        // adicionar um widget ListView(lista de itens(ListTile))
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
                accountName: Text(widget.user!.name),
                accountEmail: Text(widget.user!.email)),
            ListTile(
              title: Text('Backup'),
              leading: Icon(Icons.settings),
              trailing: Icon(Icons.arrow_forward),
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                          title: Text("Backup"),
                          content: Row(children: [
                            Icon(Icons.backup_outlined),
                            Text(
                                "Deseja realizar o backup dos \ndados no servidor?")
                          ]),
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25))));
                    });
              },
            ),
            ListTile(
              title: Text('Sair'),
              leading: Icon(SimpleLineIcons.close),
              onTap: () {
                if (Platform.isAndroid) {
                  SystemNavigator.pop();
                } else if (Platform.isIOS) {
                  exit(0);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
