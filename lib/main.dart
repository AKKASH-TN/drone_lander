import 'package:drone_lander/presentation/pages/homepage.dart';

import 'package:flutter/material.dart';



void main() {
  
  runApp(MyApp());
}



class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'dronelander',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'GeistMono',
        useMaterial3: true,
        
      ),
      home: const Homepage(),
    );
  }
}