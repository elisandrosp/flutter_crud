import 'dart:io';
import 'package:flutter/material.dart';
import 'screens/add.dart';
import 'screens/list.dart';

void main() {
  HttpOverrides.global = MyHttpOverrides();

  runApp(MaterialApp(
    initialRoute: '/list',
    routes: {
      '/add': (context) => const Add(),
      '/list': (context) => ClienteListView(),
    },
  ));
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
