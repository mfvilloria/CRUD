import 'package:crud/pag/guard.dart';
import 'package:crud/pag/list.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: ListP.ROUTE,
      routes: {
        ListP.ROUTE : (_) => ListP(),
        SavePage.ROUTE : (_) => SavePage()
      },
    );
  }
}

