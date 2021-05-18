import 'dart:async';
import 'dart:convert';

import 'package:bluetooth_print/bluetooth_print.dart';
import 'package:bluetooth_print/bluetooth_print_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';


class Impresora extends StatefulWidget {
  @override
  _ImpresoraState createState() => _ImpresoraState();
}

class _ImpresoraState extends State<Impresora> {
  
  String Fecha = "05/07/09";
  String Cobrador="AGUERO RICARDO RAMON";
  String Comprobante="C-0001-00273258";
  String Cliente="BAEZ LUCIA";
  String Valor1="1.380";
  String Valor2="1.380";
  String CuotaMensualDesde="5/2020";
  String CuotaMensualHasta="5/2020";
  BluetoothPrint bluetoothPrint = BluetoothPrint.instance;

  bool _connected = false;
  BluetoothDevice _device;
  String tips = 'Dispositivo No Conectado';

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) => initBluetooth());
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initBluetooth() async {
    bluetoothPrint.startScan(timeout: Duration(seconds: 4));
  
    bool isConnected=await bluetoothPrint.isConnected;

    bluetoothPrint.state.listen((state) {
      print('Estado del Dispositivo: $state');

      switch (state) {
        case BluetoothPrint.CONNECTED:
          setState(() {
            _connected = true;
            final snackBar = SnackBar(content: Text('Conexión con éxito'));
            Scaffold.of(context).showSnackBar(snackBar);
            tips = 'Conexión con éxito';
          });
          break;
        case BluetoothPrint.DISCONNECTED:
          setState(() {
            _connected = false;
            final snackBar = SnackBar(content: Text('Se desconectó'));
            Scaffold.of(context).showSnackBar(snackBar);
            tips = 'Se desconectó';
          });
          break;
        default:
          break;
      }
    });

    if (!mounted) return;

    if(isConnected) {
      setState(() {
        _connected=true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: RefreshIndicator(
          onRefresh: () =>
              bluetoothPrint.startScan(timeout: Duration(seconds: 4)),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      child: Text(tips),
                    ),
                  ],
                ),
                Divider(),
                StreamBuilder<List<BluetoothDevice>>(
                  stream: bluetoothPrint.scanResults,
                  initialData: [],
                  builder: (c, snapshot) => Column(
                    children: snapshot.data.map((d) => ListTile(
                      title: Text(d.name??''),
                      subtitle: Text(d.address),
                      onTap: () async {
                        setState(() {
                          _device = d;
                        });
                      },
                      trailing: _device!=null && _device.address == d.address?Icon(
                        Icons.check,
                        color: Colors.green,
                      ):null,
                    )).toList(),
                  ),
                ),
                Divider(),
                Container(
                  padding: EdgeInsets.fromLTRB(20, 5, 20, 10),
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          OutlineButton(
                            child: Text('Conectar'),
                            onPressed:  _connected?null:() async {
                              if(_device!=null && _device.address !=null){
                                await bluetoothPrint.connect(_device);
                              }else{
                                setState(() {
                                  tips = 'Por favor Seleccione un dispositivo';
                                });
                                print('Por favor Seleccione un dispositivo');
                              }
                            },
                          ),
                          SizedBox(width: 10.0),
                          OutlineButton(
                            child: Text('Desconectar'),
                            onPressed:  _connected?() async {
                              await bluetoothPrint.disconnect();
                            }:null,
                          ),
                        ],
                      ),
                      OutlineButton(
                        child: Text('Imprimir'),
                        onPressed:  _connected?() async {
                          Map<String, dynamic> config = Map();
                          List<LineText> list = List();
                          Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
                          list.add(LineText(type: LineText.TYPE_TEXT, content: '---------------------------', weight: 1, align: LineText.ALIGN_CENTER,linefeed: 1));
                          list.add(LineText(type: LineText.TYPE_TEXT, content: 'SERVICIOS SOCIALES SAN JUAN', weight: 1, align: LineText.ALIGN_LEFT,linefeed: 1));
                          list.add(LineText(type: LineText.TYPE_TEXT, content: '------RECIBO DE COBRO------', weight: 1, align: LineText.ALIGN_CENTER,linefeed: 1));
                          list.add(LineText(type: LineText.TYPE_TEXT, content: 'Fecha:'+ Fecha , weight: 0, align: LineText.ALIGN_LEFT,linefeed: 1));
                          list.add(LineText(type: LineText.TYPE_TEXT, content: 'Cobrador:'+ Cobrador, weight: 0, align: LineText.ALIGN_LEFT,linefeed: 1));
                          list.add(LineText(type: LineText.TYPE_TEXT, content: 'ORIGINAL', weight: 0, align: LineText.ALIGN_LEFT,linefeed: 1));
                          list.add(LineText(type: LineText.TYPE_TEXT, content: 'NRO COMPROBANTE:'+ Comprobante, weight: 0, align: LineText.ALIGN_LEFT,linefeed: 1));
                          list.add(LineText(type: LineText.TYPE_TEXT, content: 'NRO PROPUESTA: 0', weight: 0, align: LineText.ALIGN_LEFT,linefeed: 1));
                          list.add(LineText(type: LineText.TYPE_TEXT, content: 'Cliente:'+ Cliente, weight: 0, align: LineText.ALIGN_LEFT,linefeed: 1));
                          list.add(LineText(type: LineText.TYPE_TEXT, content: 'Valor a pagar:'+ Valor1, weight: 0, align: LineText.ALIGN_LEFT,linefeed: 1));
                          list.add(LineText(type: LineText.TYPE_TEXT, content: 'Valor pagado:'+ Valor2, weight: 0, align: LineText.ALIGN_LEFT,linefeed: 1));
                          list.add(LineText(type: LineText.TYPE_TEXT, content: '', weight: 0, align: LineText.ALIGN_LEFT,linefeed: 1));
                          list.add(LineText(type: LineText.TYPE_TEXT, content: 'Serv. Sepelio Cuota Mensual', weight: 0, align: LineText.ALIGN_LEFT,linefeed: 1));
                          list.add(LineText(type: LineText.TYPE_TEXT, content: '-'+CuotaMensualDesde+'-'+CuotaMensualHasta, weight: 0, align: LineText.ALIGN_LEFT,linefeed: 1));
                          list.add(LineText(type: LineText.TYPE_TEXT, content: "Posición: Latitud"+ position.latitude.toString() +"Longitud"+ position.longitude.toString(), weight: 1, align: LineText.ALIGN_CENTER,linefeed: 1));
                         
                          list.add(LineText(type: LineText.TYPE_TEXT, content: '---------------------------', weight: 1, align: LineText.ALIGN_CENTER,linefeed: 1));
                          await bluetoothPrint.printReceipt(config, list);
                          final snackBar = SnackBar(content: Text('Imprimiendo Prueba...'));
                          Scaffold.of(context).showSnackBar(snackBar);
                        }:null,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        floatingActionButton: StreamBuilder<bool>(
          stream: bluetoothPrint.isScanning,
          initialData: false,
          builder: (c, snapshot) {
            if (snapshot.data) {
              return FloatingActionButton(
                child: Icon(Icons.stop),
                onPressed: () => bluetoothPrint.stopScan(),
                backgroundColor: Colors.red,
              );
            } else {
              return FloatingActionButton(
                  child: Icon(Icons.search),
                  onPressed: () => bluetoothPrint.startScan(timeout: Duration(seconds: 4)));
            }
          },
        ),
      ),
    );
  }
}