import 'package:expense_app/homepage.dart';
import 'package:flutter/material.dart';
//import 'package:flutter/services.dart';

void main() {
 // SystemChrome.setPreferredOrientations(
   // [DeviceOrientation.portraitUp,
    // DeviceOrientation.portraitUp],
  //);
  runApp(MaterialApp(
    theme: ThemeData(
      primarySwatch: Colors.purple,
      appBarTheme: const AppBarTheme(
        color: Colors.purple,
      ),
      useMaterial3: true,
    ),
    debugShowCheckedModeBanner: false,
    home: const HomePage(),
  ));
}
