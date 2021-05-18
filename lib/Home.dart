import 'package:cobranza/Impresora.dart';
import 'package:flutter/material.dart';
import 'displays.dart';
import 'Tabla.dart';

const color = const Color(0xffb74093);
const color2 = const Color(0xFF80025D);
class Home extends StatefulWidget{
  @override
  State<StatefulWidget> createState()=> _HomeState();
}

class _HomeState extends State<Home>{

  int _currentIndex=1;

  final List<Widget> _children = [
    DisplaysWidgets(Colors.white), //LLAMADO A LA CLASE QUE CONTIENE LA NUEVA PANTALLA
    Impresora(),
    DisplaysWidgets(Colors.white),
    DisplaysWidgets(Colors.white),
  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Cobranza'),
        backgroundColor: color2,
      ),
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: onTapTapped,

        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Clientes'),
            backgroundColor: color,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.error),
            title: Text('Incidencias'),
            backgroundColor: color,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.monetization_on),
            title: Text('Recaudación'),
            backgroundColor: color,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            title: Text('Configuración'),
            backgroundColor: color,
          ),
           BottomNavigationBarItem(
            icon: Icon(Icons.backup),
            title: Text('Base de DatosTEST'),
            backgroundColor: color,
          ),
        ],
      ),
    );
  }
 void onTapTapped(int index){

    setState(() {
      _currentIndex = index;
    });

 }
}