import 'package:flutter/material.dart';
import '../screens/home_screen.dart';  

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false, // This line removes the debug banner
      home: HomeScreen(),
    );
  }
}
