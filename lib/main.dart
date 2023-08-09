
import 'package:Expense_management/splashscreen.dart';
import 'package:flutter/material.dart';

import 'login page.dart';
var ip_address = "192.168.29.64";
var get_username;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      home: Splashscreen(),
      routes: {
        '/log':(context)=>loginpage(),
      },
    );
  }
}
