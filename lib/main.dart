import 'package:flutter/material.dart';
import 'Home.dart';
void main()
{
  runApp(App());
}

class App extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Cobranza',
      home: Home(),
    );
  }


}