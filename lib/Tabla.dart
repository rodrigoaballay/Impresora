import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:bluetooth_print/bluetooth_print.dart';
import 'package:bluetooth_print/bluetooth_print_model.dart';
import 'package:flutter/services.dart';
class Tabla extends StatefulWidget{

  @override
  _TablaState createState() => _TablaState();
}

class _TablaState extends State<Tabla> {
  BluetoothPrint bluetoothPrint = BluetoothPrint.instance;

  @override
  Widget build(BuildContext context) {

    String isConnected= bluetoothPrint.isConnected.toString();

    return Center(

      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            TextFormField(
              decoration: const InputDecoration(
                hintText: 'Ingrese Fecha',
              ),
            ),

            RaisedButton(
              onPressed: () {
                final snackBar = SnackBar(content: Text('No está funcionando'));
                Scaffold.of(context).showSnackBar(snackBar);
              },
              child: const Text('Imprimir'),
            ),

            Text("MENSAJE: "+isConnected,
                style: TextStyle(
                  fontSize: 25
                ),

            ),
          ]),
    );
  }
}