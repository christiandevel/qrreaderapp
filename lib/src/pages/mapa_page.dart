import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:qrreaderapp/src/models/scan_model.dart';


class MapaPages extends StatefulWidget {

  @override
  _MapaPagesState createState() => _MapaPagesState();
}

class _MapaPagesState extends State<MapaPages> {
  final  map = new MapController();

  String estiloMapa = 'dark';

  @override
  Widget build(BuildContext context) {
    final ScanModel scan = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text('Cordenas QR'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.my_location),
            onPressed: () {
              map.move(scan.getLatLng(), 15);
            },
          )
        ],
      ),
      body: _crearFlutterMap(scan),
      floatingActionButton: _crearBotonFlotante(context),
    );
  }

  Widget _crearFlutterMap(ScanModel scan) {
    return FlutterMap(
      mapController: map,
      options: MapOptions(
        center: scan.getLatLng(),
        zoom: 15
      ),
      layers: [
        _crearMapa(),
        _creararcodores(scan),
      ],
    );
  }

  _crearMapa() {
    return TileLayerOptions(
      urlTemplate: 'https://api.mapbox.com/v4/'
      '{id}/{z}/{x}/{y}@2x.png?access_token={accessToken}',
      additionalOptions: {
        'accessToken' : 'pk.eyJ1IjoiY2hyaXN0aWFuY29kZSIsImEiOiJjazlyb3JvY3gwd3RrM2VwamNrMjVmMHYxIn0.oUqiX5SWaz5pQ9DZo72QOQ',
        'id' : 'mapbox.$estiloMapa'
      }
    );
  }

  _creararcodores(ScanModel scan) {
    return MarkerLayerOptions(
      markers: <Marker>[
        Marker(
          width: 120.0,
          height: 120.0,
          point: scan.getLatLng(),
          builder: (context)  =>Container(
            child: Icon(Icons.location_on, size: 70.0, color: Theme.of(context).primaryColor),
          )
        )
      ]
    );
  }

  Widget _crearBotonFlotante(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Theme.of(context).primaryColor,
      onPressed: (){
        setState(() {
          print('Click en el boton : $estiloMapa');
        if(estiloMapa == 'streets'){
          estiloMapa = 'dark';
        }else if(estiloMapa == 'dark') {
           estiloMapa = 'light';
        }else if(estiloMapa == 'light') {
           estiloMapa = 'outdoors';
        }else if(estiloMapa == 'outdoors') {
           estiloMapa = 'satellite';
        }else{
          estiloMapa = 'streets';
        }   
        });
      },
      child: Icon(Icons.repeat),
    );
  }
}