import 'dart:async';

import 'package:qrreaderapp/src/bloc/validator.dart';
import 'package:qrreaderapp/src/providers/db_provider.dart';

class ScanBloc with Validators {
    static final ScanBloc _singleton = new ScanBloc._internal();
    factory ScanBloc(){
      return _singleton;
    }

    ScanBloc._internal(){
      // Obtener Scans de la base de Datos
      obtenerScans();
    }

    final _scansController = StreamController<List<ScanModel>>.broadcast();
    Stream<List<ScanModel>> get scansStream => _scansController.stream.transform(validarGeo);
    Stream<List<ScanModel>> get scansStreamHttp => _scansController.stream.transform(validarHttp);

    obtenerScans() async {
      _scansController.sink.add( await  DBProvider.db.getTodosScans());
    }

    agragerScan(ScanModel scan) async{
      await  DBProvider.db.nuevoScan(scan);
      obtenerScans();
    }

    borrarScan(int id) async {
      await  DBProvider.db.deleteScan(id);
      obtenerScans();
    }

    borrarScanTodos() async{
      await DBProvider.db.deleteAll();
      obtenerScans();
    }

    dispose(){
      _scansController?.close();
    }
}