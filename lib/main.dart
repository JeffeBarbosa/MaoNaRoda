import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:MaoNaRoda/paginas/splash.dart';
import 'package:MaoNaRoda/rotas.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

void main() async {
  final FlutterI18nDelegate flutterDelegate = FlutterI18nDelegate(
      translationLoader: FileTranslationLoader(
          useCountryCode: false, fallbackFile: 'en', basePath: 'assets/i18n'));
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp(flutterDelegate));
}

class MyApp extends StatelessWidget {
  final FlutterI18nDelegate flutterDelegate;
  MyApp(this.flutterDelegate);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MaoNaRoda',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      builder: EasyLoading.init(),
      routes: routes,
      home: Splash(),
      localizationsDelegates: [
        flutterDelegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      supportedLocales: [
        const Locale('en'),
        const Locale('es'),
        const Locale('pt'),
      ],
    );
  }
}
