import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:offsetfarm_assignment/Screens/entry.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: EntryScreen(),
    );
  }
}
