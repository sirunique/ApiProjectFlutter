import 'package:flutter/material.dart';
import 'package:new_project/login.dart';
// import 'package:new_project/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget{
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp>{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Login(),
      )
    );
  }
}
