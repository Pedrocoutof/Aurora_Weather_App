import 'package:aurora/home/home_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aurora',
      debugShowCheckedModeBanner: false,

      themeMode: ThemeMode.system,

      darkTheme: ThemeData(

      ),

      theme: ThemeData(
        
      ),
      home: const HomePage(),
    );
  }
}