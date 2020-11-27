import 'package:flutter/material.dart';
import 'package:qrreaderapp/src/pages/homa_page.dart';
import 'package:qrreaderapp/src/pages/mapa_page.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'QRReader',
      initialRoute: 'home',
      routes: {
        'home' : (BuildContext context) => HomePage(),
        'mapa' : (BuildContext context) => MapaPages()
      },
      theme: ThemeData(
        primaryColor: Colors.deepPurple
      ),
    );
  }
}