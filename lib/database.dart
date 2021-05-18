import 'package:sqflite/sqflite.dart';
import 'dart:async';


class Cliente{
  final int id;
  final String nrocomprobante;
  final String codtalonario;
  final String cliente;
  final int codigo;
  final double importe;
  final String direccion;
  final String telefono;
  final double montorendido;
  final String detalle;
  final String periodos;
  final String montocliente;
  final String cobrador;
  final String codconfiguracion;
  final String fechapago;
  final String fechasincroniza;

  Cliente(this.id,this.nrocomprobante,this.codtalonario,this.cliente,this.codigo,this.importe,this.direccion,this.telefono,this.montorendido,this.detalle,this.periodos,this.montocliente,this.cobrador,this.codconfiguracion,this.fechapago,this.fechasincroniza);

  Map<String, dynamic> toMap(){
    return {
      "id": id,
      "nrocomprobante": nrocomprobante,
      "codtalonario": codtalonario,
      "cliente": cliente,
      "codigo": codigo,
      "importe": importe,
      "direccion": direccion,
      "telefono": telefono,
      "montorendido": montorendido,
      "detalle": detalle,
      "periodos": periodos,
      "montocliente": montocliente,
      "cobrador": cobrador,
      "codconfiguracion": codconfiguracion,
      "fechapago": fechapago,
      "fechasincroniza": fechasincroniza,
    };
  }

}

class BasedeDatos{
  Database _db;


  initDB() async{
    _db = await openDatabase(
      'my_db.db',
      version: 1,
      onCreate:(Database db, int version){
        db.execute("CREATE TABLE Client (id integer primary key, nrocomprobante TEXT,codtalonario TEXT,cliente TEXT, codigo INTEGER,importe REAL,direccion TEXT,telefono TEXT,montorendido REAL,detalle TEXT, periodos TEXT,montocliente TEXT,cobrador TEXT,codconfiguracion TEXT, fechapago TEXT,fechasincroniza TEXT);");
      }
    );
  }

  insert(Cliente cliente) async{

    _db.rawInsert("");

  }
}