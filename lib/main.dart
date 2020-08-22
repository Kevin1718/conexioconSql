import 'package:flutter/material.dart';
import 'home.dart';

void main() => runApp(MaterialApp(
  home:new MyApp(),
  theme: ThemeData(brightness: Brightness.dark, fontFamily: 'Carter'),
));

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      theme: ThemeData(brightness: Brightness.dark, fontFamily: 'Carter'),
      title: 'Flutter Demo',
      home: homepage(),
    );
  }
}