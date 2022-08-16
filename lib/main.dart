import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int latitude = 0;
  int longitude = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Container(
        child: FlutterMap(
          options: MapOptions(
            zoom: 5.0,
          ),
          layers: [
            // TileLayerOptions(
            //   urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
            //   subdomains: ['a', 'b', 'c'],
            // ),
            TileLayerOptions(
                urlTemplate:
                    'https://api.mapbox.com/styles/v1/hk-p/cl6mxxgcj001o15mxvjxr2gs9/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoiaGstcCIsImEiOiJjbDYwNTV5ejUxNzlwM2RxaDY5Zm0xMXBoIn0.eig0zZUYx91cfE9reSSlIA',
                additionalOptions: {
                  'accessToken':
                      'sk.eyJ1IjoiaGstcCIsImEiOiJjbDZwcndxaGwwazZ3M2N0NWlsN3M2cmtjIn0._hGqYOO9j9JcvRQn6gg-1w',
                  'id': 'mapbox.mapbox-streets-v8',
                }),

            MarkerLayerOptions(
              markers: [
                Marker(
                  width: 80.0,
                  height: 80.0,
                  point: LatLng(51.5, -0.09),
                  builder: (ctx) => Container(
                    child: const FlutterLogo(),
                  ),
                ),
              ],
            ),
          ],
          children: [
            MaterialButton(
              child: Text('Click Here'),
              onPressed: () {
                setState(() {
                  // get location by using latlong package
                });
              },
            )
          ],
        ),
      ),
    );
  }
}
