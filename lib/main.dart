import 'package:cruzadista/ui/login.dart';
import 'package:cruzadista/ui/onboarding.dart';
import 'package:cruzadista/ui/splash.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "Cruzadista",
    initialRoute:'/ui/splash',
    routes: {
      '/ui/splash': (context) => Splash(),
      '/ui/onboarding': (context) => Onboarding(), // VAI NA LINHA 68
      '/ui/login': (context) => Login(),
      // '/ui/home': (context) => Home(), // AQUI EU USO NAVEGAÇAO DIFERENTES DAS ROTAS VAI NA LINHAS: 55, 161, 192 e 221
      // //EU SO ESTOU USANDO AS ROTAS ate a HOME
      // '/ui/view_pdf': (context) => ViewPdf(),
      // '/ui/menu': (context) => Menu(),

    },
  ));
}
