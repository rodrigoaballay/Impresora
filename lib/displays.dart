import 'package:flutter/material.dart';

class DisplaysWidgets extends StatelessWidget{
  final Color color;
  DisplaysWidgets(this.color);

  @override
  Widget build(BuildContext context) {

    return Container(
      color: color,
    );

  }

}