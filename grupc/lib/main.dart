import 'dart:io';

import 'package:flutter/material.dart';
import 'package:grupc/pages/home_page.dart';
import 'package:grupc/pages/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyHttpoverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  Widget paginaIncial = 
  prefs.getString('funcionarioLogado') == null? LoginPage() : MenuPage();

  HttpOverrides.global = new MyHttpoverrides();

  runApp(MyApp(paginaIncial));
}


class MyApp extends StatelessWidget {
  Widget paginaIncial;

  MyApp(this.paginaIncial, {super.key});

  

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const LoginPage(),
    );
  }
}

