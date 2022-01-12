import 'package:flutter/material.dart';
import 'package:rest_api/screens/home_screen.dart';
import 'package:rest_api/services/post_services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.orange,
          primaryColor: Colors.orange[100],
          appBarTheme: const AppBarTheme(
            elevation: 0.0,
          )),
      home: const HomeScreen(),
    );
  }
}
