import 'package:flutter/material.dart';
import 'gas_home_page.dart';

void main() {
  runApp(GasAlarmApp());
}

class GasAlarmApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Allarme Gas Beppe',
      theme: ThemeData(primarySwatch: Colors.green),
      home: GasHomePage(),
    );
  }
}