import 'package:flutter/material.dart';
import 'package:recipes_app/screens/home.dart';
import 'package:recipes_app/screens/recipe.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recipes App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.grey),
      ),
      home: const MyHomePage(title: 'Recipes - 221551'),
      initialRoute: "/",
    );
  }
}